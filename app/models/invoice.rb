# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :service
  belongs_to :user
  has_one :period

  scope :current_year, -> { joins(:period).where(['period_start > ?', 1.year.ago]).order('period_start') }
  scope :by_month, ->(month) { joins(:period).where('extract(month from period_start) = ?', month) }

  delegate :name, to: :service, prefix: true
  delegate :single, to: :period
  delegate :period_start, to: :period
  delegate :period_end, to: :period

  validates :service, presence: true
  validates :period, presence: true
  validates :user, presence: true
  validates :price, presence: true, numericality: true

  def single?
    single
  end

  def strf_period
    if single
      "#{I18n.t('periods.single')} #{I18n.l(period_start)}"
    else
      "#{I18n.l(period_start)}...#{I18n.l(period_end)}"
    end
  end

  def self.user_services_by_invoices(invoices)
    Service.where(id: invoices.pluck(:service_id).uniq)
  end

  def self.user_invoices_period_uniq_months(user)
    user.invoices.current_year.pluck(:period_start).map(&:month).uniq
  end

  def self.user_invoices_period_uniq_month_names(months)
    months.each.map { |m| I18n.t('date.abbr_month_names')[m] }
  end

  ### GRAPHS ###
  def self.yearly_summary_graph_data(user)
    user_invoices = user.invoices
    # Different types of services that current user consumes:
    services = Invoice.user_services_by_invoices(user_invoices)
    # last months that user has consumed some services (max 12 months):
    invoice_months = Invoice.user_invoices_period_uniq_months(user)
    # initialize graph x-axis with ticks:
    arr = [['months'] + Invoice.user_invoices_period_uniq_month_names(invoice_months)]
    services.each do |s|
      # all the invoices of certain service (max 12 months the oldest)
      service_invoices = user_invoices.joins(:period).where(service_id: s.id)
      arr << [s.name]
      invoice_months.each do |month|
        # Sum all the prices of current service in current month
        price_sum = service_invoices.by_month(month).sum(:price)
        arr.last << price_sum.to_f
      end
    end
    arr.transpose # data-matrix for google charts ready
  end
  ### END OF GRAPHS ###
end
