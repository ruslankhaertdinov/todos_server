TodoServer::Application.routes.draw do
  resources :todos, except: [:destroy, :show, :edit] do
    get 'clear_complete', on: :collection
  end
  root :to => 'todos#index'
end
