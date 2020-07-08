require "faker"

10.times do
  user_name = Faker::Name.name
  user_hometown = Faker::Address.city
  user_password = Faker::Alphanumeric.alphanumeric(number: 10)
  place_name = Faker::Address.community
  place_city = Address.city
  place_country = Address.country
  place_user_id = rand(1..10)
  User.create(name: user_name, hometown: user_hometown, password: user_password)
end