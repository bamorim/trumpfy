import React from "react";
import Card from "./card.jsx";
import PlayerTag from "./player_tag.jsx";
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

    let cardCount = (this.props.hand && this.props.hand.card_count) || 0;

    return <div style={style}>
      { (this.props.name) ? [
          ( cardCount > 0 ) ? <image src="/images/Card_final_R.svg"/> : <image src="/images/Inactive_Card_Back_R.svg"/>,
          <PlayerTag name={this.props.name} count={cardCount}/>
        ] : [
          <image src="/images/Inactive_Card_Back_R.svg"/>,
          <image src="/images/Inactive_Player_Tag_R.svg"/>
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
        {this.renderPlaying()}
        {this.props.room.pending ? this.renderPending() : ""}
      </div>
    </div>;
  }

  getFoes(){
    let { players, hands } = this.props.room;
    console.log(this.props);

    let id = this.props.room.your_id;
    let all = [0,1,2,3,4,5,6]
    let sliced = all.slice(0,id).concat(all.slice(id+1))

    return getData()
    .foe_places
    .map(({x,y}, i) => ({x,y, hand: hands && hands[sliced[i]], name: players[sliced[i]]}))
  }

  renderUserSpots(){
    let width = getData().small_card_width;

    return this.getFoes()
    .map(({x,y, hand, name}) => <div>
      { <FoePlace name={name} hand={hand} width={width} x={x} y={y} />  }
    </div>)
  }

  renderPending(){
    let style = {
      width: `${sc(150)}px`,
      left: `${sc(760)}px`,
      top: `${sc(670)}px`,
      position: 'absolute',

    }

    return <img src="/images/Start_btn_R.svg" style={style} onClick={this.props.onNewGame} className="new-game-btn"/>;
  }

  renderPlaying(){
    var { players, your_turn, current_player, hands, curr, your_id } = this.props.room;
    hands = hands || []

    let yourCard = hands[your_id] && hands[your_id].top_card;
    let onPlay = your_turn ? ((a) => this.props.onPlay(a)) : (()=>{})

    var myCard;
    if(yourCard){
      myCard = <Card card={yourCard} onPlay={onPlay} width={sc(251)}/>;
    } else {
      myCard = <img src="/images/Inactive_Card_Back_R.svg" width={`${sc(251)}px`}/>;
    }


    let myDiv = <div style={ { position: "absolute", top: `${sc(159)}px`, left: `${sc(709)}px` } }>
      { myCard }
      <PlayerTag name={players[your_id]} count={hand_count(hands[your_id])}/>
    </div>;

    return myDiv;
  }
}

export default Room;
