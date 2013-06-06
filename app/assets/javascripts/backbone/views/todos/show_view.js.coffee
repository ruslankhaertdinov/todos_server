TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.ShowView extends Backbone.View
  template: JST["backbone/templates/todos/show"]
  tagName: 'tr'

  events:
    'click .done_state': 'toggle_state'

  initialize: (options) ->
    @todo = options.model

  render: ->
    $(@el).html(@template(todo: @todo.attributes))
    return this

  toggle_state: ->
    response = $.ajax(
      url: @todo.url()
      type: 'PUT'
      dataType: 'json'
      async: false
      data: (done: !@todo.get('done'))
    ).responseText
    obj = $.parseJSON(response)
    @todo.set(obj)
    @render()
