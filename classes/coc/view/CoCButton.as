package coc.view {

/****
 coc.view.CoCButton

 note that although this stores its current tool tip text,
 it does not display the text.  That is taken care of
 by whoever owns this.

 The mouse event handlers are public to facilitate reaction to
 keyboard events.
 ****/

import flash.display.MovieClip;
import flash.display.Sprite;
import flash.text.Font;
import flash.text.TextField;
import flash.text.TextFormat;

import flash.events.MouseEvent;

public class CoCButton extends Block {

	public static const ButtonLabelFontName:String = "Palatino Linotype";

	private var _labelField:TextField,
				_backgroundGraphic:BitmapDataSprite,
				_enabled:Boolean = true,
				_callback:Function;

	public var toolTipHeader:String,
			   toolTipText:String;

	public function CoCButton(options:Object = null):void {
		super();
		_backgroundGraphic = addBitmapDataSprite({
			stretch    : true,
			width      : MainView.BTN_W,
			height     : MainView.BTN_H
		});
		_labelField        = addTextField({
			width : MainView.BTN_W,
			height: MainView.BTN_H,
			defaultTextFormat: {
				font: ButtonLabelFontName,
				bold: true,
				size: 18,
				align: 'center'
			}
		});

		this.mouseChildren = true;
		this.buttonMode    = true;
		this.visible       = true;
		UIUtils.setProperties(this,options);

		this.addEventListener(MouseEvent.ROLL_OVER, this.hover);
		this.addEventListener(MouseEvent.ROLL_OUT, this.dim);
		this.addEventListener(MouseEvent.CLICK, this.click);
	}

	//////// Mouse Events... ////////

	public function hover(event:MouseEvent = null):void {
		if (this._backgroundGraphic)
			this._backgroundGraphic.alpha = enabled?0.5:0.4;
	}

	public function dim(event:MouseEvent = null):void {
		if (this._backgroundGraphic)
			this._backgroundGraphic.alpha = enabled?1:0.4;
	}

	public function click(event:MouseEvent = null):void {
		if (this._callback != null)
			this._callback();
	}

	public function get enabled():Boolean {
		return _enabled;
	}
	public function set enabled(value:Boolean):void {
		_enabled = value;
		this._labelField.alpha = value?1:0.4;
		this._backgroundGraphic.alpha = value?1:0.4;
	}
//////// Getters and Setters ////////

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
}
}