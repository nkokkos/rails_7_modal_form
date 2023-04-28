class AddRoles < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :roles, :text
  end
end
