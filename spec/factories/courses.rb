FactoryBot.define do
  factory :course do
    author
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
  end
end
