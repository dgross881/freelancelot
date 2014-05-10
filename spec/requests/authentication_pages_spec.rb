require 'spec_helper'
describe "Authentication Pages" do
#save_and_open_page; 
 subject { page } 
  describe "Signin page" do   
    before { visit signin_path }

    it { should have_selector('h1', text: 'Sign in') } 
    it { should have_title('Sign in') } 
  end

describe "Sign up"  do
     before { visit signin_path }
  
  context "With valid information" do 
    let(:user) { FactoryGirl.create(:user) } 
   
   before do 
     fill_in "Email", with: user.email
     fill_in "Password", with: user.password
     click_button "Sign in" 
    end 

    it {should_have title(user.name) }
    it {should have_link('Profile', href: user_path(user)) } 
    it {should have_link('Sign out', href: signout_path) } 
    it {should_not have('Sign in', href: signin_path) } 
  end 
  
  context  "with invalid informationd" do 
    before {click_button "Sign in" } 

    it {should have_title("Sign in") }
    it {should have_selector("div.alert-error") }
   
   context  "after visiting another page"  do
     before { click_link "Home" }
       it { should_not have_selector('div.alert-error') }  
     end
    end
  end 
end 
