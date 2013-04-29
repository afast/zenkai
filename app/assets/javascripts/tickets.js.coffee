# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $('#ticket_name').on 'keyup', ()->
    project_key = $(this).val().split('-')[0]
    project = $('#ticket_project_id option').filter(()->
      $(this).html() == project_key
    ).val()

    if project
      $('#ticket_project_id').val project


  $('form').on 'ajax:success', ()->
    $('<div></div>', {
      class: 'alert',
      text: 'Operation Successful'
    }).append($('<button></button>', {
      type: 'button',
      class: 'close',
      'data-dismiss': 'alert',
      html: '&times;'
    })).prependTo '.row'

    $.get '/tickets/list', (data) ->
      $('#list').html(data)

  $('#list').on 'ajax:success', 'a.destroy', () ->
    $(this).closest('tr').remove()

