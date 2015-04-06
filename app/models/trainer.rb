class Trainer < ActiveRecord::Base
  validates :name, presence: true, length: {minimum: 3}
  validates :country_of_origin, presence: true
  validates :date_of_birth, presence: true
  validate :date_of_birth_not_in_future

  def date_of_birth_not_in_future
    if date_of_birth && date_of_birth > Time.zone.now
      errors[:date_of_birth] << 'can\'t be in the future'
    end
  end
end