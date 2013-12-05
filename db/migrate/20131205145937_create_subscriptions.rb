class CreateSubscriptions < ActiveRecord::Migration
  def change
    create_table :subscriptions do |t|
      t.int :user_link_id
      t.int :sport_link_id

      t.timestamps
    end
  end
end
