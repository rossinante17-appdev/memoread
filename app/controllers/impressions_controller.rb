class ImpressionsController < ApplicationController

  def link_out

    article_id = params.fetch("path_id")

    the_article = Article.where(id: article_id).first

    the_article.read_at = DateTime.now

    the_article.save

    redirect_to("#{the_article.url}")

  end

end