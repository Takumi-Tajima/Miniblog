30.times do |_n|
  user = User.new(
    name: Faker::Internet.username.gsub(/\.|_/, ''),
    email: Faker::Internet.email,
    password: Faker::Internet.password(min_length: 8)
  )

  puts user.attributes
  user.save!
end
