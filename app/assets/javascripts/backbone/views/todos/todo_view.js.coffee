TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.TodoView extends Backbone.View
  template: JST["backbone/templates/todos/todo"]

  events:
    "click .destroy" : "destroy"

  tagName: "tr"

  destroy: () ->
    if confirm('Delete this todo?')
      @model.destroy()
      this.remove()

    return false

  render: ->
    $(@el).html(@template(@model.toJSON() ))
    return this
