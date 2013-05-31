# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$(document).ready ->
  $(document).on 'click', '.done_state', ->
    task_id = $(this).parent('td').data('id')
    if $(this).is(':checked')
      done = true
    else
      done = false

    $.ajax
      url: "/todos/change_state",
      data:
        done: done
        id: task_id
