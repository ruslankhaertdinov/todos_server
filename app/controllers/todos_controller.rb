class TodosController < ApplicationController
  # GET /todos
  # GET /todos.json
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

  def update
    @todo = Todo.find(params[:id])

    respond_to do |format|
      if @todo.update_attributes(params[:todo])
        format.html { redirect_to @todo, notice: 'Todo was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  private

  def get_variables
    @todo = Todo.new
    @todos = Todo.order_by_importance
    @items_left = Todo.where(done: false).count
    @items_complete = Todo.where(done: true).count
  end
end
