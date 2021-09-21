class ReceiptRecordsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFonud, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response

    def index
        receipt_records = ReceiptRecord.all.with_attached_images
        render json: receipt_records
    end

    def create
        user = User.find_by(id: session[:user_id])
        receipt_record = ReceiptRecord.create!(receipt_record_params, user_id: user.id)
        render json: receipt_record, status: :created
    end

    def update
        receipt_record = find_receipt_record
        receipt_record.update(receipt_record_params)
        render json: receipt_record
    end

    def destroy
        receipt_record = find_receipt_record
        receipt_record.images.purge
        receipt_record.destroy
        head :no_content
    end

    private

    def receipt_record_params
        params.permit(:trans_date, :category, :provider, :description, :qualified_exp,
            :amount, :payment_method, :reimbursed, :notes, :hsa_trans_id, images: []
        )
    end

    def find_receipt_record
        ReceiptRecord.find(params[:id])
    end

    def render_not_found_response
        render json: { error: 'Receipt record not found' }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
