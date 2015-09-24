class CreateTasks < ActiveRecord::Migration
  def change
    create_table :tasks do |t|
      t.string :name
      t.datetime :deadline
      t.integer :priority, default: 0
      t.belongs_to :project
      t.boolean :done, default: false
      t.timestamps null: false
    end
  end
end
