class ArticlesController < ApplicationController
  def index
    matching_articles = @current_user.articles

    @list_of_articles = matching_articles.order({ :created_at => :desc })

    render({ :template => "articles/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_articles = Article.where({ :id => the_id })

    @the_article = matching_articles.at(0)

    render({ :template => "articles/show.html.erb" })
  end

  def create
    the_article = Article.new
    the_article.url = params.fetch("query_url")
    the_article.headline = params.fetch("query_headline")
    the_article.summary_id = params.fetch("query_summary_id")
    the_article.source_id = params.fetch("query_source_id")
    the_article.public = params.fetch("query_public", false)
    the_article.user_id = params.fetch("query_user_id")
    the_article.unread_boolean = params.fetch("query_unread_boolean")
    the_article.email = params.fetch("query_email", false)
    the_article.text = params.fetch("query_text", false)
    the_article.reread_list = params.fetch("query_reread_list", false)
    the_article.read_at = params.fetch("query_read_at")

    if the_article.valid?
      the_article.save
      redirect_to("/articles", { :notice => "Article created successfully." })
    else
      redirect_to("/articles", { :notice => "Article failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_article = Article.where({ :id => the_id }).at(0)

    the_article.url = params.fetch("query_url")
    the_article.headline = params.fetch("query_headline")
    the_article.summary_id = params.fetch("query_summary_id")
    the_article.source_id = params.fetch("query_source_id")
    the_article.public = params.fetch("query_public", false)
    the_article.user_id = params.fetch("query_user_id")
    the_article.unread_boolean = params.fetch("query_unread_boolean")
    the_article.email = params.fetch("query_email", false)
    the_article.text = params.fetch("query_text", false)
    the_article.reread_list = params.fetch("query_reread_list", false)
    the_article.read_at = params.fetch("query_read_at")

    if the_article.valid?
      the_article.save
      redirect_to("/articles/#{the_article.id}", { :notice => "Article updated successfully."} )
    else
      redirect_to("/articles/#{the_article.id}", { :alert => "Article failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_article = Article.where({ :id => the_id }).at(0)

    the_article.destroy

    redirect_to("/articles", { :notice => "Article deleted successfully."} )
  end
end
