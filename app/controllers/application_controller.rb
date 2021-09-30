class ApplicationController < ActionController::Base
    include ActionController::MimeResponds
    before_action :configure_permitted_parameters, if: :devise_controller?
    skip_before_action :verify_authenticity_token
    respond_to :json

    private

    def configure_permitted_parameters
        devise_parameter_sanitizer.permit(:sign_up, keys: [:email, :encrypted_password, :password, :password_confirmation, :first_name, :last_name])
    end
end
