class CreateItemComments < ActiveRecord::Migration[6.0]
  def change
    create_table :item_comments do |t|
      t.references :user, null: false, foreign_key: true
      t.references :item, null: false, foreign_key: true
      t.string :content, null: false

      t.timestamps
    end
  end
end
