# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:invoices) }
  it { is_expected.to have_many(:identities) }
end
