# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(document).on 'click', '.done_state', ->
    task_id = $(this).parent('tr').data('id')
    if $(this).is(':checked')
      done = true
    else
      done = false
    data =
      done: done
      id: task_id
    $.get "/todos/change_state", data

  $(document).on 'click', 'i.importance', ->
    task_id = $(this).parents('tr').data('id')
    important = $(this).hasClass('icon-star-empty')
    data =
      important: important
      id: task_id
    $.get "/todos/change_importance", data, (todo) ->
      if todo.important
        $("tr[data-id=#{todo.id}] i.importance").removeClass("icon-star-empty").addClass('icon-star')
      else
        $("tr[data-id=#{todo.id}] i.importance").removeClass("icon-star").addClass('icon-star-empty')