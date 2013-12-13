class CreateSubscriptionLinks < ActiveRecord::Migration
  def change
    create_table :subscription_links do |t|
      t.integer :user_link_id
      t.integer :sport_link_id

      t.timestamps
    end
  end
end
