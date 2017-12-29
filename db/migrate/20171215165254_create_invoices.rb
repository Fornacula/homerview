class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices, id: :uuid do |t|
      t.references :service, foreign_key: true, type: :uuid
      t.references :user, foreign_key: true, type: :uuid
      t.decimal :price, null: false
      t.string :comment
      t.string :invoice_nr

      t.timestamps
    end
  end
end
