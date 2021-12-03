/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import classes.internals.Utils;

import flash.text.TextField;
import flash.text.TextFormat;
import flash.text.TextLineMetrics;

public class StatBar extends Block {
	[Embed(source="../../../res/ui/StatsBarBottom.png")]
	public static var StatsBarBottom:Class;
	[Embed(source = "../../../res/ui/arrow-up.png")]
	public static var ArrowUp:Class;
	[Embed(source = "../../../res/ui/arrow-down.png")]
	public static var ArrowDown:Class;

	private static function factoryReset():Object {
		return {
			width      : 200,
			height     : 28,
			minValue   : 0,
			maxValue   : 100,
			value      : 0,
			statName   : "",
			showMax    : false,
			isUp       : false,
			isDown     : false,
			hasGauge   : true,
			hasBar     : true,
			hasMinBar  : false,
			barAlpha   : 0.4,
			barHeight  : 1.0, // relative to height
			barColor   : '#0000ff',
			minBarColor: '#8080ff',
			bgColor    : null
		};
	}
	private static var DEFAULT_OPTIONS:Object     = factoryReset();
	public static function setDefaultOptions(options:Object):void {
		Utils.extend(DEFAULT_OPTIONS,options);
	}
	public static function resetDefaultOptions():void {
		DEFAULT_OPTIONS = factoryReset();
	}

	private var _bar:BitmapDataSprite;
	private var _minBar:BitmapDataSprite;
	private var _bgBar:BitmapDataSprite;
	private var _arrowUp:BitmapDataSprite;
	private var _arrowDown:BitmapDataSprite;
	private var _nameLabel:TextField;
	private var _valueLabel:TextField;
	private var _minValue:Number;
	private var _maxValue:Number;
	private var _value:Number;
	private var _showMax:Boolean;
	private function get arrowSz():Number {
		return this.height-2;
	}

	public function StatBar(options:Object) {
		super();
		options             = Utils.extend({},DEFAULT_OPTIONS, options);
		var myWidth:Number = options.width;
		var myHeight:Number = options.height;
		var arrowSz:Number  = myHeight - 2;
		var barWidth:Number = myWidth - arrowSz - 2;
		if (options.hasBar) {
			var barX:Number = 1;
			var barHeight:Number = myHeight*options.barHeight;
			var barY:Number = myHeight - barHeight;
			if (options.bgColor != null) {
				_bgBar = addBitmapDataSprite({
					x:barX,y:barY,
					alpha:options.barAlpha,
					fillColor:options.bgColor,
					width:barWidth,
					height:barHeight
				})
			}
			_bar = addBitmapDataSprite({
				x        : barX,
				y        : barY,
				alpha    : options.barAlpha,
				fillColor: options.barColor,
				width    : 0,
				height   : barHeight
			});
			if (options.hasMinBar) {
				_minBar = addBitmapDataSprite({
					x        : barX,
					y        : barY,
					alpha    : options.barAlpha,
					fillColor: options.minBarColor,
					width    : 0,
					height   : barHeight
				});
			}
			if (options.hasGauge) {
				/*gauge=*/
				addBitmapDataSprite({
					x          : 0,
					y          : myHeight - 10,
					width      : barWidth+2,
					height     : 10,
					stretch    : true,
					bitmapClass: StatsBarBottom
				});
			}
		}
		_nameLabel  = addTextField({
			x                : 6, y: 4,
			width            : barWidth,
			height           : myHeight - 4,
			defaultTextFormat: {
				font: 'Georgia',
				size: 15
			}
		});
		_valueLabel = addTextField({
			x                : 0, y: myHeight-30,
			width            : barWidth,
			height           : 30,
			defaultTextFormat: {
				font : 'Georgia',
				size : 20,
				align: 'right'
			}
		});
		_arrowUp    = addBitmapDataSprite({
			bitmapClass: ArrowUp,
			width      : arrowSz,
			height     : arrowSz,
			stretch    : true,
			x          : myWidth - arrowSz - 1,
			y          : 1,
			visible    : false
		});
		_arrowDown  = addBitmapDataSprite({
			bitmapClass: ArrowDown,
			width      : arrowSz,
			height     : arrowSz,
			stretch    : true,
			x          : myWidth - arrowSz - 1,
			y          : 1,
			visible    : false
		});
		UIUtils.setProperties(this, options);
		update();
	}

	public function get minValue():Number {
		return _minValue;
	}
	public function set minValue(value:Number):void {
		_minValue = value;
		update();
	}
	public function get maxValue():Number {
		return _maxValue;
	}
	public function set maxValue(value:Number):void {
		_maxValue = value;
		if (showMax) renderValue();
		update();
	}
	private function renderValue():void {
		var bValue:String = Math.floor(value).toString();
		var mValue:String = Math.floor(maxValue).toString();
		if (value > 1000000) bValue = value.toPrecision(3);
		if (maxValue > 1000000) mValue = maxValue.toPrecision(3);
		valueText = '' + bValue + (showMax ? '/' + mValue : '');
	}
	public function get value():Number {
		return _value;
	}
	public function set value(value:Number):void {
		_value    = value;
		renderValue();
		update();
	}
	public function get valueText():String {
		return _valueLabel ? _valueLabel.text : value + '';
	}
	public function set valueText(value:String):void {
		if (_valueLabel) _valueLabel.text = value;
	}
	public function update():void {
		if (_bar) {
			_bar.width = maxValue > 0 ?
					Utils.boundFloat(0, value, maxValue) * (width - arrowSz-2) / maxValue : 0;
		}
		if (_minBar) {
			_minBar.width = maxValue > 0 ?
					Utils.boundFloat(0, minValue, maxValue) * (width - arrowSz-2) / maxValue : 0;
		}
	}
	public function get showMax():Boolean {
		return _showMax;
	}
	public function set showMax(value:Boolean):void {
		_showMax = value;
		renderValue();
	}
	public function get isUp():Boolean {
		return _arrowUp.visible;
	}
	public function set isUp(value:Boolean):void {
		_arrowUp.visible = value;
		if (value) _arrowDown.visible = false;
	}
	public function get isDown():Boolean {
		return _arrowDown.visible;
	}
	public function set isDown(value:Boolean):void {
		_arrowDown.visible = value;
		if (value) _arrowUp.visible = false;
	}
	public function get statName():String {
		return _nameLabel.text;
	}
	public function set statName(value:String):void {
		_nameLabel.text = value;
	}
	public function set nameColor(value:*):void {
		var tf:TextFormat = _nameLabel.defaultTextFormat;
		tf.color = Color.convertColor(value);
		_nameLabel.defaultTextFormat = tf;
		_nameLabel.setTextFormat(tf);
	}

	public function get bar():BitmapDataSprite {
		return _bar;
	}
	public function get minBar():BitmapDataSprite {
		return _minBar;
	}
	public function get nameLabel():TextField {
		return _nameLabel;
	}
	public function get valueLabel():TextField {
		return _valueLabel;
	}
	public function get arrowUp():BitmapDataSprite {
		return _arrowUp;
	}
	public function get arrowDown():BitmapDataSprite {
		return _arrowDown;
	}
}
}
