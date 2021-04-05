FactoryBot.define do
  factory :comment do
    # article { create(:article) }
    commenter { Faker::Name.name }
    body { Faker::Address.full_address }
  end
end
