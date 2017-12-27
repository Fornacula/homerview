# frozen_string_literal: true

class Invoice < ApplicationRecord
  belongs_to :service
  belongs_to :user
  has_one :period

  scope :current_year, -> { joins(:period).where(['period_start > ?', 1.year.ago]) }

  delegate :name, to: :service, prefix: true
  delegate :single, to: :period
  delegate :period_start, to: :period
  delegate :period_end, to: :period

  validates :service, presence: true
  validates :period, presence: true
  validates :user, presence: true
  validates :price, presence: true, numericality: true

  def strf_period
    if single
      I18n.t('invoices.single')
    else
      "#{I18n.l(period_start)}...#{I18n.l(period_end)}"
    end
  end

  def self.user_invoices_period_uniq_month_names(user)
    user.invoices.current_year.pluck(:period_start).map { |p| I18n.t('date.abbr_month_names')[p.month] }.uniq
  end

  def self.yearly_summary_graph_data(user)
    user_invoices = user.invoices
    # Different types of services that current user consumes:
    services = Service.where(id: user_invoices.pluck(:service_id).uniq)
    # last months that user has consumed some services (max 12 months):
    invoice_months = Invoice.user_invoices_period_uniq_month_names(user)
    # initialize graph data matrix with contents of x-axis ticks:
    arr = [['months'] + invoice_months]
    services.each do |s|
      # all the invoices of certain service (max 12 months the oldest)
      service_invoices = user_invoices.joins(:period).where(service_id: s.id)
      arr << [s.name]
      invoice_months.each do |month|
        first_date_of_month = Date.new(2017, (I18n.t('date.abbr_month_names').index(month)), 1)
        i = service_invoices.find_by('period_start = ?', first_date_of_month)
        arr.last << (i ? i.price.to_f : 0)
      end
    end
    arr.transpose # data-matrix for google charts ready
  end
end
