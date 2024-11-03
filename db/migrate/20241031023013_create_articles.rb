class CreateArticles < ActiveRecord::Migration[7.2]
  def change
    create_table :articles do |t|
      t.string :title, null: false
      t.datetime :published_at, null: false
      t.string :original_url, null: false
      t.string :image_url
      t.references :publisher, null: false, foreign_key: true
      t.timestamps
    end
    add_index :articles, :original_url, unique: true
    add_index :articles, :published_at
  end
end
