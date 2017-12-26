FactoryBot.define do
  factory :period do
    length 'month'
    period_start '2017-12-01'
    period_end '2017-12-31'
    single false

    factory :five_months_ago_monthly_period do
      period_start (Date.current - 5.months).beginning_of_month
      period_end (Date.current - 5.months).end_of_month
    end
  end
end
