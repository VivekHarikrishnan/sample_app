Given /^a user visits the sign in page$/ do
	visit signin_path
end

When /^he submits invalid sign in information$/ do
	click_button "Sign in"
end

Then /^he should see an error message$/ do
	page.should have_selector "div.alert.alert-error"
end

And /^user has an account$/ do
	@user = User.create(name: "Test", email: "test@test.com", password: "password", password_confirmation: "password")
end

And /^the user submits valid sign in information$/ do
	fill_in "Email", with: "test@test.com"
	fill_in "Password", with: "password"
	click_button "Sign in"
end

Then /^he should see his profile page$/ do
	page.should have_selector "title", text: @user.name
end

And /^he should see sign out link$/ do
	page.should have_link "Sign out", href: signout_path
end