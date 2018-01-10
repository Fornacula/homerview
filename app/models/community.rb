# frozen_string_literal: true

class Community < ApplicationRecord
  has_many :partnerships

  validates :name, presence: true
end
