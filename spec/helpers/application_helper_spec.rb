# frozen_string_literal: true

require 'rails_helper'

RSpec.describe ApplicationHelper, type: :helper do
  it 'Returns beginning of last month' do
    expect(beginning_of_last_month).to eq((Date.current - 1.month).beginning_of_month)
  end

  it 'Returns end of last month' do
    expect(end_of_last_month).to eq((Date.current - 1.month).end_of_month)
  end
end
