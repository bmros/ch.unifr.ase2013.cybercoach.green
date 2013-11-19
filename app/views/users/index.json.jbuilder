json.array!(@users) do |user|
  json.extract! user, :uri, :username, :password, :realname, :email, :publicvisible
  json.url user_url(user, format: :json)
end
