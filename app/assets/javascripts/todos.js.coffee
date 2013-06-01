# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  saveChanges = (opts) ->
    $.get "/todos/change", (opts)

  $(document).on 'click', '.done_state', ->
    task_id = $(this).parents('tr').data('id')
    done = $(this).is(':checked')
    saveChanges(done: done, id: task_id)

  $(document).on 'click', 'td.importance', ->
    task_id = $(this).parents('tr').data('id')
    important = $(this).children('i').hasClass('icon-star-empty')
    saveChanges(important: important, id: task_id)

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
    title_old = $(this).text()
    task_id = $(this).parents('tr').data('id')
    $(this).html($('<input type="text"/>').val(title_old))
    el = "tr[data-id=#{task_id}] td.title"
    input = el + " input"

    $(document).on 'keydown', input, (event) ->
      title_new = $(input).val()
      if event.which == 13 and title_new.length
        $(el).text(title_new)
        saveChanges(title: title_new, id: task_id)
      else if event.which == 27
        $(el).text(title_old)

  $(document).on 'keydown', '#todo_title', ->
    if event.which == 13
      $('form#new_todo').submit ->
        if $('#todo_title').val().length == 0
          return false
    else if event.which == 27
      $('#todo_title').val('')

