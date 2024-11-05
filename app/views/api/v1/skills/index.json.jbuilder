json.meta do
  json.total_count @skills.count
end

json.skills do
  json.array! @skills do |skill|
    json.partial! "api/v1/skills/skill", skill: skill
  end
end
