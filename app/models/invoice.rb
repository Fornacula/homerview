class Invoice < ApplicationRecord
  belongs_to :service
  belongs_to :user
  has_one :period

  scope :current_year, lambda{ joins(:period).where(['period_start > ?', 1.year.ago]) }

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
    user.invoices.current_year.pluck(:period_start).map {|p| I18n.t('date.abbr_month_names')[p.month]}.uniq
  end
end
