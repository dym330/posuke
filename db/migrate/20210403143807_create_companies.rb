class CreateCompanies < ActiveRecord::Migration[5.2]
  def change
    create_table :companies do |t|
      t.string :company_name, null: false
      t.string :responsible_name, null: false
      t.string :postcode, null: false
      t.string :address, null: false
      t.string :email, null: false
      t.string :phone_number, null: false
      t.boolean :usage_status, default: true

      t.timestamps
    end
  end
end
