# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invitation, type: :model do
  it { is_expected.to belong_to(:community) }
  it { is_expected.to belong_to(:user) }
end
