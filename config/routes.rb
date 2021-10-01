Rails.application.routes.draw do
    devise_for :users, path: '', path_names: {
        sign_in: 'login',
        sign_out: 'logout',
        registration: 'signup'
    },
    controllers: {
        sessions: 'sessions',
        registrations: 'registrations'
    },
    defaults: {
        format: :json
    }

    post "/forgot-password", to: "passwords#forgot"
    patch "/reset-password", to: "passwords#reset"

    get "/receipt-records", to: "receipt_records#index"
    get "/receipt-records/:id", to: "receipt_records#show"
    post "/receipt-records", to: "receipt_records#create"
    patch "/receipt-records/:id", to: "receipt_records#update"
    delete "/receipt-records/:id", to: "receipt_records#destroy"

    get "/profile", to: "users#show"
end
