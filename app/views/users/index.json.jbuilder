json.array!(@users) do |user|
  json.extract! user, :id, :email, :name, :bio, :level, :buzz, :max_motivation, :cur_motivation, :max_dignity, :cur_dignity, :max_strangepoints, :cur_strangepoints
  json.url user_url(user, format: :json)
end
