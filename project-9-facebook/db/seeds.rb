50.times do
  User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password' # Replace with the desired default password for the generated users
  )
end
