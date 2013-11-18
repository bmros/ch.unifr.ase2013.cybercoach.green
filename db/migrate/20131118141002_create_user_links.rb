class CreateUserLinks < ActiveRecord::Migration
  def change
    create_table :user_links do |t|
      t.string :username

      t.timestamps
    end
  end
end
