# == Schema Information
#
# Table name: invoices
#
#  id         :bigint           not null, primary key
#  total      :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  client_id  :bigint           not null
#
class Invoice < ApplicationRecord
  belongs_to :client, class_name: 'Customer'
  belongs_to :company

  has_many :items, dependent: :destroy

  validates :client_id, presence: true

  before_create :generate_code

  scope :ordered,-> { order(id: :desc) }

  broadcasts_to ->(invoice) { [invoice.company, "invoices"] }, inserts_by: :prepend

  def total_price
    items.sum(&:total_price)
  end

  def generate_code
    Invoices::GenerateCode.new.call(self)
  end
end
