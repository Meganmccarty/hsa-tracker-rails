class PasswordsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    
    def forgot
        user = User.find_by(email: params[:email])
        if user
            user.send_password_reset
            render json: { message: "We have sent a password reset email." }
        else
            render json: { message: "If a user with this email address exists, we have sent a password reset email." }
        end
        
    end

    def reset
        user = User.find_by(reset_password_token: params[:token], email: params[:email])
        if user.present? && user.reset_password_token_valid?
            if user.reset_password(params[:password])
                render json: { message: "Your password has been successfully reset!" }
            else
                render json: { errors: user.errors.full_messages }, status: :unprocessable_entity
            end
        else
            render json: { errors: "Link not valid or expired. Try generating a new link." }, status: :not_found
        end
    end

    def update
        user = current_user
        old_password = params[:old_password]
        if user&.valid_password?(old_password)
            if user.update!(password_params)
                render json: { user: user, message: "Password successfully updated" }, status: 200
            else
                render json: { message: "New passwords do not match" }, status: :unprocessable_entity
            end
        else
            render json: { message: "Old password is incorrect" }, status: :unprocessable_entity
        end
    end

    private

    def password_params
        params.permit(:password, :password_confirmation)
    end

end