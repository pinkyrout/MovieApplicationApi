FactoryBot.define do
  factory :user do
    username { FFaker::Name.name }
    sequence(:email) { |n| "person#{n}@example.com" }
    password_digest { FFaker::Internet.password }
  end
end
