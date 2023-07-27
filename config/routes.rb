# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  devise_scope :user do
    unauthenticated { root to: "devise/sessions#new", as: :unauthenticated_root }

    resource :profile, only: [:edit, :update], controller: :profile
    resource :password, only: [:update, :edit], controller: :password
    resources :generated_images, only: [:index, :show]
    resources :prompts, only: [:new, :create, :show]

    authenticate :user, -> (user) { user.maintainer? } do
      draw :maintenance
    end

    authenticate :user, -> (user) { user.admin? || user.maintainer? } do
      draw :admin
    end
  end

  root "prompts#new"
end
