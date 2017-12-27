# frozen_string_literal: true

FactoryBot.define do
  factory :period do
    length 'month'
    period_start '2017-06-01'
    period_end '2017-06-30'
    single false

    factory :last_month_monthly_period do
      period_start (Date.current - 1.months).beginning_of_month
      period_end (Date.current - 1.months).end_of_month
    end

    factory :five_months_ago_monthly_period do
      period_start (Date.current - 5.months).beginning_of_month
      period_end (Date.current - 5.months).end_of_month
    end

    factory :two_years_ago_montly_period do
      period_start (Date.current - 2.years).beginning_of_month
      period_end (Date.current - 2.years).end_of_month
    end

    factory :single_period do
      length nil
      period_start '2017-12-01'
      period_end nil
      single true
    end
  end
end
