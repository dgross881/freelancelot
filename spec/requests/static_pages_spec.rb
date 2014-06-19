require 'spec_helper'

describe "StaticPages" do
  subject { page } 
  
  describe "Home Page"  do
    before {visit root_path } 
     
   it {should have_title('Welcome To Student App') }
   it {should_not have_title('| Home') }

  describe "for signed-in users" do
  let(:user) {FactoryGirl.create(:user) } 
   before do 
    FactoryGirl.create(:micropost, user: user) 
    FactoryGirl.create(:micropost, user: user) 
    sign_in user
    visit root_path 
   end
   
   it "should render the user's feed" do 
     user.feed.each do |item|
       expect(page).to have_selector("li##{item.id}", text: item.content) 
    end 
   end 
  end
 end 

  describe "Help page" do
   before { visit help_path }

   it {should have_selector('h1', text: 'Need Help Selecting the Right Book ?')}  
   it {should have_title(full_title("Help"))}
  
  end 
   
  describe "About Page"  do
   before {visit about_path } 
    
   it {should have_selector('h1', text: 'We Help Students Find The Books They Need')}
   it {should have_title('About') } 
 end
 
 describe "Contact page" do 
   before {visit contact_path } 

   it { should have_selector('h1', text: "Contact") } 
   it { should have_title("Contact") } 
   end 
   it "has the right links on layout" do 
     visit root_path 
     first(:link, "Sign in").click  
     page.has_title? "Sign in"
     click_link "About" 
     page.has_title? "About" 
     click_link "Home" 
     page.has_no_title? "Home" 
     click_link "Sign up"
     page.has_title? "Sign up" 
   end 
 end 
