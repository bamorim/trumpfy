import React from "react";
import Card from "./card.jsx";
import vp from "../viewport.js"
let { getData, viewport, sc } = vp;

function hand_count(hand){
  if(hand){
    return hand.card_count;
  }
  return 0;
}

class FoePlace extends React.Component {
  render(){
    let {x,y,width} = this.props;
    let style = {
      position: "absolute",
      top: `${y}px`,
      left: `${x}px`,
      width: `${width}px`
    }
    return <div style={style}>
      { (this.props.name && this.props.hand && this.props.hand.card_count > 0) ? [
          <image src="/images/Card_final_R.svg"/>,
          this.props.hand.card_count,
          this.props.name 
        ] : [
          <image src="/images/Inactive_Card_Back_R.svg"/>
        ]
      }
    </div>
  }
}

class Room extends React.Component {
  render(){
    let outerStyle = {
      position: "absolute",
      background: `url(/images/Pattern_R.svg) #EEE`,
      backgroundSize: `${sc(200)}px`,
      left: 0,
      top: 0,
      right: 0,
      bottom: 0
    };

    let x = viewport._x;
    let y = viewport._y;
    let boardStyle = {
      left: `${x}px`,
      top: `${y}px`,
      position: "absolute",
      width: `${sc(1024)}px`,
      height: `${sc(768)}px`
    }

    return <div style={outerStyle}>
      <div style={boardStyle}>
        {this.renderUserSpots()}
        {this.renderInner()}
      </div>
    </div>;
  }

  getFoes(){
    let { players, hands } = this.props.room;

    let id = this.props.room.your_id;
    let all = [0,1,2,3,4,5,6]
    let sliced = all.slice(0,id).concat(all.slice(id+1))

    return getData()
    .foe_places
    .map(({x,y}, i) => ({x,y, hand: hands[sliced[i]], name: players[sliced[i]]}))
  }

  renderUserSpots(){
    let width = getData().small_card_width;

    return this.getFoes()
    .map(({x,y, hand, name}) => <div>
      { <FoePlace name={name} hand={hand} width={width} x={x} y={y} />  }
    </div>)
  }

  renderInner(){
    let { room } = this.props;

    if(room.pending){
      return this.renderPending();
    }

    return this.renderPlaying();
  }

  renderPending(){
    return [
      <button onClick={this.props.onNewGame}>New Game</button>
    ];
  }

  renderPlaying(){
    let { players, your_turn, current_player, hands, curr, your_id } = this.props.room;

    let yourCard = hands[your_id].top_card;
    let onPlay = your_turn ? ((a) => this.props.onPlay(a)) : (()=>{})

    return [
      your_turn ? "Choose the card attribute" : `${current_player} is choosing`,
      <Card card={yourCard} onPlay={onPlay} width={sc(251)} height={sc(411)} x={sc(709)} y={sc(159)}/>
    ];
  }
}

export default Room;
