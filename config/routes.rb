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
    collect