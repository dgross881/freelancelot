module SessionsHelper
 def sign_in(user)  
   cookies.permanent[:remember_token] = remember_token  
 end 
end
