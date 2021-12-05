class AddOpenedAtToArticle < ActiveRecord::Migration[6.0]
  def change

    add_column(:articles, :opened_at, :datetime)

  end
end
