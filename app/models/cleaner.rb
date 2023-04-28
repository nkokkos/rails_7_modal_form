class Cleaner < ApplicationRecord
  has_many :assignments
  has_many :cities, through: :assignments
end
