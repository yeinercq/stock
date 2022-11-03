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

for i in 1..10 do
  Customer.create!(
    name: Faker::Name.name,
    email: "person#{i}@mail.com",
    phone_number: "11111111#{i}",
    id_number: "123456#{i}",
    address: "Valencia de la paz"
  )
end

puts "Customers has been created."
