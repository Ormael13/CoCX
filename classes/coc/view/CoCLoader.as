/**
 * Coded by aimozg on 23.07.2017.
 */
package coc.view {
import classes.internals.LoggerFactory;

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

import mx.logging.ILogger;

/**
 *
 */
public class CoCLoader {
	private static const LOGGER:ILogger = LoggerFactory.getLogger(CoCLoader);
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
	[Embed(source="../../../res/charview/alraune.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_ALRAUNE_PNG:Class;
	IMAGE_BUNDLE["res/charview/alraune.png"] = ldbmp(BUNDLE_RES_CHARVIEW_ALRAUNE_PNG);
	[Embed(source="../../../res/charview/basic.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_BASIC_PNG:Class;
	IMAGE_BUNDLE["res/charview/basic.png"] = ldbmp(BUNDLE_RES_CHARVIEW_BASIC_PNG);
	[Embed(source="../../../res/charview/beasts.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_BEASTS_PNG:Class;
	IMAGE_BUNDLE["res/charview/beasts.png"] = ldbmp(BUNDLE_RES_CHARVIEW_BEASTS_PNG);
	[Embed(source="../../../res/charview/chitin.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_CHITIN_PNG:Class;
	IMAGE_BUNDLE["res/charview/chitin.png"] = ldbmp(BUNDLE_RES_CHARVIEW_CHITIN_PNG);
	[Embed(source="../../../res/charview/hinezumi.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_HINEZUMI_PNG:Class;
	IMAGE_BUNDLE["res/charview/hinezumi.png"] = ldbmp(BUNDLE_RES_CHARVIEW_HINEZUMI_PNG);
	[Embed(source="../../../res/charview/manticore.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_MANTICORE_PNG:Class;
	IMAGE_BUNDLE["res/charview/manticore.png"] = ldbmp(BUNDLE_RES_CHARVIEW_MANTICORE_PNG);
	[Embed(source="../../../res/charview/orca.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_ORCA_PNG:Class;
	IMAGE_BUNDLE["res/charview/orca.png"] = ldbmp(BUNDLE_RES_CHARVIEW_ORCA_PNG);
	[Embed(source="../../../res/charview/scales.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_SCALES_PNG:Class;
	IMAGE_BUNDLE["res/charview/scales.png"] = ldbmp(BUNDLE_RES_CHARVIEW_SCALES_PNG);

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
		function orLocal(e:Event):void {
			if (path in TEXT_BUNDLE) {
				setTimeout(callback, 0,true, TEXT_BUNDLE[path], new Event("complete"));
			} else {
				setTimeout(callback, 0,false, null, e);
			}
		}
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				orLocal(new ErrorEvent("error", false, false,
						"Internal resource " + path + "not found"));
				break;
			case "external":
				var loader:URLLoader = new URLLoader();
				loader.addEventListener(Event.COMPLETE, function (e:Event):void {
					try {
						LOGGER.info("Loaded external "+path);
						TEXT_BUNDLE[path] = loader.data;
						callback(true, loader.data, e);
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
					}
				});
				var req:URLRequest = new URLRequest(path);
				loader.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					LOGGER.warn(e.type+" loading external "+path+": "+e.toString());
					orLocal(e);
				});
				try {
					loader.load(req);
				} catch (e:Error) {
					LOGGER.warn(e.name+" loading external "+path+": "+e.message);
					orLocal(new ErrorEvent("error",false,false,e.message));
				}
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
		function orLocal(e:Event):void {
			if (path in IMAGE_BUNDLE) {
				setTimeout(callback, 0,true, IMAGE_BUNDLE[path], new Event("complete"));
			} else {
				setTimeout(callback, 0,false, null, e);
			}
		}
		if (path.indexOf("./") == 0) path = path.slice(2);
		switch (location) {
			case "internal":
				orLocal(new ErrorEvent("error", false, false,
						"Internal resource " + path + "not found"));
				break;
			case "external":
				var loader:Loader = new Loader();
				var cli:LoaderInfo = loader.contentLoaderInfo;
				cli.addEventListener(Event.COMPLETE, function (e:Event):void {
					try {
						var bmp:Bitmap = cli.content as Bitmap;
						if (bmp) {
							LOGGER.info("Loaded external "+path);
							IMAGE_BUNDLE[path] = bmp.bitmapData;
							callback(true, bmp.bitmapData, e);
						} else {
							LOGGER.warn("Not found external "+path);
							callback(false, null, e);
						}
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
					}
				});
				cli.addEventListener(IOErrorEvent.IO_ERROR, function (e:IOErrorEvent):void {
					LOGGER.warn(e.type+" loading external "+path+": "+e.toString());
					orLocal(e);
				});
				try {
					loader.load(new URLRequest(path));
				} catch (e:Error) {
					LOGGER.warn(e.name+" loading external "+path+": "+e.message);
					orLocal(new ErrorEvent("error",false,false,e.message));
				}
				break;
			default:
				throw new Error("Incorrect location " + location);
		}

	}
}
}
