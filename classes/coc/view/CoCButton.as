package coc.view {

/****
 coc.view.CoCButton

 note that although this stores its current tool tip text,
 it does not display the text.  That is taken care of
 by whoever owns this.

 The mouse event handlers are public to facilitate reaction to
 keyboard events.
 ****/

import classes.ItemSlotClass;
import classes.ItemType;
import classes.Parser.Parser;
import classes.internals.Utils;

import flash.display.Bitmap;
import flash.events.MouseEvent;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

public class CoCButton extends Block {

	[Embed(source='../../../res/ui/Shrewsbury-Titling_Bold.ttf',
			advancedAntiAliasing='true',
			fontName='ShrewsburyTitlingBold',
			embedAsCFF='false')]
	private static const ButtonLabelFont:Class;
	public static const ButtonLabelFontName:String = (new ButtonLabelFont() as Font).fontName;
	
	/**
	 * function(error:Error, button:CoCButton):void
	 */
	public static var clickErrorHandler:Function;
	public static const DEFAULT_COLOR:String = "#000000";
	public static const MAX_FONT_SIZE:int = 18;
	public static const MIN_FONT_SIZE:int = 12;
	
	public static const ICON_WIDTH:int = 36;
	public static const ICON_HEIGHT:int = 36;
	private static const ICON_Y:int = (MainView.BTN_H - ICON_HEIGHT) / 2;
	private static const ICON_X:int = 0;
	private static const ICON_LABEL_X:int = ICON_X+ICON_WIDTH;
	private static const ICON_LABEL_WIDTH:int = MainView.BTN_W-ICON_LABEL_X;

	private var _labelField:TextField,
				_iconGraphic:BitmapDataSprite,
				_backgroundGraphic:BitmapDataSprite,
				_enabled:Boolean = true,
				_callback:Function = null,
				_preCallback:Function = null,
				_icon:String = null;

	public var toolTipHeader:String,
			   toolTipText:String;

		/**
		 * @param options  enabled, labelText, bitmapClass, callback
		 */
	public function CoCButton(options:Object = null):void {
		super();
		_backgroundGraphic = addBitmapDataSprite({
			stretch: true,
			width  : MainView.BTN_W,
			height : MainView.BTN_H
		});
		_iconGraphic = addBitmapDataSprite({
			stretch: true,
			visible: false,
			x: ICON_X,
			y: ICON_Y,
			width: ICON_WIDTH,
			height: ICON_HEIGHT
		});
		_labelField        = addTextField({
			width            : MainView.BTN_W,
			embedFonts       : true,
			y                : 8,
			height           : MainView.BTN_H - 8,
			defaultTextFormat: {
				font : ButtonLabelFontName,
				size : MAX_FONT_SIZE,
				align: 'center'
			}
		});

		this.mouseChildren = true;
		this.buttonMode    = true;
		this.visible       = true;
		UIUtils.setProperties(this, options);

		this.addEventListener(MouseEvent.ROLL_OVER, this.hover);
		this.addEventListener(MouseEvent.ROLL_OUT, this.dim);
		this.addEventListener(MouseEvent.CLICK, this.click);
	}

	//////// Mouse Events... ////////

	public function hover(event:MouseEvent = null):void {
		if (this._backgroundGraphic)
			this._backgroundGraphic.alpha = enabled ? 0.5 : 0.4;
	}

	public function dim(event:MouseEvent = null):void {
		if (this._backgroundGraphic)
			this._backgroundGraphic.alpha = enabled ? 1 : 0.4;
	}

	public function click(event:MouseEvent = null):void {
		if (!this.enabled) return;
		try {
			if (this._preCallback != null)
				this._preCallback(this);
			if (this._callback != null)
				this._callback();
		} catch (e:Error) {
			if (clickErrorHandler != null) {
				clickErrorHandler(e, this);
			} else {
				throw e;
			}
		}
	}



		//////// Getters and Setters ////////

	public function get enabled():Boolean {
		return _enabled;
	}
	public function set enabled(value:Boolean):void {
		_enabled                      = value;
		this._labelField.alpha        = value ? 1 : 0.4;
		this._backgroundGraphic.alpha = value ? 1 : 0.4;
	}
	
	public function get icon():String {
		return _icon;
	}
	
	public function set icon(iconId:String):void {
		_icon = iconId;
		var bitmap:Bitmap = iconId ? IconLib.getBitmap(iconId) : null;
		if (bitmap) {
			_iconGraphic.bitmap = IconLib.getBitmap(iconId);
			_iconGraphic.visible = true;
			this._labelField.x = ICON_LABEL_X;
			this._labelField.width = ICON_LABEL_WIDTH;
		} else {
			_iconGraphic.visible = false;
			this._labelField.x = 0;
			this._labelField.width = MainView.BTN_W;
		}
		labelText = labelText; // forse resize
	}
	public function get labelText():String {
		return this._labelField.text;
	}
	
	public function set labelText(value:String):void {
		var fontSize:int                   = MAX_FONT_SIZE;
		var tf:TextFormat                  = this._labelField.defaultTextFormat;
		tf.size                            = fontSize;
		this._labelField.defaultTextFormat = tf;
		this._labelField.text              = value;
		while (this._labelField.textWidth > width - 4 && fontSize > MIN_FONT_SIZE) {
			fontSize--;
			tf.size                            = fontSize;
			this._labelField.defaultTextFormat = tf;
			this._labelField.text              = value;
		}
	}

	public function set bitmapClass(value:Class):void {
		_backgroundGraphic.bitmapClass = value;
	}
	public function get bitmapClass():Class {
		return null;
	}

	public function get callback():Function {
		return this._callback;
	}

	public function set callback(value:Function):void {
		this._callback = value;
	}

	public function get preCallback():Function {
		return _preCallback;
	}
	public function set preCallback(value:Function):void {
		_preCallback = value;
	}
	//////////// Builder functions
	/**
	 * Setup (text, callback, tooltip) and show enabled button. Removes all previously set options
	 * @return this
	 */
	public function show(text:String,callback:Function,toolTipText:String="",toolTipHeader:String=""):CoCButton {
		this.reset();
		this.labelText     = text;
		this.callback      = callback;
		this.toolTipText = toolTipText;
		this.toolTipHeader = toolTipHeader || text;
		if (this.labelText)
			this.labelText = Parser.recursiveParser(this.labelText);
        if (this.toolTipText)
            this.toolTipText = Parser.recursiveParser(this.toolTipText);
        if (this.toolTipHeader)
            this.toolTipHeader = Parser.recursiveParser(this.toolTipHeader);
		this.visible       = true;
		this.enabled       = (this.callback != null);
		return this;
	}
	
	public function color(rgb:String):CoCButton {
		this._labelField.textColor = Color.convertColor(rgb);
		return this;
	}
	public function get labelColor():String {
		return Color.toHex(this._labelField.textColor);
	}
	/**
	 * Set color, text, and hint from the item
	 */
	public function itemTexts(item:ItemType):CoCButton {
		text(item.shortName, item.description, Utils.capitalizeFirstLetter(item.longName));
		color(item.buttonColor);
		return this;
	}
	/**
	 * Set hint from the item
	 */
	public function itemHints(item:ItemType):CoCButton {
		text(labelText, item.description, Utils.capitalizeFirstLetter(item.longName));
		return this;
	}
	/**
	 * Set color, text, and hint from the item slot
	 */
	public function itemSlotTexts(slot:ItemSlotClass):CoCButton {
		itemIcon(slot.itype);
		itemTexts(slot.itype);
		if (slot.quantity > 1 || slot.itype.stackSize > 1) labelText += " x"+slot.quantity;
		return this;
	}
	public function itemIcon(item:ItemType):CoCButton {
		icon = item.iconId;
		return this;
	}
	public function showForItem(item:ItemType, callback:Function):CoCButton {
		show(item.shortName, callback);
		itemIcon(item);
		itemTexts(item);
		return this;
	}
	public function showForItemSlot(slot:ItemSlotClass, callback:Function):CoCButton {
		show(slot.itype.shortName, callback);
		itemSlotTexts(slot);
		return this;
	}
	/**
	 * Setup (text, tooltip, and show) disabled button. Removes all previously set options
	 * @return this
	 */
	public function showDisabled(text:String,toolTipText:String="",toolTipHeader:String=""):CoCButton {
		return show(text, null, toolTipText, toolTipHeader);
	}
	/**
	 * Set text and tooltip. Don't change callback, enabled, visibility
	 * @return this
	 */
	public function text(text:String,toolTipText:String = "",toolTipHeader:String=""):CoCButton {
		this.labelText = text;
		this.toolTipText = toolTipText||labelText;
		this.toolTipHeader = toolTipHeader;
        if (this.toolTipText)
            this.toolTipText = Parser.recursiveParser(this.toolTipText);
        if (this.toolTipHeader)
            this.toolTipHeader = Parser.recursiveParser(this.toolTipHeader);
		return this;
	}
	/**
	 * Set tooltip only. Don't change text, callback, enabled, visibility
	 * @return this
	 */
	public function hint(toolTipText:String = "",toolTipHeader:String=""):CoCButton {
		this.toolTipText = toolTipText;
		this.toolTipHeader = toolTipHeader||labelText;
        if (this.toolTipText)
            this.toolTipText = Parser.recursiveParser(this.toolTipText);
        if (this.toolTipHeader)
            this.toolTipHeader = Parser.recursiveParser(this.toolTipHeader);
		return this;
	}
	/**
	 * Disable if condition is true, optionally change tooltip and/or label. Does not un-hide button.
	 * @return this
	 */
	public function disableIf(condition:Boolean, toolTipText:String=null, labelText:String=null):CoCButton {
		if (condition) {
			enabled = false;
			if (toolTipText !== null)
				this.toolTipText = Parser.recursiveParser(toolTipText);
			if (labelText !== null)
				this.labelText = labelText;
		}
		return this;
	}
	/**
	 * Disable, optionally change tooltip. Does not un-hide button.
	 * @return this
	 */
	public function disable(toolTipText:String=null):CoCButton {
		enabled = false;
        if (toolTipText !== null)
            this.toolTipText = Parser.recursiveParser(toolTipText);
		return this;
	}

	/**
	 * Enable, optionally change tooltip. Does not un-hide button.
	 * @return this
	 */
	public function enable(toolTipText:String = null):CoCButton {
		enabled = true;
		if (toolTipText !== null)
			this.toolTipText = Parser.recursiveParser(toolTipText);
		return this;
	}

	/**
	 * Set callback to fn(...args)
	 * @return this
	 */
	public function call(fn:Function,...args:Array):CoCButton {
		this.callback = Utils.curry.apply(null,[fn].concat(args));
		return this;
	}
	
	public function reset():CoCButton {
		color(DEFAULT_COLOR);
		visible       = false;
		labelText     = "";
		toolTipHeader = "";
		toolTipText   = "";
		alpha         = 1;
		enabled       = false;
		callback      = null;
		return this;
	}
	/**
	 * Hide the button
	 * @return this
	 */
	public function hide():CoCButton {
		visible = false;
		return this;
	}
	/**
	 * Show the button with all properties from previous configuration
	 * @return this
	 */
	public function unhide():CoCButton {
		visible = true;
		return this;
	}
}
}
