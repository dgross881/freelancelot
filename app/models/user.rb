class User < ActiveRecord::Base
 #name 
  validates :name, presence: true, length: { maximum: 50 }  

 #validate microposts and relationships 
  has_many :microposts, dependent: :destroy
  has_many :relationships, foreign_key: "follower_id", dependent: :destroy
  has_many :followed_users, through: :relationships, source: :followed  
  has_many :reverse_relationships, foreign_key: "followed_id", 
                                   class_name: "Relationship",
                                   dependent: :destroy  
  has_many :followers, through: :reverse_relationships, source: :follower  

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
  has_attached_file :avatar, :styles => { :xsmall => "30x30", :small => "64x64", :medium => "300x300>", :thumb => "100x100>" }, 
                    :default_url => "person_:style.jpg",
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

 def following?(other_user)
  self.relationships.find_by_followed_id(other_user.id)  
 end 

 def follow!(other_user)
   self.relationships.create!(followed_id: other_user.id ) 
 end 

 def unfollow!(other_user) 
  self.relationships.find_by(followed_id: other_user.id).destroy
 end 
 
 def create_remember_token
  self.remember_token = SecureRandom.urlsafe_base64   
 end 
end



