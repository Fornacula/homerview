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

  describe 'named scope' do
    context '.current_year' do
      it 'includes invoice with period of 5 months ago' do
        invoice = Invoice.create(attributes_for(:invoice,
          user: build(:user),
          service: build(:service),
          period: build(:five_months_ago_monthly_period))
        )
        expect(Invoice.current_year).to include(invoice)
      end

      it 'excludes invoice with period older than 2 years' do
        invoice = Invoice.create(attributes_for(:invoice,
          user: build(:user),
          service: build(:service),
          period: build(:two_years_ago_montly_period))
        )
        expect(Invoice.current_year).not_to include(invoice)
      end
    end
  end
end
