# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :attendances, only: %i[index show create new] do
    get :attendances_per_employee, on: :collection
  end
  get 'employee_attendancies/:user_id', to: 'attendances#attendances_per_employee', as: 'employee_attendancies'
end
