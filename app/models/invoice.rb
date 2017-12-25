class Invoice < ApplicationRecord
  belongs_to :service
  belongs_to :user
  has_one :period

  delegate :name, to: :service, prefix: true

  validates :service, presence: true
  validates :user, presence: true
  validates :price, presence: true, numericality: true
end
