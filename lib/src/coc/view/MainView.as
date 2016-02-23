/****
	coc.view.MainView

	I have no real idea yet what eventTestInput is for,
	but its coordinates get tested for in places, and set in others.
	Perhaps some day I'll ask.

	It's for allowing people to test stuff in the parser. It gets moved into view, and you 
	can enter stuff in the text window, which then gets fed through the parser.

	That's good to know.  Cheers.
****/

package coc.view {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.Font;
	import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import fl.controls.ComboBox; 
	import fl.data.DataProvider; 

    //import coc.model.GameModel;

    import buttonBackground0;
    import buttonBackground1;
    import buttonBackground2;
    import buttonBackground3;
    import buttonBackground4;
    import buttonBackground5;
    import buttonBackground6;
    import buttonBackground7;
    import buttonBackground8;
    import buttonBackground9;

	public class MainView extends MovieClip {
		// Menu button names.
		public static const MENU_NEW_MAIN:String = 'newGame';
		public static const MENU_DATA:String = 'data';
		public static const MENU_STATS:String = 'stats';
		public static const MENU_LEVEL:String = 'level';
		public static const MENU_PERKS:String = 'perks';
		public static const MENU_APPEARANCE:String = 'appearance';

		private static const BOTTOM_BUTTON_COUNT:int = 15;
		private static const BOTTOM_BUTTON_PER_ROW_COUNT:int = 5;

		private static const BUTTON_X_OFFSET:Number = 200;
		private static const BUTTON_Y_OFFSET:Number = 668;
		private static const BUTTON_X_DELTA:Number = 160;
		private static const BUTTON_Y_DELTA:Number = 45;
		private static const BUTTON_REAL_WIDTH:Number = 150;
		private static const BUTTON_REAL_HEIGHT:Number = 40;

		public var aCb:ComboBox;
		public var nameBox:TextField;

		//// Actual buttons.
		public var bottomButtons:Array;
		public var newGameButton:CoCButton;
		public var dataButton:CoCButton;
		public var statsButton:CoCButton;
		public var levelButton:CoCButton;
		public var perksButton:CoCButton;
		public var appearanceButton:CoCButton;

		public var bottomButtonTexts:Array; // <TextField>
		public var bottomButtonBGs:Array; // <MovieClip>
		public var menuButtonTexts:Array;
		public var menuButtonBGs:Array;
		private var currentActiveButtons:Array;

		public var toolTipView:ToolTipView;
		public var statsView:StatsView;

		public var sideBarDecoration:Sprite;
		
		protected var options:Object;
		// protected var allButtonTexts:Array;
		protected var allButtons:Array;
		protected var callbacks:Object = {}

		//protected var model:GameModel;
		
		public var
			newGameBG:MovieClip, 
			dataBG:MovieClip, 
			statsBG:MovieClip, 
			levelBG:MovieClip, 
			perksBG:MovieClip, 
			appearanceBG:MovieClip;

		public function MainView(/*model:GameModel = null, options:Object = null*/):void {
			// Note: Currently we can't touch this on construction
			// due to the code being a mess.  We'll fix that at some point.
			// maybe even get like update events or some shit like real MV*s or something.
			//this.model = model;
			//this.options = options || {} Is this even used?
			super();

			/*if (! model) {
				trace("MainView/constructor: Game model not passed in.  Don't publish MainView.fla with Ctrl-Enter/Cmd-Enter.  Rather, go to File > Publish to build the SWC.");
				throw new ArgumentError("MainView/constructor: MainView must be constructed with a GameModel as its first argument.");
			}*/

			// Init subviews.
			this.statsView = new StatsView(this/*, this.model*/);
			this.statsView.hide();
			this.addChild(this.statsView);
			
			this.toolTipView = new ToolTipView(this/*, this.model*/);
			this.toolTipView.hide();
			this.addChild(this.toolTipView);

			this.formatMiscItems();

			this.allButtons = [];
			
			createBottomButtons();
			createMenuButtons();

			// disable interaction for any remaining TFs.
			disableMouseForMostTextFields();

			// hook!
			hookBottomButtons();
			hookAllButtons();
		}



		//////// Initialization methods. /////////

		protected function formatMiscItems():void {
			// this.mainText = this.getChildByName("mainText");

			this.nameBox.maxChars = 54;

			this.sideBarDecoration = getChildByName("statsBarMarker") as Sprite;
			
			this.aCb = new ComboBox(); 
			this.aCb.dropdownWidth = 200; 
			this.aCb.width = 200; 
			this.aCb.scaleY = 1.1;
			this.aCb.move(-1250, -1550); 
			this.aCb.prompt = "Choose a perk"; 
			this.addChild(this.aCb);

			this.hideSprite();
		}

		// Removes the need for some code in input.as and InitializeUI.as.
		protected function disableMouseForMostTextFields():void {
			var ci:int, t:TextField;

			for(ci = 0; ci < this.numChildren; ++ci) {
				t = this.getChildAt(ci) as TextField;

				if (! t) {
					continue;
				}

				switch(t) {
					case this.mainText:
					case this.nameBox:
					case this.eventTestInput:
						t.mouseEnabled = true;
						break;

					default:
						t.mouseEnabled = false;
						break;
				}
			}
		}

		// This creates the bottom buttons,
		// positions them,
		// and also assigns their index to a bottomIndex property on them.
		protected function createBottomButtons():void {
			var b:MovieClip, bgClasses:Array,
				bi:int, r:int, c: int,
				backgroundChildIndex:int,
				button:CoCButton;

			this.bottomButtonBGs = [];
			this.bottomButtons = [];
			bgClasses = [
				buttonBackground0,
				buttonBackground1,
				buttonBackground2,
				buttonBackground3,
				buttonBackground4,
				buttonBackground5,
				buttonBackground6,
				buttonBackground7,
				buttonBackground8,
				buttonBackground9];

			backgroundChildIndex = this.getChildIndex(background);
			//var originalTextFormat:TextFormat = this.toolTipView.hd.getTextFormat();
			var buttonFont:Font = new ButtonLabelFont();
			for (bi = 0; bi < BOTTOM_BUTTON_COUNT; ++bi) {
				b = new (bgClasses[bi % 10])();
				b.name = 'b' + String((bi + 1) % 10) + 'BG';

				r = (bi / BOTTOM_BUTTON_PER_ROW_COUNT) << 0;
				c = bi % BOTTOM_BUTTON_PER_ROW_COUNT;

				b.x = BUTTON_X_OFFSET + c * BUTTON_X_DELTA;
				b.y = BUTTON_Y_OFFSET + r * BUTTON_Y_DELTA;
				b.width = BUTTON_REAL_WIDTH;   //The button symbols are actually 135 wide
				b.height = BUTTON_REAL_HEIGHT; //and 38 high. Not sure why the difference here.
				//Create new TextField.
				var labelText:TextField = new TextField();
				labelText.x = b.x + 2;
				labelText.y = b.y + 2;
				labelText.width = b.width - 4;
				labelText.height = b.height - 4;
				labelText.embedFonts = true;
				//Create format.
				var labelFormat:TextFormat = new TextFormat();
				labelFormat.font = buttonFont.fontName;
				labelFormat.bold = true;
				labelFormat.align = TextFormatAlign.CENTER;
				labelFormat.size = 18;
				//Assign text format.
				labelText.defaultTextFormat = labelFormat;
				//Create button and push.
				button = new CoCButton(labelText, b);
				this.bottomButtonBGs.push(b);
				this.bottomButtons.push(button);
				this.addChildAt(button, backgroundChildIndex + 1);
			}
			this.allButtons = this.allButtons.concat(this.bottomButtons);
		}

		protected function createMenuButtons():void {
			var btf:TextField, bbg:MovieClip,
				bn:String,
				backgroundChildIndex:int,
				buttonNames:Array,
				button:CoCButton;

			buttonNames = [
				MENU_NEW_MAIN,
				MENU_DATA,
				MENU_STATS,
				MENU_LEVEL,
				MENU_PERKS,
				MENU_APPEARANCE
			];

			backgroundChildIndex = this.getChildIndex(background);

			for each(bn in buttonNames) {
				button =
					new CoCButton(
						// second case is for levelBG.
						(this.getChildByName(bn + 'Text2') || this.getChildByName(bn + 'Text')) as TextField,
						(this.getChildByName(bn + 'BG2')   || this.getChildByName(bn + 'BG')) as MovieClip
					);

				this[bn + "Button"] = button
				this.allButtons.push(button);
				this.addChildAt(button, backgroundChildIndex + 1);
			}
		}

		protected function hookBottomButtons():void {
			var bi:MovieClip;
			for each(bi in this.bottomButtons) {
				bi.addEventListener(MouseEvent.CLICK, this.executeBottomButtonClick);
			}
		}

		protected function hookAllButtons() {
			var b:MovieClip;

			for each(b in this.allButtons) {
				b.mouseChildren = false;
				b.addEventListener(MouseEvent.ROLL_OVER, this.hoverButton);
				b.addEventListener(MouseEvent.ROLL_OUT, this.dimButton);
			}
		}

		//////// Internal(?) view update methods ////////

		public function showBottomButton(index:int, label:String, callback:Function = null, toolTipViewText:String = '', toolTipViewHeader:String = ''):void {
			var button:CoCButton = this.bottomButtons[index] as CoCButton;

			if (!button) return;
			button.labelText = label;
			button.callback = callback;
			button.toolTipHeader = toolTipViewHeader;
			button.toolTipText = toolTipViewText;
			button.visible = true;
			button.enabled = true;
		}

		public function showBottomButtonDisabled(index:int, label:String, toolTipViewText:String = '', toolTipViewHeader:String = ''):void {
			var button:CoCButton = this.bottomButtons[index] as CoCButton;
			
			if (!button) return;
			button.labelText = label;
			button.callback = null;
			button.toolTipHeader = toolTipViewHeader;
			button.toolTipText = toolTipViewText;
			button.alpha = 0.4;
			button.visible = true;
			button.enabled = false;
		}
		
		public function hideBottomButton(index:int) {
			var button:CoCButton = this.bottomButtons[index] as CoCButton;

			// Should error.
			if (!button) return;

			button.visible = false;
		}

			public function hideCurrentBottomButtons():void
			{
				this.currentActiveButtons = new Array();
				
				for (var i:int = 0; i < BOTTOM_BUTTON_COUNT; i++)
				{
					var button:CoCButton = this.bottomButtons[i] as CoCButton;
					
					if (button.visible == true)
					{
						this.currentActiveButtons.push(i);
						button.visible = false;
					}
				}
			}
			
			public function showCurrentBottomButtons():void
			{
				if (!this.currentActiveButtons) return;
				if (currentActiveButtons.length == 0) return;
				
				for (var i:int = 0; i < currentActiveButtons.length; i++)
				{
					var btnIdx = currentActiveButtons[i];
					var button:CoCButton = this.bottomButtons[btnIdx] as CoCButton;
					
					button.visible = true;
				}
			}

		//////// Internal event handlers ////////

		protected function textForBG(bg:DisplayObject):TextField {
			var textName:String;

			if (! bg) {
				throw new ArgumentError("MainView.textForBG() must be called with a DisplayObject as its argument.");
			}

			textName = bg.name.replace(/BG$/, 'Text');

			if (bg.name == 'levelBG')
				textName += '2';

			return this[textName] as TextField;
		}

		protected function executeBottomButtonClick(event:Event) {
			this.toolTipView.hide();
		}

		protected function hoverButton(event:MouseEvent) {
			var button:CoCButton;

			button = event.target as CoCButton;

			if (button && button.visible && button.toolTipText) {
				this.toolTipView.header = button.toolTipHeader;
				this.toolTipView.text = button.toolTipText;
				this.toolTipView.showForButton(button);
			}
			else {
				this.toolTipView.hide();
			}
		}

		protected function dimButton(event:MouseEvent) {
			this.toolTipView.hide();
		}



		//////// Bottom Button Methods ////////

		// TODO: Refactor button set-up code to use callback and toolTipViewText here.
		public function setButton(index:int, label:String = '', callback:Function = null, toolTipViewText:String = '') {
			if (index < 0 || index >= BOTTOM_BUTTON_COUNT) {
				trace("MainView.setButton called with out of range index:", index);
				// throw new RangeError();
				return;
			}

			if (label) {
				this.showBottomButton(index, label, callback, toolTipViewText);
			}
			else {
				this.hideBottomButton(index);
			}
		}

		// There was one case where the label needed to be set but I could not determine from context whether the button should be shown or not...
		public function setButtonText(index:int, label:String):void {
			this.bottomButtons[index].labelText = label;
		}

		public function hasButton(labelText:String):Boolean {
			var b:TextField;

			return this.indexOfButtonWithLabel(labelText) !== -1;
		}

		public function indexOfButtonWithLabel(labelText:String):int {
			var i:int;

			for(i = 0; i < this.bottomButtons.length; ++i) {
				if (this.getButtonText(i) === labelText)
					return i;
			}

			return -1;
		}

		public function clearBottomButtons():void {
			var i:int;

			for(i = 0; i < BOTTOM_BUTTON_COUNT; ++i) {
				this.setButton(i);
			}
		}

		public function getButtonText(index:int):String {
//			var matches:*;

			if (index < 0 || index > BOTTOM_BUTTON_COUNT) {
				return '';
			}
			else {
				return this.bottomButtons[index].labelText;
			}
		}

		public function clickButton(index:int):void {
			this.bottomButtons[index].click();
		}

		// This function checks if the button at index has text
		// that matches at least one of the possible texts passed as an argument.
		public function buttonTextIsOneOf(index:int, possibleLabels:Array):Boolean {
			var label:String,
				buttonText:String;

			buttonText = this.getButtonText(index);

			return (possibleLabels.indexOf(buttonText) != -1);
		}

		public function buttonIsVisible(index:int):Boolean {
			if (index < 0 || index > BOTTOM_BUTTON_COUNT) {
				return undefined;
			}
			else {
				return this.bottomButtons[index].visible;
			}
		}



		//////// Menu Button Methods ////////

		protected function getMenuButtonByName(name:String):CoCButton {
			return this[name + 'Button'] as CoCButton;
		}

		////////

		public function setMenuButton(name:String, label:String = '', callback:Function = null):void {
			var button:CoCButton = this.getMenuButtonByName(name);

			if (! button) {
				throw new ArgumentError("MainView.setMenuButton: Invalid menu button name: " + String(name));
			}

			if (label) {
				button.labelText = label;
				button.toolTipHeader = label;
			}

			if (callback != null) {
				button.callback = callback;
			}
		}

		public function set onNewGameClick(callback:Function):void {
			this.newGameButton.callback = callback;
		}

		public function set onDataClick(callback:Function):void {
			this.dataButton.callback = callback;
		}

		public function set onStatsClick(callback:Function):void {
			this.statsButton.callback = callback;
		}

		public function set onLevelClick(callback:Function):void {
			this.levelButton.callback = callback;
		}

		public function set onPerksClick(callback:Function):void {
			this.perksButton.callback = callback;
		}

		public function set onAppearanceClick(callback:Function):void {
			this.appearanceButton.callback = callback;
		}

		public function showMenuButton(name:String):void {
			var button:CoCButton = this.getMenuButtonByName(name);
			button.visible = true;
		}

		public function hideMenuButton(name:String):void {
			var button:CoCButton = this.getMenuButtonByName(name);
			button.visible = false;
		}

		public function showAllMenuButtons() {
			this.showMenuButton(MENU_NEW_MAIN);
			this.showMenuButton(MENU_DATA);
			this.showMenuButton(MENU_STATS);
			this.showMenuButton(MENU_LEVEL);
			this.showMenuButton(MENU_PERKS);
			this.showMenuButton(MENU_APPEARANCE);
		}

		public function hideAllMenuButtons() {
			this.hideMenuButton(MENU_NEW_MAIN);
			this.hideMenuButton(MENU_DATA);
			this.hideMenuButton(MENU_STATS);
			this.hideMenuButton(MENU_LEVEL);
			this.hideMenuButton(MENU_PERKS);
			this.hideMenuButton(MENU_APPEARANCE);
		}

		public function menuButtonIsVisible(name:String):Boolean {
			return this.getMenuButtonByName(name).visible;
		}

		public function menuButtonHasLabel(name:String, label:String):Boolean {
			return this.getMenuButtonByName(name).labelText == label;
		}



		//////// misc... ////////

		public function invert():void {
			if (! this.blackBackground.visible) {
				this.blackBackground.visible = true;
			}
			else {
				this.blackBackground.visible = false;
			}
		}

		public function clearOutputText():void {
			this.mainText.htmlText = '';
			this.scrollBar.update();
		}

		public function appendOutputText(text:String):void {
			this.mainText.htmlText += text;
			this.scrollBar.update();
		}

		public function setOutputText(text:String):void {
			// Commenting out for now, because this is annoying to see flooding the trace.
			// trace("MainView#setOutputText(): This is never called in the main outputText() function.  Possible bugs that were patched over by updating text manually?");
			this.mainText.htmlText = text;
			this.scrollBar.update();
		}

		public function selectSprite(index:Number = 0, type:int = 0):void {
			var scale:Number;

			// TODO: When flags goes away, if it goes away, replace this with the appropriate settings thing.
			if (index < 0) { // = SHOW_SPRITES_FLAG from flagDefs...
				this.sprite.visible = false;
				this.spriteOld.visible = false;
			}
			else {
				if (type == 0) {
					this.sprite.visible = true;
					this.sprite.gotoAndStop(index);

					this.sprite.scaleX = 1;
					this.sprite.scaleY = 1;
					scale = 80 / this.sprite.height;
					this.sprite.scaleX = scale;
					this.sprite.scaleY = scale;
				}
				else if (type == 1) {
					this.spriteOld.visible = true;
					this.spriteOld.gotoAndStop(index);

					this.spriteOld.scaleX = 1;
					this.spriteOld.scaleY = 1;
					scale = 80 / this.spriteOld.height;
					this.spriteOld.scaleX = scale;
					this.spriteOld.scaleY = scale;
				}
			}
		}

		public function hideSprite():void {
			this.selectSprite(-1);
		}

		public function showTestInputPanel():void
		{
			this.eventTestInput.x = 207.5;
			this.eventTestInput.y = 55.1;
			
			this.mainText.visible = false;

			this.eventTestInput.selectable = true;
			this.eventTestInput.type = TextFieldType.INPUT;
			this.eventTestInput.visible = true;

			this.scrollBar.scrollTarget = this.eventTestInput;

		}

		public function hideTestInputPanel():void
		{

			this.eventTestInput.x = -10207.5;
			this.eventTestInput.y = -1055.1;
			
			this.mainText.visible = true;


			this.eventTestInput.selectable = false;
			this.eventTestInput.type = TextFieldType.DYNAMIC;
			this.eventTestInput.visible = false;

			this.scrollBar.scrollTarget = this.mainText;

		}
	}
}