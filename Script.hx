import h2d.col.Point;
import h2d.Interactive;

class Script extends h2d.Interactive{
    var mask:h2d.Mask;
    var listParent:h2d.Object;
    var list:Array<Card>;
    var par:Milliner;
    var blank:Int = 0;
    var sensitivity = 40;
    var maxVisible = 12;
    var buffer = false;
    override public function new(width:Int, height:Int, par:Milliner) {
        super(width, height, par);
        this.par = par;
        var graph = new h2d.Graphics(this);
        graph.beginFill(0x888888);
        graph.drawRect(0, 0, width, height);
        graph.endFill();
        mask = new h2d.Mask(width, height, this);
        listParent = new h2d.Object(mask);
        list = new Array<Card>();
        onMove = (e)->{update();}
        onClick = (e:hxd.Event)->{
            if (buffer){buffer = false; update(); return;}
            if (par.held == null){
                // handle picking up moveables
            }
            else{
                if (par.held.type == "op"){
                    addElement(par.held.text.text, par.held.type);
                    par.freeHeld();
                    update();
                }
            }
        }
        onWheel = (e:hxd.Event)->{
            var scroll = e.wheelDelta * -sensitivity;
            listParent.y += scroll;
            var minY = 0;
            if (list.length > maxVisible){
                minY = -(list.length - maxVisible) * 50;
            }
            if (listParent.y < minY){listParent.y = minY;}
            if (listParent.y > 0){listParent.y = 0;}
        }
        
    }
    function addElement(text:String, type:String) {
        var card = new Card(100, 40, par.held.text.text, ()->{
            var move = new Moveable(h2d.Tile.fromColor(0xFFFFFF, 100, 40), text, type, par);
            //par.hold(move, par.mouseX - x - localToGlobal().x, par.mouseY - y - localToGlobal().y);
            par.hold(move);
            removeElement();
            buffer = true;
        }, null, listParent);
        card.propagateEvents = true;
        list.insert(blank + 1, card);
        //list.push(card);
        blank = list.length;
    }

    function removeElement() {
        var elem = list[blank - 1];
        list.remove(elem);
        listParent.removeChild(elem);
    }
    function update() {
        var mousePos = globalToLocal(new h2d.col.Point(par.mouseX, par.mouseY));
        blank = Math.floor( (mousePos.y - 10 - listParent.y) / 50) - 1;
        if (par.held == null || par.held.type != "op" || !isOver()){blank = list.length;}
        //else{trace(blank);}
        for (i in 0...list.length) {
            var elem = list[i];
            var y = 50 * i + 10;
            if(i > blank){y += 50;}
            elem.setPosition(10, y);
        }
    }
}