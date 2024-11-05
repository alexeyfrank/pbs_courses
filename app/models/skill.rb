class Skill < ApplicationRecord
  has_many :course_skills
  has_many :courses, through: :course_skills

  validates :name, presence: true
  validates :slug, presence: true, uniqueness: true
end
