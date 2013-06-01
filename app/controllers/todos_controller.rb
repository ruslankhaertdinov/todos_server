class TodosController < ApplicationController
  # GET /todos
  # GET /todos.json
  def index
    @todos = Todo.order_by_importance
    @todo = Todo.new
    @items_left = items_left
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @todos }
    end
  end

  def change_state
    todo = Todo.find(params[:id])
    todo.done = params[:done]
    todo.save
    render json: {items_left: view_context.pluralize(items_left, 'item')}
  end

  def mark_all
    done_state = params[:mark_all]
    Todo.all.each do |todo|
      todo.done = done_state
      todo.save(validate: false)
    end
    render json: {items_left: items_left}
  end

  def change_importance
    todo = Todo.find(params[:id])
    todo.important = params[:important]
    todo.save
    render json: todo
  end


  # GET /todos/1
  # GET /todos/1.json
  def show
    @todo = Todo.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/new
  # GET /todos/new.json
  def new
    @todo = Todo.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @todo }
    end
  end

  # GET /todos/1/edit
  def edit
    @todo = Todo.find(params[:id])
  end

  # POST /todos
  # POST /todos.json
  def create
    @todo = Todo.new(params[:todo])

    respond_to do |format|
      if @todo.save
        format.html { redirect_to todos_url, notice: 'Todo was successfully created.' }
        format.json { render json: @todo, status: :created, location: @todo }
      else
        format.html { render action: "index" }
        format.json { render json: @todo.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /todos/1
  # PUT /todos/1.json
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

  # DELETE /todos/1
  # DELETE /todos/1.json
  def destroy
    @todo = Todo.find(params[:id])
    @todo.destroy

    respond_to do |format|
      format.html { redirect_to todos_url }
      format.json { head :no_content }
    end
  end

  private

  def items_left
    @items ||= Todo.where(done: false).count
  end
end
