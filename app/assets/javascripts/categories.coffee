# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

jQuery ->
  get_children = ->
    parent_category = $('#category_parent_id').val()
    if parent_category != ''
      $.ajax
        type: 'GET'
        url: "/categories/#{parent_category}/children.js"
        processData: false,
        contentType: false,
        dataType: 'script'
    else
      alert('Wybierz kategorię rodzic')

  $('#category_parent_id').on 'change', ->
    get_children()

  $('#inheritance_true_button').on 'click', ->
    $('#own_parameters').hide()
    $('#inheritance').show()
    get_children()

  $('#inheritance_false_button').on 'click', ->
    $('#own_parameters').show()
    $('#inheritance').hide()
