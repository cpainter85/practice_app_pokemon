class CreateTrainers < ActiveRecord::Migration
  def change
    create_table :trainers do |t|
      t.string :name
      t.string :country_of_origin
      t.date :date_of_birth
      t.timestamps
    end
  end
end
