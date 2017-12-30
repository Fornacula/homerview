# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Period, type: :model do
  it { is_expected.to belong_to(:invoice) }

  it 'annulls period_end if single' do
    invoice = create(:single_invoice)
    expect(invoice.period_end).to be_nil
    period = invoice.period
    period.update(period_end: Date.current)
    expect(period.period_end).to be_nil
  end
end
