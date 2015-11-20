$(document).ready(function() {
  $('#calendar').datepicker({
      showOtherMonths: true,
      defaultDate: null,
      appendText:"(mm-dd-yy)",
      dateFormat: "yy-mm-dd",
      altField: "#alt_date",
      altFormat: "yy-mm-dd",
      dateFormat: 'mm-dd-yy',
      onSelect: function (dateText, inst) {
        console.log(dateText);
      }
  });
});