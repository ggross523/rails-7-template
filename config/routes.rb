Rails.application.routes.draw do
  resources :course_evaluations, only: [:index] do
    collection do
      get :import
      post :upload
    end
  end
end
