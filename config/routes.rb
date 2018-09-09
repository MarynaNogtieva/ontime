# frozen_string_literal: true

Rails.application.routes.draw do
  devise_for :users
  # For details on the DSL available within this file, see http://guides.rubyonrails.org/routing.html

  root 'welcome#index'

  resources :attendances do
    get :attendances_per_employee, on: :collection
  end

  get 'employee_attendances/:user_id', to: 'attendances#attendances_per_employee', as: 'employee_attendances'
end
