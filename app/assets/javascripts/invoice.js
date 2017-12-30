function manage_single_invoice() {
  var checkbox = document.getElementById('invoice_period_single')
  var period_end_field = document.getElementById('invoice_period_period_end')
  $(checkbox).on('click', function() {
    if(checkbox.checked) {
      $(period_end_field).prop('disabled', true)
    }
    else {
      $(period_end_field).prop('disabled', false)
    }
  }
)}
