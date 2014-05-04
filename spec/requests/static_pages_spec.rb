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

end
end  
