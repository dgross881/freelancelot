class User < ActiveRecord::Base
 #name 
  validates :name, presence: true, length: { maximum: 50 }  

 #validate microposts
  has_many :microposts, dependent: :destroy
 
 #email
   before_save {|user| user.email = email.downcase} 
   before_save :create_remember_token 
   EMAIL_VALIDATOR = /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i
   validates :email, presence: true, uniqueness: { case_sensitive: false }, format: { with: EMAIL_VALIDATOR } 
 
 #password 
   has_secure_password 
   validates :password, length: { minimum: 6 }  
   validates :password_confirmation, presence: true
 
 #Avatar paperclip  
  has_attached_file :avatar, :styles => { :small => "64x64", :medium => "300x300>", :thumb => "100x100>" }, :default_url => "frog.jpg",
                    :storage => :dropbox,
                    :url  => "/assets/users/:id/:style/:basename.:extension",
                    :dropbox_credentials => Rails.root.join("config/dropbox.yml")

  validates_attachment_content_type :avatar, :content_type => /\Aimage\/.*\Z/
 
def User.new_remember_token
 SecureRandom.urlsafe_base64 
end 

def feed 
 Micropost.where("user_id = ?", id) 
end 

private 
 def create_remember_token
  self.remember_token = SecureRandom.urlsafe_base64   
 end 
end


