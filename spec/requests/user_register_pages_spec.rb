require 'spec_helper'

feature 'User registers' do #, {js: true, vcr: true}do
  before do
    visit signup_path
  end
 
 scenario "user visits sign up page" do 
  expect(page).to have_content('Sign up') 
  expect(page).to have_title('Sign up') 
 end 
   
 scenario "with valid user info" do
    fill_in_valid_user_info
    expect{ click_button "Sign up" }.to change(User, :count).by(1)
    expect(page).to have_selector('div.alert.alert-success')
    expect(page).to have_content("Welcome to the Sample App!")
    expect(page).to have_title("John Doe")
  end

 scenario "should create user" do 
 end 
 
 scenario "with invalid info" do
    fill_in_invalid_user_info
    expect{ click_button "Sign up" }.not_to change(User, :count).by(1)
    expect(page).to have_content("Name can't be blank")
    expect(page).to have_content("Email can't be blank")
  end

  def fill_in_valid_user_info
    fill_in "Name", with: "John Doe"
    fill_in "Email", with: "biggy@email.com"
    fill_in "Occupation", with: "Ruby on Rails" 
    fill_in "Password", with: "123456"
    fill_in "Confirmation", with: "123456" 
  end


  def fill_in_invalid_user_info
    fill_in "Name", with: nil
    fill_in "Email", with: nil
    fill_in "Password", with: "123456"
    fill_in "Confirmation", with: "123456" 
    fill_in "Occupation", with: "Ruby on Rails" 
  end
end 
