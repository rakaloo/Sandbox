require 'slim'

user_seeds = [
  { username: "rach", email: "rach@sandbox.com", password: "password", role: "Admin" },
  { username: "will", email: "will@sandbox.com", password: "password" },
  { username: "sayam", email: "sayam@sandbox.com", password: "password" },
  { username: "john", email: "john@sandbox.com", password: "password" },
  { username: "nick", email: "nick@sandbox.com", password: "password" },
]

user_seeds.each { |user| User.create(user) }

10.times { Article.create }

version_seeds = [
  { title: "Turtle", body: File.open("#{Rails.root}/db/seed_files/turtle.html").read , article_id: 1, editor_id: 1 },
  { title: "Bat", body: File.open("#{Rails.root}/db/seed_files/bat.html").read , article_id: 2, editor_id: 2 },
  { title: "Caterpiller", body: File.open("#{Rails.root}/db/seed_files/caterpillar.html").read , article_id: 3, editor_id: 3 },
  { title: "Capybara", body: File.open("#{Rails.root}/db/seed_files/capybara.html").read , article_id: 4, editor_id: 4 },
  { title: "DNA", body: File.open("#{Rails.root}/db/seed_files/dna.html").read , article_id: 5, editor_id: 5 },
  { title: "Volcano", body: File.open("#{Rails.root}/db/seed_files/volcano.html").read , article_id: 6, editor_id: 6 },
  { title: "Photosynthesis", body: File.open("#{Rails.root}/db/seed_files/photosynthesis.html").read , article_id: 7, editor_id: 7 },
  { title: "Mars", body: File.open("#{Rails.root}/db/seed_files/mars.html").read , article_id: 8, editor_id: 8 },
  { title: "Jupiter", body: File.open("#{Rails.root}/db/seed_files/jupiter.html").read , article_id: 9, editor_id: 9 },
  { title: "Zeus", body: File.open("#{Rails.root}/db/seed_files/zeus.html").read , article_id: 10, editor_id: 10 }
]

version_seeds.each { |version| Version.create(version) }

category_seeds = [
  { name: "Science" },
  { name: "Animal" },
  { name: "Mammal" },
  { name: "Planet" },
  { name: "Mythology" },
  { name: "Insect" }
]

category_seeds.each { |category| Category.create(category) }

categorization_seeds = [
  { article_id: 1, category_id: 2},
  { article_id: 2, category_id: 2},

  { article_id: 3, category_id: 2},
  { article_id: 3, category_id: 6},

  { article_id: 4, category_id: 3},
  { article_id: 4, category_id: 2},

  { article_id: 5, category_id: 1},
  { article_id: 6, category_id: 1},
  { article_id: 7, category_id: 1},

  { article_id: 8, category_id: 4},
  { article_id: 9, category_id: 4},
  { article_id: 10, category_id: 5}
]

categorization_seeds.each { |categorization| Categorization.create(categorization) }
