FactoryBot.define do
  factory :invoice do
    service nil
    user nil
    price 9.99
    invoice_nr 'a_32786'
    comment 'MyString'
  end
end
