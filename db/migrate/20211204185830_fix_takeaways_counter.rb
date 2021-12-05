class FixTakeawaysCounter < ActiveRecord::Migration[6.0]
  def change

    remove_column(:users, :summaries_count )

    add_column(:users, :takeaways_count, :integer)

  end
end
