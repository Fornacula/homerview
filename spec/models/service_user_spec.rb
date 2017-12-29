# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ServiceUser, type: :model do
  it { is_expected.to belong_to(:service) }
  it { is_expected.to belong_to(:user) }
end
