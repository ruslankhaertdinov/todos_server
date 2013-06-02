class TodoServer.Routers.TodosRouter extends Backbone.Router
  initialize: (options) ->
    @todos = new TodoServer.Collections.TodosCollection()
    @todos.reset options.todos

  routes:
    "index"    : "index"
    ":id/edit" : "edit"
    ":id"      : "show"
    ".*"        : "index"

  index: ->
    @new_view = new TodoServer.Views.Todos.NewView(collection: @todos)
    $("#todos_form").html(@new_view.render().el)

    @index_view = new TodoServer.Views.Todos.IndexView(todos: @todos)
    $("#todos_table").append(@index_view.render().el)

  show: (id) ->
    todo = @todos.get(id)

    @view = new TodoServer.Views.Todos.ShowView(model: todo)
    $("#todos").html(@view.render().el)

  edit: (id) ->
    todo = @todos.get(id)

    @view = new TodoServer.Views.Todos.EditView(model: todo)
    $("#todos").html(@view.render().el)
