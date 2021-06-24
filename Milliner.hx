import js.html.Screen;

class Milliner extends h2d.Scene{
    var backdropImage:h2d.Graphics;
    var backboard:h2d.Interactive;
    var tray:h2d.Interactive;
    var alchemyTiles:Array<h2d.Tile>;
    var guiTiles:Array<h2d.Tile>;
    var controls:Map<String,Control>;
    var script:Script;
    public var held:Moveable = null;
    public var heldOffset:h2d.col.Point;
    override public function new() {
        super();
        heldOffset = new h2d.col.Point();
        hxd.Window.getInstance().addEventTarget((e:hxd.Event) -> {
            if (e.kind == hxd.Event.EventKind.EPush && e.button == 1){
                if (held != null){
                    freeHeld();
                }
            }
            if (e.kind == hxd.Event.EventKind.EMove){
                if (held != null){
                    updateHeldPosition();
                }
            }
        });

        // backdropImage = new h2d.Graphics(this);
        // backboard = new h2d.Interactive(this.width, this.height, this);
        // backboard.onClick = function (event:hxd.Event) {
        //     trace("clicked backboard");
        // }
        // tray = new h2d.Interactive(200, 400, this);
        // tray.setPosition(this.width - tray.width, 0);
        // backdropImage.beginFill(0xFFFFFF);
        // backdropImage.drawRect(this.width - tray.width, 0, tray.width, tray.height);
        // backdropImage.endFill();
        // var tf = new h2d.Text(hxd.res.DefaultFont.get(), this);
        // tf.text = "♁";
        // tray.onClick = function (event:hxd.Event) {
        //     trace("clicked tray");
        // }
        getGuiTiles();
        placeControls();
        //getAlchemyTiles();
        //new Card(100, 40, "test", ()->{trace("test");}, this);
        var opsTray = new Tray(this.width - 300, 150, 300, 560, this);
        opsTray.setOps(["in","out","dupe","del","inc", "dec", "add","sub", "mul", "div", "mod", "noop", "jmp", "jez", "jlz", "jgz", "jnz", "iip", "load", "save", "label", "note"]);
        var symbolTray = new Tray(this.width - 300, Math.floor(opsTray.y + opsTray.height) + 10, 300, 300, this);
        symbolTray.setSymbols();
        script = new Script(300, this.height - 300, this);
        script.setPosition(this.width - 610, 150);
    }
    public function updateHeldPosition() {
        held.setPosition(mouseX - heldOffset.x, mouseY - heldOffset.y);
    }

    public function freeHeld() {
        removeChild(held);
        held = null;
    }

    public function hold(h:Moveable, xOff:Float = 0, yOff:Float = 0) {
        held = h;
        addChild(h);
        heldOffset = new h2d.col.Point(xOff, yOff);
        updateHeldPosition();
    }

    function placeControls() {
        controls= new Map<String,Control>();
        var inds = [2, 5, 8, 11, 14, 3, 0];
        var names = ["back", "pause", "start", "stop", "step", "slow", "fast"];
        for (i in 0...inds.length) {
            var ctrl = new Control(guiTiles[inds[i]], this);
            ctrl.setPosition(i * 31, 0);
            controls[names[i]] = ctrl;
            ctrl.clickFunk = () -> {trace(names[i]);};
        }
    }

    function getGuiTiles() {
        var symbols = hxd.Res.gui2.toTile();
        //var tg = new h2d.TileGroup(symbols, this);
        guiTiles = [];
        var w = 31.25;
        for (i in 0...8){
            for (f in 0...3){
                var tile = symbols.sub(i * w, f * w, w, w);
                guiTiles.push(tile);
                //tg.add(i * 40, f * 40, tile);
            }
        }
    }

    function getAlchemyTiles() {
        var symbols = hxd.Res.alchemy_symbols.toTile();
        alchemyTiles = [];
        var tw = 88;
        var th = 111;
        var vpad = 12;
        var toppad = 8;
        var botpad = 16;
        // tiles are 64 x 87 pixels
        for (i in 0...8){
            for (f in 0...16){
                if (i == 7 && f > 3) continue;
                var tile = symbols.sub(i * tw + vpad, f * th + toppad, tw - vpad * 2, th - botpad * 2);
                //var bmp = new h2d.Bitmap(tile, this);
                //bmp.setPosition(i * 90, f * 113);
                alchemyTiles.push(tile);
            }
        }
    }
}