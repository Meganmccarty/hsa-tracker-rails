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
    patch "/change-password", to: "passwords#update"

    get "/receipt-records", to: "receipt_records#index"
    get "/receipt-records/:id", to: "receipt_records#show"
    post "/receipt-records", to: "receipt_records#create"
    patch "/receipt-records/:id", to: "receipt_records#update"
    delete "/receipt-records/:id", to: "receipt_records#destroy"

    get "/receipt-records/:r_id/image-files/:i_id", to: "receipt_records#download"

    get "/profile", to: "users#show"
    patch "/profile", to: "users#update"
end
