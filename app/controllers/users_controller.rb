class UsersController < ApplicationController

def index
end

 def show
  @user = User.find(params[:id])
 end

 def new
  @user = User.new
 end

 def create
  @user = User.new(user_params)
  if @user.save
    flash[:success] = "Welecome to Student app" 
   redirect_to @user
  else
   render 'new'
  end
end

def edit
end

#def update
#  if @user.update_attributes(user_params)
#  redirect_to @user
# else
#  render 'edit'
# end
# end

# def destroy
#   User.find(params[:id]).destroy
# end
#end
end 
private 

def user_params
   params.require(:user).permit(:name, :email, :occupation,:password, :avatar, :password_confirmation)
end

