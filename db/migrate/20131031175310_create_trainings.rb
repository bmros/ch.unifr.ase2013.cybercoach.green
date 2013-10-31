class CreateTrainings < ActiveRecord::Migration
  def change
    create_table :trainings do |t|
      t.references :user, index: true
      t.references :sport, index: true
      t.date :date

      t.timestamps
    end
  end
end
