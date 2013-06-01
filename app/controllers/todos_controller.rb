class TodosController < ApplicationController
  # GET /todos
  # GET /todos.json
  def index
    get_variables
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  def change
    get_variables
    todo = Todo.find(params[:id])
    todo.done = params[:done] if params[:done].present?
    todo.important = params[:important] if params[:important].present?
    todo.title = params[:title] if params[:title].present?
    todo.save
  end

  def mark_all
    get_variables
    done_state = params[:mark_all]
    Todo.all.each do |todo|
      todo.done = done_state
      todo.save(validate: false)
    end
  end

  def clear_complete
    get_variables
    Todo.where(done: true).delete_all
  end

  def create
    get_variables
    @todo = Todo.new if @todo.save
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

  def items_left
    @letf ||= Todo.where(done: false).count
  end

  def items_complete
    @complete ||= Todo.where(done: true).count
  end

  def get_variables
    @todo = Todo.new(params[:todo])
    @todos = Todo.order_by_importance
    @items_left = items_left
    @items_complete = items_complete
  end
end
