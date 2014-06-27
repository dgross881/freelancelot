require 'spec_helper'

describe Relationship do

  let(:follower) {FactoryGirl.create(:user) }
  let(:followed) {FactoryGirl.create(:user) } 
  let(:relationship) { follower.relationships.build(followed_id: followed.id) } 
  subject { relationship }  
  
  it { should be_valid } 

  context "associations with Followers and followed" do

  it {should belong_to(:follower) } 
  it {should belong_to(:followed) }
  its(:follower) { should eq follower }
  its(:followed) { should eq followed }
  
 end   

 it "is not valid when follower id is not present" do
  relationship.follower_id = nil  
  expect(relationship).not_to be_valid 
 end 

 it "is valid when follwer id is present" do 
 end 
end
