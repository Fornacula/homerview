# frozen_string_literal: true

class Community < ApplicationRecord
  has_many :partnerships, dependent: :destroy
  has_many :invitations, dependent: :destroy
  belongs_to :user, required: false

  validates :name, presence: true

  alias_attribute :master, :user

  def set_master(user)
    self.master = user
  end
end
