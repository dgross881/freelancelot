class Micropost < ActiveRecord::Base
 belongs_to :user
 validates :user_id, presence: true 
 validates :content, presence: true, length: { maximum: 200 }  
 default_scope -> { order('microposts.created_at DESC') } 

end
