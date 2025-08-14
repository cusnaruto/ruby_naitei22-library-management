require "faker"

# ===== USERS =====
puts "Creating users..."

User.create!(
  name: "Admin User",
  email: "admin@example.com",
  password: "password",
  password_confirmation: "password",
  gender: 0,
  date_of_birth: Date.new(1990, 1, 1),
  role: 1,
  status: 1, 
  activated_at: Time.zone.now
)

99.times do |n|
  User.create!(
    name: Faker::Name.name,
    email: "user#{n+1}@example.com",
    password: "password",
    password_confirmation: "password",
    gender: rand(0..2),
    date_of_birth: Faker::Date.birthday(min_age: 18, max_age: 65),
    role: 0,
    status: 1,
    activated_at: Time.zone.now
  )
end

# ===== AUTHORS =====
puts "Creating authors..."

10.times do
  Author.create!(
    name: Faker::Book.author
  )
end

# ===== PUBLISHERS =====
puts "Creating publishers..."

5.times do |i|
  Publisher.create!(
    name: "Publisher #{i}"
  )
end

# ===== CATEGORIES =====
puts "Creating categories..."

categories = []
5.times do |i|
  categories << Category.create!(
    name: "Category #{i}"
  )
end

# ===== BOOKS =====
puts "Creating books..."

100.times do
  available = rand(0..10)
  total = available + 5
  borrow = rand(0..100)

  book = Book.create!(
    title: Faker::Book.title,
    description: Faker::Lorem.paragraph(sentence_count: 5),
    author: Author.order("RAND()").first,       # ✅ sửa RANDOM() → RAND()
    publisher: Publisher.order("RAND()").first, # ✅ sửa RANDOM() → RAND()
    publication_year: 2000,
    total_quantity: total,
    available_quantity: available,
    borrow_count: borrow
  )

  image_paths = [
    Rails.root.join("app/assets/images/book1.jpg"),
    Rails.root.join("app/assets/images/book2.jpg"),
    Rails.root.join("app/assets/images/book3.jpg")
  ]

  # Gắn ảnh ngẫu nhiên
  book.image.attach(
    io: File.open(image_paths.sample),
    filename: "book_cover.jpg",
    content_type: "image/jpeg"
  )

  book.categories << categories.sample(rand(1..3))
end

users = User.all
books = Book.all

books.each do |book|
  reviewers = users.sample(rand(3..10)) # mỗi sách có từ 3 đến 10 người đánh giá

  reviewers.each do |user|
    Review.create!(
      user: user,
      book: book,
      score: rand(1..5),
      comment: Faker::Lorem.sentence(word_count: rand(5..15))
    )
  end
end

puts "✅ Done seeding."
