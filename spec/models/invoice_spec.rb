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
require 'rails_helper'

RSpec.describe Invoice, type: :model do
  describe 'associations' do
    it { should belong_to(:company) }
    it { should have_many(:items) }
  end

  describe 'validations' do
    it { should validate_presence_of(:client_id) }
  end

  context "with params from scratch" do
    let!(:company) { create :company }
    let(:client) { create :customer }
    let(:product_1) { create :product, company: company, unit: :bulto }
    let(:product_2) { create :product, company: company, unit: :bulto }
    let(:item_1) { create( :item, product: product_1) }
    let(:item_2) { create( :item, product: product_2) }

    subject(:invoice) do
      described_class.new(
        company: company,
        client: client,
        items: [item_1, item_2]
      )
    end

    it { is_expected.to be_valid }

    context "after save" do
      before(:each) { invoice.save }
      it { is_expected.to be_persisted }

      it "has a computed code" do
        expect(invoice.code).to be_present
      end
    end
  end

  context "with params from factory bot" do
    let!(:items_count) { 5 }
    subject(:invoice) { create(:invoice_with_items, items_count: items_count) }

    it 'is persisted' do
      expect(invoice.save).to eq true
    end

    context 'after save' do
      before(:each) { invoice.save }

      it 'has items added' do
        expect(invoice.items.count).to eq items_count
      end
    end
  end
end
