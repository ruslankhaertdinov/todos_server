class AddImportantToTodo < ActiveRecord::Migration
  def change
    add_column :todos, :important, :boolean, default: false
  end
end
