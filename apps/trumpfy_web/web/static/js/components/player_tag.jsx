import React from "react";

class PlayerTag extends React.Component {
  render(){
    return <svg version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
      viewBox="0 0 166.3 43.8" enable-background="new 0 0 166.3 43.8" xmlSpace="preserve">
      <g id="Active_x5F_Player">
        <g>
          <polygon style={ { fill: "#591815" } } points="149,38.9 18.9,38.9 18.9,16.7 166.3,16.7 		"/>
          <polygon style={ { fill: "#D82C1A" } } points="148,33 18.9,33 18.9,10.7 166.3,10.7 		"/>
        </g>
        <text transform="matrix(1 0 0 1 50.8169 26.8015)">{ this.props.name }</text>
        <g id="Logo_Frame_1_">
          <path style={ { fill: "#1A1A1A" } } d="M21.9,43.3c-11.8,0-21.4-9.6-21.4-21.4S10.1,0.5,21.9,0.5s21.4,9.6,21.4,21.4S33.7,43.3,21.9,43.3z
            "/>
          <path style={ { fill: "#1B1464" } } d="M21.9,1c11.5,0,20.9,9.4,20.9,20.9s-9.4,20.9-20.9,20.9S1,33.4,1,21.9S10.4,1,21.9,1 M21.9,0
            C9.8,0,0,9.8,0,21.9s9.8,21.9,21.9,21.9S43.8,34,43.8,21.9S34,0,21.9,0L21.9,0z"/>
        </g>
        <radialGradient id="Logo_Place_3_" cx="20.4069" cy="17.9511" r="18.4871" gradientUnits="userSpaceOnUse">
          <stop  offset="1.477833e-002" style={ { stopColor: "#FFFFFF"} }/>
          <stop  offset="0.4187" style={ { stopColor: "#FBB03B"} }/>
          <stop  offset="0.5412" style={ { stopColor: "#FBAC3A" } }/>
          <stop  offset="0.6681" style={ { stopColor: "#F99F37" } }/>
          <stop  offset="0.797" style={ { stopColor: "#F78B31" } }/>
          <stop  offset="0.9265" style={ { stopColor: "#F36E29" } }/>
          <stop  offset="1" style={ { stopColor: "#F15A24" } }/>
        </radialGradient>
        <circle id="Logo_Place_1_" style={ { fill: "url(#Logo_Place_3_)" } } cx="21.9" cy="21.9" r="18.5"/>
        <text transform="matrix(1 0 0 1 20 29)" style={ {fontFamily: 'MyriadPro-Regular', fontSize: "22.7217px", textAnchor: "middle"} }>{ this.props.count }</text>
      </g>
    </svg>
  }
}

export default PlayerTag;
