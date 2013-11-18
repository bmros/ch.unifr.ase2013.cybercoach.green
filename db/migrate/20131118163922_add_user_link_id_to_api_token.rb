class AddUserLinkIdToApiToken < ActiveRecord::Migration
  def change
    add_column :api_tokens, :user_link_id, :integer
  end
end
