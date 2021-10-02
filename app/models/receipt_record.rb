class ReceiptRecord < ApplicationRecord
    validates :trans_date, presence: true
    validates :provider, presence: true
    validates :amount, presence: true
    validates :payment_method, presence: true

    belongs_to :user

    has_many_attached :receipt_images, dependent: :destroy
end
