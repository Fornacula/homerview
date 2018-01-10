# frozen_string_literal: true

class Partnership < ApplicationRecord
  belongs_to :community
  belongs_to :user
end
