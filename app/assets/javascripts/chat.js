var socket = new WebSocket("ws://" + window.location.host + "/v1/chats/chat?roomname="+$("#container").data("imageId")); //change hello later

socket.onmessage = function(event) {
  if (event.data.length) {
    addNewMessage(JSON.parse(event.data));
  }
};


$("#chatroom textarea").keyup(function (e) {
  if (e.keyCode == 13) {
    var text = $(this).val().trim();

    if (text != ""){
      socket.send(JSON.stringify({
        phi: PSV.getPhi(),
        theta: PSV.getTheta(),
        zoomLevel: PSV.getZoomLevel(),
        body: text,
        sender: $("nav").data("currAccountName")
      }));
    }

    $(this).val("");
  }
});


function addNewMessage(data) {
  var block = document.createElement('blockquote');
  var p = document.createElement('p');
  var footer = document.createElement('footer');
  $(p).html(data.body);
  $(footer).html(data.sender);
  $(block).append(p);
  $(block).append(footer);
  $(block).data( "phi", data.phi );
  $(block).data( "theta", data.theta );
  $(block).data( "zoomLevel", data.zoomLevel );
  $("#messages").prepend(block);
}

$('body').on('click', '#messages blockquote', function(){
  PSV.move($(this).data("phi"), $(this).data("theta"));
  PSV.zoom($(this).data("zoomLevel"));
});

