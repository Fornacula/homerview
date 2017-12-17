class Invoice < ApplicationRecord
  belongs_to :service
  belongs_to :user

  validates :service, presence: true
  validates :user, presence: true
end
