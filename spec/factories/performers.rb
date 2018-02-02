FactoryBot.define do
  factory :performer do
    name { Faker::Name.name }
    performer_groups { [create(:performer_group)] }
  end
end
