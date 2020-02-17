FactoryBot.define do
  factory :show do
    start_time 1200
    end_time 1500
    date { FFaker::Time.date }
    is_full false

    association :movie, factory: :movie
  end
end