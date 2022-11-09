# == Schema Information
#
# Table name: invoices
#
#  id          :bigint           not null, primary key
#  total       :decimal(10, 2)
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#  client_id   :bigint           not null
#  code        :string
#  status      :string
#  transitions :hstore           is an Array
#
FactoryBot.define do
  factory :invoice do
    company
    association :client, factory: :customer
    # invoice_with_items will create items data after the invoice has been created
    factory :invoice_with_items do
      # items_count is declared as a transient attribute available in the
      # callback via the evaluator
      transient do
        items_count { 3 }
      end
      # the after(:create) yields two values; the innvoice instance itself and the
      # evaluator, which stores all values from the factory, including transient
      # attributes; `create_list`'s second argument is the number of records
      # to create and we make sure the invoice is associated properly to the item
      after(:build) do |invoice, evaluator|
        create_list(:item, evaluator.items_count, invoice: invoice)

        # You may need to reload the record here, depending on your application
        invoice.reload
      end
    end
  end
end
