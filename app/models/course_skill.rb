class CourseSkill < ApplicationRecord
  belongs_to :course
  belongs_to :skill

  validates :course, presence: true
  validates :skill, presence: true
end
