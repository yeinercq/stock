require 'rails_helper'

RSpec.describe "Items", type: :request do
  let(:company) { create :company }
  let(:invoice) { create :invoice, company: company }
  let(:user) { create( :user, company: company ) }

  before(:each) { sign_in user }

  describe "GET /invoices/:id/imtes/new" do
    it "render new template" do
      get new_invoice_item_path(invoice)
      expect(response).to render_template(:new)
    end
  end

  describe "POST /invoices/:id/items" do
    let(:product) { create :product }
    let(:params) do
      {
        "item" => {
          "product_id" => product.id.to_s,
          "quantity" => "1",
          "unit_price" => "12"
        }
      }
    end

    it "creates a new item and redirect to invoice show page" do
      post "/invoices/#{invoice.id}/items", params: params
      expect(response).to redirect_to(assigns(:invoice))
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("Item was successfully created.")
    end
  end
end
