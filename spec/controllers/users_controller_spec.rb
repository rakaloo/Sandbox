require 'rails_helper'

RSpec.describe UsersController, type: :controller do

	describe "User registration path" do

		it "user registration redirects to login page when no email typed in" do
		post :create, { user: { username: "sayam", password: "password" } }
		# let!(:user) {User.create(username: "sayam", email: "sayam@sayam.com", password: "password")}
		expect(response).to have_http_status 302
		end
	end

	describe "user login works when email and password match, fails otherwise" do
		let!(:user) {User.create()}
	end

end
