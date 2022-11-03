class ChangeProviderPhoneNumberToString < ActiveRecord::Migration[7.0]
  def change
    change_column :providers, :phone_number, :string
  end
end
