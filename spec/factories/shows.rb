FactoryBot.define do
  factory :show do
    title { Faker::Book.unique.title }
    description "MyText"
    image { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }

    factory :show_with_ratings do
      after(:create) do |show|
        create_list :rating, 2, show: show
      end
    end

    factory :show_with_high_ratings do
      after(:create) do |show|
        create_list :rating, 2, show: show, score: 5
      end
    end
    factory :show_with_ok_ratings do
      after(:create) do |show|
        create :rating, show: show, score: 4
        create :rating, show: show, score: 2
      end
    end
    factory :show_with_low_ratings do
      after(:create) do |show|
        create_list :rating, 2, show: show, score: 1
      end
    end
  end
end
