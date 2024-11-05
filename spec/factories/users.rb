FactoryBot.define do
  factory :user do
    email { FFaker::Internet.email }
    full_name { FFaker::Name.name }
  end
end
