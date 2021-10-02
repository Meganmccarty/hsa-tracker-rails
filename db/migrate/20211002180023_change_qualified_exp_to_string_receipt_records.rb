class ChangeQualifiedExpToStringReceiptRecords < ActiveRecord::Migration[6.1]
    def change
        change_column :receipt_records, :qualified_exp, :string
    end
end
