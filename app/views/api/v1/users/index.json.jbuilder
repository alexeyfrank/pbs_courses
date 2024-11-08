json.meta do
  json.total_count @users.count
end

json.users do
  json.array! @users do |user|
    json.partial! "api/v1/users/user", user: user
  end
end
