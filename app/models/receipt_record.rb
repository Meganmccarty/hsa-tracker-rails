class ReceiptRecord < ApplicationRecord
    validates :trans_date, presence: true
    validates :provider, presence: true
    validates :amount, presence: true
    validates :payment_method, presence: true
    validates :reimbursed, presence: true, inclusion: {
        in: ['Yes', 'No', 'N/A'],
        message: 'is not a valid option'
    }

    belongs_to :user
end
