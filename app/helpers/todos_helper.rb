module TodosHelper
  def items_left
    Todo.where(done: false).count
  end
end
