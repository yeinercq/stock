require 'rails_helper'

RSpec.describe "Invoices", type: :system do
  let(:company) { create :company }
  let(:user) { create( :user, company: company ) }

  before(:each) { sign_in user }

  # put this config in rails_helper
  # before do
  #   driven_by(:rack_test)
  # end

  describe 'GET /invoices' do
    it 'has a correct title and New Invoice button'do
    visit '/invoices'
    expect(page).to have_content("Invoices")
    expect(page).to have_content("New invoice")
    end
  end

  describe 'POST /invoices' do
    let!(:client) { create :customer }

    it 'render new invoice template' do
      visit '/invoices'

      click_link('New invoice')
      # binding.pry
      # xpath = '//*[@id="new_invoice"]'
      # within(:xpath, xpath) do
        select(client.name, from: 'invoice[client_id]')
        click_button('Create Invoice')
      # end
      expect(page).to have_content("Invoice was successfully created.")
      expect(page).to have_content("FVF")
      expect(page).to have_content("Client: #{client.name}")
    end
  end

  describe 'POST /invoices/id' do
    let!(:company) { create :company }
    let!(:invoice) { create :invoice, company: company }
    let!(:product) { create :product }

    it 'render new item template' do
      visit "/invoices/#{invoice.id}"

      click_link('Add item')
      # binding.pry
      # xpath = '//*[@id="new_invoice"]'
      # within(:xpath, xpath) do
        select(product.name, from: 'item[product_id]')
        fill_in 'item[quantity]', with: "2"
        fill_in 'item[unit_price]', with: "1000"
        click_button('Create Item')
      # end
      expect(page).to have_content("Item was successfully created.")
    end
  end

end
