json.array!(@user_links) do |user_link|
  json.extract! user_link, :username, :encrypted_password, :salt, :realname, :email, :publicvisible
  json.url user_link_url(user_link, format: :json)
end
