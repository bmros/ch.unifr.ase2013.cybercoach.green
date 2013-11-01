json.array!(@sessions) do |session|
  json.extract! session, :password, :username
  json.url session_url(session, format: :json)
end
