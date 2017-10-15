class Student < ApplicationRecord
	has_many :enrollments, dependent: :destroy
	has_many :courses, :through => :enrollments, dependent: :destroy

	validates :student_id, length: {is: 9}, numericality: {only_integer: true}, uniqueness: true
	validates :name, numericality: false, length: {minimum:1, maximum: 20}
	validates :email, format: { with: /\A([^@\s]+)@((?:[-a-z0-9]+\.)+[a-z]{2,})\z/i, on: :create }, uniqueness: true
end
