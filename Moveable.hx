import h2d.Bitmap;

class Moveable extends h2d.Bitmap{
    public var text:h2d.Text;
    public var type:String;
    override public function new(tile:h2d.Tile, title:String, type:String, parent:Milliner) {
        super(tile, parent);
        this.type = type;
        text = new h2d.Text(hxd.res.DefaultFont.get(), this);
        text.text = title;
        text.color = new h3d.Vector();
        text.setScale(2);
    }
}