class CreateSchedules < ActiveRecord::Migration[5.2]
  def change
    create_table :schedules do |t|

      t.references :employee, foreign_key: true
      t.string :title, null: false
      t.datetime :start_time, null: false
      t.datetime :end_time, null: false
      t.text :content, null: false
      t.text :question, default: ""
      t.integer :schedule_status, default: 0
      t.boolean :comment_status, default: false

      t.timestamps
    end
  end
end
