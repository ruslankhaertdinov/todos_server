class TodosController < ApplicationController
  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.order_by_importance
    @todo = Todo.new
    @items_left = items_left
    @items_complete = items_complete
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  def change_state
    todo = Todo.find(params[:id])
    todo.done = params[:done]
    todo.save
    @todo = Todo.new(params[:todo])
    @todos = Todo.order_by_importance
    @items_left = items_left
    @items_complete = items_complete
  end

  def mark_all
    done_state = params[:mark_all]
    Todo.all.each do |todo|
      todo.done = done_state
      todo.save(validate: false)
    end
    @todo = Todo.new(params[:todo])
    @todos = Todo.order_by_importance
    @items_left = items_left
    @items_complete = items_complete
  end

  def change_importance
    todo = Todo.find(params[:id])
    todo.important = params[:important]
    todo.save
    @todo = Todo.new(params[:todo])
    @todos = Todo.order_by_importance
    @items_left = items_left
    @items_complete = items_complete
  end

  def create
    @todo = Todo.new(params[:todo])
    @todos = Todo.order_by_importance
    @items_left = items_left

    respond_to do |format|
      if @todo.save
        @todo = Todo.new
        format.js
      else
        format.html { render action: "index" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
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
end
