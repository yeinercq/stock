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
FactoryBot.define do
  factory :item do
    quantity { 3 }
    unit_price { 1000 }
    invoice
    product
  end
end
