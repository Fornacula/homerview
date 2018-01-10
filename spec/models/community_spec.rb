# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Community, type: :model do
  it { is_expected.to have_many(:partnerships) }

  it { is_expected.to validate_presence_of(:name) }
end
