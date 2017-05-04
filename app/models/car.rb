class Car < ApplicationRecord
  
  validates :manufacturer, :price, presence: true
  validates :price, numericality: { greater_than_or_equal_to: 0 }
  validates_inclusion_of :used, in: [true, false], message: "Must be a boolean value 'true' or 'false'"

end
