class ChangeColumnToNull < ActiveRecord::Migration[6.0]
  def up
    change_column_null :items, :price, true
  end

  def down
    change_column_null :items, :price, false
  end
end
