for i in 1..10 do
  Product.create!(
    name: Faker::Commerce.product_name,
    description: Faker::Commerce.material,
    unit: 1
  )
end

puts "Products has been created."

for i in 1..10 do
  Provider.create!(
    name: Faker::Company.name,
    email: "company#{i}@mail.com",
    phone_number: "3101112223"
  )
end

puts "Providers has been created."
