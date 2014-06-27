require 'spec_helper'

feature "StaticPages" do
  
  scenario "visit Home Page"  do
    visit root_path  
     
   expect(page).to have_title('Welcome To Student App') 
   expect(page).not_to have_title('| Home') 
  end 

  scenario "visit Help page" do
   visit help_path 

   expect(page).to have_content('Need Help Selecting the Right Book ?')  
   expect(page).to have_title(full_title("Help"))
  end 
   
  scenario "visit About Page"  do
   visit about_path  
    
   expect(page).to have_content('We Help Students Find The Books They Need')
   expect(page).to have_title('About')
 end

  feature "following/followers count" do 
   let(:user) {FactoryGirl.create(:user) } 
   let(:other_user) { FactoryGirl.create(:user) } 
   before do 
     sign_in(user)
     other_user.follow!(user)
   end 
   
  scenario "following/follower links work" do
   visit root_path
   expect(page).to have_link("0 following", href: following_user_path(user))
   expect(page).to have_link("1 followers", href: followers_user_path(user))
  end 
 end

 scenario "visit Contact page" do 
   visit contact_path  

   expect(page).to have_content("Contact")  
   expect(page).to have_title("Contact")  
   end 
   
   scenario "All the links correctly linked" do 
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
