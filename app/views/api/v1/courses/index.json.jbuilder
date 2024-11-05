json.meta do
  json.total_count @courses.count
end

json.courses do
  json.array! @courses do |course|
    json.partial! "api/v1/courses/course", course: course
  end
end
