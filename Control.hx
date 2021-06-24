class Control extends h2d.Interactive{
    var status = 0;
    var bmps:Array<h2d.Bitmap>;
    public var clickFunk:(Void -> Void);
    override public function new(tile:h2d.Tile, parent:h2d.Object) {
        super(32, 32, parent);
        var colors = [0xFF8800, 0xFFFF00, 0x888888];
        bmps = colors.map(color -> new h2d.Bitmap(h2d.Tile.fromColor(color, 31, 31), this));
        new h2d.Bitmap(tile, this);
        setStatus(0);
        onOver = function (event:hxd.Event) {
            if (status != 2){
                setStatus(1);
            }
        }
        onOut = function (event:hxd.Event) {
            if (status != 2){
                setStatus(0);
            }
        }
        this.onClick = function (event:hxd.Event) {
            if (status != 2){
                setStatus(2);
                clickFunk();
            }
            else{setStatus(1);}
        }
    }
    public function setStatus(status) {
        this.status = status;
        for (bmp in bmps) {
            bmp.visible = false;
        }
        bmps[status].visible = true;
    }
}