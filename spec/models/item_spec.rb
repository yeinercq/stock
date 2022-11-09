require 'rails_helper'

RSpec.describe Item, type: :model do
  let(:invoice) { create(:invoice) }
  let(:product) { create(:product, unit: 'bulto') }
  subject(:item) { build(:item, invoice: invoice, product: product) }

  describe 'associations' do
    it { should belong_to(:product) }
    it { should belong_to(:invoice) }
  end

  describe 'validations' do
    it { should validate_presence_of(:quantity) }
    it { should validate_presence_of(:unit_price) }
    it { should validate_uniqueness_of(:product_id).scoped_to(:invoice_id) }
    it { should validate_numericality_of(:quantity) }
    it { should validate_numericality_of(:unit_price) }
  end

  it 'is persisted' do
    expect(item.save).to eq true
  end

  context 'after save' do
    before(:each) { item.save }

    it 'has an product' do
      expect(item.product.id).to eq product.id
    end

    it 'has a total price' do
      expect(item.total_price).to eq 3000
    end
  end
end
