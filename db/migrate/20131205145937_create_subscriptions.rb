class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.integer :user_link_id
      t.integer :sport_link_id

      t.timestamps
    end
  end
end
