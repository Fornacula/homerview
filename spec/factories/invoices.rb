# frozen_string_literal: true

FactoryBot.define do
  factory :invoice do
    service { build(:service) }
    user { build(:user) }
    period { build(:period) }
    price 9.99
    invoice_nr 'a_32786'
    comment 'MyString'

    factory :single_invoice do
      period { build(:single_period) }
    end
  end
end
