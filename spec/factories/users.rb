FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.unique.email }
    sequence(:first_name) { Faker::Name.unique.first_name }
    sequence(:last_name) { Faker::Name.unique.last_name }
    password 'password'
    password_confirmation 'password'

    after(:create) do |user|
      user.confirmed_at = Time.now.utc
      user.save
    end
  end
end
