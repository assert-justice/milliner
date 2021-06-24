class Store extends h2d.Object{
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
}