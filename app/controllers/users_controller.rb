class UsersController < ApplicationController
    before_action :authenticate_user!
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def show
        user = current_user
        render json: user
    end

    private

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
