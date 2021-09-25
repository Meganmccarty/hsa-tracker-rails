Rails.application.routes.draw do
    get "/receipt-records", to: "receipt_records#index"
    get "/receipt-records/:id", to: "receipt_records#show"
    post "/receipt-records", to: "receipt_records#create"
    patch "/receipt-records/:id", to: "receipt_records#update"
    delete "/receipt-records/:id", to: "receipt_records#destroy"

    get "/profile", to: "users#show"
    post "/signup", to: "users#create"
    post "/login", to: "sessions#create"
    delete "/logout", to: "sessions#destroy"
end
