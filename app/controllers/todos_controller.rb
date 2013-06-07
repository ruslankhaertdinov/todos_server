class TodosController < ApplicationController

  respond_to :html, :json

  def index
    respond_with ordered_todos
  end

  def clear_complete
    Todo.where(done: true).delete_all
    render json: ordered_todos
  end

  def create
    todo = Todo.new(params[:todo])
    todo.save
    render json: ordered_todos
  end

  def update
    todo = Todo.find(params[:id])
    todo.update_attributes(params[:todo])
    render json: ordered_todos
  end

  private

  def ordered_todos
    Todo.order_by_importance
  end
end
