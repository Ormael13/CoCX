package coc.view {
import classes.internals.Utils;

import flash.display.Bitmap;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.setTimeout;

public class NotificationView extends Block {
	public static const FADEIN_TIME:int  = 250;
	/** Default notification time, ms */
	public static const DEFAULT_TTL:int  = 5000;
	public static const FADEOUT_TIME:int = 1000;
	public static const DEFAULT_TEXT_FORMAT:Object = {
		font: "Arial",
		size: 16,
		color: "#000000",
		bold: true
	};
	public static const DEFAULT_BAR_COLOR:String = "#eeee00";
	public static const DEFAULT_BAR2_COLOR:String = "#eeeeee";
	public static const BAR_BG:String = "#222222";
	public static const BAR_BORDER:String = "#888888";
	private static const ICON_SIZE:int = 32;
	private static const BAR_WIDTH:int = 64;
	private static const BAR_HEIGHT:int = 8;
	private static const BAR_Y:int = 8;
	private static const BAR_BORDER_WIDTH:int = 2;
	private static const BAR_FILL_WIDTH:int = BAR_WIDTH - 2*BAR_BORDER_WIDTH;
	private static const BAR_FILL_HEIGHT:int = BAR_HEIGHT - 2*BAR_BORDER_WIDTH;
	private var idMap:Object = {};
	
	public function NotificationView(options:Object = null) {
		super(options);
		this.layoutConfig = {
			type        : 'flow',
			direction   : 'column',
			ignoreHidden: true,
			gap         : 1
		};
	}
	/**
	 * Fade-in, wait, then fade-out and delete the element.
	 * @param notification
	 * @param ttl
	 */
	private function animateNotification(id:String, notification:DisplayObject, ttl:int = DEFAULT_TTL):void {
		var fadeinTime:int = FADEIN_TIME;
		if (id) {
			clearNotification(id);
			fadeinTime = 0;
			idMap[id] = notification;
		}
		var alpha:Number   = notification.alpha;
		notification.alpha = 0.0;
		// Fade-in animation
		new SimpleTween(notification, "alpha", alpha, fadeinTime)
				.then(function ():void {
					if (!hasElement(notification)) return;
					setTimeout(function ():void {
						if (!hasElement(notification)) return;
						new SimpleTween(notification, "alpha", 0.0, FADEOUT_TIME)
								.then(function():void {
									if (!hasElement(notification)) return;
									delete idMap[id];
									removeElement(notification);
								})
					}, ttl);
				});
		doLayout();
	}
	/**
	 * Display custom Sprite notification.
	 * @param sprite
	 * @param ttl Time before popup disappears (ms), default 5000
	 */
	public function popupDisplayObject(id:String, sprite:DisplayObject, ttl:int = DEFAULT_TTL):void {
		addElement(sprite);
		animateNotification(id, sprite, ttl);
	}
	/**
	 * Display text notification
	 * @param htmlText
	 * @param textFormat TextFormat options, default Arial 16 bold
	 * @param ttl Time before popup disappears (ms), default 5000
	 */
	public function popupText(id:String, htmlText:String, textFormat:Object = null, ttl:int = DEFAULT_TTL):void {
		textFormat = Utils.extend({}, DEFAULT_TEXT_FORMAT, textFormat)
		var tf:TextField = addTextField({
			defaultTextFormat:textFormat,
			wordWrap:true,
			autoSize: TextFieldAutoSize.LEFT,
			width: width,
			height: ICON_SIZE,
			htmlText: htmlText,
			filters: [UIUtils.outlineFilter("#ffffff")]
		});
		animateNotification(id, tf, ttl);
	}
	/**
	 * Display notification with an icon
	 * @param iconId
	 * @param htmlText
	 * @param textFormat TextFormat options, default Arial 16 bold
	 * @param ttl Time before popup disappears (ms), default 5000
	 */
	public function popupIconText(id:String, iconId:String, htmlText:String, textFormat:Object = null, ttl:int = DEFAULT_TTL):void {
		var bitmap:Bitmap = IconLib.getBitmap(iconId);
		if (!bitmap) {
			popupText(id, htmlText, textFormat, ttl);
			return;
		}
		
		var block:Block = new Block({
			layoutConfig: {
				type: "grid",
				columns: [ICON_SIZE,-1],
				gap: 2
			},
			width: width
		});
		block.addBitmapDataSprite({bitmap:bitmap});
		block.addTextField({
			defaultTextFormat: Utils.extend({}, DEFAULT_TEXT_FORMAT, textFormat),
			autoSize: TextFieldAutoSize.LEFT,
			wordWrap: true,
			width: width - ICON_SIZE - 2,
			htmlText: htmlText,
			filters: [UIUtils.outlineFilter("#ffffff")]
		});
		block.doLayout();
		
		popupDisplayObject(id, block, ttl);
	}
	/**
	 * Display a notification with an icon (optional) and a progress bar.
	 *
	 * @param id Notification id. If exi
	 * @param iconId Icon id, can be null
	 * @param htmlLabel Text to display (HTML)
	 * @param progress Progress, 0..1
	 * @param barColor Progressbar color (default yellow)
	 * @param ttl Time before popup disappears (ms), default 5000
	 */
	public function popupProgressBar(id:String, iconId:String, htmlLabel:String, progress:Number, barColor:String=DEFAULT_BAR_COLOR, ttl:int = DEFAULT_TTL):void {
		popupProgressBar2(id,iconId,htmlLabel,progress,progress,barColor,barColor,ttl);
	}
	/**
	 * Display a notification with an icon (optional) and a progress bar with highlighted increment.
	 *
	 * @param id Notification id. If exi
	 * @param iconId Icon id, can be null
	 * @param htmlLabel Text to display (HTML)
	 * @param progressStart Starting progress, 0..1
	 * @param progressEnd Ending progress, 0..1
	 * @param barColorStart Starting bar color (default yellow)
	 * @param barColorEnd Increment color (default white)
	 * @param ttl Time before popup disappears (ms), default 5000
	 *
	 * @example Show Experience increasing from 0.5 to 0.75, with white main bar (0-0.5) and blue increment (0.5-0.75)
	 * popupProgressBar2("xp", "XP", "Experience",
	 *                   0.5, 0.75, "white", "blue")
	 */
	public function popupProgressBar2(
			id:String,
			iconId:String,
			htmlLabel:String,
			progressStart:Number,
			progressEnd:Number,
			barColorStart:String=DEFAULT_BAR_COLOR,
			barColorEnd:String=DEFAULT_BAR2_COLOR,
			ttl:int = DEFAULT_TTL
	):void {
		// Convert to pixels
		var pxStart:Number = Math.round(Utils.boundFloat(0, progressStart, 1)*BAR_FILL_WIDTH);
		var pxEnd:Number = Math.round(Utils.boundFloat(0, progressEnd, 1)*BAR_FILL_WIDTH);
		var pxInc:Number = pxEnd - pxStart;
//		trace("popupProgressBar2",progressStart,progressEnd,pxStart,pxEnd,pxInc);
		
		var bitmap:Bitmap = IconLib.getBitmap(iconId);
		var block:Block = new Block({
			layoutConfig: {
				type: "grid",
				columns: bitmap ? [ICON_SIZE, BAR_WIDTH, -1] : [BAR_WIDTH, -1],
				gap: 2
			},
			width: width
		});
		if (bitmap) block.addBitmapDataSprite({bitmap:bitmap});
		var progressBar:Sprite = new Sprite();
		progressBar.addChild(new BitmapDataSprite({
			// Border
			x: 0,
			y: BAR_Y,
			width: BAR_WIDTH,
			height: BAR_HEIGHT,
			fillColor: BAR_BORDER
		}));
		progressBar.addChild(new BitmapDataSprite({
			// Background
			x: BAR_BORDER_WIDTH,
			y: BAR_Y + BAR_BORDER_WIDTH,
			width: BAR_WIDTH - BAR_BORDER_WIDTH*2,
			height: BAR_HEIGHT - BAR_BORDER_WIDTH*2,
			fillColor: BAR_BG
		}));
		if (pxInc > 0) {
			var incBar:BitmapDataSprite = new BitmapDataSprite({
				// End bar
				x: BAR_BORDER_WIDTH + pxStart,
				y: BAR_Y + BAR_BORDER_WIDTH,
				height: BAR_FILL_HEIGHT,
				width: pxInc,
				fillColor: barColorEnd
			});
			progressBar.addChild(incBar);
			new SimpleTween(incBar, "fillColor", barColorStart, FADEIN_TIME+ttl, {
				color: true
			});
		}
		progressBar.addChild(new BitmapDataSprite({
			// Start bar
			x: BAR_BORDER_WIDTH,
			y: BAR_Y + BAR_BORDER_WIDTH,
			height: BAR_FILL_HEIGHT,
			width: pxStart,
			fillColor: barColorStart
		}))
		block.addElement(progressBar);
		block.addTextField({
			defaultTextFormat: DEFAULT_TEXT_FORMAT,
			autoSize: TextFieldAutoSize.LEFT,
			wordWrap: true,
			width: width - ICON_SIZE - 2,
			htmlText: htmlLabel,
			filters: [UIUtils.outlineFilter("#ffffff")]
		});
		block.doLayout();
		
		popupDisplayObject(id, block, ttl);
	}
	
	public function clearNotification(id:String):void {
		if (!id) return;
		var e:DisplayObject = idMap[id] as DisplayObject;
		if (e) {
			delete idMap[id];
			removeElement(e);
		}
	}
	
	public function clearNotifications():void {
		removeAllElements();
	}
}
}
