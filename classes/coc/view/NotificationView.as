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
		bold: true
	};
	public static const DEFAULT_BAR_COLOR:String = "#eeee00";
	public static const ICON_SIZE:int = 32;
	public static const BAR_BG:String = "#222222";
	public static const BAR_BORDER:String = "#222222";
	public static const BAR_WIDTH:int = 64;
	public static const BAR_HEIGHT:int = 8;
	public static const BAR_Y:int = (ICON_SIZE-BAR_HEIGHT)/2;
	public static const BAR_BORDER_WIDTH:int = 2;
	
	public function NotificationView(options:Object = null) {
		super(options);
		this.layoutConfig = {
			type        : 'flow',
			direction   : 'column',
			ignoreHidden: true,
			gap         : 1
		};
	}
	
	private function animateNotification(notification:DisplayObject, ttl:int = DEFAULT_TTL):void {
		var alpha:Number   = notification.alpha;
		notification.alpha = 0.0;
		// Fade-in animation
		new SimpleTween(notification, "alpha", alpha, FADEIN_TIME)
				.then(function ():void {
					if (!hasElement(notification)) return;
					setTimeout(function ():void {
						if (!hasElement(notification)) return;
						new SimpleTween(notification, "alpha", 0.0, FADEOUT_TIME)
								.then(function():void {
									removeElement(notification);
								})
					}, ttl);
				})
	}
	
	public function popupDisplayObject(sprite:DisplayObject, ttl:int = DEFAULT_TTL):void {
		addElement(sprite);
		animateNotification(sprite, ttl);
	}
	public function popupText(htmlText:String, textFormat:Object = null, ttl:int = DEFAULT_TTL):void {
		textFormat = Utils.extend({}, DEFAULT_TEXT_FORMAT, textFormat)
		var tf:TextField = addTextField({
			defaultTextFormat:textFormat,
			wordWrap:true,
			autoSize: TextFieldAutoSize.LEFT,
			width: width,
			height: ICON_SIZE,
			htmlText: htmlText
		});
		animateNotification(tf, ttl);
	}
	public function popupIconText(iconId:String, htmlText:String, textFormat:Object = null, ttl:int = DEFAULT_TTL):void {
		var bitmap:Bitmap = IconLib.getBitmap(iconId);
		if (!bitmap) {
			popupText(htmlText, textFormat, ttl);
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
			htmlText: htmlText
		});
		
		popupDisplayObject(block, ttl);
	}
	public function popupProgressBar(id:String, iconId:String, label:String, progress:Number, barColor:String=DEFAULT_BAR_COLOR, ttl:int = DEFAULT_TTL):void {
		
		var bitmap:Bitmap = IconLib.getBitmap(iconId);
		var block:Block = new Block({
			layoutConfig: {
				type: "grid",
				columns: bitmap ? [ICON_SIZE, BAR_WIDTH, -1] : [-1,BAR_WIDTH, -1],
				gap: 2
			},
			width: width
		});
		if (bitmap) block.addBitmapDataSprite({bitmap:bitmap});
		var progressBar:Sprite = new Sprite();
		progressBar.addChild(new BitmapDataSprite({
			// Border + Background
			y: BAR_Y,
			width: BAR_WIDTH,
			height: BAR_HEIGHT,
			fillColor: BAR_BG
		}));
		progressBar.addChild(new BitmapDataSprite({
			// Fill
			x: BAR_BORDER_WIDTH,
			y: BAR_Y + BAR_BORDER_WIDTH,
			height: BAR_HEIGHT - 2*BAR_BORDER_WIDTH,
			width: BAR_WIDTH*progress,
			fillColor: barColor
		}))
		block.addElement(progressBar);
		block.addTextField({
			defaultTextFormat: DEFAULT_TEXT_FORMAT,
			autoSize: TextFieldAutoSize.LEFT,
			wordWrap: true,
			width: width - ICON_SIZE - 2,
			text: label
		});
		
		// Mark the block and remove existing with similar ID
		block.dataset.progress = id;
		for (var i:int = 0; i < numElements; i++) {
			var ib:Block = getElementAt(i) as Block;
			if (ib && ib.dataset.progress == id) {
				removeElement(ib);
				break;
			}
		}
		popupDisplayObject(block, ttl);
	}
	
	public function clearNotifications():void {
		removeAllElements();
	}
}
}
