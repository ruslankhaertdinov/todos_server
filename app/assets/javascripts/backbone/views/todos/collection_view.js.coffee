TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.CollectionView extends Backbone.View

  el: '#todos_table'

  initialize: (options) =>
    @collection.on('add', @addOne, @)
    @collection.on('reset', @addAll, @);

  render: =>
    @addAll()

  addOne: (model) =>
    @todo_show = new TodoServer.Views.Todos.ShowView(model: model)
    @$el.append(@todo_show.render().el)

  addAll: =>
    @collection.forEach(@addOne, @)

