# expand/unexpand collapsable content in tabs
initExpand = ->
  $('.expand-button').not('.expanded').click ->
    $(this).addClass('expanded').text 'Less'
    $(this).siblings('.expand-content').addClass 'expanded'
    initUnexpand()

initUnexpand = ->
  $('.expand-button.expanded').click ->
    $(this).removeClass('expanded').text 'Read More'
    $(this).siblings('.expand-content').removeClass 'expanded'
    initExpand()

$ ->
  initExpand()
  initUnexpand()

# reset expandable content when switching tabs
$(document).on 'click', '#tab-triggers', ->
  $('.expand-content').removeClass 'expanded'
  $('.expand-button').removeClass('expanded').text 'Read More'

# photo row scrolling animation
$ ->
  photoRow = $('.photo-row')
  $('#right-click-area').click ->
    leftPos = photoRow.scrollLeft()
    width = $(window).width()
    photoRow.animate { scrollLeft: leftPos + width }, 500
    false
  $('#left-click-area').click ->
    leftPos = photoRow.scrollLeft()
    width = $(window).width()
    photoRow.animate { scrollLeft: leftPos - width }, 500
    false

# submit contact form through techbient api
$(document).on 'submit', '.contact-form', ->
  $form = $(this)
  emptyFields = []
  $form.find('.required').each ->
    if $(this).val() == ''
      $(this).addClass('error')
      $(this).after('<i class="fa fa-exclamation-triangle error-icon"></i>')
      emptyFields.push(this)
    else
      $(this).removeClass('error')
      $(this).siblings('.error-icon').remove()
  if emptyFields.length
    false
  else
    $form.find('button[type=submit]').addClass('btn-loading').prop('disabled', true)
    $.ajax(
      method: 'POST',
      url: 'https://techbient.com/api/messages',
      data: $('.contact-form').serialize(),
      dataType: 'json',
    ).done((response) ->
      $('.contact-form')[0].reset()
      $('.contact-form').find('button[type=submit]').removeClass('btn-loading').prop('disabled', false)
      $('.message-success').removeClass('hidden')
      $('.message-error').addClass('hidden')
      setTimeout ->
        $('.message-success').addClass('hidden')
      , 5000
    ).fail((reason) ->
      $('.contact-form').find('button[type=submit]').removeClass('btn-loading').prop('disabled', false)
      $('.message-error').removeClass('hidden')
    )
    false

