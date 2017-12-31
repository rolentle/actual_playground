FactoryBot.define do
  factory :user do
    sequence(:email) { Faker::Internet.unique.email }
    password 'password'
    password_confirmation 'password'
    sequence(:username) { Faker::Internet.unique.user_name }

    after(:create) do |user|
      user.confirmed_at = Time.now.utc
      user.save
    end
  end
end
