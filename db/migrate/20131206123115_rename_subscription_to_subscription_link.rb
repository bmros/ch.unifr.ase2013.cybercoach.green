class RenameSubscriptionToSubscriptionLink < ActiveRecord::Migration
  def change
    rename_table :subscriptions, :subscription_links
  end
end
