jQuery ->
  users = $('#part').data('part')
  for u in users
    $("#w1"+ u.user_id).click ->
     $(this).children('input').prop("checked", true)
     $(this).parent("tr").children('td').removeClass("selected")
     $(this).addClass("selected")
    $("#s1" + u.user_id).click ->
     $(this).children('input').prop("checked", true)
     $(this).parent("tr").children('td').removeClass("selected")
     $(this).addClass("selected")
    $("#2" + u.user_id).click ->
     $(this).children('input').prop("checked", true)
     $(this).parent("tr").children('td').removeClass("selected")
     $(this).addClass("selected")
