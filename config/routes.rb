# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users

  scope module: :web do
    root 'posts#index'
    resources :posts do
      scope module: :posts do
        resources :comments, exclude: %i[index show]
        resources :likes, only: %i[create destroy]
      end
    end
  end
end
