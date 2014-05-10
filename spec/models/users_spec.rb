require 'spec_helper' 


describe User do
subject { @user } 

before do
  @user = User.new(name: "David Gross", email: "example@gmail.com", password: "foobar", password_confirmation: "foobar")
end

 describe "User validation"  do
  it {should respond_to(:name) } 
  it {should respond_to(:email) }
  it {should respond_to(:password_digest) }
  it {should respond_to(:password) }
  it {should respond_to(:password_confirmation) }
  it {should respond_to(:remember_token) } 

 end 
 
 describe "When no names are present"  do
   before {@user.name = " " }
   it {should_not be_valid } 
 end
 
 describe "When name is too long"  do
   before { @user.name = "a" * 52 } 
   it {should_not be_valid }
 end
 describe "When no emails are present" do 
   before {@user.email = " "}
   it {should_not be_valid }  
 end 


 describe "when emails are invalid" do
  it "has invalid email" do
    addresses = %w[user@foo,com user_at_foo.org example.user@foo.
                  foobar@bar_baz.com foo@bar+baz.com ]
  addresses.each do |invalid_emails|
    @user.email = invalid_emails
    expect(@user).to_not be_valid 
    end 
  end
end 
 
 context "When emails are valid"  do
  it "has a valid email" do
  addresses = %w[user@foo.COM A_US-ER@f.b.org frist.lst@foo.jp a+b@baz.cn]
    addresses.each do |valid_email|
    @user.email = valid_email
     expect(@user).to be_valid 
   end 
  end
 end  
 
describe "when password_confirmation is not present" do 
  before { @user.password = @user.password_confirmation = "" } 
  it {should_not be_valid} 
 end 

  context "when password_confirmation is a mismatch" do 
  before { @user.password_confirmation = "notthesame" }
  it {should_not be_valid } 
 end 

  context "When password is to short" do 
  before { @user.password = @user.password_confirmation =  "a" * 5  }
  it  { should_not be_valid }  
 end 

  context "remember tokenin is used in the password" do 
  before { @user.save } 
    it "will not be blank" do 

    expect(subject.remember_token).to_not be_nil 
    end 
  end 
end 

