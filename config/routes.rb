TodoServer::Application.routes.draw do
  resources :todos, only: [:index, :create, :update] do
    get 'change_state', on: :collection
    get 'change_importance', on: :collection
    get 'mark_all', on: :collection
  end
  root :to => 'todos#index'
end
