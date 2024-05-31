FactoryBot.define do
  factory :user do
    email { "one@example.com" }
    first_name { "User" }
    last_name { "One" }
    password { "password" }
    terms_of_service { true }
    confirmed_at { Time.current }
  end
end
