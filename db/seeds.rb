# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rake db:seed (or created alongside the db with db:setup).
#
# Examples:
#
#   cities = City.create([{ name: 'Chicago' }, { name: 'Copenhagen' }])
#   Mayor.create(name: 'Emanuel', city: cities.first)

puts "Seeding Data ..."

# Helper functions
def open_asset(file_name)
  File.open(Rails.root.join('db', 'seed_assets', file_name))
end

# Only run on development (local) instances not on production, etc.
# unless Rails.env.development?
#   puts "Development seeds only (for now)!"
#   exit 0
# end

# Let's do this ...

## CATEGORIES

puts "Finding or Creating Categories ..."

cat1 = Category.find_or_create_by! name: 'Apparel'
cat2 = Category.find_or_create_by! name: 'Electronics'
cat3 = Category.find_or_create_by! name: 'Furniture'

## PRODUCTS

puts "Re-creating Products ..."

Product.destroy_all

p1 = cat1.products.create!({
  name:  'Men\'s Classy shirt',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/apparel1.jpg',
  quantity: 10,
  price: 64.99
})

cat1.products.create!({
  name:  'Women\'s Zebra pants',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/apparel2.jpg',
  quantity: 18,
  price: 124.99
})

cat1.products.create!({
  name:  'Hipster Hat',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/apparel3.jpg',
  quantity: 4,
  price: 34.49
})

cat1.products.create!({
  name:  'Hipster Socks',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/apparel4.jpg',
  quantity: 8,
  price: 25.00
})

cat1.products.create!({
  name:  'Russian Spy Shoes',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/apparel5.jpg',
  quantity: 8,
  price: 1_225.00
})

cat1.products.create!({
  name:  'Human Feet Shoes',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/apparel6.jpg',
  quantity: 82,
  price: 224.50
})


cat2.products.create!({
  name:  'Modern Skateboards',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/electronics1.jpg',
  quantity: 40,
  price: 164.49
})

cat2.products.create!({
  name:  'Hotdog Slicer',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/electronics2.jpg',
  quantity: 3,
  price: 26.00
})

cat2.products.create!({
  name:  'World\'s Largest Smartwatch',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/electronics3.jpg',
  quantity: 32,
  price: 2_026.29
})

p10 = cat3.products.create!({
  name:  'Optimal Sleeping Bed',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/furniture1.jpg',
  quantity: 320,
  price: 3_052.00
})

p11 = cat3.products.create!({
  name:  'Electric Chair',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/furniture2.jpg',
  quantity: 2,
  price: 987.65
})

p12 = cat3.products.create!({
  name:  'Red Bookshelf',
  description: Faker::Hipster.paragraph(4),
  image: 'https://res.cloudinary.com/chronosphere111/image/upload/v1522716307/furniture3.jpg',
  quantity: 23,
  price: 2_483.75
})

u1 = User.create!({
  first_name: "Wilfred",
  last_name: "Farraway",
  email: "WFarraway@gmail.com",
  password: "pass1",
  password_confirmation: "pass1"
})

u2 = User.create!({
  first_name: "Allison",
  last_name: "Wright",
  email: "AWright@gmail.com",
  password: "pass2",
  password_confirmation: "pass2"
})

p1.reviews.create!({
  user_id: 1,
  description: "This is a classy shirt",
  rating: 4
})

p12.reviews.create!({
  user_id: 1,
  description: "Its an okay bookshelf",
  rating: 3
})

p12.reviews.create!({
  user_id: 2,
  description: "I love the colour!",
  rating: 4
})

p11.reviews.create!({
  user_id: 1,
  description: "It vibrates!",
  rating: 5
})

p10.reviews.create!({
  user_id: 1,
  description: "Not at all comfortable",
  rating: 1
})

puts "DONE!"
