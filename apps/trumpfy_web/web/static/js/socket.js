import {Socket} from "deps/phoenix/web/static/js/phoenix"

let socket = new Socket("/socket", {params: {
  userGuid: window.userGuid
}})

socket.connect();

/*
let channel = socket.channel("rooms:1234", {})
channel.join()
  .receive("ok", resp => { console.log("Joined successfully", resp) })
  .receive("error", resp => { console.log("Unable to join", resp) })
*/

window.socket = socket
//window.channel = channel

export default socket
