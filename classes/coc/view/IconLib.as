package coc.view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.events.Event;

public class IconLib {
	public static const INSTANCE:IconLib = new IconLib();
	
	function IconLib() {
	}
	
	// String -> Bitmap
	private const icons:Object = {};
	// String -> String
	private const aliases:Object = {};
	
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
		for each(item in xml.aliases.alias) {
			aliases[String(item.@alias)] = String(item.@icon);
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
				var iconId:String = prefix+xicon.text().toString();
				if (iconId) {
					icons[iconId] = new Bitmap(UIUtils.subsprite(bd, x, y, cellwidth, cellheight));
				}
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
		var i:int = 100; // circular dependency protection
		while (i-->0 && id in aliases && id != aliases[id]) id = aliases[id];
		return icons[id] || null;
	}
	public static function getBitmap(id:String):Bitmap {
		return INSTANCE.getBitmap(id);
	}
	public static function hasIcon(id:String):Boolean {
		return !!getBitmap(id);
	}
	/**
	 * Pick and return first icon id that exists
	 **/
	public static function pickIcon(...ids:/*String*/Array):String {
		for each(var id:String in ids) {
			if (hasIcon(id)) return id;
		}
		return null;
	}
	/**
	 * Pick and return first icon that exists
	 * @example
	 * IconLib.pickBitmap(item.id, "I_GenericWeapon", "I_GenericItem")
	 **/
	public static function pickBitmap(...ids:/*String*/Array):Bitmap {
		for each(var id:String in ids) {
			var bmp:Bitmap = getBitmap(id);
			if (bmp) return bmp;
		}
		return null;
	}
}
}
