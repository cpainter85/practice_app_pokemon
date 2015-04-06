class Pet < ActiveRecord::Base
  belongs_to :pokemon
  belongs_to :trainer
  validates :trainer_id, presence: true
  validates :pokemon_id, presence: true
  validates :name, presence: true
  validates :experience_level, presence: true, numericality: { greater_than: 0, less_than_or_equal_to: 50}
end
