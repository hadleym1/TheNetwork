$(function () {  
   setTimeout(checkForEvents, 10000);  
}); 

function checkForEvents()
{
    $.getScript('/active_user/home');  
    setTimeout(checkForEvents, 10000);
}

function chatWithLocalUser(user)
{
   window.open('/chat/index?remote=false&user=' + user, "Chat", "top=200, left=200, width=450, height=400");
}

function clearEvents()
{
  var doc = document.getElementById("event_notice");
  doc.innerHTML = "";
}


