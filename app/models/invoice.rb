# == Schema Information
#
# Table name: invoices
#
#  id          :bigint           not null, primary key
#  total       :decimal(10, 2)
#  customer_id :bigint           not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#
class Invoice < ApplicationRecord
  belongs_to :customer

  has_many :items, dependent: :destroy

  validates :customer_id, presence: true

  scope :ordered,-> { order(id: :desc) }

  broadcasts_to ->(invoice) { "invoices" }, inserts_by: :prepend
end
