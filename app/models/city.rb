class City < ApplicationRecord
  has_many :assignments
  has_many :cleaners, :through => :assignments
end
