Rails.application.routes.draw do
	get 'enrollments/histogram'

  resources :enrollments
  resources :courses
  resources :students

  match ':controller(/:action(/:id))', :via => :get
  match ':controller(/:action(/:id))', :via => :post
#get '/histogram', :to => redirect('/histogram.html')

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
