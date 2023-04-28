class CreateJoinTableItemsStudents < ActiveRecord::Migration[7.0]
  def change
    create_table :items_students do |t|
      t.integer "item_id"
      t.integer "student_id"
    end
  end
end
