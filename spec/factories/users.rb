FactoryBot.define do
  factory :user do
    email { "#{first_name}.#{last_name}@example.com".downcase }
    first_name { Faker::Name.first_name }
    last_name { Faker::Name.last_name }
    password { "password" }
    password_confirmation { "password" }

    trait :john_smith do
      email { "john.smith@example.com" }
      first_name { "John" }
      last_name { "Smith" }
    end
  end
end
