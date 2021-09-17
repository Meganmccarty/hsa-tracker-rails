class CreateReceiptRecords < ActiveRecord::Migration[6.1]
    def change
        create_table :receipt_records do |t|
            t.date :trans_date
            t.string :category
            t.string :provider
            t.text :description
            t.boolean :qualified_exp
            t.float :amount
            t.string :payment_method
            t.string :reimbursed
            t.text :notes
            t.string :hsa_trans_id

            t.timestamps
        end
    end
end
