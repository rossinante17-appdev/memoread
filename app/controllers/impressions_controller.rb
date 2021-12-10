class ImpressionsController < ApplicationController

  skip_before_action(:force_user_sign_in, only: [:link_out, :receive_text])

  # Link Out: when the link Memoread sends is used to access an article
  def link_out

    article_id = params.fetch("path_id")

    the_article = Article.where(id: article_id).first

    the_article.opened_at = DateTime.now

    the_article.save

    if the_article.text == true

      twilio_sid = ENV.fetch("TWILIO_ACCOUNT_SID")
      twilio_token = ENV.fetch("TWILIO_AUTH_TOKEN")
      twilio_sending_number = ENV.fetch("TWILIO_SENDING_NUMBER")

      twilio_client = Twilio::REST::Client.new(twilio_sid, twilio_token)

      takeaway_url = "https://3000-amethyst-louse-bmphrzge.ws-us23.gitpod.io/articles/#{the_article.id}"
      
      sms_parameters = {

        from: twilio_sending_number,
        to: the_article.user.phone,
        body: "You recently opened this article: #{the_article.headline}. If you'd like to commit a takeaway to Memoread, follow this link: #{takeaway_url}"

      }

      twilio_client.api.messages.create(sms_parameters)

    end

    redirect_to("#{the_article.url}")

  end

  # Receive: when Users submit a Takeaway, via text (or email?)
  def receive_text

    the_takeaway = params.fetch("Body")

    return the_takeaway

  end

end