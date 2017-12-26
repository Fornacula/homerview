class Invoice < ApplicationRecord
  belongs_to :service
  belongs_to :user
  has_one :period

  delegate :name, to: :service, prefix: true
  delegate :single, to: :period
  delegate :period_start, to: :period
  delegate :period_end, to: :period

  validates :service, presence: true
  validates :period, presence: true
  validates :user, presence: true
  validates :price, presence: true, numericality: true

  def strf_period
    single ? I18n.t('invoices.single') : "#{I18n.l(period_start)}...#{I18n.l(period_end)}"
  end
end
