FactoryBot.define do
  factory :comment do
    content { Faker::Lorem.paragraph }
    user
    post
  end

  trait :comment_invalid do
    content { nil }
  end
end
