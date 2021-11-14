FactoryBot.define do
  factory :mock_user, class: User do
    email { Faker::Internet.email }
    password_digest { Faker::Internet.password(min_length: 8) }
    api_key { Faker::Internet.api_key }
  end
end
