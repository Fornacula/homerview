# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Identity, type: :model do
  it { is_expected.to belong_to(:user) }

  it { is_expected.to validate_presence_of(:provider) }
  it { is_expected.to validate_uniqueness_of(:uid).scoped_to(:provider) }
end
