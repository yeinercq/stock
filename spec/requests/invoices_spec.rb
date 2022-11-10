require 'rails_helper'

RSpec.describe "Invoices", type: :request do
  let(:company) { create :company }
  let(:user) { create( :user, company: company ) }
  before(:each) { sign_in user }

  describe "GET /invoices" do
    it "render invoices index" do
      get invoices_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /invoices/new" do
    it "render new template" do
      get new_invoice_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /invoice" do
    let(:client) { create :customer }
    let(:params) do
      {
        "invoice" => {
          "client_id" => client.id.to_s
        }
      }
    end

    it "creates a new invoice and redirect to show page" do
      post '/invoices', params: params
      expect(response).to redirect_to(assigns(:invoice))
      follow_redirect!
      expect(response).to render_template(:show)
      expect(response.body).to include("Invoice was successfully created.")
    end
  end
end
