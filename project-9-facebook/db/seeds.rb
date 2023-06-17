30.times do
  user = User.create(
    name: Faker::Name.name,
    email: Faker::Internet.email,
    password: 'password' # Replace with the desired default password for the generated users
  )
  url = URI.parse(Faker::LoremFlickr.image)
  downloaded_image = URI.open(url)
  user.profile_pic.attach(io: downloaded_image, filename: 'profile_pic.jpg')
end
