class TodoServer.Routers.TodosRouter extends Backbone.Router

  routes:
    "index"    : "index"
    ""         : "index"
    ".*"       : "index"
    "/"        : "index"

  index: ->
    console.log 'index'

    @new_todo_form = new TodoServer.Views.Todos.NewView().render()

    @todos = new TodoServer.Collections.TodosCollection()
    @todos.fetch  =>
      success: (collection, response, options) ->
        console.log collection
        console.log response


    @clear_complete = new TodoServer.Views.Todos.ClearCompleteView().render()
