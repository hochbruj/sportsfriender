# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
  $('#event_city').autocomplete
    source: $('#event_city').data('autocomplete-source')
    select: (event, ui) ->
	         $(this).val(ui.item.value).parents("form").submit()

  $('#event_date').datepicker({
								showOn: "both",
								buttonImage: "/assets/calendar.gif",
								buttonText: 'Choose',
								buttonImageOnly: false,
											});