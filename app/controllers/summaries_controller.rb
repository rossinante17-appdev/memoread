class SummariesController < ApplicationController
  def index
    matching_summaries = Summary.all

    @list_of_summaries = matching_summaries.order({ :created_at => :desc })

    render({ :template => "summaries/index.html.erb" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_summaries = Summary.where({ :id => the_id })

    @the_summary = matching_summaries.at(0)

    render({ :template => "summaries/show.html.erb" })
  end

  def create
    the_summary = Summary.new
    the_summary.body = params.fetch("query_body")
    the_summary.user_id = @current_user.id
    the_summary.article_id = params.fetch("query_article_id")
    the_summary.public = params.fetch("query_public", false)

    if the_summary.valid?
      the_summary.save

      matching_article = Article.where(id: the_summary.article_id).first
      matching_article.summary_id = the_summary.id
      
      matching_article.save
      redirect_to("/articles/#{the_summary.article_id}>", { :notice => "Summary created successfully." })
    else
      redirect_to("/articles/:path_id", { :notice => "Summary failed to create successfully." })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_summary = Summary.where({ :id => the_id }).at(0)

    the_summary.body = params.fetch("query_body")
    the_summary.user_id = params.fetch("query_user_id")
    the_summary.article_id = params.fetch("query_article_id")
    the_summary.public = params.fetch("query_public", false)

    if the_summary.valid?
      the_summary.save
      redirect_to("/summaries/#{the_summary.id}", { :notice => "Summary updated successfully."} )
    else
      redirect_to("/summaries/#{the_summary.id}", { :alert => "Summary failed to update successfully." })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_summary = Summary.where({ :id => the_id }).at(0)

    the_summary.destroy

    redirect_to("/summaries", { :notice => "Summary deleted successfully."} )
  end
end
