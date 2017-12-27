FactoryBot.define do
  factory :show do
    title Faker::Book.title
    description "MyText"
    image { Faker::LoremPixel.image }

    factory :show_with_ratings do
      after(:create) do |show|
        create_list :rating, 2, show: show
      end
    end
  end
end
