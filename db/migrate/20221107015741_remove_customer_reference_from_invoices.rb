class RemoveCustomerReferenceFromInvoices < ActiveRecord::Migration[7.0]
  def change
    remove_column :invoices, :customer_id, :integer
  end
end
