require 'spec_helper'

 feature "User microposts" do 
   let!(:user){ FactoryGirl.create(:user) }
   let!(:m1) {FactoryGirl.create(:micropost, user: user)}  
   let!(:m2) {FactoryGirl.create(:micropost, user: user)}
   before {sign_in(user) }
 
  scenario "microposts content is valid" do 
    visit root_path
    expect(page).to have_content(m1.content)
    expect(page).to have_content(m2.content) 
    expect(page).to have_content(user.microposts.count)
   end 
 
   scenario "Post a micropost with no content"  do 
    expect { click_button "Post" }.not_to change(Micropost, :count)
    expect(page).to have_content("Content can't be blank")  
   end 

   
   scenario "post a micropost with valid content" do 
      fill_in 'micropost_content', with: "Lorem ipsum" 
      expect { click_button "Post" }.to change(Micropost, :count).by(1)
    end
   
   scenario "delete microposts that have been posted" do 
    expect { first(:link, "delete").click}.to change(Micropost, :count) .by(-1)
    end 
   
   scenario "render the user's feed" do 
     user.feed.each do |post|
      expect(page).to have_selector("li##{post.id}", text: post.content) 
    end 
   end 
 end
  
 




