require 'spec_helper'

describe RelationshipsController do
   let(:user) { FactoryGirl.create(:user) }
   let(:other_user) { FactoryGirl.create(:user) }
   before do 
     user.follow!(other_user) 
   end 
   context "#new controller" do 
    it "does not show relationships when not signed in" do 
     get :new  
     expect(response).to redirect_to signin_path 
    end 

    it "renders the new index when signed in" do 
      sign_in(user) 
      get :new
      expect(response).to render_template :new  
    end 
    
     it "has a a flash error if the follower_id:param is missing" do 
      sign_in(user)
      get :new, {} 
      expect(response.request.flash[:error]).not_to be_nil
    end 

  it "display the friends name if followed" do 
     get :new
     expect(response).to have_content(user.name)
     end 
   end 
end 



