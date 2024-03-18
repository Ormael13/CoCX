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
import classes.CoC;
import classes.CoC_Settings;
import classes.EngineCore;


import com.bit101.components.ComboBox;
import com.bit101.components.ScrollBar;
import com.bit101.components.TextFieldVScroll;
import com.bit101.components.ScrollPane;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.events.Event;
import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.TextField;
import flash.text.TextFormat;
import flash.ui.Multitouch;
import flash.ui.MultitouchInputMode;

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
	public static var Themes:Array = [
		// Style 1, "Map"
		{
			dark           : false,
			bgBitmap       : Background1,
			glass          : 0xffffff,
			glassAlpha     : 0.4,
			statGlass      : 0xffffff,
			statGlassAlpha : 0.4,
			statBorderColor: 0x000000,
			statTextColor  : 0x000000,
			barAlpha       : 0.4
		},
		// Style 2, "Parchment"
		{
			dark           : false,
			bgBitmap       : Background2,
			glass          : 0xffffff,
			glassAlpha     : 0.4,
			statGlass      : 0xffffff,
			statGlassAlpha : 0.4,
			statBorderColor: 0x000000,
			statTextColor  : 0x000000,
			barAlpha       : 0.4
		},
		// Style 3, "Marble"
		{
			dark           : false,
			bgBitmap       : Background3,
			glass          : 0xffffff,
			glassAlpha     : 0.4,
			statGlass      : 0xffffff,
			statGlassAlpha : 0.4,
			statBorderColor: 0x000000,
			statTextColor  : 0x000000,
			barAlpha       : 0.4
		},
		// Style 4, "Obsidian"
		{
			dark           : false,
			bgBitmap       : Background4,
			glass          : 0xffffff,
			glassAlpha     : 0.7,
			statGlass      : 0xffffff,
			statGlassAlpha : 0.2,
			statBorderColor: 0xA37C17,
			statTextColor  : 0xFFFFFF,
			barAlpha       : 0.5
		},
		// Style 5, "Black"
		{
			dark           : true,
			bgBitmap       : null,
			glass          : 0xffffff,
			glassAlpha     : 0,
			statGlass      : 0xffffff,
			statGlassAlpha : 0,
			statBorderColor: 0xA37C17,
			statTextColor  : 0xFFFFFF,
			barAlpha       : 1
		},
		// Style 6, "Kaizo"
		{
			dark           : false,
			bgBitmap       : BackgroundKaizo,
			glass          : 0xffffff,
			glassAlpha     : 0.4,
			statGlass      : 0xffffff,
			statGlassAlpha : 0.4,
			statBorderColor: 0x000000,
			statTextColor  : 0x000000,
			barAlpha       : 0.4
		}
	];

	// Menu button names.
	public static const MENU_NEW_MAIN:String   = 'newGame';
	public static const MENU_DATA:String       = 'data';
	public static const MENU_STATS:String      = 'stats';
	public static const MENU_LEVEL:String      = 'level';
	public static const MENU_PERKS:String      = 'perks';
	public static const MENU_APPEARANCE:String = 'appearance';


	public static const GAP:Number   = 4; // Gap between UI panels
	public static const HALFGAP:Number = GAP/2;
	public static const BTN_W:Number = 150; // Button size
	public static const BTN_H:Number = 40;

	public static const SCREEN_W:Number       = 1420;
	public static const SCREEN_H:Number       = 800;

	// TOPROW: [Main Menu]/[New Game], [Data] ... [Appearance]
	
	// Columns:
	//      1               2          3
	//
	//     [ TOPROW                 ]
	//     [STAT1 | STAT2] /TEXTZONE\ [SPRITE ]
	//     [   CHARVIEW  ] \TEXTZONE/ [MONSTER]
	//                     [BUTTONS ]
	// Rows are NOT fixed, so stat1/2 and sprite are NOT of same height
	
	// Misc properties
	internal static const TOPROW_NUMBTNS:Number   = 6;
	public static const VSCROLLBAR_W:Number     = ScrollBar.VWIDTH;
	internal static const BOTTOM_COLS:Number      = 5;
	internal static const BOTTOM_ROWS:Number      = 3;
	internal static const BOTTOM_BUTTON_COUNT:int = BOTTOM_COLS * BOTTOM_ROWS;
	
	// Column 1 core
	internal static const STATBAR_COL_W:Number   = 205;
	internal static const STATBAR_W:Number       = STATBAR_COL_W * 2;
	internal static const CHARVIEW_W:Number      = 200*2;
	internal static const COLUMN_1_X:Number      = HALFGAP;
	internal static const COLUMN_1_W:Number      = Math.max(STATBAR_W, CHARVIEW_W);
	internal static const COLUMN_1_RIGHT:Number  = COLUMN_1_X + COLUMN_1_W;
	// Column 2 core
	public static const TEXTZONE_W:Number        = 770;
	internal static const COLUMN_2_X:Number      = COLUMN_1_RIGHT + GAP;
	internal static const COLUMN_2_W:Number      = TEXTZONE_W;
	internal static const COLUMN_2_RIGHT:Number  = COLUMN_2_X + COLUMN_2_W;
	// Column 3 core
	internal static const COLUMN_3_X:Number      = COLUMN_2_RIGHT + GAP;
	internal static const COLUMN_3_RIGHT:Number  = SCREEN_W - HALFGAP;
	internal static const COLUMN_3_W:Number      = COLUMN_3_RIGHT - COLUMN_3_X;
	// Top row. Its width depends on textzone size and declared later
	internal static const TOPROW_X:Number        = COLUMN_1_X;
	internal static const TOPROW_Y:Number        = HALFGAP;
	internal static const TOPROW_H:Number        = BTN_H;
	internal static const TOPROW_BOTTOM:Number   = TOPROW_Y + TOPROW_H + GAP;
	// Stat bar and its columns. Height depends on charview size
	public static const STATBAR_X:Number       = COLUMN_1_X;
	internal static const STATBAR_Y:Number       = TOPROW_BOTTOM + GAP;
	internal static const STATBAR_1_X:Number     = STATBAR_X;
	internal static const STATBAR_1_RIGHT:Number = STATBAR_1_X + STATBAR_COL_W + HALFGAP;
	internal static const STATBAR_2_X:Number     = STATBAR_1_RIGHT;
	internal static const STATBAR_2_RIGHT:Number = STATBAR_2_X + STATBAR_COL_W + HALFGAP;
	internal static const STATBAR_RIGHT:Number   = STATBAR_2_RIGHT;
	public static const STATBAR_WIDTH:Number     = STATBAR_RIGHT - STATBAR_X;
	// Char viewer
	internal static const CHARVIEW_X:Number      = 0;
	internal static const CHARVIEW_H:Number      = 202*2;
	internal static const CHARVIEW_BOTTOM:Number = SCREEN_H;
	internal static const CHARVIEW_Y:Number      = CHARVIEW_BOTTOM - CHARVIEW_H;
	// Text zone
	internal static const TEXTZONE_X:Number      = STATBAR_RIGHT;
	internal static const TEXTZONE_Y:Number      = TOPROW_BOTTOM + GAP;
	internal static const TEXTZONE_RIGHT:Number  = TEXTZONE_X + TEXTZONE_W + GAP;
	// Bottom menu
	internal static const BOTTOM_X:Number        = STATBAR_RIGHT + HALFGAP;
	internal static const BOTTOM_H:Number        = (GAP + BTN_H) * BOTTOM_ROWS; // height = rows x button height
	internal static const BOTTOM_W:Number        = TEXTZONE_W; // width = textzone width
	internal static const BOTTOM_HGAP:Number     = (BOTTOM_W - BTN_W * BOTTOM_COLS) / (2 * BOTTOM_COLS); // between btns
	internal static const BOTTOM_Y:Number        = SCREEN_H - BOTTOM_H; // bottom = screen bottom
	// Sprite (top right)
	public static const SPRITE_X:Number           = COLUMN_3_X;
	public static const SPRITE_Y:Number           = TEXTZONE_Y;
	public static const SPRITE_MAX_W:Number       = SCREEN_W - SPRITE_X - GAP;
	public static const SPRITE_MAX_H:Number       = SPRITE_MAX_W;
	// monster stats (top right below sprite)
	public static const MONSTER_X:Number          = COLUMN_3_X;
	public static const MONSTER_W:Number          = SPRITE_MAX_W;
	public static const MONSTER_H:Number          = 270;
	public static const MONSTER_Y:Number          = SPRITE_Y + SPRITE_MAX_H + GAP;
	// corner stats (bottom right)
	internal static const CORNERSTATS_X:Number      = COLUMN_3_X;
	internal static const CORNERSTATS_W:Number      = COLUMN_3_W;
	internal static const CORNERSTATS_BOTTOM:Number = SCREEN_H - HALFGAP;
	// Various dependencies
	internal static const TEXTZONE_H:Number         = SCREEN_H - TEXTZONE_Y - BOTTOM_H - 2 * GAP;
	internal static const TOPROW_W:Number           = TEXTZONE_X + TEXTZONE_W;
	internal static const STATBAR_BOTTOM:Number     = CHARVIEW_BOTTOM - CHARVIEW_H - GAP;
	internal static const STATBAR_H:Number          = STATBAR_BOTTOM - STATBAR_Y;

	private var blackBackground:BitmapDataSprite;
	public var textBGWhite:BitmapDataSprite;
	public var textBGTan:BitmapDataSprite;
	public var background:BitmapDataSprite;
	public var backgroundGlass:BitmapDataSprite;
	public var sprite:BitmapDataSprite;

	public var mainText:TextField;
	public var nameBox:TextField;
	public var eventTestInput:TextField;
	public var aCb:ComboBox;
	private var comboboxHandler:Function;

	public var toolTipView:ToolTipView;
	public var cornerStatsView:CornerStatsView;
	public var statsView:StatsView;
	public var notificationView:NotificationView;
	public var monsterStatsView:MonsterStatsView;
	public var sideBarDecoration:Sprite;

	private var _onBottomButtonClick:Function;//(index:int, button:CoCButton)=>void
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
	public var scrollBar:TextFieldVScroll;

	protected var callbacks:Object = {};
	protected var options:Object;
	/**
	 * `function(event:String):void` to handle `<a href="event:data">` links.
	 * Is reset on `clearOutput()`
	 */
	public var linkHandler:Function;
	private var customElement:DisplayObject = null;
	public var hotkeysDisabled:Boolean = false;

	public var charView:CharView;
	public function MainView():void {
		super();
		addElement(blackBackground = new BitmapDataSprite({
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
		addElement(backgroundGlass = new BitmapDataSprite({
			fillColor: '#ffffff',
			borderColor: '#222222',
			borderWidth: 1,
			x        : TEXTZONE_X,
			y        : TEXTZONE_Y,
			width    : TEXTZONE_W,
			height   : TEXTZONE_H,
			alpha    : 0.4
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
			labelText  : 'New Game'
		}));
		topRow.addElement(dataButton = new CoCButton({
			labelText  : 'Data'
		}));
		topRow.addElement(statsButton = new CoCButton({
			labelText  : 'Stats'
		}));
		topRow.addElement(levelButton = new CoCButton({
			labelText  : 'Level Up'
		}));
		topRow.addElement(perksButton = new CoCButton({
			labelText  : 'Perks & Opt.'
		}));
		topRow.addElement(appearanceButton = new CoCButton({
			labelText  : 'Appearance'
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
		mainText.addEventListener(TextEvent.LINK, function(e:TextEvent):void {
			if (linkHandler != null) linkHandler(decodeURI(e.text));
		});
		scrollBar = new TextFieldVScroll(mainText);
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
		StatBar.setDefaultOptions({
			barColor: '#600000',
			width: STATBAR_COL_W - 2*HALFGAP
		});
		this.cornerStatsView = new CornerStatsView();
		this.addElement(this.cornerStatsView);
		// Init subviews.
		this.statsView = new StatsView(this, this.cornerStatsView);
		this.statsView.hide();
		this.addElement(this.statsView);
		this.notificationView = new NotificationView({
			x: CHARVIEW_X,
			y: CHARVIEW_Y,
			width: COLUMN_1_W
		});
		this.addElement(this.notificationView);
		
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
		this.width  = SCREEN_W;
		this.height = SCREEN_H;
		this.scaleX = 1;
		this.scaleY = 1;
		charView         = new CharView();
		//charView.bgFill  = 0xff808080;
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
		this.aCb.width         = 200;
		this.aCb.scaleY        = 1.1;
		this.aCb.move(-1250, -1550);
		this.aCb.addEventListener(Event.SELECT, function (event:Event):void {
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

			button = createActionButton(bi);
			button.visible = false;
			button.x = BOTTOM_X + BOTTOM_HGAP + c * (BOTTOM_HGAP * 2 + BTN_W);
			button.y = BOTTOM_Y + r * (GAP + BTN_H);
			this.bottomButtons.push(button);
			this.addElement(button);
		}
		this.allButtons = this.allButtons.concat(this.bottomButtons);
	}
	
	public function createActionButton(index:int):CoCButton {
		var button:CoCButton = new CoCButton();
		button.preCallback = function (b:CoCButton):void {
			if (_onBottomButtonClick != null) _onBottomButtonClick(index, button);
		};
		button.addEventListener(MouseEvent.CLICK, this.executeBottomButtonClick);
		return button;
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
		return button.reset();
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

	protected function hoverElement(event:MouseEvent):void {
		var button:CoCButton;

		button = event.target as CoCButton;

		if (button && button.visible && button.toolTipText) {
			this.toolTipView.showForElement(button, button.toolTipHeader, button.toolTipText);
		}
		else {
			this.toolTipView.hide();
		}
	}

	protected function dimElement(event:MouseEvent):void {
		this.toolTipView.hide();
	}


	//////// Bottom Button Methods ////////

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
		this.linkHandler = null;
		if (this.customElement) {
			this.removeElement(this.customElement);
			this.customElement = null;
			this.scrollBar.activated = true;
		}
		this.hotkeysDisabled = false;
		this.mainText.htmlText = '';
		this.scrollBar.draw();
	}
	
	/**
	 * Display a custom UI element. Only 1 supported at a time (use container if more is needed).
	 * It will be removed on clearOutput() call
	 * @param element
	 * @param afterText Position the element after current text (true, default) or on top of text (false)
	 * @param stretch Stretch the element (default false)
	 */
	public function setCustomElement(element:DisplayObject, afterText:Boolean=true, stretch:Boolean=false, scroll:Boolean=false):void {
		CoC.instance.flushOutputTextToGUI();
		if (this.customElement) {
			this.removeElement(this.customElement);
		}
		var innerElement:DisplayObject = element;
		if (scroll) {
			var container:ScrollPane = new ScrollPane();
			container.autoHideScrollBar = true;
			container.PanelAlpha = 0;
			container.color = 0xCCCCC;
			container.border = false;
			//container.setStyle("upSkin", new MovieClip());
			//container.horizontalScrollPolicy = ScrollPolicy.OFF;
			//container.verticalPageScrollSize = mainText.height - 64;
			//container.verticalLineScrollSize = 16;
			container.addChild(innerElement);
			element = container;
			if (innerElement is Block) {
				innerElement.addEventListener(Block.ON_LAYOUT, function(e:Event):void {
					container.update();
				})
			}
			scrollBar.visible = false;
			if (CoC_Settings.mobileBuild) {
				container.dragContent = true;
				Multitouch.inputMode = MultitouchInputMode.TOUCH_POINT;
//				container.addEventListener(TransformGestureEvent.GESTURE_PAN, function (e:TransformGestureEvent):void {
//					if (e.phase == GesturePhase.UPDATE) {
//						this._vScrollbar.value += -(e.offsetY);
//					}
//				});
			}
		}
		element.x = mainText.x;
		element.y = afterText ? mainText.y + mainText.textHeight : mainText.y;
		if (stretch || scroll) {
			element.width = TEXTZONE_W;
			element.height = mainText.y + mainText.height - element.y;
		}
		if (scroll && stretch) {
			innerElement.width = container.width - ScrollBar.VWIDTH;
			// innerElement.height = container.height;
		}
		this.addElement(element);
		this.customElement = element;
	}
	public function getCustomElement():DisplayObject {
		return customElement;
	}

	public function appendOutputText(text:String):void {
		var fmt:TextFormat = this.mainText.defaultTextFormat;
		fmt.bold = false;
		fmt.italic = false;
		fmt.underline = false;
		this.mainText.htmlText += text;
		this.mainText.defaultTextFormat = fmt;
		this.scrollBar.draw();
	}

	// I think font ones are 90% false reports (because of some Flash weirdness)
	// (no actual unclosed tag, but the font is off because dark magic)
	// there's a workaround I might try - if the font is messed up, clear text (but save first), reset font, and print text again
	private var fontKostyl:Boolean = false;

	public function setOutputText(text:String):void {
		var fmt:TextFormat     = this.mainText.defaultTextFormat;
		fmt.bold = false;
		fmt.italic = false;
		fmt.underline = false;
		this.mainText.defaultTextFormat = fmt;
		this.mainText.htmlText = text; // Altering htmlText can cause changes in defaultTextFormat
		var fmtnew:TextFormat  = this.mainText.defaultTextFormat;
		this.mainText.defaultTextFormat = fmt;
		if (fmtnew.bold != fmt.bold || fmtnew.italic != fmt.italic || fmtnew.underline != fmt.underline) {
			if (fontKostyl) {
				//autofix failed, rerun didn't help
				this.mainText.htmlText += " /!\\ UNCLOSED TAG DETECTED (When reporting this bug, give information on your previous actions. You can check text history by pressing [H] (Mobile version does not support this).) /!\\ ";
			} else {
				//attempt to autofix
				var txt:String = CoC.instance.currentText;
				EngineCore.clearOutputTextOnly(true);
				CoC.instance.currentText = txt;
				fontKostyl = true;
				CoC.instance.flushOutputTextToGUI();
				fontKostyl = false;
			}
		}
		this.scrollBar.draw();
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

		this.scrollBar.value = this.eventTestInput.y;

	}

	public function hideTestInputPanel():void {

		this.eventTestInput.x = -10207.5;
		this.eventTestInput.y = -1055.1;

		this.mainText.visible = true;


		this.eventTestInput.selectable = false;
//		this.eventTestInput.type       = TextFieldType.DYNAMIC;
		this.eventTestInput.visible    = false;

		this.scrollBar.value = this.mainText.y;

	}

	public function hideComboBox():void {
		stage.focus = null;
		if (aCb.parent != null) {
			removeElement(aCb);
		}
		comboboxHandler = null;
	}

	public function showComboBox(items:Array,propmt:String,onChange:Function):void {
		aCb.items = items;
		aCb.numVisibleItems = 15;
		aCb.defaultLabel = propmt;
		comboboxHandler = onChange;
		if (aCb.parent == null) {
			addElement(aCb);
		}
		aCb.visible = true;
	}
	public function placeComboBox(x:Number,y:Number):void {
		aCb.move(x,y);
	}
	public function placeCharviewAtRight():void {
		charView.x = CHARVIEW_X;
		charView.y = CHARVIEW_BOTTOM - CHARVIEW_H;
	}
	public function showSpriteBitmap(bmp:BitmapData):void {
		if (!bmp) return;
		sprite.visible              = true;
		var scale:Number = SPRITE_MAX_W/bmp.width;
		if (bmp.height*scale > SPRITE_MAX_H) {
			scale = SPRITE_MAX_H/bmp.height;
		}
		if (scale > 4) scale = 4;
		sprite.scaleX               = scale;
		sprite.scaleY               = scale;
		sprite.graphics.clear();
		sprite.graphics.beginBitmapFill(bmp, null, false, false);
		sprite.graphics.drawRect(0, 0, bmp.width, bmp.height);
		sprite.graphics.endFill();
		// sprite.x = SCREEN_W - GAP - sprite.width; // align right
		// sprite.y = SCREEN_H - GAP - sprite.height; // align bottom
	}
	public function setTheme(theme:int, font:String):void {
		var style:* = Themes[theme];
		if (!style) return;
		background.bitmapClass    = style.bgBitmap;
		backgroundGlass.fillColor = style.glass;
		backgroundGlass.alpha     = style.glassAlpha;
		statsView.setTheme(theme, font);
		monsterStatsView.setTheme(theme, font);
	}
}
}
