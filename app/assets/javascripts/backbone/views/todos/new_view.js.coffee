TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.NewView extends Backbone.View
  template: JST["backbone/templates/todos/new"]

  el: '.new_title'

#  events:
#    "submit #new-todo": "save"

  render: ->
    $(@el).html(@template)
#    $(@el).html('@template')
