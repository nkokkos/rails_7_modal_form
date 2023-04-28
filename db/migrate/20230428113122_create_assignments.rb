class CreateAssignments < ActiveRecord::Migration[7.0]
  def change
    create_table :assignments do |t|
      t.references :city, null: false, foreign_key: true
      t.references :cleaner, null: false, foreign_key: true

      t.timestamps
    end
  end
end
