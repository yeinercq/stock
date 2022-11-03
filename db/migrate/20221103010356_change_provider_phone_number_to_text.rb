class ChangeProviderPhoneNumberToText < ActiveRecord::Migration[7.0]
  def change
    change_column :providers, :phone_number, :text
  end
end
