json.array!(@trainings) do |training|
  json.extract! training, :user_id, :sport_id, :date
  json.url training_url(training, format: :json)
end
