FactoryBot.define do
  factory :period do
    length 'month'
    period_start '2017-12-01'
    period_end '2017-12-31'
    single false
  end
end
