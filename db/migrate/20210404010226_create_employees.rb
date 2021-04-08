class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.string :email,              null: false, default: ""
      t.string :password_digest, null: false, default: ""
      t.references :company, foreign_key: true
      t.string :name, null: false
      t.string :image_id, null: false, default: ""
      t.string :department, null: false
      t.date :joining_date, null: false
      t.boolean :admin, default: false
      t.boolean :enrollment_status, default: true

      t.timestamps
    end
  end
end
