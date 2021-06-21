FactoryBot.define do
  factory :post do
    content { Faker::Lorem.paragraph }
    user
  end

  trait :post_invalid do
    content { nil }
  end
end
