class Course < ApplicationRecord
  belongs_to :author, class_name: "User"

  has_many :course_skills
  has_many :skills, through: :course_skills

  validates :title, presence: true
  validates :description, presence: true
  validates :author, presence: true
end