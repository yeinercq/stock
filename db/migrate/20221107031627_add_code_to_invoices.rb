class AddCodeToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_column :invoices, :code, :string
  end
end
