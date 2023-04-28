class AddCheckboxToItems < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :can_send_email, :boolean 
  end
end
