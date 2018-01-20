# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  it { is_expected.to have_many(:invoices) }
  it { is_expected.to have_many(:identities) }
  it { is_expected.to have_many(:partnerships) }
  it { is_expected.to have_many(:communities) }
  it { is_expected.to have_many(:invitations) }

  it 'returns all the communities user has'
end
