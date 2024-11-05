FactoryBot.define do
  factory :skill do
    slug { FFaker::Lorem.word }
    name { FFaker::Lorem.word }
  end
end
