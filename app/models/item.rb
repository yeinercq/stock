# == Schema Information
#
# Table name: items
#
#  id         :bigint           not null, primary key
#  invoice_id :bigint           not null
#  product_id :bigint           not null
#  quantity   :integer          not null
#  unit_price :decimal(10, 2)   not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#
class Item < ApplicationRecord
  belongs_to :invoice
  belongs_to :product

  validates :product_id, uniqueness: true
  validates :quantity, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :unit_price, presence: true, numericality: { greater_than: 0 }
end
