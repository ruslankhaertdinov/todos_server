module TodosHelper
  def all_todos_checked?
    Todo.where(done: false).count == 0
  end
end
