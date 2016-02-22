import "phoenix_html";

//import socket from "./socket.js";
import Game from "./components/game.jsx";
import React from "react";

document.addEventListener("DOMContentLoaded", function(event) { 
  Array.prototype.slice.apply(document.querySelectorAll(".game-component")).forEach(function(gameDiv){
    var room_id = gameDiv.attributes["data-room-id"].value;
    React.render(<Game roomId={room_id}/>, gameDiv);
  });
});

window.goToRoom = function goToRoom(){
	var code = document.querySelector('.room-code').value;
	if(code && code.length > 0)
		window.location.pathname='/rooms/'+code;
}
