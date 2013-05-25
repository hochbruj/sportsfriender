# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

jQuery ->
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



