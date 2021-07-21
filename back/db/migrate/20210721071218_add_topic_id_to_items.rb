class AddTopicIdToItems < ActiveRecord::Migration[6.0]
  def change
    add_column :items, :topic_id, :integer
  end
end
