class CreateSessions < ActiveRecord::Migration
  def change
    create_table :sessions do |t|
      t.string :password
      t.string :username

      t.timestamps
    end
  end
end
