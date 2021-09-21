class ReceiptRecordsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFonud, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
    end

    def create
    end

    def update
    end

    def destroy
    end

    private

    def render_not_found_response
        render json: { error: 'Receipt record not found' }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
