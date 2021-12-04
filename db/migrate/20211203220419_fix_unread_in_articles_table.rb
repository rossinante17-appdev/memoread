class FixUnreadInArticlesTable < ActiveRecord::Migration[6.0]
  def change

    remove_column(:articles, :unread_boolean)
    add_column(:articles, :read, :boolean)

  end
end
