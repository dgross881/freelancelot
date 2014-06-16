require 'spec_helper' 

feature "User experiance" do
   subject { page }   
 
  feature "index" do
   let(:user) { FactoryGirl.create(:user) } 
   before(:each) do
    sign_in user
    visit users_path 
   end 
   
   it {should have_title("All Users") } 
   it {should have_content("All Users") } 

   feature "using pagination"  do
     before(:all) { 30.times { FactoryGirl.create(:user) }}  
     after(:all) { User.delete_all } 

     it { should have_selector('div.pagination') } 
   end
  end 

  feature  "signup page" do 
   before { visit signup_path }

   it { should have_content("Sign up") }
   it { should have_title(full_title("Sign up")) }
end 
 
 feature "signup" do

   let(:submit) { "Sign up" }

  scenario "with invalid information" do
    it "should not create a user" do
    expect { click_button submit }.not_to change(User, :count)
  end
  
   scenario "after submision"  do
     click_button submit 

    it {should have_title('Sign up') }
    it {should have_content('error') }
    it {should_not have_content('Password digest') }
  end
 end

  feature "with valid information" do
   before {visit signup_path }  
   before do
     fill_in "Name",         with: "Example User"
     fill_in "Email",        with: "user@example.com"
     fill_in "Password",     with: "foobar"
     fill_in "Confirmation", with: "foobar"
   end

  scenario"should create a user" do
   expect { click_button submit }.to change(User, :count).by(1)
  end
  feature "after saving a user"  do
   before { click_button submit }
    let(:user) { User.find_by(email: 'user@example.com') }

    it { should have_title(user.name) }
    it {should have_selector('div.alert.alert-success') }
    end 
   end
 end
 
 describe "profile page"  do
   let(:user) {FactoryGirl.create(:user) }

   before {visit user_path(user) }

   it {should have_content(user.name)} 
   it {should have_title(user.name) }
 end

 describe "edit" do 
  let(:user) { FactoryGirl.create(:user) }  
   before do 
   sign_in user 
   visit edit_user_path(user) 
 end 
   
 describe "page" do 
  it {should have_selector('h1', text: "Update your profile") }
  it {should have_title("Edit user") } 
end 
 describe "with invalid information" do
   before { click_button "Save changes" }

   it {should have_content("error") }      
 end

 describe "with valid information" do 

   let(:new_name)  { "New Name" } 
   let(:new_email) { "new@email.com" } 
   before do 
    fill_in "Name",       with: new_name 
    fill_in "Email",      with: new_email 
    fill_in "Password",   with: user.password 
    fill_in "Confirm Password", with: user.password 
    click_button "Save changes" 
   end 

   it { should have_title("New Name") } 
  # it { should have_link("Sign out", href: signout_path) } 
   it { should have_selector('div.alert.alert-success') } 
   specify {expect(user.reload.name).to eq new_name }
   specify {expect(user.reload.email).to eq new_email }  
  end 
 end 
end 
 

