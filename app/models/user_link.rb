class UserLink < ActiveRecord::Base
  belongs_to :user
  has_many :api_tokens
end
