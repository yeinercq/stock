for i in 1..10 do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Commerce.material,
    unit: 1
  )
end

puts "Products has been created."
