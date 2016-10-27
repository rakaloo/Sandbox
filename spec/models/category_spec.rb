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

  describe "associations" do
    let!(:category) { Category.create(name: "potato") }
    let!(:another_category) { Category.create(name: "onion") }

    let (:articles) { [Article.create(), Article.create()] }

    let (:categorizations) { [Categorization.create(article: articles[0], category: category), Categorization.create(article: articles[1], category: category), Categorization.create(article: articles[1], category: another_category), Categorization.create(article: articles[0], category: another_category)] }

    it "has many articles" do
      expect(category.articles).to all be_a Article
    end

    it "has many categorizations" do
      expect(category.categorizations).to all be_a Categorization
    end

  end
end
