Rails.application.routes.draw do
    resources :receipt_records, only: [:index, :create, :update, :destroy]

    get "/profile", to: "users#show"
    post "/signup", to: "users#create"
end
