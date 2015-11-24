// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready(function(){
  $('[data-behaviour~=datepicker]').datepicker( {
    showOtherMonths: true,
    defaultDate: null,
    autoclose: true,
    clearBtn: true,
    startDate: new Date(),
    format: 'yyyy-mm-dd'
  } );
})
