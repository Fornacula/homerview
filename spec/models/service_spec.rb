# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Service, type: :model do
  it { is_expected.to have_many(:invoices).dependent(:destroy) }

  it { is_expected.to validate_presence_of(:name) }
  it { is_expected.to validate_uniqueness_of(:name) }
end
