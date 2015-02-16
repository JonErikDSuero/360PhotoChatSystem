var socket = new WebSocket("ws://" + window.location.host + "/v1/chats/chat?roomname=hello"); //change hello later

socket.onmessage = function(event) {
  if (event.data.length) {
    return $("#output").append(event.data + "<br>");
  }
};

$('body').on('submit', 'form.chat', function(event) {
  var $input;
  event.preventDefault();
  $input = $(this).find("input");
  socket.send($input.val());
  return $input.val(null);
});

