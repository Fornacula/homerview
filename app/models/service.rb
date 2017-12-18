class Service < ApplicationRecord
  has_many :invoices
  validates :name, uniqueness: true
end
