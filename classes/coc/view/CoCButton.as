package coc.view {

/****
 coc.view.CoCButton

 note that although this stores its current tool tip text,
 it does not display the text.  That is taken care of
 by whoever owns this.

 The mouse event handlers are public to facilitate reaction to
 keyboard events.
 ****/

import classes.internals.Utils;
import flash.text.Font;
import flash.text.TextField;

import flash.events.MouseEvent;
import classes.Parser.Parser;

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

	private var _labelField:TextField,
				_backgroundGraphic:BitmapDataSprite,
				_enabled:Boolean = true,
				_callback:Function = null,
				_preCallback:Function = null;

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
		_labelField        = addTextField({
			width            : MainView.BTN_W,
			embedFonts       : true,
			y                : 8,
			height           : MainView.BTN_H - 8,
			defaultTextFormat: {
				font : ButtonLabelFontName,
				size : 18,
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

	public function get labelText():String {
		return this._labelField.text;
	}

	public function set labelText(value:String):void {
		this._labelField.text = value;
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
		this.alpha         = 1;
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
	 * Disable if condition is true, optionally change tooltip. Does not un-hide button.
	 * @return this
	 */
	public function disableIf(condition:Boolean, toolTipText:String=null):CoCButton {
		if (condition) {
			enabled = false;
			if (toolTipText !== null)
                this.toolTipText = Parser.recursiveParser(toolTipText);
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
	 * Set callback to fn(...args)
	 * @return this
	 */
	public function call(fn:Function,...args:Array):CoCButton {
		this.callback = Utils.curry.apply(null,[fn].concat(args));
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
