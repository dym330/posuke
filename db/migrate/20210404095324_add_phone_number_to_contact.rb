class AddPhoneNumberToContact < ActiveRecord::Migration[5.2]
  def up
    add_column :contacts, :phone_number, :string, null: false
  end
end
