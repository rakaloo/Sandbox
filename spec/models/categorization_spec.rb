require 'rails_helper'

RSpec.describe Categorization, type: :model do
  describe "validations" do
    let (:article) { Article.create}
    let (:category) { Category.create(name: "Clouds") }
    # let (:categorization_1) { Categorization.create(article)}
    # let (:categorization_2) { Categorization.create(article: article, category: category) }

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

  # describe "associations" do
  #   let!(:category) { Category.create(name: "potato") }
  #   let!(:another_category) { Category.create(name: "onion") }

  #   let (:articles) { [Article.create(), Article.create()] }

  #   let (:categorizations) { [Categorization.create(article: articles[0], category: category), Categorization.create(article: articles[1], category: category), Categorization.create(article: articles[1], category: another_category), Categorization.create(article: articles[0], category: another_category)] }

  #   it "has many articles" do
  #     expect(category.articles).to all be_a Article
  #   end

  #   it "has many categorizations" do
  #     expect(category.categorizations).to all be_a Categorization
  #   end

  # end
end
