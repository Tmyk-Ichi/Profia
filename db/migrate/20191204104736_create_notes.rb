class CreateNotes < ActiveRecord::Migration[5.2]
  def change
    create_table :notes do |t|
      t.string :title
      t.text :body
      t.text :introduction
      t.integer :user_id
      t.integer :status,default: 1, null: false, limit: 1
      t.integer :impressions_count, default: 0
      t.integer :notebook_id
      t.text :url

      t.timestamps
    end
  end
end
