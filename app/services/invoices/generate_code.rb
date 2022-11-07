class Invoices::GenerateCode
  def call(invoice)
    invoice.code = "FVF#{Time.now.strftime('%d%m%Y')}#{invoice.client.id}#{SecureRandom.hex(8)}"
    [true, 'successful']
  rescue => e
    # binding.pry
    Rails.logger.error e
    [false, 'failed']
  end
end
