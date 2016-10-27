require 'rails_helper'

RSpec.describe Categorization, type: :model do
  describe "validations" do
    let (:article) { Article.create}
    let (:category) { Category.create(name: "Clouds") }

    it "is not valid without an article" do
      categorization = Categorization.new(category: category)
      expect(categorization.valid?).to eq false
    end

    it "is not valid without an article" do
      categorization = Categorization.new(article: article)
      expect(categorization.valid?).to eq false
    end

    it "is valid with an article and a category" do
      categorization = Categorization.create(article: article, category: category)
      expect(categorization.valid?).to eq true
    end
  end

  describe "associations" do
    let (:article) { Article.create}
    let (:category) { Category.create(name: "Clouds") }
    let (:categorization) { Categorization.create(article: article, category: category) }

    it "belongs to an article" do
      expect(categorization.article).to be_a Article
    end

    it "belongs to a category" do
      expect(categorization.category).to be_a Category
    end

  end
end
