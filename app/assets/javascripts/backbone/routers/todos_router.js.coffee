class TodoServer.Routers.TodosRouter extends Backbone.Router

  routes:
    "index"    : "index"
    ""         : "index"
    ".*"       : "index"
    "/"        : "index"

  index: ->
    @todos = new TodoServer.Collections.TodosCollection()
    @todos.fetch
      success: (collection, response, options) ->
        @todos_view = new TodoServer.Views.Todos.CollectionView(collection: collection)
        @todos_view.render()

    @new_todo_form = new TodoServer.Views.Todos.NewView(collection: @todos)
    @new_todo_form.render()

    @clear_complete = new TodoServer.Views.Todos.ClearCompleteView(todos: @todos)
    @clear_complete.render()
