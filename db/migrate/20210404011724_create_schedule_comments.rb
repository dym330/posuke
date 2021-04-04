class CreateScheduleComments < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_comments do |t|

      t.references :employee, foreign_key: true
      t.references :schedule, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end
  end
end
