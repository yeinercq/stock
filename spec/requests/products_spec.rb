require 'rails_helper'

RSpec.describe "Products", type: :request do
  let(:company) { create :company }
  let(:user) { create( :user, company: company ) }
  
  before(:each) { sign_in user }

  describe "GET /products" do
    it "render invoices index" do
      get products_path
      expect(response).to have_http_status(200)
    end
  end

  describe "GET /products/new" do
    it "render new template" do
      get new_product_path
      expect(response).to render_template(:new)
    end
  end

  describe "POST /products" do
    let(:params) do
      {
        "product" => {
          "name" => "15-15-15",
          "unit" => "bulto",
          "description" => "description"
        }
      }
    end

    it "creates a new product and redirect to show page" do
      post '/products', params: params
      expect(response).to redirect_to(assigns(:products))
      follow_redirect!
      expect(response).to render_template(:index)
      expect(response.body).to include("Product was successfully created.")
    end
  end
end
