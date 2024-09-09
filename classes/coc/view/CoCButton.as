package coc.view {

/****
 coc.view.CoCButton

 note that although this stores its current tool tip text,
 it does not display the text.  That is taken care of
 by whoever owns this.

 The mouse event handlers are public to facilitate reaction to
 keyboard events.
 ****/

import classes.CoC;
import classes.GameSettings;
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

	[Embed(source="../../../res/ui/buttonBackground.png")]
	private static const ButtonBackgroundImage:Class;

	[Embed(source="../../../res/ui/buttonBorder.png")]
	private static const ButtonBorderImage:Class;
	
	private static const BACKGROUND_SIZE:int = 256;
	public static const ButtonBorder:BorderImage = new BorderImage((new ButtonBorderImage() as Bitmap).bitmapData, 8, 8, 8, 8);
	
	public static const ButtonLabelFontName:String = (new ButtonLabelFont() as Font).fontName;
	public static const ButtonKeyFontName:String = 'Arial';
	public static const ButtonKeyFontColor:* = "#ffffff";
	public static const ButtonKeyShadowColor:* = "#000000";
	public static const ButtonKeyFontSize:int = 10;
	public static const IconQuantityFormat:Object = {
		font: 'Arial',
		size: 10,
		bold: true,
		align: 'right'
	};
	public static const IconQuantityColor:String = "#ffff00";
	public static const IconQuantityShadow:String = "#000000";
	
	/**
	 * function(error:Error, button:CoCButton):void
	 */
	public static var clickErrorHandler:Function;
	public static const DEFAULT_COLOR:String = "#000000";
	public static const MAX_FONT_SIZE:int = 18;
	public static const MIN_FONT_SIZE:int = 12;
	
	public static const ICON_WIDTH:int = 32;
	public static const ICON_HEIGHT:int = 32;
	private static const BTN_W:int = MainView.BTN_W;
	private static const BTN_H:int = MainView.BTN_H;
	private static const ICON_Y:int = 4;
	private static const ICON_X:int = 4;
	private static const LABEL_NOICON_X:int = 0;
	private static const LABEL_ICON_X:int = ICON_X + ICON_WIDTH;
	private static const LABEL_RIGHT:int = 2;
	private static const LABEL_Y:int = 8; // works for default font size
	

	private var _labelField:TextField,
				_key1label:TextField,
				_key2label:TextField,
				_iconQuantityLabel:TextField,
				_cornerLabel:TextField,
				_iconGraphic:BitmapDataSprite,
				_backgroundGraphic:BitmapDataSprite,
				_enabled:Boolean      = true,
				_callback:Function    = null,
				_preCallback:Function = null,
				_iconId:String        = null;

	public var toolTipHeader:String,
			   toolTipText:String;

		/**
		 * @param options  enabled, labelText, bitmapClass, callback
		 */
	public function CoCButton(options:Object = null):void {
		super();
		const width:Number =
					  (options && 'square' in options) ? BTN_H :
					  (options && 'width' in options) ? options['width'] : BTN_W;
		const height:Number = BTN_H;
		this.width = width;
		this.height = height;
		_backgroundGraphic = addBitmapDataSprite({
			width  : width,
			height : BTN_H,
			bitmapX: Math.max(0, Math.random()*(BACKGROUND_SIZE-width))|0,
			bitmapY: Math.max(0, Math.random()*(BACKGROUND_SIZE-height))|0,
			bitmapClass: ButtonBackgroundImage,
			stretch: false,
			crop: true,
			repeat: true,
			borderImage: ButtonBorder
		});
		_labelField        = addTextField({
			width            : width - LABEL_RIGHT - LABEL_NOICON_X,
			embedFonts       : true,
			x                : LABEL_NOICON_X,
			y                : LABEL_Y,
			height           : BTN_H - LABEL_Y,
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
		this.resize();
	}
	private function iconElement():BitmapDataSprite {
		if (_iconGraphic) return _iconGraphic;
		_iconGraphic = addElementBelow(new BitmapDataSprite({
			stretch: true,
			smooth: false,
			visible: false,
			x: ICON_X,
			y: ICON_Y,
			width: ICON_WIDTH,
			height: ICON_HEIGHT
		}), _labelField) as BitmapDataSprite;
		return _iconGraphic;
	}
	private function iconQuantityElement():TextField {
		if (_iconQuantityLabel) return _iconQuantityLabel;
		_iconQuantityLabel = addElementAbove(UIUtils.newTextField({
			x: ICON_X,
			y: ICON_Y + (ICON_HEIGHT/2),
			width: ICON_WIDTH,
			height: ICON_HEIGHT/2,
			textColor: IconQuantityColor,
			defaultTextFormat: IconQuantityFormat
		}), iconElement()) as TextField;
		_iconQuantityLabel.filters = [UIUtils.outlineFilter(IconQuantityShadow)];
		return _iconQuantityLabel;
	}
	private function cornerLabelElement():TextField {
		if (_cornerLabel) return _cornerLabel;
		_cornerLabel         = addElementAbove(UIUtils.newTextField({
			x                : ICON_X,
			width            : width - ICON_X * 2,
			y                : ICON_Y,
			height           : ICON_HEIGHT / 2,
			textColor        : IconQuantityColor,
			defaultTextFormat: IconQuantityFormat
		}), _labelField) as TextField;
		_cornerLabel.filters = [UIUtils.outlineFilter(IconQuantityShadow)];
		return _cornerLabel;
	}
	private function key1labelElement():TextField {
		if (_key1label) return _key1label;
		_key1label         = addElementAbove(UIUtils.newTextField({
			alpha            : 0.5,
			x                : 8,
			width            : width - 12,
			y                : 2,
			height           : (MainView.BTN_H - 4) / 2,
			textColor        : ButtonKeyFontColor,
			defaultTextFormat: {
				font : ButtonKeyFontName,
				size : ButtonKeyFontSize,
				bold : true,
				align: 'right'
			}
		}), _labelField) as TextField;
		_key1label.filters = [UIUtils.outlineFilter(ButtonKeyShadowColor)];
		return _key1label;
	}
	private function key2labelElement():TextField {
		if (_key2label) return _key2label;
		_key2label         = addElementAbove(UIUtils.newTextField({
			alpha            : 0.5,
			x                : 8,
			width            : width - 12,
			y                : 2+(MainView.BTN_H-4)/2,
			height           : (MainView.BTN_H-4)/2,
			textColor        : ButtonKeyFontColor,
			defaultTextFormat: {
				font : ButtonKeyFontName,
				size : ButtonKeyFontSize,
				bold: true,
				align: 'right'
			}
		}), _labelField) as TextField;
		_key2label.filters = [UIUtils.outlineFilter(ButtonKeyShadowColor)];
		return _key2label;
	}
	
	override protected function resize():void {
		if (_backgroundGraphic) {
			_backgroundGraphic.width = innerWidth;
			if (_key1label) _key1label.width         = innerWidth - 12;
			if (_key2label) _key2label.width         = innerWidth - 12;
			iconId                   = iconId;
		}
		if (_cornerLabel) {
			_cornerLabel.width = width - ICON_X * 2;
		}
		super.resize();
	}
	
	//////// Mouse Events... ////////
	
	public function hover(event:MouseEvent = null):void {
		if (this._backgroundGraphic)
			this._backgroundGraphic.alpha = enabled ? 0.5 : 0.4;
		if (visible && toolTipText) {
			CoC.instance.mainView.toolTipView.showForElement(this, toolTipHeader, toolTipText);
		}
	}

	public function dim(event:MouseEvent = null):void {
		if (this._backgroundGraphic)
			this._backgroundGraphic.alpha = enabled ? 1 : 0.4;
		CoC.instance.mainView.toolTipView.hide();
	}

	public function click(event:MouseEvent = null):void {
		if (!this.enabled) return;
		CoC.instance.mainView.toolTipView.hide();
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
		var alpha:Number              = value ? 1 : 0.4;
		this._labelField.alpha        = alpha;
		this._backgroundGraphic.alpha = alpha;
		if (_iconGraphic) this._iconGraphic.alpha       = alpha;
	}
	
	public function get iconId():String {
		return _iconId;
	}
	
	public function set iconId(iconId:String):void {
		if (!GameSettings.buttonIconsEnabled) return;
		_iconId           = iconId;
		var bitmap:Bitmap = iconId ? IconLib.getBitmap(iconId) : null;
		if (bitmap) {
			iconElement();
			_iconGraphic.bitmap = IconLib.getBitmap(iconId);
			_iconGraphic.visible = true;
			this._labelField.x = LABEL_ICON_X;
		} else {
			if (_iconGraphic) _iconGraphic.visible = false;
			this._labelField.x = LABEL_NOICON_X;
		}
		this._labelField.width = width - LABEL_RIGHT - this._labelField.x;
		if (_iconQuantityLabel && _iconGraphic) _iconQuantityLabel.visible = _iconGraphic.visible;
		if (labelText) labelText = labelText; // force resize
	}
	public function get iconQty():String {
		return _iconQuantityLabel && _iconQuantityLabel.visible ? _iconQuantityLabel.text : "";
	}
	public function set iconQty(value:String):void {
		if (value && !_iconQuantityLabel) iconQuantityElement();
		if (_iconQuantityLabel) {
			_iconQuantityLabel.text    = value;
			_iconQuantityLabel.visible = _iconGraphic && _iconGraphic.visible;
		}
	}
	public function cornerLabel(value:String):CoCButton {
		cornerLabelText = value;
		return this;
	}
	public function get cornerLabelText():String {
		return _cornerLabel ? _cornerLabel.text : "";
	}
	public function set cornerLabelText(value:String):void {
		if (value && !_cornerLabel) cornerLabelElement();
		if (_cornerLabel) {
			_cornerLabel.text = value;
		}
	}
	public function icon(iconId:String, iconQty:String=""):CoCButton {
		this.iconId = iconId;
		this.iconQty = iconQty;
		return this;
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
		this._labelField.y                 = LABEL_Y;
		this._labelField.height            = BTN_H - this._labelField.y;
		while (this._labelField.textWidth + 2 > this._labelField.width && fontSize > MIN_FONT_SIZE) {
			fontSize--;
			tf.size                            = fontSize;
			this._labelField.defaultTextFormat = tf;
			this._labelField.text              = value;
			this._labelField.y                 = (BTN_H - this._labelField.textHeight)/2;
			this._labelField.height            = BTN_H - this._labelField.y;
		}
	}
	public function get key1text():String {
		return _key1label ? this._key1label.text : "";
	}
	
	public function set key1text(value:String):void {
		key1labelElement();
		this._key1label.text = value;
	}
	
	public function get key2text():String {
		return _key2label ? this._key2label.text : "";
	}
	
	public function set key2text(value:String):void {
		key2labelElement();
		this._key2label.text = value;
	}

	public function get callback():Function {
		return this._callback;
	}

	public function set callback(value:Function):void {
		this._callback = value;
	}

	/**
	 * In case of needing to execute multiple callback when button press
	 * e.g. during combat need to end player turn
	 * use this instead of hardcoding everything
	 * @param postCallback
	 * @return
	 */
	public function and(postCallback:Function):void {
		var oldCb:Function = this.callback;
		this.callback = function():void {
			oldCb();
			postCallback();
		}
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
	
	public function color(rgb:*):CoCButton {
		labelColor = rgb;
		return this;
	}
	public function get labelColor():String {
		return Color.toHex(this._labelField.textColor);
	}
	public function set labelColor(value:*):void {
		this._labelField.textColor = Color.convertColor(value);
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
		iconQty = "";
		if (slot.quantity > 1 || slot.itype.stackSize > 1) {
			toolTipHeader = ""+slot.quantity+" x "+toolTipHeader;
			if (_iconGraphic && _iconGraphic.visible) {
				iconQty = String(slot.quantity);
			} else {
				labelText += " x" + slot.quantity;
			}
		}
		return this;
	}
	public function itemIcon(item:ItemType):CoCButton {
		iconId = item.iconId;
		return this;
	}
	public function showForItem(item:ItemType, callback:Function):CoCButton {
		show(item.shortName, callback);
		itemIcon(item);
		itemTexts(item);
		return this;
	}
	public function showForItemSlot(slot:ItemSlotClass, callback:Function):CoCButton {
		if (slot.isEmpty()) {
			showDisabled("Empty");
			hint("");
			color(DEFAULT_COLOR);
			iconId = null;
			iconQty = "";
			return this;
		}
		showForItem(slot.itype, callback);
		if (slot.itype.stackSize > 1 || slot.quantity > 1) {
			iconQty = String(slot.quantity);
		} else {
			iconQty = "";
		}
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
	 * If tooltipText starts with '++', the text after '++' will be appended to existing hint.
	 * @return this
	 */
	public function disableIf(condition:Boolean, toolTipText:String=null, labelText:String=null):CoCButton {
		if (condition) {
			enabled = false;
			if (toolTipText !== null) {
				if (toolTipText.indexOf("++")==0) this.toolTipText += Parser.recursiveParser(toolTipText).slice(2);
				else this.toolTipText = Parser.recursiveParser(toolTipText);
			}
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
		visible         = false;
		labelText       = "";
		toolTipHeader   = "";
		toolTipText     = "";
		alpha           = 1;
		enabled         = false;
		callback        = null;
		iconId          = null;
		iconQty         = "";
		cornerLabelText = "";
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
