class AddClientToInvoices < ActiveRecord::Migration[7.0]
  def change
    add_reference :invoices, :client, null: false, foreign_key: { to_table: :customers }, index: true
  end
end
