# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  scope module: :web do
    root 'home#index'
    resources :posts do
      resources :comments, exclude: %i[index show], controller: 'post_comments'
    end
  end
end
