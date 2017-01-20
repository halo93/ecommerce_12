User.create! email: "admin@gmail.com", password: "123456",
  password_confirmation: "123456", name: "Do Ha Long", role: 0
User.create! email: "kominam.2511@gmail.com", password: "foobar",
  password_confirmation: "foobar", name: "Nam DV", role: 0
User.create! email: "dohalong1993@gmail.com", password: "123456",
  password_confirmation: "123456", name: "Do Ha Long", role: 0

20.times do |n|
  name  = FFaker::Name.name
  email = "example-#{n + 1}@framgia.com"
  password = "password"
  phone = FFaker::PhoneNumber.phone_number
  User.create! name: name,
    email: email,
    phone: phone,
    password: password,
    password_confirmation: password,
    role: 1
end

user = User.find 3
30.times do |n|
  title = "Suggest #{n}"
  content = FFaker::Lorem.paragraph
  Suggest.create! title: title,
    content: content,
    user_id: user.id,
    category_id: nil
end

Category.create name: "Valentine Giftbox",
  description: "This is valentine giftbox", depth: 0, lft: 1, rgt: 6
Category.create name: "Giftbox for lover",
  description: "This is Giftbox for lover", depth: 1, lft: 2, rgt: 3
Category.create name: "Giftbox for parents",
  description: "This is Giftbox for parents", depth: 1, lft: 4, rgt: 5
Category.create name: "New Year Giftbox",
  description: "This is New Year Giftbox", depth: 0, lft: 7, rgt: 20
Category.create name: "Giftbox for parents-in-law",
  description: "This is Giftbox for parents-in-law", depth: 1, lft: 8, rgt: 9
Category.create name: "Giftbox for boss",
  description: "This is Giftbox for boss", depth: 1, lft: 10, rgt: 11
Category.create name: "Giftbox for pet",
  description: "This is Giftbox for pet", depth: 1, lft: 12, rgt: 13
Category.create name: "Giftbox for grandparents",
  description: "This is Giftbox for grandparents", depth: 1, lft: 14, rgt: 15
Category.create name: "Giftbox for friend",
  description: "This is Giftbox for friend", depth: 1, lft: 16, rgt: 17
Category.create name: "Giftbox for trainer",
  description: "This is Giftbox for trainer", depth: 1, lft: 18, rgt: 19

10.times do |p|
  product_name = FFaker::Food.fruit + p.to_s
  description = "a gift box, complete with fill,"\
    "and attractively wrapped in cellophane."
  price = 100
  in_stock = 10
  category_id = p + 1
  Product.create! name: product_name,
    description: description,
    price: price,
    in_stock: in_stock,
    category_id: category_id
end
