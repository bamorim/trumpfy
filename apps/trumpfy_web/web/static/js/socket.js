import {Socket} from "phoenix"

let socket = new Socket("/socket", {params: {
  userGuid: window.userGuid
}})

socket.connect();


export default socket;
