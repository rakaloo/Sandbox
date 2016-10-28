require 'rails_helper'

RSpec.describe Article, type: :model do

  describe "associations" do
    let!(:category) { Category.create(name: "potato") }
    let!(:another_category) { Category.create(name: "onion") }

    let (:articles) { [Article.create(), Article.create()] }

    let (:categorizations) { [Categorization.create(article: articles[0], category: category), Categorization.create(article: articles[1], category: category), Categorization.create(article: articles[1], category: another_category), Categorization.create(article: articles[0], category: another_category)] }

    let (:user) { User.create(username: "pentella", email: "npentella@gmail.com", password: "password") }

    let (:versions) { [Version.create(title: "it's a test title", body: "it's a test body", article: articles[0], editor: user ), Version.create(title: "it's second test title", body: "it's  second test body", article: articles[0], editor: user)] }

    it "has many categories" do
      expect(articles[0].categories).to all be_a Category
    end

    it "has many categorizations" do
      expect(articles[0].categorizations).to all be_a Categorization
    end

    it "has many versions" do
      expect(articles[0].versions).to all be_a Version
    end

    it "has many editors through versions" do
      expect(articles[0].editors).to all be_a User
    end
  end

  describe "class methods" do
    # let!(:category) { Category.create(name: "potato") }
    # let!(:another_category) { Category.create(name: "onion") }

    let (:article) { Article.create }

    # let (:categorizations) { [Categorization.create(article: articles[0], category: category), Categorization.create(article: articles[1], category: category), Categorization.create(article: articles[1], category: another_category), Categorization.create(article: articles[0], category: another_category)] }

    let (:user) { User.create(username: "pentella", email: "npentella@gmail.com", password: "password") }

    let (:versions) { [
                      Version.create(title: "it's a test title", body: "it's a test body", article: article, editor: user ),
                      Version.create(title: "it's second test title", body: "it's  second test body", article: article, editor: user)]
    }

    it  "returns the current_version" do
      article.versions = versions
      expect(article.current_version).to eq versions[1]
    end

    it  "returns a version as its current_version" do
      article.versions = versions
      expect(article.current_version).to be_a Version
    end

    it  "returns the cached body" do
      article.versions = versions
      expect(article.cached_body).to eq versions[0].body
    end

    it  "returns the cached_title" do
      article.versions = versions
      expect(article.cached_title).to eq versions[0].title
    end

  end
end
