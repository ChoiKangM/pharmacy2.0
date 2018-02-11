Rails.application.routes.draw do
  resources :cards do
    resources :creplies, only: [:create, :destroy]
  end
  resources :handouts do
    resources :hreplies, only: [:create, :destroy]
  end
  resources :notices do
    resources :nreplies, only: [:create, :destroy]
  end
  devise_for :users, :controllers => { omniauth_callbacks: 'user/omniauth_callbacks' }
  get '/introductions/userInformation', to: 'introductions#userInformation', as: 'userInformation'
  
  # A
  root 'introductions#main'
  get '/introductions/mainEvent', to: 'introductions#mainEvent', as: 'mainEvent'
  get '/introductions/privacyInformation', to: 'introductions#privacyInformation', as: 'privacyInformation'
  get '/introductions/agreeOfUtil', to: 'introductions#agreeOfUtil', as: 'agreeOfUtil'
  
  # B
  get '/introductions/introduction', to: 'introductions#introduction', as: 'introduction'
  get '/introductions/alumni', to: 'introductions#alumni', as: 'alumni'
  get '/introductions/studentActivity', to: 'introductions#studentActivity', as: 'studentActivity'
  get '/introductions/village', to: 'introductions#village', as: 'village'
  get '/introductions/club', to: 'introductions#club', as: 'club'
  get '/introductions/attendance', to: 'introductions#attendance', as: 'attendance'
  get '/introductions/operationCommittee', to: 'introductions#operationCommittee', as: 'operationCommittee'
  
  # F
  get '/introductions/help', to: 'introductions#help', as: 'help'
  get '/introductions/question', to: 'introductions#question', as: 'question'
  get '/introductions/tier', to: 'introductions#tier', as: 'tier'
  get '/introductions/payment', to: 'introductions#payment', as: 'payment'
  get '/introductions/makePublic', to: 'introductions#makePublic', as: 'makePublic'
  get '/introductions/knupManager', to: 'introductions#knupManager', as: 'knupManager'
  
  # G
  get '/introductions/contactUs', to: 'introductions#contactUs', as: 'contactUs'
end
