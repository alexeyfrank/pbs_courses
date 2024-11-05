class Course < ApplicationRecord
  belongs_to :author, class_name: "User", counter_cache: true

  has_many :course_skills, dependent: :destroy
  has_many :skills, through: :course_skills

  validates :title, presence: true, length: { maximum: 255 }
  validates :description, presence: true, length: { maximum: 1000 }
  validates :author, presence: true
end
