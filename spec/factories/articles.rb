FactoryBot.define do
  factory :article do
    title { Faker::Name.name }
    body { Faker::Address.full_address }
  end
end
