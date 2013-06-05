TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.NewView extends Backbone.View
  template: JST["backbone/templates/todos/new"]

  el: '.new_title'

  events:
    "keydown #todo_title": "save"

  render: ->
    $(@el).html(@template)

  save: (event) ->
    todo_title = $('#todo_title').val()
    if (event.which == 13) and (todo_title.length)
      new_todo = new TodoServer.Models.Todo(title: todo_title)
      new_todo.save {},
        success: (model, response, options) ->
          show_view = new TodoServer.Views.Todos.ShowView(model: model)
          $('#todos_table').prepend(show_view.render().el)
          $('#todo_title').val('')