# Clear existing data (optional - be careful in production!)
puts "Clearing existing users..."
User.destroy_all

30.times do
  User.create!(
    name: Faker::Name.name,
    email: Faker::Internet.unique.email,
    password: "password",
    password_confirmation: "password",
    role: 0, # user
    gender: [0, 1, 2].sample, # male, female, other
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 80),
    status: [0, 1].sample,
    activated_at: [nil, Time.zone.now].sample
  )
end
