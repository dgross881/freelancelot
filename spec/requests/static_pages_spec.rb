require 'spec_helper'

describe "StaticPages" do
  subject { page } 
  
  describe "Home Page"  do
    before {visit root_path } 
     
    it {should have_selector('h1', text: 'Welcome To Student App') }
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
     click_link "Sign in" 
     page.has_title? "Sign in"
     click_link "About" 
     page.has_title? "About" 
     click_link "Home" 
     page.has_no_title? "Home" 
     click_link "Sign up Now!" 
     page.has_title? "Sign up" 
   end 
 end 
