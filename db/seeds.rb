# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end


ActiveRecord::Base.transaction do
  users = [
    { full_name: "John Doe", email: "john.doe@example.com" },
    { full_name: "Jane Doe", email: "jane.doe@example.com" },
    { full_name: "Jim Beam", email: "jim.beam@example.com" }
  ].map do |user|
    User.create!(user)
  end

  skills = [
    { name: "Ruby", slug: "ruby" },
    { name: "Rails", slug: "rails" },
    { name: "JavaScript", slug: "javascript" }
  ].map do |skill|
    Skill.create!(skill)
  end

  courses = [
    { title: "Ruby on Rails", description: "Learn Ruby on Rails", author: users.first },
    { title: "JavaScript", description: "Learn JavaScript", author: users.second },
    { title: "Ruby", description: "Learn Ruby", author: users.third }
  ].map do |course|
    Course.create!(course)
  end

  course_skills = [
    { course: courses.first, skill: skills.first },
    { course: courses.second, skill: skills.second },
    { course: courses.third, skill: skills.third }
  ].map do |course_skill|
    CourseSkill.create!(course_skill)
  end
end
