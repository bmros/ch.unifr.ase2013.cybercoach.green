Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fatsecret, ENV['FATSECRET_KEY'], ENV['FATSECRET_SECRET']
end   