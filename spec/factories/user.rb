require "ffaker" 


FactoryGirl.define do 
 factory :user do
  name  {Faker::Name.name } 
  email {Faker::Internet.email }
  occupation 'Ruby on rails' 
  password 'secret' 
  password_confirmation 'secret'
 end 
end 
