class ReceiptRecordSerializer < ActiveModel::Serializer
    include Rails.application.routes.url_helpers

    attributes :id, :trans_date, :category, :provider, :description, :qualified_exp, :amount, :payment_method, 
        :reimbursed, :reimbursed_date, :notes, :hsa_trans_id, :user_id, :receipt_images

    def receipt_images
        return unless object.receipt_images.attached?

        object.receipt_images.map do |receipt_image|
            receipt_image.blob.attributes
                .slice('filename', 'byte_size', 'id')
                .merge(url: receipt_image_url(receipt_image))
        end
    end

    def receipt_image_url(image)
        rails_blob_path(image, only_path: true)
    end
end
