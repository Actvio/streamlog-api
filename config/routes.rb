Rails.application.routes.draw do
  resources :notifications
  resources :other_files
  resources :folders
  resources :clips
  resources :projects do
    member do
      get 'clips'
      put 'add_clip'
      put 'remove_clip'
    end
  end
  resources :authentication, only: [] do
    collection do
      post 'login'
      post 'signup'
      post 'google_signup'
      post 'google_login'
    end
  end

  resources :audio_files, only: [:index, :show, :new, :create, :update] do
    member do
      post :trim
    end
  end

  resourc