class ApiToken < ActiveRecord::Base
  belongs_to :user_link
end
