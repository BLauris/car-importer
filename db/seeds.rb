manufacturers = ["Honda", "Ford", "Mazda", "Opel", "Peogeot", "Lada"]

puts "Started Seeding..."

30.times do
  Car.create!(
    manufacturer: manufacturers.sample,
    price: rand(1000..100000),
    used: [true, false].sample,
    note: Faker::Lorem.sentence
  )
end

puts "Seed Finished!"
