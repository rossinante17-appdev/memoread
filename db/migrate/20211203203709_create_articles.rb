class CreateArticles < ActiveRecord::Migration[6.0]
  def change
    create_table :articles do |t|
      t.string :url
      t.string :headline
      t.integer :summary_id
      t.integer :source_id
      t.boolean :public
      t.integer :user_id
      t.string :unread_boolean
      t.boolean :email
      t.boolean :text
      t.boolean :reread_list
      t.datetime :read_at

      t.timestamps
    end
  end
end
