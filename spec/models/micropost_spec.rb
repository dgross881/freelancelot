require 'spec_helper'

describe Micropost do
 let(:user) { FactoryGirl.create(:user) } 
 let(:micropost) { FactoryGirl.create(:micropost, 
                                      user: user,
                                      user_id: user.id)}
 subject { micropost }

 it {should respond_to(:content) } 
 it {should respond_to(:user_id) } 
 it {should belong_to(:user) } 
 
 it {should be_valid } 

 context "is invalid when user_id is not present" do 
  before { micropost.user_id = nil } 
  it {should_not be_valid } 
 end 

 context "is invalid with blank content" do
  before {micropost.content = nil }
  it {should_not be_valid } 
 end 

 context "is invalid with  content that is too long" do
  before {micropost.content = "a" * 201 } 
  it { should_not be_valid } 
  end 
end
