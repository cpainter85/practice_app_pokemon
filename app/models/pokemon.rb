class Pokemon < ActiveRecord::Base

  has_many :pets

  validates :name, presence: true
  validates :species, presence: true, length: {minimum: 3}
end
