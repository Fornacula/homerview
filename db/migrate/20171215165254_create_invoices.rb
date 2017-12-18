class CreateInvoices < ActiveRecord::Migration[5.1]
  def change
    create_table :invoices do |t|
      t.references :service, foreign_key: true
      t.references :user, foreign_key: true
      t.decimal :price
      t.string :comment

      t.timestamps
    end
  end
end
