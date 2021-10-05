class AddReimbursedDateToReceiptRecords < ActiveRecord::Migration[6.1]
    def change
        add_column :receipt_records, :reimbursed_date, :date
    end
end
