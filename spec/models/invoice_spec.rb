require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'Validation' do
    it { is_expected.to validate_presence_of(:service) }
    it { is_expected.to validate_presence_of(:user) }
    it { is_expected.to validate_presence_of(:price) }
  end
end
