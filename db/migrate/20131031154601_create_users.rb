class CreateUsers < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :uri
      t.string :username
      t.string :password
      t.string :realname
      t.string :email
      t.integer :publicvisible

      t.timestamps
    end
  end
end
