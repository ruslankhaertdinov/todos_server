class TodoServer.Models.Todo extends Backbone.Model
  url: ->
    url = if @get('id')
      '/todos/' + @get('id')
    else
      '/todos/'
    url

class TodoServer.Collections.TodosCollection extends Backbone.Collection
  model: TodoServer.Models.Todo
  url: '/todos'
