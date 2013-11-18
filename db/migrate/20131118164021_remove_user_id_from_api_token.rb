class RemoveUserIdFromApiToken < ActiveRecord::Migration
  def change
    remove_column :api_tokens, :user_id, :integer
  end
end
