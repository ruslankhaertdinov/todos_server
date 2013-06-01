class TodosController < ApplicationController

  def index
    get_variables
  end

  def change
    todo = Todo.find(params[:id])
    todo.done = params[:done] if params[:done].present?
    todo.important = params[:important] if params[:important].present?
    todo.title = params[:title] if params[:title].present?
    todo.save
    get_variables
  end

  def mark_all
    Todo.all.each do |todo|
      todo.done = params[:mark_all]
      todo.save(validate: false)
    end
    get_variables
  end

  def clear_complete
    Todo.where(done: true).delete_all
    get_variables
  end

  def create
    @todo = Todo.new(params[:todo])
    @todo.save
    get_variables
  end

  private

  def get_variables
    @todo = Todo.new
    @todos = Todo.order_by_importance
    @items_left = Todo.where(done: false).count
    @items_complete = Todo.where(done: true).count
  end
end
