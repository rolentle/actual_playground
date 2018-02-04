FactoryBot.define do
  factory :show do
    title { Faker::Book.unique.title }
    description 'MyText'
    image { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }
    twitter_username { Faker::Twitter.unique.screen_name }
    status 'approved'
    submitter factory: :user
    creator factory: :performer_group


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

    factory :show_created_by_a_performer do
      creator factory: :performer
    end

    factory :show_created_by_a_performer_group do
      creator factory: :performer_group
    end

    factory :protean_city_comics do
      title "Protean City Comics"
      description "Protean City Comics is a weekly actual play podcast in the Masks: A New Generation game. It follows the lives of teenage super heroes in Protean City as they battle villains, seek to establish themselves as heroes, and struggle to find what kind of person they want to be."
      twitter_username "ProteanCity"
      creator { create(:performer_group, name: "SHR Network") }
      after(:create) do |show|
        create_list :rating, 2, show: show, score: 5
      end
    end
  end
end
