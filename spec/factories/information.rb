FactoryBot.define do
  factory :information do
    title { Faker::Lorem.paragraph }
    content { Faker::Lorem.paragraph }
  end
end
