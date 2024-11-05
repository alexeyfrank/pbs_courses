FactoryBot.define do
  factory :course do
    author { create(:user) }
    title { FFaker::Lorem.word }
    description { FFaker::Lorem.sentence }
    skills { create_list(:skill, 3) }
  end
end
