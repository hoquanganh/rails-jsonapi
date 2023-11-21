FactoryBot.define do
  factory :article do
    title { Faker::Book.title }
    body { Faker::Lorem.paragraph }
    association :author, factory: :author
  end
end
