class Student < ApplicationRecord
  # https://stackoverflow.com/questions/53586779/activerecordrecordinvalid-validation-failed-technologies-portfolio-must-exist
  # https://jasoncharnes.com/belongs-to-required-rails-5/
  belongs_to :item, optional: true # optional true is set here because student_ids may or may not exists in the joint table
end
