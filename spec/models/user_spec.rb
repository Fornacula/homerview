require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'Associations' do
    it { is_expected.to have_many(:invoices)}
  end

  describe 'Validations' do
    context 'uniqueness' do
      it { is_expected.to validate_uniqueness_of(:email) }
    end
  end
end
