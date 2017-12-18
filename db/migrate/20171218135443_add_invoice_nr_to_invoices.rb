class AddInvoiceNrToInvoices < ActiveRecord::Migration[5.1]
  def change
    add_column :invoices, :invoice_nr, :string
  end
end
