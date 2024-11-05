FactoryBot.define do
  factory :course_skill, class: 'Course::Skill' do
    course { nil }
    skill { nil }
  end
end
