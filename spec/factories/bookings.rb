FactoryBot.define do
  factory :booking do
    price 0.0

    association :user, factory: :user
    association :show, factory: :show
  end
end