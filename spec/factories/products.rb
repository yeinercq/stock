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
FactoryBot.define do
  factory :product do
    sequence(:name) { |n| "Product #{n}" }
    description { Faker::Commerce.material }
    company
    trait :kilo do
      unit { 1 }
    end
    trait :bulto do
      unit { 2 }
    end
    trait :unidad do
      unit { 3 }
    end

    after(:build) do |product, _|
      product.unit = "bulto"
      product.save
    end
  end
end
