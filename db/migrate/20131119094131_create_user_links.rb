class CreateUserLinks < ActiveRecord::Migration
  def change
    create_table :user_links do |t|
      t.string :username
      t.string :encrypted_password
      t.string :salt
      t.string :realname
      t.string :email
      t.integer :publicvisible

      t.timestamps
    end
  end
end
