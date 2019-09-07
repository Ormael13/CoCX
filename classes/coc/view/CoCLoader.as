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
	bundleText("res/model.xml", BUNDLE_RES_MODEL_XML);

	[Embed(source="../../../content/coc.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_XML:Class;
	bundleText("content/coc.xml", BUNDLE_CONTENT_COC_XML);
	
	[Embed(source="../../../content/coc/appearance.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_APPEARANCE_XML:Class;
	bundleText("content/coc/appearance.xml", BUNDLE_CONTENT_COC_APPEARANCE_XML);

	[Embed(source="../../../content/coc/desert.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_DESERT_XML:Class;
	bundleText("content/coc/desert.xml", BUNDLE_CONTENT_COC_DESERT_XML);

	[Embed(source="../../../content/coc/forest.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_FOREST_XML:Class;
	bundleText("content/coc/forest.xml", BUNDLE_CONTENT_COC_FOREST_XML);
	
	[Embed(source="../../../content/coc/monsters/goblin.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_MONSTERS_GOBLIN_XML:Class;
	bundleText("content/coc/monsters/goblin.xml", BUNDLE_CONTENT_COC_MONSTERS_GOBLIN_XML);
	
	[Embed(source="../../../content/coc/NPC/celess.xml", mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_NPC_CELESS_XML:Class;
	bundleText("content/coc/NPC/celess.xml", BUNDLE_CONTENT_COC_NPC_CELESS_XML);

	[Embed(source="../../../content/coc/NPC/diva.xml",mimeType="application/octet-stream")]
	public static var BUNDLE_CONTENT_COC_NPC_DIVA_XML:Class;
	bundleText("content/coc/NPC/diva.xml",BUNDLE_CONTENT_COC_NPC_DIVA_XML);

    [Embed(source="../../../content/coc/NPC/teladreshops.xml", mimeType="application/octet-stream")]
    public static var BUNDLE_CONTENT_COC_NPC_TELADRESHOPS_XML:Class;
    bundleText("content/coc/NPC/teladreshops.xml", BUNDLE_CONTENT_COC_NPC_TELADRESHOPS_XML);
	
	public static function bundleText(key:String,c:Class):void {
		if (c) TEXT_BUNDLE[key] = new c();
	}

	// [path:String]=>BitmapData
	private static var IMAGE_BUNDLE:Object = {};
//
// [Embed(source="../../../res/char1.png", mimeType="image/png")]
//	public static var BUNDLE_RES_CHAR1_PNG:Class;
//	ldbmp("res/char1.png",BUNDLE_RES_CHAR1_PNG);

	[Embed(source="../../../res/charview/body.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_BODY_PNG:Class;
	bundleImage("res/charview/body.png", BUNDLE_RES_CHARVIEW_BODY_PNG);

	[Embed(source="../../../res/charview/extra.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_EXTRA_PNG:Class;
	bundleImage("res/charview/extra.png", BUNDLE_RES_CHARVIEW_EXTRA_PNG);

	[Embed(source="../../../res/charview/hair.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_HAIR_PNG:Class;
	bundleImage("res/charview/hair.png", BUNDLE_RES_CHARVIEW_HAIR_PNG);

	[Embed(source="../../../res/charview/head.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_HEAD_PNG:Class;
	bundleImage("res/charview/head.png", BUNDLE_RES_CHARVIEW_HEAD_PNG);
	
	[Embed(source="../../../res/charview/lewd.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_LEWD_PNG:Class;
	bundleImage("res/charview/lewd.png", BUNDLE_RES_CHARVIEW_LEWD_PNG);
	
	[Embed(source="../../../res/charview/tails.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_TAILS_PNG:Class;
	bundleImage("res/charview/tails.png", BUNDLE_RES_CHARVIEW_TAILS_PNG);
	
	[Embed(source="../../../res/charview/wings.png", mimeType="image/png")]
	public static var BUNDLE_RES_CHARVIEW_WINGS_PNG:Class;
	bundleImage("res/charview/wings.png", BUNDLE_RES_CHARVIEW_WINGS_PNG);

	public static function bundleImage(key:String, c:Class):void {
		var o:BitmapData = c ? ((new c() as Bitmap).bitmapData) : null;
		if (o) IMAGE_BUNDLE[key] = o;
	}
	/**
	 * @param path
	 * @param callback Function (success:Boollean, result:*,event:Event):*
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
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
						return;
					}
					callback(true, loader.data, e);
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
					var bmp:Bitmap = null;
					try {
						bmp = cli.content as Bitmap;
					} catch (e:Error) {
						LOGGER.warn(e.name+" loading external "+path+": "+e.message);
						orLocal(new ErrorEvent("error",false,false,e.message));
						return;
					}
					if (bmp) {
						LOGGER.info("Loaded external "+path);
						IMAGE_BUNDLE[path] = bmp.bitmapData;
						callback(true, bmp.bitmapData, e);
					} else {
						LOGGER.warn("Not found external "+path);
						callback(false, null, e);
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
