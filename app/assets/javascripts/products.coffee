jQuery ->
  $('#product_category_id').on 'change', ->
    if this.value == ''
      $('#product_values').hide()
    else
      $('#product_values').show()
      $.ajax
        type: 'GET'
        url: "/categories/#{this.value}/parameters.js"
        processData: false,
        contentType: false,
        dataType: 'script'