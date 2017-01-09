User.create! email: "admin@gmail.com", password: "123456",
  password_confirmation: "123456", name: "Do Ha Long", role: 0

20.times do |n|
  name  = Faker::Name.name
  email = "example-#{n + 1}@framgia.com"
  password = "password"
  User.create! name: name,
    email: email,
    password: password,
    password_confirmation: password,
    role: 1
end

user = User.find 3
30.times do |n|
  title = "Suggest #{n}"
  content = Faker::Lorem.paragraph
  Suggest.create! title: title,
    content: content,
    user_id: user.id,
    category_id: nil
end
