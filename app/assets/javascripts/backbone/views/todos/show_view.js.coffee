TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.ShowView extends Backbone.View
  template: JST["backbone/templates/todos/show"]

  initialize: (options) ->
    @todo = options.model

  render: ->
    $(@el).html(@template(todo: @todo.attributes))
    return this
