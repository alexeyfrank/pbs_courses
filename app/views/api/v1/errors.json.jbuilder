json.errors do
  attributes = errors.attribute_names

  json.array! attributes do |attribute|
    json.attribute attribute
    json.messages errors[attribute]
  end
end
