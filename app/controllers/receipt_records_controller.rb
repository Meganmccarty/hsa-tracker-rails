class ReceiptRecordsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    # before_action :current_user

    def index
        # receipt_records = current_user.receipt_records
        receipt_records = ReceiptRecord.all
        render json: receipt_records
    end

    def show
        # receipt_record = current_user.receipt_records.find(params[:id])
        receipt_record = ReceiptRecord.find(params[:id])
        render json: receipt_record
    end

    def create
        user = User.find_by(id: session[:user_id])
        # receipt_record = ReceiptRecord.create!(receipt_record_params, user_id: current_user.id)
        receipt_record = ReceiptRecord.new(receipt_record_params)
        receipt_record.user_id = user.id
        receipt_record.save!
        render json: receipt_record, status: :created
    end

    def update
        receipt_record = find_receipt_record
        receipt_record.update(receipt_record_params)
        render json: receipt_record
    end

    def destroy
        receipt_record = find_receipt_record
        # receipt_record.images.purge
        receipt_record.destroy
        render json: { message: "Receipt record successfully deleted"}, status: 200
    end

    private

    # def current_user
    #     User.find_by(id: session[:user_id])
    # end

    def receipt_record_params
        params.require(:receipt_record).permit(:trans_date, :category, :provider, :description, :qualified_exp,
            :amount, :payment_method, :reimbursed, :notes, :hsa_trans_id, images: []
        )
    end

    def find_receipt_record
        ReceiptRecord.find(params[:id])
    end

    def render_not_found_response
        render json: { errors: 'Receipt record not found' }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { errors: invalid.record.errors.full_messages }, status: :unprocessable_entity
    end

end
