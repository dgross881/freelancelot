class StaticPagesController < ApplicationController
  def home
  	if signed_in? 
      @micropost  = current_user.microposts.build 
      @feed_items = current_user.feed.paginate(page: params[:page])
        respond_to do |format|
          format.html
          format.js # add this line for your js template
         end 
       end
     end 

  def about
  end

  def help
  end

  def contact
  end 

end
