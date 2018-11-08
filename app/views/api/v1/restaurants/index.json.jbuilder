json.array! @restaurants do |restaurant| #I work with an array of objects
  json.extract! restaurant, :id, :name, :address
end