/**
 * Coded by aimozg on 06.06.2017.
 */
package coc.view {
import classes.internals.Utils;

import flash.text.TextField;

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
			barHeight  : 28,
			barColor   : '#0000ff',
			minBarColor: '#8080ff'
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

	/**
	 * options.width      : default 200
	 * options.height     : default 30
	 * options.minValue   : default 0
	 * options.maxValue   : default 100
	 * options.value      : default 0
	 * options.statName   : default ""
	 * options.showMax    : default false
	 * options.isUp       : default false
	 * options.isDown     : default false
	 * options.hasGauge   : default true
	 * options.hasBar     : default true
	 * options.hasMinBar  : default false
	 * options.barAlpha   : default 0.4
	 * options.barHeight  : default 28
	 * options.barColor   : default '#0000ff'
	 * options.minBarColor: default '#8080ff'
	 */
	public function StatBar(options:Object) {
		super();
		options          = Utils.extend({},DEFAULT_OPTIONS, options);
		var arrowSz:Number = options.height-2;
		var barWidth:Number = options.width-arrowSz-2;
		if (options.hasBar) {
			_bar = addBitmapDataSprite({
				x        : 1,
				y        : options.height - options.barHeight,
				alpha    : options.barAlpha,
				fillColor: options.barColor,
				width    : 0,
				height   : options.barHeight
			});
			if (options.hasMinBar) {
				_minBar = addBitmapDataSprite({
					x        : _bar.x,
					y        : y,
					alpha    : options.barAlpha,
					fillColor: options.minBarColor,
					width    : 0,
					height   : _bar.height
				});
			}
			if (options.hasGauge) {
				/*gauge=*/
				addBitmapDataSprite({
					x          : 0,
					y          : options.height - 10,
					width      : barWidth,
					height     : 10,
					stretch    : true,
					bitmapClass: StatsBarBottom
				});
			}
		}
		_nameLabel  = addTextField({
			x:6,y:4,
			width: barWidth,
			height:options.height,
			defaultTextFormat: {
				font: 'Georgia',
				size: 15
			}
		});
		_valueLabel = addTextField({
			x:0,y:0,
			width: barWidth-4,
			height: options.height,
			defaultTextFormat: {
				font: 'Georgia',
				size: 22,
				align: 'right'
			}
		});
		_arrowUp = addBitmapDataSprite({
			bitmapClass: ArrowUp,
			width: arrowSz,
			height: arrowSz,
			stretch: true,
			x: 1+(options.width-arrowSz),
			y: 1,
			visible: false
		});
		_arrowDown = addBitmapDataSprite({
			bitmapClass: ArrowDown,
			width: arrowSz,
			height: arrowSz,
			stretch: true,
			x: 1+(options.width-arrowSz),
			y: 1,
			visible: false
		});
		UIUtils.setProperties(this,options);
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
		valueText = '' + Math.floor(value) + (showMax ? '/' + Math.floor(maxValue) : '');
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
