Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html
  
  root :to => "contents#index"
    
    
    resource :homes do
     get :about, on: :collection
    end
    

    resources :users, only: [:index, :show, :edit, :update] do
     resources :relationships, only: [:index, :create, :destroy]
    end
    

    resources :contents do
     resources :favorites, only: [:index, :create, :destroy]
     resources :comments, only: [:index, :create, :destroy]
    end
    
    
    get 'chat/:id' => 'chats#show', as: 'chat'
 
    resources :chats, only: [:index, :create]
  
  
end
