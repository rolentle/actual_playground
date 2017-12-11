FactoryBot.define do
  factory :show do
    title "MyString"
    description "MyText"
    image { File.new("#{Rails.root}/spec/support/fixtures/image.jpg") }

  end
end
