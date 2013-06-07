TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.ClearCompleteView extends Backbone.View
  template: JST["backbone/templates/todos/clear_complete"]

  el: '.clear_complete'

  events:
    "click #clear_complete_btn": "clear_complete"

  initialize: (options) ->
    @todos = options.todos

  render: ->
    $(@el).html(@template)

  clear_complete: ->
    if $('input.done_state:checked').length
      that = @
      $.get("/todos/clear_complete")
        .success (response) ->
          $('#todos_table tbody').empty()
          that.todos.reset(response)

