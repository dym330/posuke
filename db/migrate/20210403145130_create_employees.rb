class CreateEmployees < ActiveRecord::Migration[5.2]
  def change
    create_table :employees do |t|
      t.references :company, foreign_key: true
      t.string :name, null: false
      t.string :email, null: false
      t.string :image_id, null: false
      t.string :department, null: false
      t.date :joining_date, null: false
      t.boolean :admin, null: false, default: false
      t.boolean :enrollment_status, null: false, default: true

      t.timestamps
    end
  end
end
