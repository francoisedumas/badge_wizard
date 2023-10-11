# frozen_string_literal: true

FactoryBot.define do
  factory :prompt do
    description { Faker::Lorem.sentence }
    user
  end
end
