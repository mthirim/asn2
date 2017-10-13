class Course < ApplicationRecord
	has_many :enrollments, dependent: :destroy
	has_many :students, :through => :enrollments, dependent: :destroy

	validates :description, presence: true, allow_blank: false
	validates :course_id, uniqueness: true
end
