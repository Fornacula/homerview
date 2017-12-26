require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { is_expected.to belong_to(:service) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_one(:period) }

  it { is_expected.to delegate_method(:name).to(:service).with_prefix }

  it { is_expected.to validate_presence_of(:service) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price)}
end
