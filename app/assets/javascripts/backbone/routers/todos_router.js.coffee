class TodoServer.Routers.TodosRouter extends Backbone.Router
  initialize: (options) ->
    @todos = new TodoServer.Collections.TodosCollection()
    @todos.reset options.todos

  routes:
    "index"    : "index"
    ""         : "index"
    ".*"        : "index"

  index: ->
    @index_view = new TodoServer.Views.Todos.IndexView().render()

