require 'rails_helper'
include RSpecHtmlMatchers

feature 'Viewing all categories' do
	scenario 'Seeing all categories in sidebar' do
		Category.create(name: "Test 1")
		Category.create(name: "Test 2")
		Category.create(name: "Test 3")
		Category.create(name: "Test 4")

		visit '/'

		within('#sidebar') do
			expect(page).to have_tag('h4', count: 4)
		end
	end
end
