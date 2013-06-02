class TodoServer.Models.Todo extends Backbone.Model
  paramRoot: 'todo'

  defaults:
    title: 'empty title...'
    done: false

class TodoServer.Collections.TodosCollection extends Backbone.Collection
  model: TodoServer.Models.Todo
  url: '/todos'
