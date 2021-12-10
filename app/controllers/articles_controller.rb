class ArticlesController < ApplicationController
  
  def user_articles
    matching_articles = @current_user.articles

    @list_of_articles = matching_articles.order({ :created_at => :desc })

    render({ :template => "articles/user_articles.html.erb" })
  end

  def article_form



    render("/articles/create_form.html.erb")

  end

  def show

    the_id = params.fetch("path_id")

    matching_articles = Article.where({ :id => the_id })

    @the_article = matching_articles.at(0)

    render({ :template => "articles/show.html.erb" })

  end

  # Create article, with text and email -> maybe break these out?
  def create
    
    the_article = Article.new
    the_article.url = params.fetch("query_url")
    the_article.headline = params.fetch("query_headline")
    # the_article.source_id = params.fetch("query_source_id")
    the_article.public = params.fetch("query_public", false)
    the_article.user_id = @current_user.id
    the_article.read = params.fetch("query_read", false)
    the_article.email = params.fetch("query_email", false)
    the_article.text = params.fetch("query_text", false)    
    the_article.reread_list = params.fetch("query_reread_list", false)


    if the_article.valid?
      
      the_article.save

      # Check to see if User wanted the article texted to them
      if the_article.text == true

        twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
        twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
        twilio_sending_number = ENV.fetch("TWILIO_SENDING_NUMBER")

        twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

        link_out_url = "https://3000-amethyst-louse-bmphrzge.ws-us21.gitpod.io/link/#{the_article.id}"
        
        sms_parameters = {

          from: twilio_sending_number,
          to: @current_user.phone,
          body: "You requested this article from Memoread: #{the_article.headline} -- #{link_out_url}"

        }

        twilio_client.api.messages.create(sms_parameters)

      end

      # Check to see if User wanted the article emailed to them
      if the_article.email == true           

        # Retrieve AppDev Mailgun credentials
        mg_api_key = ENV.fetch("MAILGUN_API_KEY")
        mg_sending_domain = ENV.fetch("MAILGUN_SENDING_DOMAIN")

        # Create an instance of the Mailgun Client and authenticate with AppDev key
        mg_client = Mailgun::Client.new(mg_api_key)

        link_out_url = "https://3000-amethyst-louse-bmphrzge.ws-us21.gitpod.io/link/#{the_article.id}"

        # Craft email
        email_parameters =  { 
          :from => @current_user.email,
          :to => @current_user.email,
          :subject => "Memoread: #{the_article.headline}",
          :text => "#{@current_user.username}, you requested this article from Memoread: #{the_article.headline} -- #{link_out_url}"
        }

        # Send it
        mg_client.send_message(mg_sending_domain, email_parameters)

      end

      # Redirect
      if the_article.email == true && the_article.text == true

        redirect_to("/my_articles", { :notice => "Article added; text and email sent." })

      elsif the_article.email == true && the_article.text == false
        
        redirect_to("/my_articles", notice: "Article added; email sent.")

      elsif the_article.text == true && the_article.email == false

        redirect_to("/my_articles", notice: "Article added; text sent.")

      else

        redirect_to("/my_articles", notice: "Article added.")

      end

    else

      redirect_to("/my_articles", { :alert => "Article failed to create successfully." })

    end

  end

  def update
    the_id = params.fetch("path_id")
    the_article = Article.where({ :id => the_id }).at(0)

    the_article.url = params.fetch("query_url")
    the_article.headline = params.fetch("query_headline")
    the_article.takeaway_id = params.fetch("query_takeaway_id")
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

    its_takeaway = the_article.takeaway

    the_article.destroy
    
    if its_takeaway.present?
      
      its_takeaway.destroy

    end

    redirect_to("/my_articles", { :alert => "Article deleted."} )
    
  end
end
