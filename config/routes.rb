Rails.application.routes.draw do
	get 'courses/histogram'
	get 'courses/edit'
	get 'courses/index'
	get 'courses/show'
	get 'courses/new'

	get 'enrollments/edit'
	get 'enrollments/index'
	get 'enrollments/show'
	get 'enrollments/new'

	get 'students/edit'
	get 'students/index'
	get 'students/show'
	get 'students/new'

  resources :enrollments
  resources :courses
  resources :students

  match ':controller(/:action(/:id))', :via => :get
  match ':controller(/:action(/:id))', :via => :post

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
