class CreatePets < ActiveRecord::Migration
  def change
    create_table :pets do |t|
      t.integer :trainer_id
      t.integer :pokemon_id
      t.string :name
      t.integer :experience_level
      t.timestamps
    end
  end
end
