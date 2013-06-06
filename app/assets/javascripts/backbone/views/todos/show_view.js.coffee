TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.ShowView extends Backbone.View
  template: JST["backbone/templates/todos/show"]
  tagName: 'tr'
  events:
    'click .done_state': 'toggle_state'
    'click .importance': 'toggle_importance'

  initialize: (options) ->
    @todo = options.model
    @todos = options.collection

  render: ->
    $(@el).html(@template(todo: @todo.attributes))
    return this

  toggle_state: ->
    @todo.set(done: !@todo.get('done'))
    @save_this(@todo)

  toggle_importance: ->
    @todo.set(important: !@todo.get('important'))
    @save_this(@todo)

  save_this: (todo) ->
    that = @
    todo.save {},
      success: (model, response, options) ->
        $('#todos_table tbody').empty()
        that.todos.reset(response)