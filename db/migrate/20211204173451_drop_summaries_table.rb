class DropSummariesTable < ActiveRecord::Migration[6.0]
  def change

    drop_table :summaries do |t|

      t.string(:body, null: false)
      t.boolean(:public, null: false)
      t.integer(:article_id, null: false)
      t.integer(:user_id, null: false)
      t.timestamps(null: false)

    end

  end
end
