require 'rails_helper'

RSpec.describe Category, type: :model do

  describe "reader and writer attributes" do
    let (:category) { Category.create(name: "dogs") }

    it "has a readable name" do
      expect(category.name).to eq "dogs"
    end

    it "has a writable name" do
      category.name = "popcorn"
      expect(category.name).to eq "popcorn"
    end

  end

  describe "validations" do
    let!(:category) { Category.create(name: "potato") }

    it "is not valid without an name" do
      category = Category.new
      expect(category.valid?).to eq false
    end

    it "is not valid if the name is not unique" do
      category = Category.new(name: "potato")
      expect(category.valid?).to eq false
    end

    it "is valid with a name" do
      category = Category.new(name: "onion")
      expect(category.valid?).to eq true
    end
  end

  # describe "associations" do
  #   let (:user) { User.create(username: "pentella", email: "npentella@gmail.com", password: "password") }

  #   let (:articles) { [Article.create(), Article.create()] }

  #   let (:versions) { [Version.create(title: "it's a test title", body: "it's a test body", article: articles[0], editor: user ), Version.create(title: "it's second test title", body: "it's  second test body", article: articles[1], editor: user)] }

  #   it "has many versions" do
  #     user.versions = versions
  #     expect(user.versions[0]).to be_a Version
  #   end

  #   it "has many articles" do
  #     user.articles = articles
  #     expect(user.articles[0]).to be_a Article
  #   end

  end
  pending "add some examples to (or delete) #{__FILE__}"
end
