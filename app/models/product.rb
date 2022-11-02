class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }

  enum unit: { kilo: 1, bulto: 2, unidad: 3 }
end
