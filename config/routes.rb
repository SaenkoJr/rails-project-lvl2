# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  scope module: :web do
    root 'posts#index'
    resources :posts do
      resources :comments, exclude: %i[index show], controller: 'post_comments'
      resources :likes, only: %i[create destroy], controller: 'post_likes'
    end
  end
end
