class UsersController < ApplicationController
    before_action :authenticate_user!
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def show
        user = current_user
        render json: user
    end

    def update
        user = current_user
        if user
            user.update!(user_params)
            render json: { user: user, message: "Profile successfully updated" }, status: 200
        else
            render json: { errors: "Not authorized" }, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:first_name, :last_name, :email)
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
