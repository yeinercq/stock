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
#  company_id   :bigint           not null
#
class Provider < ApplicationRecord
  belongs_to :company

  validates :name, presence: true, uniqueness: { scope: :company_id, message: "has been already taken", case_sensitive: false }
  validates :email, presence: true, uniqueness: { scope: :company_id, message: "has been already taken", case_sensitive: false }
  validates :phone_number, presence: true, numericality: { only_integer: true, greater_than: 0 }

  scope :ordered, -> { order(id: :desc) }

  broadcasts_to ->(provider) { [provider.company, "providers"] }, inserts_by: :prepend

  before_validation :normalize_email

  def normalize_email
    self.email = email.downcase
  end
end
