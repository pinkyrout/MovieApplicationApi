FactoryBot.define do
  factory :movie do
    name { FFaker::Movie.title }
    rating 10.0
    is_active true
  end
end