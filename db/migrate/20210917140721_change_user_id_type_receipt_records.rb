class ChangeUserIdTypeReceiptRecords < ActiveRecord::Migration[6.1]
    def change
        change_column :receipt_records, :user_id, :integer
    end
end
