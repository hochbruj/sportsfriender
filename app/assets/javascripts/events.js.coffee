# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#search_city').autocomplete
    source: $('#search_city').data('autocomplete-source')
  $('#event_city').autocomplete
    source: $('#event_city').data('autocomplete-source')
    select: (event, ui) ->
	         $(this).val(ui.item.value).parents("form").submit()
  $('#event_date').datepicker({
								showOn: "both",
								buttonImage: "/assets/calendar.gif",
								buttonText: 'Choose',
								buttonImageOnly: false,
								dateFormat: date_format,
											});
  $('#event_rep_end').datepicker({
								showOn: "both",
								buttonImage: "/assets/calendar.gif",
								buttonText: 'Choose',
								buttonImageOnly: false,
								dateFormat: date_format,
											});
  $('#rep_fields').show() if $('#event_repeat').is(':checked')
  $('#rep_fields').hide() if not $('#event_repeat').is(':checked')
  $('#event_repeat').change ->
     $('#rep_fields').show() if $('#event_repeat').is(':checked')
     $('#rep_fields').hide() if not $('#event_repeat').is(':checked')
											
  $('#search_event').click ->
		     window.location = searcheventURL
  $('#host_event').click ->
			 window.location = neweventURL




