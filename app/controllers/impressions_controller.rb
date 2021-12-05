class ImpressionsController < ApplicationController

  skip_before_action(:force_user_sign_in, only: [:receive_text])

  # Link Out: when the link Memoread sends is used to access an article
  def link_out

    article_id = params.fetch("path_id")

    the_article = Article.where(id: article_id).first

    the_article.read_at = DateTime.now

    the_article.save

    redirect_to("#{the_article.url}")

  end

  # Receive: when Users submit a Takeaway, via text (or email?)
  def receive_text

    the_takeaway = params.fetch("Body")

    return the_takeaway

  end

end