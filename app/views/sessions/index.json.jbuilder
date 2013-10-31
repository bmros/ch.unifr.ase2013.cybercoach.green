json.array!(@sessions) do |session|
  json.extract! session, :password
  json.url session_url(session, format: :json)
end
