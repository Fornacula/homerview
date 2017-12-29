// function disable_period_end_if_single(){
//   $(document.getElementById('invoice_period_single')).checked? ? alert("Checked") : alert("Unchecked");
//   var checkbox =
//   checkbox.on('click', function(){
//     if(checkbox.checked?){
//       alert('asd')
//     }
//   })
// }

function manage_single_invoice() {
  var checkbox = document.getElementById('invoice_period_single')
  var period_end_field1 = document.getElementById('invoice_period_period_end_1i')
  var period_end_field2 = document.getElementById('invoice_period_period_end_2i')
  var period_end_field3 = document.getElementById('invoice_period_period_end_3i')
  $(checkbox).on('click', function() {
    if(checkbox.checked) {
      $(period_end_field1).prop('disabled', true)
      $(period_end_field2).prop('disabled', true)
      $(period_end_field3).prop('disabled', true)
    }
    else {
      $(period_end_field1).prop('disabled', false)
      $(period_end_field2).prop('disabled', false)
      $(period_end_field3).prop('disabled', false)
    }
  }
)}
