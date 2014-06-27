require 'spec_helper' 

feature 'Sign in page' do 
   let!(:user) { FactoryGirl.create(:user) }
   before do 
    visit signin_path 
   end 

    scenario "user visists sign in page" do 
      expect(page).to have_content('Sign in')
      expect(page).to have_title('Sign in')
    end 

    scenario "with valid email address and password" do
        user = create(:user) 
        sign_in(user)
        expect(page).to  have_content("Welcome back #{user.name} !")
     end
   
    scenario "with invalid email address" do 
      fill_in "Email", with:user.email
      fill_in "Password", with: "wrong password"
      click_button "Sign in"
      expect(page).to have_error_message('Invalid email/password combination')
   end 
   
   scenario "when signed in" do 
     sign_in(user)
     visit user_path(user) 
     expect(page).to have_title(user.name) 
     expect(page).to have_link('Users',    href: users_path) 
     expect(page).to have_link('Profile',  href: user_path(user)) 
     expect(page).to have_link('Settings', href: edit_user_path(user))
     expect(page).to have_link('Sign out', href: signout_path) 
   end 
   
   scenario "signing out a user changes the links" do
    sign_in(user)
    click_link "Sign out" 
   expect(page).to have_link('Sign in') 
   end
  end
 
                          
