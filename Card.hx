import h2d.Text;

class Card extends h2d.Interactive{
    var backboard:h2d.Bitmap;
    var text:h2d.Text;
    var graphic:h2d.Graphics;
    public var interact:Void->Void;
    override public function new(width:Int, height:Int, title:String, interact:Void->Void, bmp:h2d.Bitmap, parent:h2d.Object) {
        this.interact = interact;
        super(width, height, parent);
        var borderWidth = 4;
        backboard = new h2d.Bitmap(h2d.Tile.fromColor(0xFFFFFF, width, height), this);
        text = new h2d.Text(hxd.res.DefaultFont.get(), this);
        text.text = title;
        text.color = new h3d.Vector();
        text.setScale(2);
        text.x = borderWidth * 2;
        text.y = height / 2 - text.textHeight;
        if(bmp != null){
            addChild(bmp);
        }

        graphic = new h2d.Graphics(this);
        graphic.beginFill(0xFFFF00);
        
        graphic.drawRect(0, 0, borderWidth, height);
        graphic.drawRect(width - borderWidth, 0, borderWidth, height);
        graphic.drawRect(0, 0, width, borderWidth);
        graphic.drawRect(0, height - borderWidth, width, borderWidth);
        graphic.endFill();
        graphic.visible = false;
        this.onClick = (e:hxd.Event) -> {interact();}
        this.onOver = (e:hxd.Event) -> {graphic.visible = true; text.x += 4;}
        this.onOut = (e:hxd.Event) -> {graphic.visible = false; text.x -= 4;}
    }
}