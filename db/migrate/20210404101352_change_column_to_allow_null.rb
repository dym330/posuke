class ChangeColumnToAllowNull < ActiveRecord::Migration[5.2]
  def up
    change_column :schedules, :question, :string, null: true, default: ""
  end
end
