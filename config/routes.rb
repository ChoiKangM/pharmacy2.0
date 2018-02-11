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
  get '/introductions/userInformation', as: 'userInformation'
  
  # A
  root 'introductions#main'
  get '/introductions/mainEvent', as: 'mainEvent'
  get '/introductions/privacyInformation', as: 'privacyInformation'
  get '/introductions/agreeOfUtil', as: 'agreeOfUtil'
  
  # B
  get '/introductions/introduction', as: 'introduction'
  get '/introductions/alumni', as: 'alumni'
  get '/introductions/studentActivity', as: 'studentActivity'
  get '/introductions/village', as: 'village'
  get '/introductions/club', as: 'club'
  get '/introductions/attendance', as: 'attendance'
  get '/introductions/operationCommittee', as: 'operationCommittee'
  
  # F
  get '/helps/help', as: 'help'
  get '/helps/question', as: 'question'
  get '/helps/tier', as: 'tier'
  get '/helps/payment', as: 'payment'
  get '/helps/makePublic', as: 'makePublic'
  get '/helps/knupManager', as: 'knupManager'
  
  # G
  get '/helps/contactUs', as: 'contactUs'
end
