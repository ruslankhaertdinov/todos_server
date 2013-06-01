# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(document).on 'click', '.done_state', ->
    task_id = $(this).parents('tr').data('id')
    $('#mark_all').prop(checked: false)
    if $(this).is(':checked')
      done = true
    else
      done = false
    data =
      done: done
      id: task_id
    $.get "/todos/change_state", data, (data) ->
      $('#items_left').text(data.items_left)
      if !data.items_left
        $('#mark_all').prop(checked: true)
      else
        $('#mark_all').prop(checked: false)

  $(document).on 'click', 'td.importance', ->
    task_id = $(this).parents('tr').data('id')
    important = $(this).children('i').hasClass('icon-star-empty')
    data =
      important: important
      id: task_id
    $.get "/todos/change_importance", data, (todo) ->
      if todo.important
        $("tr[data-id=#{todo.id}] i").removeClass("icon-star-empty").addClass('icon-star')
      else
        $("tr[data-id=#{todo.id}] i").removeClass("icon-star").addClass('icon-star-empty')

  $('#mark_all').change ->
    all_checkboxes = $('.done_state')

    if $(this).is(':checked')
      all_checkboxes.prop(checked: true)
    else
      all_checkboxes.prop(checked: false)

    unchecked = $("input.done_state:not(:checked)").length
    $('#items_left').text(unchecked)

    data =
      mark_all: $(this).is(':checked')
    $.get "/todos/mark_all", data
