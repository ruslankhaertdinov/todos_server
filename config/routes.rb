TodoServer::Application.routes.draw do
  resources :todos do
    get 'change', on: :collection
    get 'mark_all', on: :collection
    get 'clear_complete', on: :collection
  end
  root :to => 'todos#index'
end
