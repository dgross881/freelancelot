require 'spec_helper'

describe "user microposts" do 
 subject { page } 
 let(:user) { FactoryGirl.create(:user) } 
 before {sign_in user } 

describe "micropost crateion"  do
  before {visit root_path} 

  describe "with invalit info"  do
   it "should not create a micropost" do
        expect { click_button "Post" }.not_to change(Micropost, :count)
      end
   describe "error message"  do
     before {click_button "Post" } 
     it {should have_content('error') } 
   end 
  end 
 end 

 describe "destroy messages " do
   before {FactoryGirl.create(:micropost, user: user) } 
   
   describe "as correct user" do
    before {visit root_path } 
     
     it "should delete the message" do 
       expect {click_link "delete" }.to change(Micropost, :count).by(-1)
     end 
    end
  end
end 



