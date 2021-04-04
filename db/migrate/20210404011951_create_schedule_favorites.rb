class CreateScheduleFavorites < ActiveRecord::Migration[5.2]
  def change
    create_table :schedule_favorites do |t|

      t.references :employee, foreign_key: true
      t.references :schedule, foreign_key: true

      t.timestamps
    end
  end
end
