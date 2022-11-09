# == Schema Information
#
# Table name: products
#
#  id          :bigint           not null, primary key
#  name        :string           not null
#  description :text             not null
#  unit        :integer          not null
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#  company_id  :bigint           not null
#
require 'rails_helper'

RSpec.describe Product, type: :model do
  subject{ build(:product, unit: :bulto)}

  describe 'associations' do
    it { should belong_to(:company) }
  end

  describe 'validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:unit) }
    it { should validate_uniqueness_of(:name).scoped_to(:company_id).case_insensitive }
    it { should define_enum_for(:unit) }
  end
end
