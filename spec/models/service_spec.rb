require 'rails_helper'

RSpec.describe Service, type: :model do
  describe 'Validations' do
    context 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:name) }
    end
  end
end
