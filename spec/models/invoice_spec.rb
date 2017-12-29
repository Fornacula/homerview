# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Invoice, type: :model do
  it { is_expected.to belong_to(:service) }
  it { is_expected.to belong_to(:user) }
  it { is_expected.to have_one(:period) }

  it { is_expected.to delegate_method(:name).to(:service).with_prefix }
  it { is_expected.to delegate_method(:single).to(:period) }
  it { is_expected.to delegate_method(:period_start).to(:period) }
  it { is_expected.to delegate_method(:period_end).to(:period) }

  it { is_expected.to validate_presence_of(:service) }
  it { is_expected.to validate_presence_of(:user) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price) }

  describe 'named scope' do
    context '.current_year' do
      it 'includes invoice with period of 5 months ago' do
        invoice = Invoice.create(attributes_for(:invoice, period: build(:five_months_ago_monthly_period)))

        expect(Invoice.current_year).to include(invoice)
      end

      it 'excludes invoice with period older than 2 years' do
        invoice = Invoice.create(attributes_for(:invoice, period: build(:two_years_ago_montly_period)))

        expect(Invoice.current_year).not_to include(invoice)
      end
    end
  end

  context 'stringify period' do
    it 'can stringify periodic invoice' do
      invoice = build(:invoice)
      expect(invoice.strf_period).to eq('01.06.2017...30.06.2017')
    end

    it 'can stringify single invoice' do
      invoice = build(:single_invoice)
      expect(invoice.strf_period).to eq(I18n.t('invoices.single'))
    end
  end

  it 'gives out uniq month names for user invoices' do
    user = create(:user)
    Invoice.create(
      attributes_for(
        :invoice,
        user: user,
        period: build(
          :period,
          period_start: Date.new(2017, 7, 1),
          period_end: Date.new(2017, 7, 31)
        )
      )
    )
    Invoice.create(
      attributes_for(
        :invoice,
        user: user,
        period: build(
          :period,
          period_start: Date.new(2017, 11, 1),
          period_end: Date.new(2017, 11, 30)
        )
      )
    )
    expect(Invoice.user_invoices_period_uniq_month_names(user)).to eq(%w[Juul Nov])
  end
end
