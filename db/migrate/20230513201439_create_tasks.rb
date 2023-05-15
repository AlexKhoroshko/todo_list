class CreateTasks < ActiveRecord::Migration[7.0]
  def change
    create_table :tasks do |t|
      t.string :title
      t.text :description
      t.integer :priority
      t.integer :status
      t.references :user, null: false, foreign_key: true
      t.datetime :deleted_at
      t.index :deleted_at

      t.timestamps
    end
  end
end
