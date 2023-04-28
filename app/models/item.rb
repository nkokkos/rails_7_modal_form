class Item < ApplicationRecord
  validates_presence_of :name, :description
  enum status: {
    submitted:   0,
    viewed: 	 1,
    reviewed: 	 2,
    rejected: 	 3,
    invited: 	 4,
    interviewed: 5,
    verified: 	 6,
    offered: 	 7,
    hired: 	 8,
    in_trial: 	 9,
    after_trial: 10
  }

  serialize :roles

  has_many :item_students
  has_many :students, through: :item_students

end
