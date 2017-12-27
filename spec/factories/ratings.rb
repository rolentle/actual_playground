FactoryBot.define do
  factory :rating do
    user
    show
    score 1
    sequence(:review) { Faker::StarWars.quote }
  end
end
