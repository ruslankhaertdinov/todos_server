# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(document).on 'click', '.done_state', ->
    task_id = $(this).parents('tr').data('id')
    done = $(this).is(':checked')
    data = (done: done, id: task_id)
    $.get "/todos/change", data

  $(document).on 'click', 'td.importance', ->
    task_id = $(this).parents('tr').data('id')
    important = $(this).children('i').hasClass('icon-star-empty')
    data =
      important: important
      id: task_id
    $.get "/todos/change", data

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

  $(document).on 'click', '#clear_complete_btn', ->
    if $('input.done_state:checked').length > 0
      $.get "/todos/clear_complete"

  $(document).on 'dblclick', 'td.title', ->
    title = $(this).text()
    id = $(this).parents('tr').data('id')
    $(this).text('')
    $(this).append($('<input type="text"/>').val(title))
    $(document).on 'keydown', "tr[data-id=#{id}] td.title input", (event) ->
      new_text = $("tr[data-id=#{id}] td.title input").val()
      if event.which == 13
        $("tr[data-id=#{id}] td.title").text(new_text)
