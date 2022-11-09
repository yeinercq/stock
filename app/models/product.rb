# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text             not null
#  unit        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
class Product < ApplicationRecord
  belongs_to :company
  validates :name, presence: true, uniqueness: { scope: :company_id, message: "has already been taken", case_sensitive: false }
  validates :unit, presence: true

  enum unit: { kilo: 1, bulto: 2, unidad: 3 }

  scope :ordered, -> { order(id: :desc) }

  # When an user creates a new product, turbo stream prepends the new product to the DOM of all subscribed users (target "products")
  # after_create_commit -> { broadcast_prepend_to "products", patial: "products/product", locales: { product: self }, target: "products" }

  # synchronous broacast
  # after_create_commit -> { broadcast_prepend_to "products" }
  # after_update_commit -> { broadcast_replace_to "products" }
  # after_destroy_commit -> { broadcast_remove_to "products" }

  # Asynchronous broacast
  # after_create_commit -> { broadcast_prepend_later_to "products" }
  # after_update_commit -> { broadcast_replace_later_to "products" }
  # after_destroy_commit -> { broadcast_remove_to "products" }

  # Equal al the code above

  broadcasts_to ->(product) { [product.company, "products"] }, inserts_by: :prepend
end
