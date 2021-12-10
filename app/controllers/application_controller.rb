class ApplicationController < ActionController::Base
  before_action(:load_current_user)
  
  # Uncomment this if you want to force users to sign in before any other actions
  before_action(:force_user_sign_in)
  
  def load_current_user
    the_id = session[:user_id]
    @current_user = User.where({ :id => the_id }).first
  end
  
  def force_user_sign_in
    if @current_user == nil
      redirect_to("/user_sign_in", { :notice => "You have to sign in first." })
    end
  end

  def homepage

    # Variables for Things to Read section 
      user_articles = @current_user.articles.order(created_at: "desc")    
      @things_to_read = user_articles.first(5)

    # Variables for Things I've Learned section
      user_takeaways = @current_user.takeaways.order(created_at: "desc")
      @things_ive_learned = user_takeaways.first(5)

    render(template: "/misc/homepage.html.erb")

  end

end
