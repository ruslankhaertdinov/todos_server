class TodoServer.Models.Todo extends Backbone.Model
  url: ->
    url = '/todos/' + @get('id')
    url

class TodoServer.Collections.TodosCollection extends Backbone.Collection
  model: TodoServer.Models.Todo
  url: '/todos'
