json.array!(@sport_links) do |sport_link|
  json.extract! sport_link, :name
  json.url sport_link_url(sport_link, format: :json)
end
