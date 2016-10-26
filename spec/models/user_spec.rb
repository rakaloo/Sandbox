require 'rails_helper'
require 'spec_helper'

RSpec.describe User, type: :model do
  describe "reader and writer attributes" do
    let (:user) { User.new(username: "pentella", email: "npentella@gmail.com", password: "password") }

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

  end
  pending "add some examples to (or delete) #{__FILE__}"
end
