json.extract! student, :id, :student_id, :name, :email, :created_at, :updated_at
json.url student_url(student, format: :json)
