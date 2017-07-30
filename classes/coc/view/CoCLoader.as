/**
 * Coded by aimozg on 23.07.2017.
 */
package coc.view {
import flash.display.Bitmap;
import flash.display.BitmapData;
import flash.display.Loader;
import flash.display.LoaderInfo;
import flash.events.ErrorEvent;
import flash.events.Event;
import flash.events.IOErrorEvent;
import flash.net.URLLoader;
import flash.net.URLRequest;
import flash.utils.setTimeout;

/**
 *
 */
public class CoCLoader {
	public function CoCLoader() {
	}
	// [path:String]=>String
	private static var TEXT_BUNDLE:Object  = {};
	[Embed(source="../../../res/model.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_RES_MODEL_XML:Class;
	TEXT_BUNDLE["res/model.xml"] = new BUNDLE_RES_MODEL_XML();

	// [path:String]=>BitmapData
	private static var IMAGE_BUNDLE:Object = {};
//	[Embed(source="../../../res/char1.png", mimeType="image/png")]
//	public static var BUNDLE_RES_CHAR1_PNG:Class;
//	IMAGE_BUNDLE["res/char1.png"] = ldbmp(BUNDLE_RES_CHAR1_PNG);
	[Embed(source="../../../res/charview/arms.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_ARMS_PNG:Class;
	IMAGE_BUNDLE["res/charview/arms.png"] = ldbmp(BUNDLE_RES_CHARVIEW_ARMS_PNG);
	[Embed(source="../../../res/charview/breasts.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_BREASTS_PNG:Class;
	IMAGE_BUNDLE["res/charview/breasts.png"] = ldbmp(BUNDLE_RES_CHARVIEW_BREASTS_PNG);
	[Embed(source="../../../res/charview/ears.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_EARS_PNG:Class;
	IMAGE_BUNDLE["res/charview/ears.png"] = ldbmp(BUNDLE_RES_CHARVIEW_EARS_PNG);
	[Embed(source="../../../res/charview/eyes.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_EYES_PNG:Class;
	IMAGE_BUNDLE["res/charview/eyes.png"] = ldbmp(BUNDLE_RES_CHARVIEW_EYES_PNG);
	[Embed(source="../../../res/charview/face.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_FACE_PNG:Class;
	IMAGE_BUNDLE["res/charview/face.png"] = ldbmp(BUNDLE_RES_CHARVIEW_FACE_PNG);
	[Embed(source="../../../res/charview/hair.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_HAIR_PNG:Class;
	IMAGE_BUNDLE["res/charview/hair.png"] = ldbmp(BUNDLE_RES_CHARVIEW_HAIR_PNG);
	[Embed(source="../../../res/charview/horns.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_HORNS_PNG:Class;
	IMAGE_BUNDLE["res/charview/horns.png"] = ldbmp(BUNDLE_RES_CHARVIEW_HORNS_PNG);
	[Embed(source="../../../res/charview/legs.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_LEGS_PNG:Class;
	IMAGE_BUNDLE["res/charview/legs.png"] = ldbmp(BUNDLE_RES_CHARVIEW_LEGS_PNG);
	[Embed(source="../../../res/charview/tail.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_TAIL_PNG:Class;
	IMAGE_BUNDLE["res/charview/tail.png"] = ldbmp(BUNDLE_RES_CHARVIEW_TAIL_PNG);
	[Embed(source="../../../res/charview/torso.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_TORSO_PNG:Class;
	IMAGE_BUNDLE["res/charview/torso.png"] = ldbmp(BUNDLE_RES_CHARVIEW_TORSO_PNG);
	[Embed(source="../../../res/charview/wings.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_WINGS_PNG:Class;
	IMAGE_BUNDLE["res/charview/wings.png"] = ldbmp(BUNDLE_RES_CHARVIEW_WINGS_PNG);

	private static function ldbmp(c:Class):BitmapData {
		return c ? ((new c() as Bitmap).bitmapData) : null;
	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:*):*
	 * where result is String or Error
	 * @param location "external", "internal"
	 */
	public static function loadText(path:String, callback:Function, location:String = "external"):void {
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				if (path in TEXT_BUNDLE) {
					setTimeout(callback, 0, true, TEXT_BUNDLE[path], new Event("complete"));
				} else {
					setTimeout(callback, 0, false, new ErrorEvent("error", false, false,
							"Internal resource " + path + "not found"));
				}
				break;
			case "external":
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function (e:Event):void {
					TEXT_BUNDLE[path] = loader.data;
					callback(true, loader.data, e);
				});
				var req:URLRequest = new URLRequest(path);
				loader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					if (path in TEXT_BUNDLE) {
						e.preventDefault();
						callback(true, TEXT_BUNDLE[path], new Event("complete"));
					} else {
						callback(false, null, e);
					}
				});
				loader.load(req);
				break;
			default:
				throw new Error("Incorrect location " + location);
		}

	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:BitmapData, e:Event):*
	 * @param location "external", "internal"
	 */
	public static function loadImage(path:String, callback:Function, location:String = "external"):void {
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				if (path in IMAGE_BUNDLE) {
					setTimeout(callback, 0, true, IMAGE_BUNDLE[path], new Event("complete"));
				} else {
					setTimeout(callback, 0, false, new ErrorEvent("error", false, false,
							"Internal resource " + path + "not found"));
				}
				break;
			case "external":

				var loader:Loader = new Loader();
				var cli:LoaderInfo = loader.contentLoaderInfo;
				cli.addEventListener(Event.COMPLETE, function (e:Event):void {
					var bmp:Bitmap = cli.content as Bitmap;
					if (bmp) {
						IMAGE_BUNDLE[path] = bmp.bitmapData;
						callback(true, bmp.bitmapData, e);
					} else {
						callback(false, null, e);
					}
				});
				cli.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					if (path in IMAGE_BUNDLE) {
						callback(true, IMAGE_BUNDLE[path], new Event("complete"));
					} else {
						callback(false, null, e);
					}
				});
				loader.load(new URLRequest(path));
				break;
			default:
				throw new Error("Incorrect location " + location);
		}

	}
}
}
