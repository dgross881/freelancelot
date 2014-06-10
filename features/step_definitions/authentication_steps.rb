Given /^a user visits the signin page$/ do 
  visit signin_path 
end 

When /^he submit invalid singin information$/ do
  click_button "Sign in" 
end

Then /^he should see erro message$/ do
  expect(page).to have_selector('div.alert.alert-error') 
end

Given /^the user has an account$/ do
  @user = User.create(name: "Example User", email: "user@example.com",
                      password: "foobar", password_confirmation: "foobar") 
end

Given /^the user submits valid singin information$/ do
          fill_in  "Email",   with: @user.email
          fill_in  "Password", with: @user.password 
          click_button "Sign in"
end

Then /^he should see his profile page$/ do
  expect(page).to have_title(@user.name) 
end

Then /^he should see a signout link$/ do
  expect(page).to have_link("Sign out", href: signout_path)
end
