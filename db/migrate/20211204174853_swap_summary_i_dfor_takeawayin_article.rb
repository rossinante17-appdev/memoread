class SwapSummaryIDforTakeawayinArticle < ActiveRecord::Migration[6.0]
  def change

    remove_column(:articles, :summary_id)
    add_column(:articles, :takeaway_id, :boolean)

  end
end
