if (socket instanceof WebSocket) { // close previous socket
  socket.close();
}

var socket = new WebSocket("ws://" + window.location.host + "/v1/chats/chat?roomname="+$("#container").data("imageId"));

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
  var p1 = [PSV.getPhi(), PSV.getTheta(), PSV.getZoomLevel()]
  var p2 = [$(this).data("phi"), $(this).data("theta"), $(this).data("zoomLevel")];
  anim(p1, p2);
});

var duration = 2000;

function anim(p1, p2, done){
  var start = null;
  function step(timestamp) {
    if (!start){
      start = timestamp;
    }
    var progress = timestamp - start;
    new_coord = calc_coord(p1, p2, progress);
    PSV.move(new_coord[0], new_coord[1]);
    PSV.zoom(new_coord[2]);
    if (progress < duration) {
      window.requestAnimationFrame(step);
    } else {
      if (done && typeof done === "function"){
        done();
      }
    }
  }

  window.requestAnimationFrame(step);
}

function calc_coord(p1, p2, progress){
  var result = [];
  var i;
  for (i=0; i<=2; i++) {
    result[i] = p1[i]+( (p2[i] - p1[i])*(progress/duration));
  }

  return result;
}


$('body').on('click', '#chatroom #play-btn', function(){

  var p1 = [PSV.getPhi(), PSV.getTheta(), PSV.getZoomLevel()]
  var p2;
  var messages = $("#messages blockquote");
  var size = $("#messages blockquote").size();
  var index = 0;

  recurse();

  function recurse(){
    if (index != 0){
      p1 = p2;
    }
    phi = $(messages[index]).data("phi");
    theta = $(messages[index]).data("theta");
    zoomLevel = $(messages[index]).data("zoomLevel");
    p2 = [phi, theta, zoomLevel];

    console.log(index);
    index++;
    if (size >= index){
      anim(p1, p2, recurse);
    }
  }

});


