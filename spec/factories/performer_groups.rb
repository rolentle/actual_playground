FactoryBot.define do
  factory :performer_group do
    name { Faker::Lorem.unique.words(4).join(' ') }

    factory :performer_group_with_performers do
      transient do
        performer_count 2
      end

      after(:create) do |performer_group, evaluator|
        create_list(:performer, evaluator.performer_count, performer_groups: [performer_group])
      end
    end

    factory :performer_group_shows_and_performers do
      transient do
        performer_count 2
        show_count 2
      end

      after(:create) do |performer_group, evaluator|
        create_list(:performer, evaluator.performer_count, performer_groups: [performer_group])
        create_list(:show, evaluator.show_count, creator: performer_group)
      end
    end
  end
end
