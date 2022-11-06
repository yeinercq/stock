# == Schema Information
#
# Table name: customers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  email        :string           not null
#  phone_number :string           not null
#  id_number    :string           not null
#  address      :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Customer < ApplicationRecord
  validates :name, presence: true
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :phone_number, presence: true, numericality: { only_integer: true, greater_than: 0 }
  validates :id_number, presence: true, uniqueness: true, numericality: { only_integer: true, greater_than: 0 }
  validates :address, presence: true

  has_many :invoices

  before_validation :normalize_email


  def normalize_email
    self.email = email.downcase
  end

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(customer) { "customers" }, inserts_by: :prepend
end
