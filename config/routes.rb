Rails.application.routes.draw do

  # intially send user '/auth/google_oauth2'
  get '/auth/:provider/callback', to: 'sessions#create'


  # API ~~~~~~~~~~~~~~~~~~~~~~~ (start)
  scope module: :api do

    namespace :v0 do
      resources :help
    end

    namespace :v1 do
      resources :chats, only: [] do
        collection do
          get 'chat'
        end
      end
    end

  end
  # API ~~~~~~~~~~~~~~~~~~~~~~~ (end)


  # SITE ~~~~~~~~~~~~~~~~~~~~~~~ (start)
  scope module: :site do

    resources :homes, only: [] do
      collection do
        get 'frontpage'
      end
    end

    resources :visuals, only: [] do
      collection do
        get 'googledrive'
      end
    end

  end
  # SITE ~~~~~~~~~~~~~~~~~~~~~~~ (end)


end

