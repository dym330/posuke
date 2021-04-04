class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|

      t.references :employee, foreign_key: true
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :content, null: false
      t.text :question, null: false
      t.integer :schedule_status, null: false, default: 0
      t.boolean :comment_status, null: false, default: false

      t.timestamps
    end
  end
end
