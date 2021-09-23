Rails.application.routes.draw do
    resources :receipt_records, only: [:create, :update, :destroy]

    get "/receipt-records", to: "receipt_records#index"
    get "/receipt-records/:id", to: "receipt_records#show"

    get "/profile", to: "users#show"
    post "/signup", to: "users#create"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
end
