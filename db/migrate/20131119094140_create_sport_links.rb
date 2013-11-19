class CreateSportLinks < ActiveRecord::Migration
  def change
    create_table :sport_links do |t|
      t.string :name

      t.timestamps
    end
  end
end
