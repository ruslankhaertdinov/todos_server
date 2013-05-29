class CreateTodos < ActiveRecord::Migration
  def change
    create_table :todos do |t|
      t.string :title
      t.integer :order
      t.boolean :done, default: false
      t.datetime :due_date
      t.timestamps
    end
  end
end
