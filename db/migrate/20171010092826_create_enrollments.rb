class CreateEnrollments < ActiveRecord::Migration[5.1]
  def change
    create_table :enrollments do |t|
      t.references :student,  on_delete: :cascade, foreign_key: true
      t.references :course, on_delete: :cascade, foreign_key: true
      t.float :percentage 
      t.string :lettergrade, limit: 2

      t.timestamps
    end
    add_index :enrollments, :percentage
    add_index :enrollments, :lettergrade
  end
end
