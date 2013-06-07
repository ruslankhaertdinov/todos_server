class TodoServer.Models.Todo extends Backbone.Model
  url: ->
    url = if @get('id')
      '/todos/' + @get('id')
    else
      '/todos/'
    url

class TodoServer.Collections.TodosCollection extends Backbone.Collection
  model: TodoServer.Models.Todo
  url: '/todos'

  itemsLeft: ->
    @filter (model) ->
      model.get('done') is false

  updateStats: ->
    unchecked = @itemsLeft().length
    if unchecked is 1
      text = 'item left'
    else
      text = 'items left'
    $('#items_left').text(unchecked + ' ' + text)
