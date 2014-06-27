require 'spec_helper' 


describe User do
 subject { @user } 

before do
  @user = User.new(name: "David Gross", email: "example@gmail.com", password: "foobar", password_confirmation: "foobar")
end

 describe "validations on user model"  do
  it {should validate_presence_of :name } 
  it {should validate_uniqueness_of :email }
  it {should have_secure_password }
  it {should respond_to(:password_digest) }
  it {should validate_presence_of :password_confirmation }
  it {should respond_to :remember_token } 
  it {should respond_to :feed } 
  it {should respond_to :following? }
  it {should respond_to :follow! } 
  it {should respond_to :unfollow! } 
  it {should have_many  :microposts } 
  it {should have_many  :relationships } 
  it {should have_many  :followers} 
  it {should have_many  :reverse_relationships } 
  it {should have_many  :followed_users } 

  it {should be_valid } 
 end 
 
 context "is invalid with no names  present"  do
   before {@user.name = " " }
   it {should_not be_valid } 
 end
 
 context "is invalid with a name too long"  do
   before { @user.name = "a" * 52 } 
   it {should_not be_valid }
 end

 context "is invalid with no emails present" do 
   before {@user.email = " "}
   it {should_not be_valid }  
 end 


 context "is invalid with invalid emails" do
  it "has invalid email" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                  foobar@bar_baz.com foo@bar+baz.com ]
  addresses.each do |invalid_emails|
    @user.email = invalid_emails
    expect(@user).to_not be_valid 
    end 
  end
end 
 
 context "does not allow invalid emails"  do
  it "has a valid email" do
  addresses = %w[user@foo.COM A_US-ER@f.b.org frist.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_email|
    @user.email = valid_email
     expect(@user).to be_valid 
   end 
  end
 end  
 
  context  "is invalid when password_confirmation is not present" do 
  before { @user.password = @user.password_confirmation = "" } 
  it {should_not be_valid} 
 end 

  context "is invalid when password_confirmation is a mismatch" do 
  before { @user.password_confirmation = "notthesame" }
  it {should_not be_valid } 
 end 

  context "is invalid when password is to short" do 
  before { @user.password = @user.password_confirmation =  "a" * 5  }
  it  { should_not be_valid }  
 end 

  context "returns a remember tokenin for a password" do 
  before { @user.save } 
  its(:remember_token) {should_not be_blank} 
    it "will not be blank" do 

    expect(subject.remember_token).to_not be_nil 
    end 
  end 
  
  
  describe "micropost associations" do

    before { @user.save }
    let!(:older_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.day.ago)
    end
    let!(:newer_micropost) do
      FactoryGirl.create(:micropost, user: @user, created_at: 1.hour.ago)
    end

    it "should have the right microposts in the right order" do
      expect(@user.microposts.to_a).to eq [newer_micropost, older_micropost]
     end
  
  it "deletes associated microposts" do
     microposts = @user.microposts
     @user.destroy
     microposts.each do |micropost|
      expect(Micropost.where(id: micropost.id)).to be_empty 
   end 
  end 
  
  context "satus" do
   let(:unfollowed_post) do
      FactoryGirl.create(:micropost, user: FactoryGirl.create(:user))
    end 
    its(:feed) {should include(older_micropost) }
    its(:feed) {should include(newer_micropost) }
    its(:feed) {should_not include(unfollowed_post) }  
  end
 end

  context "following" do
   let(:other_user) {FactoryGirl.create(:user) }
   before do 
    @user.save
    @user.follow!(other_user)
   end 

   it { should be_following(other_user) }
   its(:followed_users) { should include(other_user)}
 
 context "followed users" do 
   subject { other_user } 
   its(:followers) { should include(@user) } 
 end 
 context "describe unfollowing" do
   before { @user.unfollow!(other_user) }
   
   it {should_not be_following(other_user) } 
   its(:followed_users) {should_not include(other_user) }
  end 
 end
end 
