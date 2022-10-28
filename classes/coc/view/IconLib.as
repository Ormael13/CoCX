package coc.view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;
import flash.geom.Point;
import flash.geom.Rectangle;

public class IconLib {
	public static const INSTANCE:IconLib = new IconLib();
	
	function IconLib() {
	}
	
	// String -> Bitmap
	private const icons:Object = {};
	
	private function init(xml:XML):void {
		for each(var item:XML in xml.file) {
			var name:String = item.@name;
			// capture item
			(function (xfile:XML):void {
				CoCLoader.loadImage("res/"+name, function(success:Boolean, result:BitmapData, e:Event):void {
					loadFile(xfile, result);
				})
			})(item);
		}
	}
	private function loadFile(xfile:XML, bd:BitmapData):void {
		var cellwidth:int = xfile.@cellwidth;
		var cellheight:int = xfile.@cellheight;
		var prefix:String = xfile.@prefix || "";
		var y:int = 0;
		for each (var xrow:XML in xfile.row) {
			var x:int = 0;
			for each (var xicon:XML in xrow.icon) {
				var bmp:BitmapData = new BitmapData(cellwidth, cellheight, true, 0);
				bmp.copyPixels(bd, new Rectangle(x,y, cellwidth, cellheight), Point(new Point(0, 0)));
				icons[prefix+xicon.text().toString()] = new Bitmap(bmp);
				x += cellwidth;
			}
			y += cellheight;
		}
	}
	
	public function loadIcons():void {
		CoCLoader.loadText("res/icons.xml", function(success:Boolean, result:String, e:Event):void {
			if (!success) return;
			init(XML(result));
		});
	}
	
	/**
	 * @return null if no icon with such id
	 */
	public function getBitmap(id:String):Bitmap {
		return icons[id] || null;
	}
	public static function getBitmap(id:String):Bitmap {
		return INSTANCE.getBitmap(id);
	}
}
}
