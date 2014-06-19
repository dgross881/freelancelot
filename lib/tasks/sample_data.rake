namespace :db do 
  desc "Fill database with sample data"
  task populate: :environment do
   make_users 
   make_microposts 
  end 
end 

def make_users  
   User.create!(name: "Example User",
                email: "example@example.com",
                occupation: "Ruby on Rails",
                password: "foobar",
                password_confirmation: "foobar" )
   
   99.times do |n|
    name =  Faker::Name.name 
    email =  Faker::Internet.email 
    occupation = "Ruby on Rails" 
    password = 'foobar'
    password_confirmation = 'foobar'
    User.create!(name: name, 
                 email: email,
                 occupation: occupation, 
                 password: password,
                 password_confirmation: password_confirmation) 
 end 
end 

def make_microposts 
   users = User.all.limit(6)
   50.times do
   content = Faker::Lorem.sentence(5)
   users.each { |user| user.microposts.create!(content: content) }
 end 
 end 
