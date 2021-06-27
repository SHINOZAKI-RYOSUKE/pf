Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root :to => "contents#index"


    resource :homes do
     get :about, on: :collection
    end


    resources :users, only: [:index, :show, :edit, :update] do
     resources :relationships, only: [:index]
     resource  :relationships, only: [:create, :destroy]
    end


    resources :contents do
     resources :favorites, only: [:index]
     resource  :favorites, only: [:create, :destroy]
     resources :comments,  only: [:destroy]
     resource  :comments,  only: [:create]
    end


    get "search" => "users#search_result", as: "search_result"

    get 'chat/:id' => 'chats#show', as: 'chat'

    resources :chats, only: [:index, :create]
    
    resources :notifications, only: [:index] do
     delete :destroy_all , on: :collection
     
    end

end
