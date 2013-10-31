class Training < ActiveRecord::Base
  belongs_to :user
  belongs_to :sport
end
