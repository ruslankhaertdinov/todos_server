TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.ClearCompleteView extends Backbone.View
  template: JST["backbone/templates/todos/clear_complete"]

  el: '.clear_complete'

  #  events:
  #    "submit #new-todo": "save"

  render: ->
    $(@el).html(@template)
