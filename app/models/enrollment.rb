class Enrollment < ApplicationRecord
  belongs_to :student
  belongs_to :course

  validates_inclusion_of :percentage, in: 0..100
  validates_uniqueness_of :student_id, :scope => :course_id
end
