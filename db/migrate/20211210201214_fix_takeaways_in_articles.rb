class FixTakeawaysInArticles < ActiveRecord::Migration[6.0]
  def change

    remove_column(:articles, :takeaway_id)

    add_column(:articles, :takeaway_id, :integer)

  end
end
