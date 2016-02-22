import React from "react";

class Card extends React.Component {
  render() {
    var {width, x, y} = this.props;
    var height = width*411/251;

    let { card } = this.props;
    let imgStyle = {
      width: (width*211/251),
      height: (height*166/411),
      left: "8%",
      position: "absolute",
      background: `url(${card.image_url}) no-repeat transparent`,
      backgroundSize: "cover",
      top: "16.5%"
    };

    return (
      <div style={ { position: "relative", height, width, left: x, top: y } }>
        <div style={ imgStyle }/>
        <svg style={ { position: "absolute" } } version="1.1" id="Layer_1" xmlns="http://www.w3.org/2000/svg" xmlnsXlink="http://www.w3.org/1999/xlink" x="0px" y="0px"
          viewBox="0 0 251 411" enableBackground="new 0 0 251 411" xmlSpace="preserve">
          <filter  id="InnerShadow">
            <feOffset  dx="2" dy="3"></feOffset>
            <feGaussianBlur  result="offsetBlur" stdDeviation="10"></feGaussianBlur>
            <feComposite  in="SourceGraphic" in2="offsetBlur" operator="out" result="inverse"></feComposite>
            <feFlood  floodColor="black" floodOpacity="0.90" result="color"></feFlood>
            <feComposite  in="color" in2="inverse" operator="in" result="shadow"></feComposite>
            <feComposite  in="shadow" in2="SourceGraphic" operator="over"></feComposite>
          </filter>
          <g id="Try_01_-_Color_1_">
            <g id="Card_Body_4_">
              <path fill="#89590C" d="M230.9,0H20.1C9,0,0,9,0,20.1v370.8C0,402,9,411,20.1,411h210.8c11.1,0,20.1-9,20.1-20.1V20.1
                C251,9,242,0,230.9,0z M230,219c0,8.3-6.7,15-15,15H36c-8.3,0-15-6.7-15-15V84c0-8.3,6.7-15,15-15h179c8.3,0,15,6.7,15,15V219z"/>
              <path fill="#BC9D19" filter="url(#InnerShadow)" d="M230.5,5.5h-210c-8.3,0-15,6.7-15,15v370c0,8.3,6.7,15,15,15h210
                c8.3,0,15-6.7,15-15v-370C245.5,12.2,238.8,5.5,230.5,5.5z M230.2,218.6c0,8.3-6.7,15-15,15H35.8c-8.3,0-15-6.7-15-15V83.7
                c0-8.3,6.7-15,15-15h179.3c8.3,0,15,6.7,15,15V218.6z"/>
              <path id="IMG_Frame_6_" fill="none" stroke="#89590C" strokeWidth="2" strokeMiterlimit="10" d="M215.2,233.6H35.8
                c-8.3,0-15-6.7-15-15V83.7c0-8.3,6.7-15,15-15h179.3c8.3,0,15,6.7,15,15v134.8C230.2,226.9,223.4,233.6,215.2,233.6z"/>
              <path id="Inner_Frame_13_" fill="none" stroke="#CCCCCC" strokeWidth="6" strokeMiterlimit="10" d="M230.5,405.5h-210
                c-8.3,0-15-6.7-15-15v-370c0-8.3,6.7-15,15-15h210c8.3,0,15,6.7,15,15v370C245.5,398.8,238.8,405.5,230.5,405.5z"/>
            </g>
            <g id="Features_Group_9_">
              <g id="Feature_01_9_" onClick={() => this.props.onPlay(1)}>
                <path fill="#F2F2F2" d="M221.9,267.4H29.1c-4.6,0-8.4-3.8-8.4-8.4V252c0-4.6,3.8-8.4,8.4-8.4h192.8c4.6,0,8.4,3.8,8.4,8.4v7.1
                  C230.3,263.7,226.6,267.4,221.9,267.4z"/>
                <text transform="matrix(1 0 0 1 29.2233 259.867)" fill="#333333" fontFamily="'MyriadPro-Regular'" fontSize="12px">{ window.deck.attribute_name1 }</text>
                <text transform="matrix(1 0 0 1 198.8322 259.867)" fontFamily="'MyriadPro-Regular'" fontSize="12px">{card.attribute1}</text>
              </g>
              <g id="Feature_02_4_" onClick={() => this.props.onPlay(2)}>
                <path fill="#F2F2F2" d="M221.9,305.8H29.1c-4.6,0-8.4-3.8-8.4-8.4v-7.1c0-4.6,3.8-8.4,8.4-8.4h192.8c4.6,0,8.4,3.8,8.4,8.4v7.1
                  C230.3,302,226.6,305.8,221.9,305.8z"/>
                <text transform="matrix(1 0 0 1 29.2233 298.2049)" fill="#333333" fontFamily="'MyriadPro-Regular'" fontSize="12px">{ window.deck.attribute_name2 }</text>
                <text transform="matrix(1 0 0 1 198.8322 298.2049)" fontFamily="'MyriadPro-Regular'" fontSize="12px">{card.attribute2}</text>
              </g>
              <g id="Feature_03_4_" onClick={() => this.props.onPlay(3)}>
                <path fill="#F2F2F2" d="M221.9,344.2H29.1c-4.6,0-8.4-3.8-8.4-8.4v-7.1c0-4.6,3.8-8.4,8.4-8.4h192.8c4.6,0,8.4,3.8,8.4,8.4v7.1
                  C230.3,340.4,226.6,344.2,221.9,344.2z"/>
                <text transform="matrix(1 0 0 1 29.2233 336.5428)" fill="#333333" fontFamily="'MyriadPro-Regular'" fontSize="12px">{ window.deck.attribute_name3 }</text>
                <text transform="matrix(1 0 0 1 198.8322 336.5428)" fontFamily="'MyriadPro-Regular'" fontSize="12px">{card.attribute3}</text>
              </g>
              <g id="Feature_04" onClick={() => this.props.onPlay(4)}>
                <path fill="#F2F2F2" d="M221.9,382.5H29.1c-4.6,0-8.4-3.8-8.4-8.4V367c0-4.6,3.8-8.4,8.4-8.4h192.8c4.6,0,8.4,3.8,8.4,8.4v7.1
                  C230.3,378.7,226.6,382.5,221.9,382.5z"/>
                <text transform="matrix(1 0 0 1 29.2233 373.867)" fill="#333333" fontFamily="'MyriadPro-Regular'" fontSize="12px">{ window.deck.attribute_name4 }</text>
                <text transform="matrix(1 0 0 1 198.8322 373.867)" fontFamily="'MyriadPro-Regular'" fontSize="12px">{card.attribute4}</text>
              </g>
            </g>
            <g id="Title_Group_5_">
              <path id="Title_Rectangle_4_" fill="#F2F2F2" d="M225.3,57.4H25.7c-4.1,0-7.4-3-7.4-6.6V29.3c0-3.7,3.3-6.6,7.4-6.6h199.6
                c4.1,0,7.4,3,7.4,6.6v21.5C232.7,54.4,229.4,57.4,225.3,57.4z"/>
            </g>
            <text transform="matrix(1 0 0 1 60 48)" fontAnchor="middle" fontFamily="'MyriadPro-Regular'" fontSize="20px">{card.name}</text>
          </g>
        </svg>
      </div>
    )
      }
      }

      export default Card;
