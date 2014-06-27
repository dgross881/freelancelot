require 'spec_helper' 

feature 'Profilepage' do 
  let(:user) { FactoryGirl.create(:user) } 
  let(:other_user) {FactoryGirl.create(:user) }
  before { user.follow!(other_user) } 
  
  scenario "following users (following)" do 
  sign_in user
  visit following_user_path(user)  
  expect(page).to have_title("Following") 
  end 

  scenario "followers" do 
   sign_in other_user
   visit followers_user_path(other_user)
   expect(page).to have_title('Followers') 
  end 
end 
