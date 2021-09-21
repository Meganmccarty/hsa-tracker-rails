Rails.application.routes.draw do
    resources :receipt_records, only: [:index, :create, :update, :destroy]
end
