# == Schema Information
#
# Table name: providers
#
#  id           :bigint           not null, primary key
#  name         :string           not null
#  email        :string           not null
#  phone_number :string           not null
#  created_at   :datetime         not null
#  updated_at   :datetime         not null
#
class Provider < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
  validates :email, presence: true, uniqueness: { case_sensitive: false }
  validates :phone_number, presence: true

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(product) { "providers" }, inserts_by: :prepend
  before_validation :normalize_email

  def normalize_email
    self.email = email.downcase
  end
end
