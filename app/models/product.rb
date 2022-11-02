class Product < ApplicationRecord
  validates :name, presence: true, uniqueness: { case_sensitive: false }
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

  broadcasts_to ->(product) { "products" }, inserts_by: :prepend
end
