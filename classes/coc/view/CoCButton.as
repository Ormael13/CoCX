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

	public class CoCButton extends MovieClip {

		[Embed(source="../../../res/ui/button0.jpg")]
		public static var buttonBackground0:Class;
		[Embed(source="../../../res/ui/button1.jpg")]
		public static var buttonBackground1:Class;
		[Embed(source="../../../res/ui/button2.jpg")]
		public static var buttonBackground2:Class;
		[Embed(source="../../../res/ui/button3.jpg")]
		public static var buttonBackground3:Class;
		[Embed(source="../../../res/ui/button4.jpg")]
		public static var buttonBackground4:Class;
		[Embed(source="../../../res/ui/button5.jpg")]
		public static var buttonBackground5:Class;
		[Embed(source="../../../res/ui/button6.jpg")]
		public static var buttonBackground6:Class;
		[Embed(source="../../../res/ui/button7.jpg")]
		public static var buttonBackground7:Class;
		[Embed(source="../../../res/ui/button8.jpg")]
		public static var buttonBackground8:Class;
		[Embed(source="../../../res/ui/button9.jpg")]
		public static var buttonBackground9:Class;

//		public static const ButtonLabelFontName:String = "Shrewsbury Titling Bold";
		public static const ButtonLabelFontName:String = "Palatino Linotype";

		public static const
			// How far down from the top of our registration point the TF is.
			LABEL_FIELD_Y_OFFSET:Number = 9,
			LABEL_FIELD_HEIGHT:Number = 25;

		protected var
			_labelField:TextField,
			_backgroundGraphic:Sprite,
			_callback:Function;

		public var
			toolTipHeader:String,
			toolTipText:String;

		public function CoCButton(labelField:TextField = null, backgroundGraphic:Sprite = null):void {
			if (backgroundGraphic) {
				this.x = backgroundGraphic.x;
				this.y = backgroundGraphic.y;
			}
			
			this.labelField = labelField;
			this.backgroundGraphic = backgroundGraphic;

			this.mouseChildren = true;
			this.buttonMode = true;
			this.visible = true;
			
			this.addEventListener(MouseEvent.ROLL_OVER, this.hover);
			this.addEventListener(MouseEvent.ROLL_OUT, this.dim);
			this.addEventListener(MouseEvent.CLICK, this.click);
		}



		//////// Mouse Events... ////////

		public function hover(event: MouseEvent = null):void {
			if (this.backgroundGraphic)
				this.backgroundGraphic.alpha = 0.5;
		}

		public function dim(event:MouseEvent = null):void {
			if (this.backgroundGraphic)
				this.backgroundGraphic.alpha = 1;
		}

		public function click(event:MouseEvent = null):void {
			if (this._callback != null)
				this._callback();
		}



		//////// Getters and Setters ////////

		public function get labelField():TextField {
			return this._labelField;
		}

		public function set labelField(value:TextField):void {
			// TODO: Remove previous labelField?

			this._labelField = value;

			if (! this._labelField) return;

			this.addChild(this._labelField);
			
			//Workaround for formatting
			var fmt:TextFormat = this._labelField.getTextFormat();
			fmt.bold = true;
			this._labelField.defaultTextFormat = fmt;
			
			this._labelField.mouseEnabled = false;
			
			this._labelField.x = 0;
			this._labelField.y = LABEL_FIELD_Y_OFFSET;
			this._labelField.width = this.width;
			this._labelField.height = LABEL_FIELD_HEIGHT;
		}

		public function get backgroundGraphic():Sprite {
			return this._backgroundGraphic;
		}

		public function set backgroundGraphic(value:Sprite):void {
			// TODO: Remove previous background graphic?

			this._backgroundGraphic = value;

			if (! this._backgroundGraphic) return;

			this.addChildAt(this._backgroundGraphic, 0);

			this._backgroundGraphic.mouseEnabled = true;

			this._backgroundGraphic.x = 0;
			this._backgroundGraphic.y = 0;

			this.width = this._backgroundGraphic.width;
		}

		public function get labelText():String {
			return this.labelField.text;
		}

		public function set labelText(value:String):void {
			this.labelField.text = value;
		}

		public function get callback():Function {
			return this._callback;
		}

		public function set callback(value:Function):void {
			this._callback = value;
		}

		//// Overrides. ////
		override public function get width():Number {
			return this.backgroundGraphic ? this.backgroundGraphic.width: 0;
		}

		override public function set width(value:Number):void {
			if (this.backgroundGraphic)
				this.backgroundGraphic.width = value;

			if (this.labelField)
				this.labelField.width = value;
		}

		override public function get height():Number {
			return this.backgroundGraphic ? this.backgroundGraphic.height: 0;
		}

		override public function set height(value:Number):void {
			if (this.backgroundGraphic)
				this.backgroundGraphic.height = value;
			// TODO: Do anything to the text field?
		}
	}
}