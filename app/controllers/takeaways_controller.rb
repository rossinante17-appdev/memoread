class TakeawaysController < ApplicationController
  
  def index
    matching_takeaways = Takeaway.all

    @list_of_takeaways = matching_takeaways.order({ :created_at => :desc })

    render({ :template => "takeaways/index.html.erb" })
  end

  def things_ive_learned
    
    matching_takeaways = @current_user.takeaways

    @list_of_takeaways = matching_takeaways.order({ :created_at => :desc })

    @matching_articles = []
    
    @list_of_takeaways.each do |a_takeaway|

      the_article = Article.where(id: a_takeaway.article_id)

      @matching_articles.push(the_article)

    end

    render({ :template => "takeaways/things_ive_learned.html.erb" })
    
  end

  def takeaway_form

    @user_articles = @current_user.articles
       
    render(template: "/takeaways/create_form.html.erb")

  end
  
  
  def show

    the_id = params.fetch("path_id")

    matching_takeaways = Takeaway.where({ :id => the_id })

    @the_takeaway = matching_takeaways.at(0)

    @the_article = Article.where(id: @the_takeaway.article_id).first

    render({ :template => "takeaways/show.html.erb" })

  end

  def create

    the_takeaway = Takeaway.new
    the_takeaway.body = params.fetch("query_body")
    the_takeaway.user_id = @current_user.id
    the_takeaway.article_id = params.fetch("query_article_id")
    the_takeaway.public = params.fetch("query_public", false)

    if the_takeaway.valid?
      the_takeaway.save

      the_article = Article.where(id: the_takeaway.article_id).first

      the_article.takeaway_id = the_takeaway.id

      if the_article.read == false

        the_article.read = true

        the_article.read_at = DateTime.now

      end

      the_article.save
      
      redirect_to("/my_takeaways", { :notice => "Takeaway created successfully." })
    else
      redirect_to("/new_takeaway", { :alert => "Takeaway failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_takeaway = Takeaway.where({ :id => the_id }).at(0)

    the_takeaway.body = params.fetch("query_body")
    the_takeaway.user_id = params.fetch("query_user_id")
    the_takeaway.article_id = params.fetch("query_article_id")
    the_takeaway.public = params.fetch("query_public", false)

    if the_takeaway.valid?
      the_takeaway.save

      if the_takeaway.article.read == false

        the_takeaway.article.read = true

      end

      redirect_to("/takeaways/#{the_takeaway.id}", { :notice => "Takeaway updated successfully."} )

    else

      redirect_to("/takeaways/#{the_takeaway.id}", { :alert => "Takeaway failed to update successfully." })

    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_takeaway = Takeaway.where({ :id => the_id }).at(0)

    the_takeaway.destroy

    redirect_to("/takeaways", { :alert => "Takeaway deleted."} )
  end
end
