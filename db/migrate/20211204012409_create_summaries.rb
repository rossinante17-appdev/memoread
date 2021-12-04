class CreateSummaries < ActiveRecord::Migration[6.0]
  def change
    create_table :summaries do |t|
      t.string :body
      t.integer :user_id
      t.integer :article_id
      t.boolean :public

      t.timestamps
    end
  end
end
