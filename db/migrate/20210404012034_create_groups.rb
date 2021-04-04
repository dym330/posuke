class CreateGroups < ActiveRecord::Migration[5.2]
  def change
    create_table :groups do |t|

      t.references :employee, foreign_key: true
      t.string :name, null: false

      t.timestamps
    end
  end
end
