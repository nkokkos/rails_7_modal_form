class AddMoreAttributes < ActiveRecord::Migration[7.0]
  def change
    add_column :items, :country, :string
    add_column :items, :graduation_year, :integer
    add_column :items, :body_temperature, :float
    add_column :items, :price, :decimal
    add_column :items, :birthday, :date
    add_column :items, :favorite_time, :time
  end
end
