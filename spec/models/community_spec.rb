# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Community, type: :model do
  it { is_expected.to have_many(:partnerships).dependent(:destroy) }
  it { is_expected.to have_many(:invitations).dependent(:destroy) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:name) }

  it { is_expected.to respond_to(:master) }
end
