class PasswordsController < ApplicationController
    before_action :authenticate_user!, only: [:update]
    
    def forgot
        user = User.find_by(email: params[:email])
        if user
            user.send_password_reset
        end
        render json: {
            status: { code: 202, message: "If a user with this email address exists, we have sent a password reset email." }
        }, status: :accepted
    end

    def reset
        user = User.find_by(reset_password_token: params[:token], email: params[:email])
        if user.present? && user.reset_password_token_valid?
            if user.reset_password(params[:password])
                render json: {
                    status: { code: 200, message: "Your password has been successfully reset!" }
                }, status: :ok
            else
                render json: {
                    status: { code: 422, errors: user.errors.full_messages }
                }, status: :unprocessable_entity
            end
        else
            render json: {
                status: { code: 404, errors: "Link not valid or expired. Try generating a new link." }
            }, status: :not_found
        end
    end

    def update
        user = current_user
        old_password = params[:old_password]
        if user&.valid_password?(old_password)
            if params[:password] != params[:password_confirmation]
                render json: {
                    status: { code: 422, errors: ["New passwords do not match"] }
                }, status: :unprocessable_entity
            elsif params[:password].length < 6 && params[:password_confirmation].length < 6
                render json: {
                    status: { code: 422, errors: ["Password is too short. Minimum is 6 characters"] }
                }, status: :unprocessable_entity
            elsif user.update!(password_params)
                render json: {
                    user: user,
                    status: { code: 200, message: "Password successfully updated" }
                }, status: :ok
            end
        elsif !user&.valid_password?(old_password)
            render json: {
                status: { code: 422, errors: ["Old password is incorrect"] }
            }, status: :unprocessable_entity
        end
    end

    private

    def password_params
        params.permit(:password, :password_confirmation)
    end

end