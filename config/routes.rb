Rails.application.routes.draw do
  get 'secrets/show' => 'secrets#index'

  get '/' => 'users#index'

  post 'bury_secret/:id' => 'secrets#destroy'

  post 'like/:id' => 'secrets#like'

  post 'unlike/:id' => 'secrets#unlike'
  
  post 'new_secret' => 'secrets#create'

  post 'create' => 'users#new'

  post 'log' => 'users#log'

  post 'out' => 'users#out'

  post 'update/:id' => 'users#update'

  get 'edit/:id' => 'users#edit'

  get '/view/:id' => 'users#view'

  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
end
