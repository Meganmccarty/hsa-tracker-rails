class PasswordsController < ApplicationController
    
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

end