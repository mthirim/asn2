class CreateCourses < ActiveRecord::Migration[5.1]
  def change
    create_table :courses do |t|
      t.string :course_id, unique: true
      t.string :description, limit: 100

      t.timestamps
    end
    add_index :courses, :course_id
  end
end
