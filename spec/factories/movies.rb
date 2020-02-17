FactoryBot.define do
  factory :movie do
    name { FFaker::Movie.title }
    rating 10.0
  end
end