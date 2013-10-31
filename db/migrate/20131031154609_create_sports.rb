class CreateSports < ActiveRecord::Migration
  def change
    create_table :sports do |t|
      t.string :uri
      t.string :name

      t.timestamps
    end
  end
end
