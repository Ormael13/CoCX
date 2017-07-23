/**
 * Coded by aimozg on 23.07.2017.
 */
package coc.view {
import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Loader;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLLoaderDataFormat;
import flash.net.URLRequest;
import flash.utils.setTimeout;

/**
 *
 */
public class CoCLoader {
	public function CoCLoader() {
	}

	[Embed(source="../../../res/model.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_RES_MODEL_XML:Class;
	[Embed(source="../../../res/char1.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHAR1_PNG:Class;

	// [path:String]=>String
	private static var TEXT_BUNDLE:Object  = {
		"res/model.xml": new BUNDLE_RES_MODEL_XML()
	};
	// [path:String]=>BitmapData
	private static var IMAGE_BUNDLE:Object = {
		"res/char1.png": ((new BUNDLE_RES_CHAR1_PNG() as Bitmap).bitmapData)
	};
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:*):*
	 * where result is String or Error
	 * @param location "external", "internal", "any"
	 */
	public static function loadText(path:String, callback:Function, location:String = "any"):void {
		if (path.indexOf("./") == 0) path = path.slice(2);
		if (location == "any" || location == "internal") {
			if (path in TEXT_BUNDLE) {
				setTimeout(callback, 0, true, TEXT_BUNDLE[path], new Event("complete"));
				return;
			}
		}
		if (location == "any" || location == "external") {
			var loader:URLLoader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, function (e:Event):void {
				TEXT_BUNDLE[path] = loader.data;
				callback(true, loader.data, e);
			});
			var req:URLRequest = new URLRequest(path);
			loader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
				callback(false, null, e);
			});
			loader.load(req);
			return;
		}
		setTimeout(callback, 0, false, new ErrorEvent("error", false, false,
				"Internal resource " + path + "not found"));
	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:BitmapData, e:Event):*
	 * @param location "external", "internal", "any"
	 */
	public static function loadImage(path:String, callback:Function, location:String = "any"):void {
		if (path.indexOf("./") == 0) path = path.slice(2);
		if (location == "any" || location == "internal") {
			if (path in IMAGE_BUNDLE) {
				setTimeout(callback, 0, true, IMAGE_BUNDLE[path], new Event("complete"));
				return;
			}
		}
		if (location == "any" || location == "external") {
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, function (e:Event):void {
				var bmp:Bitmap = loader.contentLoaderInfo.content as Bitmap;
				if (bmp) {
					IMAGE_BUNDLE[path] = bmp.bitmapData;
					callback(true, bmp.bitmapData, e);
				} else {
					callback(false, null, e);
				}
			});
			var req:URLRequest = new URLRequest(path);
			loader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
				callback(false, null, e);
			});
			loader.load(req);
			return;
		}
		setTimeout(callback, 0, false, new ErrorEvent("error", false, false,
				"Internal resource " + path + "not found"));
	}
}
}
