# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it { is_expected.to belong_to(:community) }
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:email) }
  it { is_expected.to validate_uniqueness_of(:email).scoped_to(:community_id) }
  it 'validates format of e-mail'

  it 'shows to community master'
  it 'shows to invitable'
  it 'does not show to anybody else'
end
