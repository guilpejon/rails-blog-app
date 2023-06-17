User.destroy_all

30.times do
  name = Faker::TvShows::TheOffice.character
  name = Faker::TvShows::TheOffice.character while User.pluck(:name).include? name

  user = User.create(
    name: name,
    email: "#{name.downcase.gsub(' ', '_')}@theoffice.com",
    password: 'password' # Replace with the desired default password for the generated users
  )
  url = URI.parse(Faker::Avatar.image)
  downloaded_image = URI.open(url)
  user.profile_pic.attach(io: downloaded_image, filename: 'profile_pic.jpg')
end

puts User.pluck(:name, :email)
