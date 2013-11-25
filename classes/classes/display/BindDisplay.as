package classes.display 
{
	import flash.display.MovieClip;
	import flash.text.Font;
	import flash.text.TextField;
	import coc.view.CoCButton;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.AntiAliasType;
	
	import buttonBackground0;
	import ButtonLabelFont;
	
	/**
	 * ...
	 * @author Gedan
	 */
	public class BindDisplay extends MovieClip
	{
		private var _maxWidth:int;
		private var _nameLabel:TextField;
		private var _buttons:Array;
		private var _buttonBgs:Array;
		
		private var _textFormatLabel:TextFormat;
		private var _textFormatButton:TextFormat;
		private var _textFont:Font;
		
		private static const BUTTON_X_OFFSET :Number = 200;
		private static const BUTTON_Y_OFFSET :Number = 668;
		private static const BUTTON_X_DELTA :Number = 160;
		public static const BUTTON_Y_DELTA :Number = 52;
		private static const BUTTON_REAL_WIDTH :Number = 150;
		private static const BUTTON_REAL_HEIGHT :Number = 40;
		
		public function BindDisplay(maxWidth:int) 
		{
			_maxWidth = maxWidth;
			
			// TODO: This is also the kind of thing that would be handy to stuff into a global static class
			// to init global formatting objects in a central location
			InitFormatting();
			InitButtons();
			InitLabel();
		}
		
		private function InitFormatting():void
		{
			_textFont = new ButtonLabelFont();
			
			_textFormatLabel = new TextFormat();
			_textFormatLabel.font = _textFont.fontName; // Pulls in our embedded fonts from the swc to use dynamically!
			_textFormatLabel.size = 18;
			_textFormatLabel.align = TextFormatAlign.RIGHT;
			
			_textFormatButton = new TextFormat();
			_textFormatButton.font = _textFont.fontName;
			_textFormatButton.size = 18;
			_textFormatButton.align = TextFormatAlign.CENTER;
		}
		
		// TODO: This is probably the kind of code that should be moved into the CoCButton class
		// This approach would also let us remove the seperate labels from the MainView.as and 
		// roll them into the buttons themselves.
		private function InitButtons():void
		{
			_buttons = new Array();
			_buttonBgs = new Array();
			
			var b:MovieClip;
			var button:CoCButton;
			var tf:TextField;
			
			var xPos:int;
			xPos = (_maxWidth - 15) - ( 2 * BUTTON_X_DELTA);
			
			for (var i:int = 0; i < 2; i++)
			{
				b = new buttonBackground0();
				b.name = "ctrlBtn" + String(i);
				b.x = xPos;
				xPos += BUTTON_X_DELTA;
				b.y = 0;
				b.width = BUTTON_REAL_WIDTH;
				b.height = BUTTON_REAL_HEIGHT;
				
				tf = new TextField();
				tf.defaultTextFormat = _textFormatButton;
				tf.embedFonts = true;
				tf.antiAliasType = AntiAliasType.ADVANCED;
				tf.htmlText = "<b>Unbound</b>";
				
				button = new CoCButton(tf, b);
				
				_buttons.push(button);
				_buttonBgs.push(b);
				this.addChild(button);
			}
		}
		
		private function InitLabel():void
		{
			_nameLabel = new TextField();
			_nameLabel.defaultTextFormat = _textFormatLabel;
			_nameLabel.embedFonts = true;
			_nameLabel.antiAliasType = AntiAliasType.ADVANCED;
			_nameLabel.text = "THIS IS SOME KINDA CRAZY LABEL";
			_nameLabel.width = _maxWidth - ( 2 * BUTTON_X_DELTA ) - 20;
			_nameLabel.y = _buttons[0].labelField.y;
			this.addChild(_nameLabel);
		}
		
		public function get text():String
		{
			return _nameLabel.text;
		}
		
		public function set text(value:String):void
		{
			_nameLabel.text = value;
		}
		
		public function get htmlText():String
		{
			return _nameLabel.htmlText;
		}
		
		public function set htmlText(value:String):void
		{
			_nameLabel.htmlText = value;
		}
	}

}