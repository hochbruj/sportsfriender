# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#user_city_name').autocomplete
    source: $('#user_city_name').data('autocomplete-source')
  $('#group_name').show() if $('#new_group').is(':checked')
  $('#group_name').hide() if not $('#event_new_group').is(':checked')
  
  $('#new_group').change ->
    $('#group_name').show() if $('#new_group').is(':checked')
    $('#group_name').hide() if not $('#new_group').is(':checked')





