class CreateAbstract < ActiveRecord::Migration[7.0]
  def additional_columns table_name
    change_table table_name do |t|
      t.boolean :deleted, default: false
      t.boolean :enabled, default: true
      t.references :creator, references: :users, index: true
      t.references :modifier, references: :users, index: true
      t.references :deleter, references: :users, index: true
      t.timestamps
      t.datetime :deleted_at
    end
  end
end
