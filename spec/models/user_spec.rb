require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe "reader and writer attributes" do
    let (:user) { User.create(username: "pentella", email: "npentella@gmail.com", password: "password") }

    it "has a readable username" do
      expect(user.username).to eq "pentella"
    end

    it "has a writable username" do
      user.username = "nick"
      expect(user.username).to eq "nick"
    end

    it "has a email" do
      expect(user.email).to eq "npentella@gmail.com"
    end

    it "has a writable email" do
      user.email = "nnnnn@nnnn.com"
      expect(user.email).to eq "nnnnn@nnnn.com"
    end

    it "has a role" do
      expect(user.role).to eq "User"
    end

  end

  describe "validations" do
    it "is not valid without an username" do
      user = User.new(email: "npentella@gmail.com", password: "password")
      expect(user.valid?).to eq false
    end

    it "is not valid without an email" do
      user = User.new(username: "pentella", password: "password")
      expect(user.valid?).to eq false
    end

    it "is valid with an email and password" do
      user = User.new(username: "pentella", email: "npentella@gmail.com", password: "password")
      expect(user.valid?).to eq true
    end
  end

  describe "associations" do
    let (:user) { User.create(username: "pentella", email: "npentella@gmail.com", password: "password") }

    let (:articles) { [Article.create(), Article.create()] }

    let (:versions) { [Version.create(title: "it's a test title", body: "it's a test body", article: articles[0], editor: user ), Version.create(title: "it's second test title", body: "it's  second test body", article: articles[1], editor: user)] }

    it "has many versions" do
      user.versions = versions
      expect(user.versions[0]).to be_a Version
    end

    it "has many articles" do
      user.articles = articles
      expect(user.articles[0]).to be_a Article
    end

  end


  pending "add some examples to (or delete) #{__FILE__}"
end
