class ReceiptRecordsController < ApplicationController
    rescue_from ActiveRecord::RecordNotFound, with: :render_not_found_response
    rescue_from ActiveRecord::RecordInvalid, with: :render_unprocessable_entity_response
    before_action :authenticate_user!

    def index
        receipt_records = current_user.receipt_records.with_attached_receipt_images
        render json: receipt_records, include: ['receipt_images'], status: :ok
    end

    def show
        receipt_record = current_user.receipt_records.find(params[:id])
        render json: {
            receipt_record: receipt_record,
            status: { code: 200 }
        }, status: :ok
    end

    def create
        user = current_user
        receipt_record = ReceiptRecord.new(receipt_record_params)
        receipt_record.user_id = user.id
        receipt_record.save!
        render json: {
            receipt_record: receipt_record,
            status: { code: 201, message: "Receipt record successfully created" }
        }, status: :created
    end

    def update
        receipt_record = find_receipt_record
        to_delete = params[:receipt_images_to_delete]
        receipt_record.update(receipt_record_params)

        if to_delete
            image_ids = to_delete.split(",").map(&:to_i)
            image_ids.map do |id|
                image = receipt_record.receipt_images.find(id)
                image.purge_later
            end
        end

        render json: {
            receipt_record: receipt_record,
            status: { code: 202, message: "Receipt record successfully updated" }
        }, status: :accepted
    end

    def destroy
        receipt_record = find_receipt_record
        receipt_record.receipt_images.purge_later
        receipt_record.destroy
        render json: {
            status: { code: 202, message: "Receipt record successfully deleted" } 
        }, status: :accepted
    end

    private

    def receipt_record_params
        params.permit(:trans_date, :category, :provider, :description, :qualified_exp,
            :amount, :payment_method, :reimbursed, :reimbursed_date, :notes, :hsa_trans_id, receipt_images: []
        )
    end

    def find_receipt_record
        current_user.receipt_records.find(params[:id])
    end

    def render_not_found_response
        render json: {
            status: { code: 404, errors: 'Receipt record not found' }
        }, status: :not_found
    end

    def render_unprocessable_entity_response(invalid)
        render json: { 
            status: { code: 422, errors: invalid.record.errors.full_messages }
        }, status: :unprocessable_entity
    end

end
