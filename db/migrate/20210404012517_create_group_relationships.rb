class CreateGroupRelationships < ActiveRecord::Migration[5.2]
  def change
    create_table :group_relationships do |t|

      t.references :employee, foreign_key: true
      t.references :group, foreign_key: true

      t.timestamps
    end
  end
end
