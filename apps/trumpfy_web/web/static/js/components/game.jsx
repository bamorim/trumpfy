import React from "react";
import socket from "../socket";
import Room from "./room.jsx";


class Game extends React.Component {
  state = {
  };

  ready(){
    return !!this.state.room;
  }

  render(){
    return (
      <div>
        <h1>{ this.props.roomId }</h1>
        { this.ready() ? this.renderRoom() : this.renderConnecting() }
      </div>
    );
  }

  renderRoom(){
    let { channel } = this.state;
    let newGameEvent = () => {
      channel.push('action:new_game', { room_id: this.props.roomId });
    }
    let playEvent = (attribute) => {
      console.log("Sending ", attribute);
      channel.push('action:play', { room_id: this.props.roomId, attribute })
    }
    return <Room room={this.state.room} onNewGame={newGameEvent} onPlay={playEvent}/>;
  }

  connect(name){
    let channel = socket.channel(`rooms:${this.props.roomId}`, { name })
    channel.join()
      .receive("ok", resp => {
        this.setState({ connecting: false, waiting_state: true });
        this.setupChannel(channel, name);
      })
      .receive("error", resp => { this.setState({connecting: false}) })
  }

  setupChannel(channel, name){
    this.setState({channel});
    channel.push('setup', { name, room_id: this.props.roomId });
    channel.on('update:state', (room) => {
      this.setState({room, waiting_state: false});
    });
  }

  renderConnecting(){
    if(this.state.connecting) return <div>connecting...</div>;
    if(this.state.waiting_state) return <div>waiting state...</div>;

    return <div>
      <form onSubmit={(e) => {
        e.preventDefault();
        this.connect(this.nameInput.value);
      }}>
        <input type="text" ref={(c) => this.nameInput = c} placeholder="name"></input>
        <button>Entrar</button>
      </form>
    </div>;
  }
}

export default Game;
