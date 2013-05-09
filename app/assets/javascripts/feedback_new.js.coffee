jQuery ->
  users = $('#part').data('part')
  for i in ["1","2","3","4","5"]
    for u in users
      $("#w" + i + u.user_id).click ->
       $(this).children('input').prop("checked", true)
       $(this).parent("tr").children('td').removeClass("wselected").removeClass("bselected")
       $(this).addClass("wselected")
      $("#s" + i + u.user_id).click ->
       $(this).children('input').prop("checked", true)
       $(this).parent("tr").children('td').removeClass("wselected").removeClass("bselected")
       $(this).addClass("sselected")
      $("#b" + i + u.user_id).click ->
       $(this).children('input').prop("checked", true)
       $(this).parent("tr").children('td').removeClass("wselected").removeClass("sselected")
       $(this).addClass("bselected")
