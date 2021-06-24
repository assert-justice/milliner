class Main extends hxd.App {
    var scene:h2d.Scene;
    override function init() {
        scene = new Milliner();
        setScene(scene);
    }
    static function main() {
        hxd.Res.initEmbed();
        new Main();
    }
}