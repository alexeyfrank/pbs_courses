class User < ApplicationRecord
  has_many :courses, foreign_key: :author_id

  validates :email, presence: true, uniqueness: true
  validates :full_name, presence: true
end
