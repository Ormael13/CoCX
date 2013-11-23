/****
	coc.view.MainView

	I have no real idea yet what eventTestInput is for,
	but its coordinates get tested for in places, and set in others.
	Perhaps some day I'll ask.

	It's for allowing people to test stuff in the parser. It gets moved into view, and you 
	can enter stuff in the text window, which then gets fed through the parser.
****/

package coc.view {
	import flash.display.MovieClip;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	import fl.controls.ComboBox; 
	import fl.data.DataProvider; 

    import coc.model.GameModel;

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
		public static const MENU_NEW_MAIN :String = 'newGame';
		public static const MENU_DATA :String = 'data';
		public static const MENU_STATS :String = 'stats';
		public static const MENU_LEVEL :String = 'level';
		public static const MENU_PERKS :String = 'perks';
		public static const MENU_APPEARANCE :String = 'appearance';

		private static const BOTTOM_BUTTON_COUNT :int = 10;
		private static const BOTTOM_BUTTON_PER_ROW_COUNT :int = 5;

		private static const BUTTON_X_OFFSET :Number = 200;
		private static const BUTTON_Y_OFFSET :Number = 668;
		private static const BUTTON_X_DELTA :Number = 160;
		private static const BUTTON_Y_DELTA :Number = 52;
		private static const BUTTON_REAL_WIDTH :Number = 150;
		private static const BUTTON_REAL_HEIGHT :Number = 40;

		public var aCb :ComboBox;
		// public var nameBox :TextField;

		public var bottomButtonTexts :Array; // <TextField>
		public var bottomButtonBGs :Array; // <MovieClip>
		public var menuButtonTexts :Array;
		public var menuButtonBGs :Array;

		public var toolTipView :ToolTipView;
		public var statsView :StatsView;

		// TODO: Refactor so we don't need these vars.  That sounds so simple when you put it like that...
		public var _executeButtomButtonClick :Function;
		public var _getButtonToolTipText :Function;

		protected var options :Object;
		protected var allButtonTexts :Array;
		protected var allButtons :Array;
		protected var callbacks :Object = {};

		protected var model :GameModel;

		public var
			newGameBG :MovieClip, 
			dataBG :MovieClip, 
			statsBG :MovieClip, 
			levelBG :MovieClip, 
			perksBG :MovieClip, 
			appearanceBG :MovieClip;

		public function MainView( model :GameModel = null, options :Object = null ) :void {
			// Note: Currently we can't touch this on construction
			// due to the code being a mess.  We'll fix that at some point.
			// maybe even get like update events or some shit like real MV*s or something.
			this.model = model;
			this.options = options || {};

			super();

			if( ! model ) {
				trace( "MainView/constructor: Game model not passed in.  Don't publish MainView.fla with Ctrl-Enter/Cmd-Enter.  Rather, go to File > Publish to build the SWC." );
				throw new ArgumentError( "MainView/constructor: MainView must be constructed with a GameModel as its first argument." );
			}

			// Init subviews.
			this.toolTipView = new ToolTipView( this, this.model );
			this.toolTipView.hide();
			this.addChild( this.toolTipView );

			this.statsView = new StatsView( this, this.model );
			this.statsView.hide();
			this.addChild( this.statsView );

			this.formatMiscItems();

			// button texts.  This part will eventually go away...
			this.bottomButtonTexts = [
				b1Text, b2Text, b3Text, b4Text, b5Text,
				b6Text, b7Text, b8Text, b9Text, b0Text // wonky.
				];

			this.menuButtonTexts = [
				newGameText, dataText, statsText, levelText2, perksText, appearanceText
				];

			this.allButtonTexts = this.bottomButtonTexts.concat( this.menuButtonTexts );

			disableMouseForMostTextFields();

			// button bgs.  This part too will eventually go away...
			this.menuButtonBGs = [
				newGameBG, dataBG, statsBG, levelBG, perksBG, appearanceBG
				];
				
			createBottomButtons();

			this.allButtons = this.bottomButtonBGs.concat( this.menuButtonBGs );

			// ...
			imageText.visible = false; // TODO: Remove this TF?  It doesn't seem to be used anywhere.  I think it was from the first effort to put in images.

			// hook!
			hookBottomButtons();
			hookAllButtons();
		};



		//////// Initialization methods. /////////

		protected function formatMiscItems() :void {
			// this.mainText = this.getChildByName( "mainText" );

			this.nameBox.maxChars = 54;

			this.aCb = new ComboBox(); 
			this.aCb.dropdownWidth = 200; 
			this.aCb.width = 200; 
			this.aCb.scaleY = 1.1;
			this.aCb.move(-1250, -1550); 
			this.aCb.prompt = "Choose a perk"; 

			this.hideSprite();
		};

		// Removes the need for some code in input.as and InitializeUI.as.
		protected function disableMouseForMostTextFields() :void {
			var ci :int, t :TextField;

			for( ci = 0; ci < this.numChildren; ++ci ) {
				t = this.getChildAt( ci ) as TextField;

				if( ! t ) {
					continue;
				}

				switch( t ) {
					case this.mainText:
					case this.imageText:
					case this.nameBox:
						break;

					default:
						t.mouseEnabled = false;
						break;
				}
			}
		};

		// This creates the bottom buttons,
		// positions them,
		// and also assigns their index to a bottomIndex property on them.
		protected function createBottomButtons() :void {
			var b :MovieClip, bgClasses :Array,
				bi :int, r :int, c: int,
				backgroundChildIndex :int;

			this.bottomButtonBGs = [];

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
				buttonBackground9 ];

			backgroundChildIndex = this.getChildIndex( background );

			for( bi = 0; bi < BOTTOM_BUTTON_COUNT; ++bi ) {
				b = new (bgClasses[ bi ])();
				b.bottomIndex = bi;
				b.name = 'b' + String( (bi + 1) % 10 ) + 'BG';

				r = (bi / BOTTOM_BUTTON_PER_ROW_COUNT) << 0;
				c = bi % BOTTOM_BUTTON_PER_ROW_COUNT;

				b.x = BUTTON_X_OFFSET + c * BUTTON_X_DELTA;
				b.y = BUTTON_Y_OFFSET + r * BUTTON_Y_DELTA;
				b.width = BUTTON_REAL_WIDTH;   //The button symbols are actually 135 wide
				b.height = BUTTON_REAL_HEIGHT; //and 38 high. Not sure why the difference here.

				this.bottomButtonBGs.push( b );
				this.addChildAt( b, backgroundChildIndex + 1 );
			}
		};

		protected function hookBottomButtons() :void {
			var bi :MovieClip;

			for each( bi in this.bottomButtonBGs ) {
				bi.addEventListener( MouseEvent.CLICK, this.executeBottomButtonClick );
			}
		};

		protected function hookAllButtons() {
			var b :MovieClip;

			for each( b in this.allButtons ) {
				b.mouseChildren = false;
				b.addEventListener( MouseEvent.ROLL_OVER, this.hoverButton );
				b.addEventListener( MouseEvent.ROLL_OUT, this.dimButton );
			}
		};



		//////// Internal(?) view update methods ////////

		public function showBottomButton( index :int, label :String, callback :Function = null, toolTipViewText :String = '' ) :void {
			var buttonTF :TextField = this.bottomButtonTexts[ index ] as TextField,
				buttonBG :MovieClip = this.bottomButtonBGs[ index ] as MovieClip;

			this.bottomButtonBGs[ index ].visible = true;

			buttonTF.text = label;
			buttonTF.visible = true;
		};

		public function hideBottomButton( index :int ) {
			this.bottomButtonBGs[ index ].visible = false;
			this.bottomButtonTexts[ index ].visible = false;
		};



		//////// Internal event handlers ////////

		protected function textForBG( bg :DisplayObject ) :TextField {
			var textName :String;

			if( ! bg ) {
				throw new ArgumentError( "MainView.textForBG() must be called with a DisplayObject as its argument." );
			}

			textName = bg.name.replace( /BG$/, 'Text' );

			if( bg.name == 'levelBG' )
				textName += '2';

			return this[ textName ] as TextField;
		};

		protected function executeBottomButtonClick( event :Event ) {
			var bottomButton :InteractiveObject,
				bottomButtonIndex :int;

			if( this._executeButtomButtonClick ) {
				this.toolTipView.hide();
				bottomButton = (event.currentTarget as InteractiveObject);
				bottomButtonIndex = this.bottomButtonBGs.indexOf( bottomButton );
				this._executeButtomButtonClick( bottomButtonIndex );
			}
		};

		protected function hoverButton( event :MouseEvent ) {
			event.target.alpha = 0.5;

			if( this._getButtonToolTipText ) {
				this.toolTipView.text = this._getButtonToolTipText( this.textForBG( event.target as DisplayObject ).text );
				if( this.toolTipView.text )
					this.toolTipView.showForButton( event.target as DisplayObject );
			}
		};

		protected function dimButton( event :MouseEvent ) {
			event.target.alpha = 1.0;
			this.toolTipView.hide();
		};



		//////// Bottom Button Methods ////////

		// TODO: Refactor button set-up code to use callback and toolTipViewText here.
		public function setButton( index :int, label :String = '', callback :Function = null, toolTipViewText :String = '' ) {
			if( index < 0 || index >= BOTTOM_BUTTON_COUNT ) {
				trace( "MainView.setButton called with out of range index:", index );
				// throw new RangeError();
				return;
			}

			if( label ) {
				this.showBottomButton( index, label, callback, toolTipViewText );
			}
			else {
				this.hideBottomButton( index );
			}
		};

		// There was one case where the label needed to be set but I could not determine from context whether the button should be shown or not...
		public function setButtonText( index :int, label :String ) :void {
			this.bottomButtonTexts[ index ].text = label;
		};

		public function hasButton( labelText :String ) :Boolean {
			var b :TextField;

			for each( b in this.bottomButtonTexts ) {
				if( b.text == labelText )
					return true;
			}

			return false;
		};

		public function indexOfButtonWithLabel( labelText :String ) :int {
			var i :int;

			for( i = 0; i < this.bottomButtonTexts.length; ++i ) {
				if( this.bottomButtonTexts[ i ].text == labelText )
					return i;
			}

			return -1;
		};

		public function clearBottomButtons() :void {
			var i :int;

			for( i = 0; i < BOTTOM_BUTTON_COUNT; ++i ) {
				this.setButton( i );
			}
		};

		public function getButtonText( index :int ) :String {
			var matches :*;

			if( index < 0 || index > BOTTOM_BUTTON_COUNT ) {
				return '';
			}
			else {
				return this.bottomButtonTexts[ index ].text;
			}
		};

		// This function checks if the button at index has text
		// that matches at least one of the possible texts passed as an argument.
		public function buttonTextIsOneOf( index :int, possibleLabels :Array ) :Boolean {
			var label :String,
				buttonText :String;

			buttonText = this.getButtonText( index );

			return (possibleLabels.indexOf( buttonText ) != -1);
		};

		public function buttonIsVisible( index :int ) :Boolean {
			if( index < 0 || index > BOTTOM_BUTTON_COUNT ) {
				return undefined;
			}
			else {
				return this.bottomButtonBGs[ index ].visible;
			}
		};



		//////// Menu Button Methods ////////

		protected function setMenuButtonListener( button :InteractiveObject, callback :Function ) :void {
			if( this.callbacks[ button.name ] )
				button.removeEventListener( MouseEvent.CLICK, this.callbacks[ button.name ] );

			this.callbacks[ button.name ] = callback;
			button.addEventListener( MouseEvent.CLICK, callback );
		};

		protected function getMenuButtonParts( name :String ) :Object {
			var tfName :String = name + 'Text',
				bgName :String = name + 'BG';

			if( name == 'level' )
				tfName += '2';

			return {
				textField: this[ tfName ] as TextField,
				background: this[ bgName ] as DisplayObject
			};
		};

		////////

		public function setMenuButton( name :String, label :String = '', callback :Function = null ) :void {
			var buttonParts :Object = this.getMenuButtonParts( name );

			if( ! (buttonParts.textField && buttonParts.background) ) {
				throw new ArgumentError( "MainView.setMenuButton: Invalid menu button name: " + String( name ) );
			}

			if( label ) {
				buttonParts.textField.text = label;
			}

			if( callback ) {
				this.setMenuButtonListener( buttonParts.background, callback );
			}
		};

		public function set onNewGameClick( callback :Function ) :void {
			this.setMenuButtonListener( this.newGameBG, callback );
		};

		public function set onDataClick( callback :Function ) :void {
			this.setMenuButtonListener( this.dataBG, callback );
		};

		public function set onStatsClick( callback :Function ) :void {
			this.setMenuButtonListener( this.statsBG, callback );
		};

		public function set onLevelClick( callback :Function ) :void {
			this.setMenuButtonListener( this.levelBG, callback );
		};

		public function set onPerksClick( callback :Function ) :void {
			this.setMenuButtonListener( this.perksBG, callback );
		};

		public function set onAppearanceClick( callback :Function ) :void {
			this.setMenuButtonListener( this.appearanceBG, callback );
		};

		public function showMenuButton( name :String ) :void {
			var buttonParts = this.getMenuButtonParts( name );

			buttonParts.textField.visible = true;
			buttonParts.background.visible = true;
		};

		public function hideMenuButton( name :String ) :void {
			var buttonParts = this.getMenuButtonParts( name );

			buttonParts.textField.visible = false;
			buttonParts.background.visible = false;
		};

		public function showAllMenuButtons() {
			this.showMenuButton( MENU_NEW_MAIN );
			this.showMenuButton( MENU_DATA );
			this.showMenuButton( MENU_STATS );
			this.showMenuButton( MENU_LEVEL );
			this.showMenuButton( MENU_PERKS );
			this.showMenuButton( MENU_APPEARANCE );
		};

		public function hideAllMenuButtons() {
			this.hideMenuButton( MENU_NEW_MAIN );
			this.hideMenuButton( MENU_DATA );
			this.hideMenuButton( MENU_STATS );
			this.hideMenuButton( MENU_LEVEL );
			this.hideMenuButton( MENU_PERKS );
			this.hideMenuButton( MENU_APPEARANCE );
		};

		public function menuButtonIsVisible( name :String ) :Boolean {
			return this.getMenuButtonParts( name ).background.visible;
		};

		public function menuButtonHasLabel( name :String, label :String ) :Boolean {
			return this.getMenuButtonParts( name ).textField.text == label;
		};



		//////// misc... ////////

		public function invert() :void {
			if( ! this.blackBackground.visible ) {
				this.blackBackground.visible = true;
			}
			else {
				this.blackBackground.visible = false;
			}
		};

		public function clearOutputText() :void {
			this.mainText.htmlText = '';
			this.scrollBar.update();
		};

		public function appendOutputText( text :String ) :void {
			this.mainText.htmlText += text;
			this.scrollBar.update();
		};

		public function setOutputText( text :String ) :void {
			// Commenting out for now, because this is annoying to see flooding the trace.
			// trace( "MainView#setOutputText(): This is never called in the main outputText() function.  Possible bugs that were patched over by updating text manually?" );
			this.mainText.htmlText = text;
			this.scrollBar.update();
		};

		public function selectSprite( index :Number = 0 ) :void {
			var scale :Number;

			// TODO: When flags goes away, if it goes away, replace this with the appropriate settings thing.
			if( index < 0 || this.model.flags[ 273 ] ) // = SHOW_SPRITES_FLAG from flagDefs...
				this.sprite.visible = false;
			else {
				this.sprite.visible = true;
				this.sprite.gotoAndStop( index );

				this.sprite.scaleX = 1;
				this.sprite.scaleY = 1;
				scale = 80 / this.sprite.height;
				this.sprite.scaleX = scale;
				this.sprite.scaleY = scale;
			}
		};

		public function hideSprite() :void {
			this.selectSprite( -1 );
		};


		public function showTestInputPanel():void
		{
			this.eventTestInput.x = 207.5;
			this.eventTestInput.y = 55.1;
			
			this.mainText.x += 5000;
			this.imageText.x += 5000;

			this.eventTestInput.selectable = true;
			this.eventTestInput.type = TextFieldType.INPUT;
			this.eventTestInput.mouseEnabled = true;

			this.scrollBar.scrollTarget = this.eventTestInput;

		}
		public function hideTestInputPanel():void
		{

			this.eventTestInput.x = -10207.5;
			this.eventTestInput.y = -1055.1;
			
			this.mainText.x -= 5000;
			this.imageText.x -= 5000;			


			this.eventTestInput.selectable = false;
			this.eventTestInput.type = TextFieldType.DYNAMIC;
			this.eventTestInput.mouseEnabled = false;

			this.scrollBar.scrollTarget = this.mainText;

		}

	}
}