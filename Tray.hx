class Tray extends h2d.Object{
    public var width:Int;
    public var height:Int;
    var par:Milliner;
    override public function new(x:Int, y:Int, width:Int, height:Int, parent:Milliner) {
        par = parent;
        super(parent);
        setPosition(x,y);
        this.width = width;
        this.height = height;
        new h2d.Bitmap(h2d.Tile.fromColor(0x888888, width, height), this);
    }

    public function setOps(ops:Array<String>) {
        for (i in 0...ops.length) {
            var op = ops[i];
            var x = i % 2 * 120 + 10;
            var y = Math.floor(i / 2) * 50 + 10;
            var card = new Card(100, 40, op, ()->{
                if(par.held != null){
                    par.removeChild(par.held);
                }
                par.held = new Moveable(h2d.Tile.fromColor(0xFFFFFF, 100, 40), op, "op", par);
                par.heldOffset = new h2d.col.Point(par.mouseX - x - localToGlobal().x, par.mouseY - y - localToGlobal().y);
                par.updateHeldPosition();
            }, null, this);
            card.setPosition(x, y);
        }
    }

    public function setSymbols() {
        var alpha = "abcdefghijklmnopqrstuvwxyz";
        var gridWidth:Int = 5;
        var gridHeight:Int = 4;
        var pad:Int = 10;
        var cellWidth:Int = 40;
        for (i in 0...gridWidth * gridHeight){
            var char = alpha.charAt(i);
            var x:Int = i % gridWidth * (cellWidth + pad) + pad;
            var y:Int = Math.floor(i / gridWidth) * (cellWidth + pad) + pad;
            var card = new Card(cellWidth, cellWidth, char, ()->{
                if(par.held != null){
                    par.removeChild(par.held);
                }
                par.hold(new Moveable( h2d.Tile.fromColor(0xFFFFFF, cellWidth, cellWidth), char, "symbol", par));
                //par.held = new Moveable( h2d.Tile.fromColor(0xFFFFFF, cellWidth, cellWidth), char, "symbol", par);
                par.heldOffset = new h2d.col.Point(par.mouseX - x - localToGlobal().x, par.mouseY - y - localToGlobal().y);
                par.updateHeldPosition();
            }, null, this);
            card.setPosition(x, y);
        }
    }

    // public function setSymbols(symbols:Array<h2d.Tile>) {
    //     var tileScale = 0.75;
    //     var alpha = "abcdefghijklmnopqrstuvwxyz";
    //     for (i in 0...symbols.length) {
    //         if (i == 9) break;
    //         var symbol = symbols[i];
    //         var x = i % 3 * (symbol.width * tileScale + 4) + 10;
    //         var y = Math.floor(i / 3) * (symbol.height * tileScale + 4) + 10;
    //         var bmp = new h2d.Bitmap(symbol);
    //         bmp.setScale(tileScale);
    //         var card = new Card( Math.floor(symbol.width * tileScale), Math.floor(symbol.height * tileScale), alpha.charAt(i), () -> {
    //             if(par.held != null){
    //                 par.removeChild(par.held);
    //             }
    //             par.held = new Moveable(h2d.Tile.fromColor(0xFFFFFF, Math.floor(symbol.width * tileScale), Math.floor(symbol.height * tileScale)), alpha.charAt(i), par, "symbol");
    //             par.heldOffset = new h2d.col.Point(par.mouseX - x - localToGlobal().x, par.mouseY - y - localToGlobal().y);
    //         }, null, this);
    //         card.setPosition(x, y);
    //     }
    // }
}