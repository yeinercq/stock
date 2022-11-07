class Invoices::TriggerEvent
  def call(invoice, event)
    invoice.send "#{event}!"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
