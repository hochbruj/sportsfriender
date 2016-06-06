jQuery ->
  $('#rep_fields').show() if $('#event_repeat').is(':checked')
  $('#rep_fields').hide() if not $('#event_repeat').is(':checked')
  $('#event_repeat').change ->
     $('#rep_fields').show() if $('#event_repeat').is(':checked')
     $('#rep_fields').hide() if not $('#event_repeat').is(':checked')

  $('#group_name').show() if $('#new_group').is(':checked')
  $('#group_name').hide() if not $('#event_new_group').is(':checked')
  $('#new_group').change ->
	  $('#group_name').show() if $('#new_group').is(':checked')
	  $('#group_name').hide() if not $('#new_group').is(':checked')
