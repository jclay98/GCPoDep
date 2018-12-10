Rails.application.routes.draw do

  get 'suspects/new'

  get 'suspects/edit'

  get 'crime_investigations/new'

  get 'crime_investigation/new'

  get 'investigation_notes/new'

  get 'investigation_notes/edit'

  get 'investigation_notes/destroy'

  get 'users/index'

  get 'users/new'

  get 'users/edit'

  get 'user/index'

  get 'user/new'

  get 'user/edit'

  # Semi-static page routes
  get 'home', to: 'home#index', as: :home
  get 'home/about', to: 'home#about', as: :about
  get 'home/contact', to: 'home#contact', as: :contact
  get 'home/privacy', to: 'home#privacy', as: :privacy
  get 'home/search', to: 'home#search', as: :search

  # Authentication routes
  resources :sessions
  resources :users
  get 'users/new', to: 'users#new', as: :signup
  get 'user/edit', to: 'users#edit', as: :edit_current_user
  get 'login', to: 'sessions#new', as: :login
  get 'logout', to: 'sessions#destroy', as: :logout

  # Resource routes (maps HTTP verbs to controller actions automatically):
  resources :officers
  resources :units
  resources :investigations
  resources :crimes
  resources :criminals
  resources :crime_investigations
  resources :investigation_notes
  resources :home
  #resources :suspects

  
  #get 'crime_investigations/new', to: 'crime_investigations#new', as: :new_crime_investigation

  # Routes for assignments
  get 'assignments/new', to: 'assignments#new', as: :new_assignment
  get 'assignments', to: 'assignments#index', as: :assignments_path
  post 'assignments', to: 'assignments#create', as: :assignments
  patch 'assignments/:id/terminate', to: 'assignments#terminate', as: :terminate_assignment

  # Routes for suspects
  get 'suspects/:id/new', to: 'suspects#new', as: :new_suspect
  #get 'suspects', to: 'suspects#index', as: :suspects_path
  post 'suspects', to: 'suspects#create', as: :suspects
  patch 'suspects/:id/remove', to: 'suspects#remove', as: :remove_suspect





  # Other custom routes




  # Routes for searching




  # You can have the root of your site routed with 'root'
  root 'home#index'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
