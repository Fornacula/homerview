# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    sequence(:email) { |n| "poly.ester#{n}@tester.ee" }
    password 'esterT3$t3r'
  end
end
