class TodoServer.Models.Todo extends Backbone.Model
  url: '/todos'

class TodoServer.Collections.TodosCollection extends Backbone.Collection
  model: TodoServer.Models.Todo
  url: '/todos'
