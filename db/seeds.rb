require 'slim'

user_seeds = [
  { username: "rach", email: "rach@sandbox.com", password: "password" },
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
  { title: "Caterpiller", body: File.open("#{Rails.root}/db/seed_files/caterpiller.html").read , article_id: 3, editor_id: 3 }
]

version_seeds.each { |version| Version.create(version) }
