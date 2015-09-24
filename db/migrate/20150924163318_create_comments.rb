class CreateComments < ActiveRecord::Migration
  def change
    create_table :comments do |t|
      t.belongs_to :task
      t.text :body
      t.string :attachment
      t.timestamps null: false
    end
  end
end
