TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.CollectionView extends Backbone.View

  el: '#todos_table'

  initialize: (options) =>
    @collection.on('add', @addOne, @)
    @collection.on('reset', @addAll, @)

  render: =>
    @addAll()
    @todo_show.update_stats()

  addOne: (model) =>
    @todo_show = new TodoServer.Views.Todos.ShowView(model: model, collection: @collection)
    @$el.append(@todo_show.render().el)

  addAll: =>
    @collection.forEach(@addOne, @)

