class RemoveUserLinkIdFromSportLink < ActiveRecord::Migration
  def change
    remove_column :sport_links, :user_link_id, :integer
  end
end
