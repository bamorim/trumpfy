class Viewport {
  constructor(Vw, Vh){
    let setup = () => {
      var Ww = window.innerWidth, Wh = window.innerHeight;

      console.log(Vw, Vh, Ww, Wh);
      if(Vh/Vw > Wh/Ww){
        // More more tall, fit by the height
        this._scale = Wh/Vh;
        this._x = (Ww-this._scale*Vw)/2;
        this._y = 0;
      } else {
        this._scale = Ww/Vw;
        this._x = 0;
        this._y = (Wh-this._scale*Vh)/2;
      }
    }

    setup();

    window.addEventListener("resize", setup);
  }

  scale(d){
    return d*this._scale;
  }

  translate({x,y}){
    var x = x*this._scale;
    var y = y*this._scale;
    return {x,y};
  }
}

var viewports = {};

function getViewport(Vw, Vh){
  var key = `${Vw}x${Vh}`;

  if(viewports[key]){
    return viewports[key]
  }

  var viewport = new Viewport(Vw, Vh);
  viewports[key] = viewport;
  return viewport;
}

let sc = (x) => (getViewport(1024,768).scale(x));

let getData = () => ({
  foe_places: [
    { x: sc(269), y: sc(26)  },
    { x: sc(269), y: sc(462) },
    { x: sc(521), y: sc(26)  },
    { x: sc(521), y: sc(462) },
    { x: sc(63),  y: sc(244) }
  ],
  small_card_width: sc(144),
  big_card_width: sc(251)
});

export default {
  getData,
  getViewport,
  sc,
  viewport: getViewport(1024, 768)
}
