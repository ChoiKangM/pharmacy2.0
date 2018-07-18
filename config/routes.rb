Rails.application.routes.draw do
  resources :alumnusfees

  resources :make_publics do
     collection do
      get "meeting" # generate  get "/make_publics/meeting"
      get "account"
      get "other"
      get "rule"
    end
  end
  
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
  get '/introductions/fifthGrade13', as:'fifthGrade13'
  get '/introductions/fourthGrade14', as:'fourthGrade14'
  get '/introductions/thirdGrade15', as:'thirdGrade15'
  get '/introductions/secondGrade16', as:'secondGrade16'
  get '/introductions/operationCommittee', as: 'operationCommittee'
  
  # F
  get '/helps/help', as: 'help'
  get '/helps/question', as: 'question'
  get '/helps/tier', as: 'tier'
  get '/helps/payment', as: 'payment'
  
  get '/helps/makePublic', as: 'makePublic'
  #get '/makePublic/meeting', as: 'meeting'
  #get '/makePublic/account', as: 'account'
  #get '/makePublic/other', as: 'other'
  #get '/makePublics/rule', as: 'rule'
  
  get '/helps/knupManager', as: 'knupManager'
  
  
  # G
  get '/helps/contactUs', as: 'contactUs'
end
