FactoryBot.define do
  factory :prompt do
    description { Faker::Lorem.sentence }
    user
  end
end
