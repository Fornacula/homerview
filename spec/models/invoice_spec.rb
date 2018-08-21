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
  it { is_expected.to validate_presence_of(:period) }
  it { is_expected.to validate_presence_of(:price) }
  it { is_expected.to validate_numericality_of(:price) }

  describe 'named scopes' do
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

    context '.by_month' do
      it 'includes invoices in given month and excludes any other' do
        invoice1 = create(:invoice, period: build(:period, period_start: Date.new(2014, 1, 5)))
        invoice2 = create(:invoice, period: build(:period, period_start: Date.new(2017, 5, 19)))

        expect(Invoice.by_month(1).to_a).to eq([Invoice.find(invoice1.id)])
        expect(Invoice.by_month(5).to_a).to eq([Invoice.find(invoice2.id)])
      end
    end
  end

  it { expect(described_class.new).to respond_to(:single?) }

  context 'stringify period' do
    it 'can stringify periodic invoice' do
      invoice = build(:invoice)
      expect(invoice.strf_period).to eq('01.06.2017...30.06.2017')
    end

    it 'can stringify single invoice' do
      invoice = build(:single_invoice)
      expect(invoice.strf_period).to eq("#{I18n.t('periods.single')} #{I18n.l(invoice.period_start)}")
    end
  end

  describe "graph's data" do
    let(:user) { create(:user) }
    let(:service1) { create(:service, name: 'Test_1') }
    let(:service2) { create(:service, name: 'Test_2') }
    let(:date1) { Date.today - 6.months }
    let(:date2) { Date.today - 4.months }
    let(:period_jul1) do
      build(
        :period,
        period_start: date1.beginning_of_month,
        period_end: date1.end_of_month
      )
    end
    let(:period_jul2) do
      build(
        :period,
        period_start: date1.beginning_of_month,
        period_end: date1.end_of_month
      )
    end
    let(:period_nov) do
      build(
        :period,
        period_start: date2.beginning_of_month,
        period_end: date2.end_of_month
      )
    end
    let!(:invoice1) { create(:invoice, user: user, service: service1, period: period_nov) }
    let!(:invoice2) { create(:invoice, user: user, service: service2, period: period_jul1) }
    let!(:invoice3) { create(:invoice, user: user, service: service2, period: period_jul2) }

    it 'returns uniq services based on invoice service types' do
      expect(Invoice.user_services_by_invoices(Invoice.all)).to eq([service1, service2])
    end

    it 'gives out uniq month names for user invoices in timely order' do
      expect(Invoice.user_invoices_period_uniq_months(user)).to eq([
                                                                     date1.month,
                                                                     date2.month
                                                                   ])
    end

    it 'returns month names based on month numbers' do
      months = [1, 2, 3, 10, 11, 12]
      expect(Invoice.user_invoices_period_uniq_month_names(months)).to eq(
        %w[Jaan Veeb Mär Okt Nov Dets]
      )
    end

    context 'matrices' do
      let(:matrix_transposed) { Invoice.yearly_summary_graph_data(user).transpose }

      it 'displays all the relevant services' do
        expect(matrix_transposed.size).to eq(3)
        expect(matrix_transposed.second.first).to eq('Test_1')
        expect(matrix_transposed.third.first).to eq('Test_2')
      end

      it 'displays x-axis ticks as abbreviated month names' do
        expect(matrix_transposed.first).to eq(%W[
                                                months
                                                #{I18n.t('date.abbr_month_names')[date1.month]}
                                                #{I18n.t('date.abbr_month_names')[date2.month]}
                                              ])
      end

      it 'sums up service invoices (single as well as periodic at once) in one month' do
        expect(matrix_transposed.last.second).to eq(19.98)
      end

      it 'fills the gaps with zeros' do
        expect(matrix_transposed.second).to eq(['Test_1', 0, 9.99])
        expect(matrix_transposed.last).to eq(['Test_2', 19.98, 0])
      end
    end
  end
end
