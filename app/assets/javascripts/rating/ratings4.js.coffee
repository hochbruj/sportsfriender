jQuery ->
  text1 = $('#assessments').data('text1')
  text2 = $('#assessments').data('text2')
  text3 = $('#assessments').data('text3')
  $("#rating4").text(text2 + " " + 1 + " " + text3)
  $("#rating").text(text1 + " 1")
  $("#assess_text4").text($('#assessments').data('assessments')[0].cat4)
  $('#rating_cat4').change ->
     x = 1
     y = 1
     cat1 = parseInt($("#rating_cat1 option:selected").text()) || 0
     cat2 = parseInt($("#rating_cat2 option:selected").text()) || 0
     cat3 = parseInt($("#rating_cat3 option:selected").text()) || 0
     cat5 = parseInt($("#rating_cat5 option:selected").text()) || 0
     $("#rating_cat4 option:selected").each ->
        x = $(this).text() - 1
        y = $(this).text()
     $("#assess_text4").text($('#assessments').data('assessments')[x].cat4)
     $("#rating4").text(text2 + " " + y + " " + text3)
     $("#rating").text(text1 + " " + ((parseInt(y) + cat1 + cat2 + cat3 + cat5) / $('#assessments').data('count')).toFixed(1))
