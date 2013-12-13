class AddUserLinkIdToSportLink < ActiveRecord::Migration
  def change
    add_column :sport_links, :user_link_id, :integer
  end
end
