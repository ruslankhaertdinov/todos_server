TodoServer.Views.Todos ||= {}

class TodoServer.Views.Todos.ShowView extends Backbone.View
  template: JST["backbone/templates/todos/show"]
  tagName: 'tr'
  events:
    'click .done_state'   : 'toggle_state'
    'click .importance'   : 'toggle_importance'
    'dblclick .title'     : 'make_editable'
    'keydown .title_edit' : 'editing_title'
    'focusout .title_edit': 'break_edit',

  initialize: (options) ->
    @todo = options.model
    @todos = options.collection

  render: ->
    $(@el).html(@template(todo: @todo.attributes))
    return this

  toggle_state: ->
    @todo.set(done: !@todo.get('done'))
    @save_this(@todo)
    @update_stats()

  toggle_importance: ->
    @todo.set(important: !@todo.get('important'))
    @save_this(@todo)

  save_this: (todo) ->
    that = @
    todo.save {},
      success: (model, response, options) ->
        $('#todos_table tbody').empty()
        that.todos.reset(response)

  make_editable: ->
    @$('.title_span').hide()
    @$('.title_edit').show().focus()

  editing_title: (event) ->
    new_title = @$('.title_edit').val()
    if (event.which == 13) and new_title.length
      @todo.set(title: new_title)
      @save_this(@todo)
    else if event.which == 27
      @break_edit()

  break_edit: ->
    @$('.title_span').show()
    @$('.title_edit').hide()

  update_stats: ->
    unchecked = $("input.done_state:not(:checked)").length
    if unchecked is 1
      text = 'item left'
    else
      text = 'items left'
    $('#items_left').text(unchecked + ' ' + text)
