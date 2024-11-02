class CreatePublishers < ActiveRecord::Migration[7.2]
  def change
    create_table :publishers do |t|
      t.string :name, null: false
      t.string :feed_url, null: false
      t.string :language, null: false

      t.timestamps
    end

    add_index :publishers, :name, unique: true
  end
end
