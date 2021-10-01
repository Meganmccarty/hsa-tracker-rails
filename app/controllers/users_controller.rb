class UsersController < ApplicationController
    before_action :authenticate_user!
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def show
        user = current_user
        render json: {
            user: user,
            status: { code: 200 }
        }, status: :ok
    end

    def update
        user = current_user
        if user
            user.update!(user_params)
            render json: {
                user: user,
                status: { code: 200, message: "Profile successfully updated" }
            }, status: :ok
        else
            render json: {
                status: { code: 401, errors: "Not authorized" }
            }, status: :unauthorized
        end
    end

    private

    def user_params
        params.permit(:first_name, :last_name, :email)
    end

    def render_unprocessable_entity_response(invalid)
        render json: {
            status: { code: 422, errors: invalid.record.errors.full_messages }
        }, status: :unprocessable_entity
    end

end
