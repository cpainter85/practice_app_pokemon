class Pokemon < ActiveRecord::Base
  validates :name, presence: true
  validates :species, presence: true, length: {minimum: 3}
end
