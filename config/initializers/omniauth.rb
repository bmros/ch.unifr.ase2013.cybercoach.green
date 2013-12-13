Rails.application.config.middleware.use OmniAuth::Builder do
  provider :fatsecret, 'cac271e1f5114c8298cd23ca772809fd', 'c6172e6faf1b49bb8d66b674e7a18846'
end