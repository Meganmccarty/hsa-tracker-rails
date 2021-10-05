class ReceiptRecord < ApplicationRecord
    validates :trans_date, presence: true
    validates :provider, presence: true
    validates :qualified_exp, presence: true, inclusion: {
        in: ['Yes', 'No'],
        message: 'is not a valid option'
    }
    validates :amount, presence: true
    validates :payment_method, presence: true, inclusion: {
        in: ['Cash', 'Check', 'Debit Card', 'Credit Card', 'Electronic Bank Transfer', 'HSA Debit Card'],
        message: 'is not a valid option'
    }

    belongs_to :user

    has_many_attached :receipt_images, dependent: :destroy
end
