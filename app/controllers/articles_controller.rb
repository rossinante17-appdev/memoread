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
    the_article.source_id = params.fetch("query_source_id")
    the_article.public = params.fetch("query_public", false)
    the_article.user_id = @current_user.id
    the_article.read = params.fetch("query_read", false)
    the_article.email = params.fetch("query_email", false)
    the_article.text = params.fetch("query_text", false)
    the_article.reread_list = params.fetch("query_reread_list", false)

    if the_article.valid?
      the_article.save

      if the_article.text == true

        if the_article.user.phone.present?

          twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
          twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
          twilio_sending_number = ENV.fetch("TWILIO_SENDING_NUMBER")

          twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

          sms_parameters = {

            from: twilio_sending_number,
            to: @current_user.phone,
            body: "You requested this article from Memoread: #{the_article.headline} -- #{the_article.url}"

          }

          twilio_client.api.messages.create(sms_parameters)

          redirect_to("/my_articles", notice: "Text sent")

        else

          redirect_to("/my_articles", notice: "Can't text an article without a phone number on file.")

        end

      else

        redirect_to("/my_articles", { :notice => "Article created successfully." })

      end

    else
      redirect_to("/my_articles", { :notice => "Article failed to create successfully." })
    end
  end

  def send_text

    twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
    twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
    twilio_sending_number = ENV.fetch("TWILIO_SENDING_NUMBER")

    twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

    sms_parameters = {
      
      :from => twilio_sending_number,
      :to => @current_user.phone,
      :body => @article_to_text.id

    }

    twilio_client.api.account.messages.create(sms_parameters)

    redirect_to("/my_articles", notice: "Article successfully created and texted.")

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

    its_summary = the_article.summary

    the_article.destroy
    its_summary.destroy

    redirect_to("/my_articles", { :notice => "Article deleted successfully."} )
  end
end
