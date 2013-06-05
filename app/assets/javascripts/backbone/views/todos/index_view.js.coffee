TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.IndexView extends Backbone.View
  template: JST["backbone/templates/todos/index"]

  render: =>
    $('body').append(@template)
