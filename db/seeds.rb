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
  { title: "Turtles", body: "Turtles are great!", article_id: , editor_id:  },
]
