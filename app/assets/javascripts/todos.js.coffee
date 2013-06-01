# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(document).on 'click', '.done_state', ->
    task_id = $(this).parents('tr').data('id')
    done = $(this).is(':checked')
    data = (done: done, id: task_id)
    $.get "/todos/change_state", data

  $(document).on 'click', 'td.importance', ->
    task_id = $(this).parents('tr').data('id')
    important = $(this).children('i').hasClass('icon-star-empty')
    data =
      important: important
      id: task_id
    $.get "/todos/change_importance", data

  $(document).on 'change', '#mark_all', ->
    all_checkboxes = $('.done_state')

    if $(this).is(':checked')
      all_checkboxes.prop(checked: true)
    else
      all_checkboxes.prop(checked: false)

    unchecked = $("input.done_state:not(:checked)").length
    if unchecked is 1
      text = 'item left'
    else
      text = 'items left'
    $('#items_left').text(unchecked + ' ' + text)

    data =
      mark_all: $(this).is(':checked')
    $.get "/todos/mark_all", data
