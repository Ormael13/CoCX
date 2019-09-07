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
import coc.view.UIUtils;

import fl.controls.ComboBox;
import fl.controls.ScrollBarDirection;
import fl.controls.UIScrollBar;
import fl.data.DataProvider;

import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.text.TextField;

public class MainView extends Block {
	[Embed(source="../../../res/ui/background1.png")]
	public static var Background1:Class;
	[Embed(source="../../../res/ui/background2.png")]
	public static var Background2:Class;
	[Embed(source="../../../res/ui/background3.png")]
	public static var Background3:Class;
	[Embed(source="../../../res/ui/background4.png")]
	public static var Background4:Class;
	[Embed(source="../../../res/ui/backgroundKaizo.png")]
	public static var BackgroundKaizo:Class;
	public static var Backgrounds:Array = [Background1, Background2, Background3, Background4, null, BackgroundKaizo];

	[Embed(source="../../../res/ui/button0.jpg")]
	public static var ButtonBackground0:Class;
	[Embed(source="../../../res/ui/button1.jpg")]
	public static var ButtonBackground1:Class;
	[Embed(source="../../../res/ui/button2.jpg")]
	public static var ButtonBackground2:Class;
	[Embed(source="../../../res/ui/button3.jpg")]
	public static var ButtonBackground3:Class;
	[Embed(source="../../../res/ui/button4.jpg")]
	public static var ButtonBackground4:Class;
	[Embed(source="../../../res/ui/button5.jpg")]
	public static var ButtonBackground5:Class;
	[Embed(source="../../../res/ui/button6.jpg")]
	public static var ButtonBackground6:Class;
	[Embed(source="../../../res/ui/button7.jpg")]
	public static var ButtonBackground7:Class;
	[Embed(source="../../../res/ui/button8.jpg")]
	public static var ButtonBackground8:Class;
	[Embed(source="../../../res/ui/button9.jpg")]
	public static var ButtonBackground9:Class;
	public static var ButtonBackgrounds:Array = [
		ButtonBackground0,
		ButtonBackground1,
		ButtonBackground2,
		ButtonBackground3,
		ButtonBackground4,
		ButtonBackground5,
		ButtonBackground6,
		ButtonBackground7,
		ButtonBackground8,
		ButtonBackground9,
	];


	// Menu button names.
	public static const MENU_NEW_MAIN:String   = 'newGame';
	public static const MENU_DATA:String       = 'data';
	public static const MENU_STATS:String      = 'stats';
	public static const MENU_LEVEL:String      = 'level';
	public static const MENU_PERKS:String      = 'perks';
	public static const MENU_APPEARANCE:String = 'appearance';


	public static const GAP:Number   = 4; // Gap between UI panels
	internal static const BTN_W:Number = 150; // Button size
	internal static const BTN_H:Number = 40;

	internal static const SCREEN_W:Number       = 1200;
	internal static const SCREEN_H:Number       = 800;

	// TOPROW: [Main Menu]/[New Game], [Data] ... [Appearance]

	// [ TOP ROW           ] -empty-
	// [STATBAR] [TEXT ZONE] -empty-
	// [STATBAR] [ BUTTONS ] [SPRITE]

	// Top Row.
	internal static const TOPROW_X:Number       = GAP; // left = screen left
	internal static const TOPROW_Y:Number       = GAP; // top = screen top
	internal static const TOPROW_H:Number       = BTN_H + 2 * GAP; // height = button height
	internal static const TOPROW_BOTTOM:Number  = TOPROW_Y+TOPROW_H;
	// width = statbar width + textzone width, so calculated later
	internal static const TOPROW_NUMBTNS:Number = 6;
	// Stats panel
	internal static const STATBAR_X:Number = GAP; // left = screen left
	internal static const STATBAR_Y:Number = TOPROW_BOTTOM; // top = toprow bottom
	internal static const STATBAR_W:Number = 205; // width = const
	internal static const STATBAR_H:Number = SCREEN_H - STATBAR_Y - GAP; // height = all remaining space
	internal static const STATBAR_RIGHT:Number = STATBAR_X + STATBAR_W + GAP;
	// Text area
	/*
	// I'd like to have the position calculable, but the borders are part of the bg picture so have to use magic numbers
	internal static const TEXTZONE_X:Number = STATBAR_RIGHT; // left = statbar right
	internal static const TEXTZONE_Y:Number = TOPROW_BOTTOM; // top = toprow bottom
	internal static const TEXTZONE_W:Number = 770; // width = const
	internal static const TEXTZONE_H:Number = SCREEN_H - TOPROW_H - BOTTOM_H; // height = screen height - toprow height - buttons height, so calculated later
	 */
	internal static const TEXTZONE_X:Number = 208; // left = const
	internal static const TEXTZONE_Y:Number = 52; // top = const
	internal static const TEXTZONE_W:Number = 769; // width = const
	internal static const VSCROLLBAR_W:Number = 15;
	internal static const TEXTZONE_H:Number = 602; // height = const
	// Sprite (bottom right)
	internal static const SPRITE_W:Number = 80;
	internal static const SPRITE_H:Number = 80;
	internal static const SPRITE_X:Number = SCREEN_W - SPRITE_W - GAP; // right = screen right
	internal static const SPRITE_Y:Number = SCREEN_H - SPRITE_H - GAP; // bottom = screen bottom
	// toprow width = statbar width + textzone width, so calculated later
	internal static const TOPROW_W:Number = TEXTZONE_X + TEXTZONE_W;
	// Bottom buttons
	internal static const BOTTOM_X:Number         = STATBAR_RIGHT; // left = statbar right
	internal static const BOTTOM_COLS:Number      = 5;
	internal static const BOTTOM_ROWS:Number      = 3;
	internal static const BOTTOM_BUTTON_COUNT:int = BOTTOM_COLS * BOTTOM_ROWS;
	internal static const BOTTOM_H:Number         = (GAP + BTN_H) * BOTTOM_ROWS; // height = rows x button height
	internal static const BOTTOM_W:Number         = TEXTZONE_W; // width = textzone width
	internal static const BOTTOM_HGAP:Number      = (BOTTOM_W - BTN_W * BOTTOM_COLS) / (2 * BOTTOM_COLS); // between btns
	internal static const BOTTOM_Y:Number         = SCREEN_H - BOTTOM_H; // bottom = screen bottom
	internal static const MONSTER_X:Number        = TEXTZONE_X + MainView.TEXTZONE_W + GAP;
	internal static const MONSTER_Y:Number        = TEXTZONE_Y;
	internal static const MONSTER_W:Number        = SCREEN_W - MONSTER_X;
	internal static const MONSTER_H:Number        = TEXTZONE_H;

	private var blackBackground:BitmapDataSprite;
	public var textBGWhite:BitmapDataSprite;
	public var textBGTan:BitmapDataSprite;
	public var background:BitmapDataSprite;
	public var sprite:BitmapDataSprite;

	public var mainText:TextField;
	public var nameBox:TextField;
	public var eventTestInput:TextField;
	public var aCb:ComboBox;
	private var comboboxHandler:Function;

	public var toolTipView:ToolTipView;
	public var statsView:StatsView;
	public var monsterStatsView:MonsterStatsView;
	public var sideBarDecoration:Sprite;

	private var _onBottomButtonClick:Function;//(index:int)=>void
	public var bottomButtons:Array;
	private var currentActiveButtons:Array;
	private var allButtons:Array;
	private var topRow:Block;
	public var newGameButton:CoCButton;
	public var dataButton:CoCButton;
	public var statsButton:CoCButton;
	public var levelButton:CoCButton;
	public var perksButton:CoCButton;
	public var appearanceButton:CoCButton;
	public var scrollBar:UIScrollBar;

	protected var callbacks:Object = {};
	protected var options:Object;

	public var charView:CharView;
	public function MainView():void {
		super();
		addElement(blackBackground = new BitmapDataSprite({
			bitmapClass: ButtonBackground2,
			x          : -SCREEN_W / 2,
			width      : SCREEN_W * 2,
			height     : SCREEN_H * 2,
			y          : -SCREEN_H / 2,
			fillColor  : '#000000'
		}), {});
		addElement(background = new BitmapDataSprite({
			bitmapClass: Background1,
			width      : SCREEN_W,
			height     : SCREEN_H,
			fillColor  : 0,
			repeat     : true
		}));
		addElement(topRow = new Block({
			x           : TOPROW_X,
			y           : TOPROW_Y,
			width       : TOPROW_W,
			height      : TOPROW_H,
			layoutConfig: {
				type   : 'grid',
				cols   : 6,
				padding: GAP
			}
		}));
		topRow.addElement(newGameButton = new CoCButton({
			labelText  : 'New Game',
			bitmapClass: ButtonBackground1
		}));
		topRow.addElement(dataButton = new CoCButton({
			labelText  : 'Data',
			bitmapClass: ButtonBackground2
		}));
		topRow.addElement(statsButton = new CoCButton({
			labelText  : 'Stats',
			bitmapClass: ButtonBackground3
		}));
		topRow.addElement(levelButton = new CoCButton({
			labelText  : 'Level Up',
			bitmapClass: ButtonBackground4
		}));
		topRow.addElement(perksButton = new CoCButton({
			labelText  : 'Perks',
			bitmapClass: ButtonBackground5
		}));
		topRow.addElement(appearanceButton = new CoCButton({
			labelText  : 'Appearance',
			bitmapClass: ButtonBackground6
		}));
		addElement(textBGWhite = new BitmapDataSprite({
			fillColor: '#FFFFFF',
			x        : TEXTZONE_X,
			y        : TEXTZONE_Y,
			width    : TEXTZONE_W,
			height   : TEXTZONE_H
		}));
		addElement(textBGTan = new BitmapDataSprite({
			fillColor: '#EBD5A6',
			x        : TEXTZONE_X,
			y        : TEXTZONE_Y,
			width    : TEXTZONE_W,
			height   : TEXTZONE_H
		}));
		mainText       = addTextField({
			multiline        : true,
			wordWrap         : true,
			x                : TEXTZONE_X,
			y                : TEXTZONE_Y,
			width            : TEXTZONE_W - VSCROLLBAR_W,
			height           : TEXTZONE_H,
			mouseEnabled     : true,
			defaultTextFormat: {
				size: 20
			}
		});
		scrollBar = new UIScrollBar();
		UIUtils.setProperties(scrollBar,{
			name: "scrollBar",
			direction: "vertical",
			scrollTarget: mainText,
			x: mainText.x + mainText.width,
			y: mainText.y,
			height: mainText.height,
			width: VSCROLLBAR_W
		});
		addElement(scrollBar);
		nameBox        = addTextField({
			border      : true,
			background  : '#FFFFFF',
			type        : 'input',
			visible     : false,
			width       : 160,
			height      : 25,
			defaultTextFormat: {
				size: 16,
				font: 'Arial'
			}
		});
		eventTestInput = addTextField({
			type             : 'input',
			background       : '#FFFFFF',
			border           : 'true',
			visible          : false,
			text             : 'Paste event text & codes here.',
			x                : TEXTZONE_X,
			y                : TEXTZONE_Y,
			width            : TEXTZONE_W - VSCROLLBAR_W - GAP,
			height           : TEXTZONE_H - GAP,
			defaultTextFormat: {
				size: 16,
				font: 'Arial'
			}
		});
		// Init subviews.
		this.statsView = new StatsView(this/*, this.model*/);
		this.statsView.hide();
		this.addElement(this.statsView);

		this.monsterStatsView = new MonsterStatsView(this);
		this.monsterStatsView.hide();
		this.addElement(this.monsterStatsView);
		
		addElement(sprite = new BitmapDataSprite({
			x      : SPRITE_X,
			y      : SPRITE_Y,
			stretch: true
		}));

		this.formatMiscItems();

		this.allButtons = [];

		createBottomButtons();
		var button:CoCButton;
		for each (button in [newGameButton, dataButton, statsButton, levelButton, perksButton, appearanceButton]) {
			this.allButtons.push(button);
		}
		this.toolTipView = new ToolTipView(this/*, this.model*/);
		this.toolTipView.hide();
		this.addElement(this.toolTipView);

		// hook!
		hookBottomButtons();
		hookAllButtons();
		this.width  = SCREEN_W;
		this.height = SCREEN_H;
		this.scaleX = 1;
		this.scaleY = 1;
		charView         = new CharView();
		charView.name    = "charview";
//		this.charView.x       = TEXTZONE_X + TEXTZONE_W + GAP;
//		this.charView.y       = TEXTZONE_Y;
		charView.visible = false;
//		addElement(charView);
	}

	/*override public function get width():Number {
	 return 1000;
	 }
	 override public function get height():Number {
	 return 800;
	 }
	 override public function get scaleX():Number {
	 return 1;
	 }*/
//////// Initialization methods. /////////

	protected function formatMiscItems():void {

		this.aCb               = new ComboBox();
		this.aCb.dropdownWidth = 200;
		this.aCb.width         = 200;
		this.aCb.scaleY        = 1.1;
		this.aCb.rowCount = 15;
		this.aCb.move(-1250, -1550);
		this.aCb.addEventListener(Event.CHANGE, function (event:Event):void {
			if (comboboxHandler != null) comboboxHandler(ComboBox(event.target).selectedItem);
		});

		this.hideSprite();
	}

	// Removes the need for some code in input.as and InitializeUI.as.

	// This creates the bottom buttons,
	// positions them,
	// and also assigns their index to a bottomIndex property on them.
	protected function createBottomButtons():void {
		var b:Sprite,
			bi:int, r:int, c:int,
			button:CoCButton;

		this.bottomButtons = [];

		//var originalTextFormat:TextFormat = this.toolTipView.hd.getTextFormat();
//		var buttonFont:Font  = new ButtonLabelFont();
		for (bi = 0; bi < BOTTOM_BUTTON_COUNT; ++bi) {
			r = (bi / BOTTOM_COLS) << 0;
			c = bi % BOTTOM_COLS;

//			b.x      = BUTTON_X_OFFSET + c * BUTTON_X_DELTA;
//			b.y      = BUTTON_Y_OFFSET + r * BUTTON_Y_DELTA;
//			b.width  = BUTTON_REAL_WIDTH;   //The button symbols are actually 135 wide
//			b.height = BUTTON_REAL_HEIGHT; //and 38 high. Not sure why the difference here.

			button = new CoCButton({
				bitmapClass: ButtonBackgrounds[bi % 10],
				visible    : false,
				x          : BOTTOM_X + BOTTOM_HGAP + c * (BOTTOM_HGAP * 2 + BTN_W),
				y          : BOTTOM_Y + r * (GAP + BTN_H)
			});
			button.preCallback = (function(i:int):Function{
				return function(b:CoCButton):void{
					if (_onBottomButtonClick != null) _onBottomButtonClick(i);
				};
			})(bi);
			this.bottomButtons.push(button);
			this.addElement(button);
		}
		this.allButtons = this.allButtons.concat(this.bottomButtons);
	}

	protected function hookBottomButtons():void {
		var bi:Sprite;
		for each(bi in this.bottomButtons) {
			bi.addEventListener(MouseEvent.CLICK, this.executeBottomButtonClick);
		}
	}

	protected function hookAllButtons():void {
		var b:Sprite;

		for each(b in this.allButtons) {
			b.mouseChildren = false;
			b.addEventListener(MouseEvent.ROLL_OVER, this.hoverButton);
			b.addEventListener(MouseEvent.ROLL_OUT, this.dimButton);
		}
	}

	//////// Internal(?) view update methods ////////

	public function showBottomButton(index:int, label:String, callback:Function = null, toolTipViewText:String = '', toolTipViewHeader:String = ''):CoCButton {
		var button:CoCButton = this.bottomButtons[index] as CoCButton;

		if (!button) return null;
		button.labelText     = label;
		button.callback      = callback;
		button.toolTipHeader = toolTipViewHeader;
		button.toolTipText   = toolTipViewText;
		button.visible       = true;
		button.enabled       = true;
		button.alpha         = 1; // failsafe to avoid possible problems with dirty hack
		return button;
	}

	public function showBottomButtonDisabled(index:int, label:String, toolTipViewText:String = '', toolTipViewHeader:String = ''):CoCButton {
		var button:CoCButton = this.bottomButtons[index] as CoCButton;

		if (!button) return null;
		return button.showDisabled(label,toolTipViewText,toolTipViewHeader);
	}

	public function hideBottomButton(index:int):CoCButton {
		var button:CoCButton = this.bottomButtons[index] as CoCButton;
		// Should error.
		if (!button) return null;
		return button.hide();
	}

	public function hideCurrentBottomButtons():void {
		this.currentActiveButtons = [];

		for (var i:int = 0; i < BOTTOM_BUTTON_COUNT; i++) {
			var button:CoCButton = this.bottomButtons[i] as CoCButton;

			if (button.visible == true) {
				this.currentActiveButtons.push(i);
				button.visible = false;
			}
		}
	}

	public function showCurrentBottomButtons():void {
		if (!this.currentActiveButtons) return;
		if (currentActiveButtons.length == 0) return;

		for (var i:int = 0; i < currentActiveButtons.length; i++) {
			var btnIdx:int       = currentActiveButtons[i];
			var button:CoCButton = this.bottomButtons[btnIdx] as CoCButton;

			button.visible = true;
		}
	}

	//////// Internal event handlers ////////

	protected function executeBottomButtonClick(event:Event):void {
		this.toolTipView.hide();
	}

	protected function hoverButton(event:MouseEvent):void {
		var button:CoCButton;

		button = event.target as CoCButton;

		if (button && button.visible && button.toolTipText) {
			this.toolTipView.header = button.toolTipHeader;
			this.toolTipView.text   = button.toolTipText;
			this.toolTipView.showForButton(button);
		}
		else {
			this.toolTipView.hide();
		}
	}

	protected function dimButton(event:MouseEvent):void {
		this.toolTipView.hide();
	}


	//////// Bottom Button Methods ////////

	// TODO: Refactor button set-up code to use callback and toolTipViewText here.
	public function setButton(index:int, label:String = '', callback:Function = null, toolTipViewText:String = ''):void {
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
		return this.indexOfButtonWithLabel(labelText) !== -1;
	}

	public function indexOfButtonWithLabel(labelText:String):int {
		var i:int;

		for (i = 0; i < this.bottomButtons.length; ++i) {
			if (this.getButtonText(i) === labelText)
				return i;
		}

		return -1;
	}

	public function clearBottomButtons():void {
		var i:int;
		for (i = 0; i < BOTTOM_BUTTON_COUNT; ++i) {
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
		return (possibleLabels.indexOf(this.getButtonText(index)) != -1);
	}

	public function buttonIsVisible(index:int):Boolean {
		if (index < 0 || index > BOTTOM_BUTTON_COUNT) {
			return undefined;
		} else {
			return this.bottomButtons[index].visible;
		}
	}


	//////// Menu Button Methods ////////

	protected function getMenuButtonByName(name:String):CoCButton {
		switch (name) {
			case MENU_NEW_MAIN:
				return newGameButton;
			case MENU_DATA:
				return dataButton;
			case MENU_STATS:
				return statsButton;
			case MENU_LEVEL:
				return levelButton;
			case MENU_PERKS:
				return perksButton;
			case MENU_APPEARANCE:
				return appearanceButton;
		}
		return null;
	}

	////////

	public function setMenuButton(name:String, label:String = '', callback:Function = null):void {
		var button:CoCButton = this.getMenuButtonByName(name);

		if (!button) {
			throw new ArgumentError("MainView.setMenuButton: Invalid menu button name: " + String(name));
		}

		if (label) {
			button.labelText     = label;
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

	public function set onBottomButtonClick(value:Function):void {
		_onBottomButtonClick = value;
	}
	public function showMenuButton(name:String):void {
		var button:CoCButton = this.getMenuButtonByName(name);
		button.visible       = true;
	}

	public function hideMenuButton(name:String):void {
		var button:CoCButton = this.getMenuButtonByName(name);
		button.visible       = false;
	}

	public function showAllMenuButtons():void {
		this.showMenuButton(MENU_NEW_MAIN);
		this.showMenuButton(MENU_DATA);
		this.showMenuButton(MENU_STATS);
		this.showMenuButton(MENU_LEVEL);
		this.showMenuButton(MENU_PERKS);
		this.showMenuButton(MENU_APPEARANCE);
	}

	public function hideAllMenuButtons():void {
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
		this.blackBackground.visible = !this.blackBackground.visible;
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

	public function hideSprite():void {
		this.sprite.visible = false;
	}

	public function showTestInputPanel():void {
		this.eventTestInput.x = 207.5;
		this.eventTestInput.y = 55.1;

		this.mainText.visible = false;

		this.eventTestInput.selectable = true;
//		this.eventTestInput.type       = TextFieldType.INPUT;
		this.eventTestInput.visible    = true;

		this.scrollBar.scrollTarget = this.eventTestInput;

	}

	public function hideTestInputPanel():void {

		this.eventTestInput.x = -10207.5;
		this.eventTestInput.y = -1055.1;

		this.mainText.visible = true;


		this.eventTestInput.selectable = false;
//		this.eventTestInput.type       = TextFieldType.DYNAMIC;
		this.eventTestInput.visible    = false;

		this.scrollBar.scrollTarget = this.mainText;

	}

	public function hideComboBox():void {
		stage.focus = null;
		if (aCb.parent != null) {
			removeElement(aCb);
		}
		comboboxHandler = null;
	}

	public function showComboBox(items:Array,propmt:String,onChange:Function):void {
		aCb.dataProvider = new DataProvider(items);
		aCb.prompt = propmt;
		comboboxHandler = onChange;
		if (aCb.parent == null) {
			addElement(aCb);
		}
		aCb.visible = true;
	}
	public function placeComboBox(x:Number,y:Number):void {
		aCb.move(x,y);
	}
}
}