Rails.application.routes.draw do
  devise_for :users

  devise_scope :user do
    root to: 'devise/sessions#new'
    match "/users/sign_out" => "devise/sessions#destroy", :as => "sign_out", via: 'delete'
  end

  resources :users, only: ['index','show']
  resources :searches, only: 'index'
  resources :messages, only: ['new', 'create']
end
