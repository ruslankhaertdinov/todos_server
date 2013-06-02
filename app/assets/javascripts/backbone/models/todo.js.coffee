class TodoServer.Models.Todo extends Backbone.Model
  paramRoot: 'todo'

  defaults:
    title: null
    done: null

class TodoServer.Collections.TodosCollection extends Backbone.Collection
  model: TodoServer.Models.Todo
  url: '/todos'
