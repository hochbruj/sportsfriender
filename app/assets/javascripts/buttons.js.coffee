jQuery ->
  $('#facebook').click ->
   window.location = facebookURL
  $('#facebook_signup').click ->
   window.location = facebookURL
  $('#my_sports').click ->
   window.location = mysportsURL
  $('#my_progress').click ->
   window.location = myprogressURL
  $('#my_events').click ->
   window.location = myeventsURL
  $('#dashboard').click ->
   window.location = dashboardURL
  $('#my_sportsfriends').click ->
   window.location = mysportsfriendsURL
  $('#search_event').click ->
   window.location = searcheventURL
  $('#host_event').click ->
   window.location = neweventURL
  $('#sports').click ->
   window.location = sportsURL

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

