json.id course.id
json.title course.title
json.description course.description
json.author do
  json.partial! "api/v1/users/user", user: course.author
end
json.skills do
  json.array! course.skills do |skill|
    json.partial! "api/v1/skills/skill", skill: skill
  end
end
json.created_at course.created_at
json.updated_at course.updated_at
