class AlterTableName < ActiveRecord::Migration[7.0]
  def change
      rename_table :items_students, :item_students
  end
end
