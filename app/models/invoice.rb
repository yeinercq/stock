# == Schema Information
#
# Table name: invoices
#
#  id         :bigint           not null, primary key
#  total      :decimal(10, 2)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  company_id :bigint           not null
#  client_id  :bigint           not null
#  code       :string
#
class Invoice < ApplicationRecord
  include AASM

  belongs_to :client, class_name: 'Customer'
  belongs_to :company

  has_many :items, dependent: :destroy

  validates :client_id, presence: true

  before_create :generate_code

  scope :ordered,-> { order(id: :desc) }

  broadcasts_to ->(invoice) { [invoice.company, "invoices"] }, inserts_by: :prepend

  def total_price
    items.sum(&:total_price)
  end

  aasm column: :status do
    state :new, initial: true
    state :recorded, :confirmed, :paid, :delivered

    after_all_transitions :log_status_change

    event :record do
      transitions from: :new, to: :recorded
    end

    event :confirm do
      transitions from: :recorded, to: :confirmed
    end

    event :pay do
      transitions from: :confirmed, to: :paid
    end

    event :deliver do
      transitions from: :paid, to: :delivered
    end
  end

  def log_status_change
    transitions.push(
      {
        from_state: aasm.from_state,
        to_state: aasm.to_state,
        current_event: aasm.current_event,
        timestamp: Time.zone.now
      }
    )
  end

  def generate_code
    Invoices::GenerateCode.new.call(self)
  end
end
