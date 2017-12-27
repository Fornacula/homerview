# frozen_string_literal: true

class ServiceUser < ApplicationRecord
  belongs_to :service
  belongs_to :user
end
