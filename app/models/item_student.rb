class ItemStudent < ApplicationRecord
  self.table_name = "item_students"
  belongs_to :item
  belongs_to :student
end
