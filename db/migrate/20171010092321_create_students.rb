class CreateStudents < ActiveRecord::Migration[5.1]
  def change
    create_table :students do |t|
      t.string :student_id, limit: 9, unique: true
      t.string :name, limit:30
      t.string :email, limit:30, unique: true

      t.timestamps
    end
    add_index("students", "student_id")
    add_index("students", "email")
  end
end
