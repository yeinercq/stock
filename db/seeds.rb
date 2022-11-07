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

coopkahawa = Company.create!(name: "Coopkahawa")
cadefihuila = Company.create!(name: "Cadefihuila")

puts "Companies has been created."

yeiner = User.create(email: "yeiner@coopkahawa.com", password: "123456", password_confirmation: "123456", company: coopkahawa )
cristina = User.create(email: "cristina@coopkahawa.com", password: "123456", password_confirmation: "123456", company: coopkahawa )
gilberto = User.create(email: "gilberto@cadefihuila.com", password: "123456", password_confirmation: "123456", company: cadefihuila )

puts "Users has been created."

for i in 1..10 do
  coopkahawa.invoices.create!(
    client_id: 1
  )
end

puts "Invoices has been created."
