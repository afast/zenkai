# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->

  $(".best_in_place").best_in_place()

  $('#ticket_name').on 'keyup', ()->
    project_key = $(this).val().split('-')[0]
    project = $('#ticket_project_id option').filter(()->
      $(this).html() == project_key
    ).val()

    if project
      $('#ticket_project_id').val project

  $('.re-estimate').on 'ajax:success', () ->
    $.get $('#pending').data('path'), (data) ->
      $('#pending').html(data)
      $(".best_in_place").best_in_place()

  $('form').on 'ajax:success', ()->
    $('.alert').remove()
    $('<div></div>', {
      class: 'alert',
      text: 'Operation Successful'
    }).append($('<button></button>', {
      type: 'button',
      class: 'close',
      'data-dismiss': 'alert',
      html: '&times;'
    })).prependTo $('#pending_estimate').closest('.row')

    $.get $('#pending_estimate').data('path'), (data) ->
      $('#pending_estimate').html(data)
      $(".best_in_place").best_in_place()

  $('#list').on 'ajax:success', 'a.destroy', () ->
    $(this).closest('tr').remove()

  $('select#project').on 'change', ->
    this.form.submit()
  $('select#user').on 'change', ->
    this.form.submit()
  $('select#sprint').on 'change', ->
    this.form.submit()
  $('input#from[type="date"]').on 'change', ->
    this.form.submit()
