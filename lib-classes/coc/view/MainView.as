/****
	coc.view.MainView
****/

package coc.view {
	import flash.display.MovieClip;
	import flash.display.InteractiveObject;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

    import coc.model.GameModel;

	public dynamic class MainView extends MovieClip {
		private static const BOTTOM_BUTTON_COUNT :int = 10;
		private static const BOTTOM_BUTTON_PER_ROW_COUNT :int = 5;

		private static const BUTTON_X_OFFSET :Number = 200;
		private static const BUTTON_Y_OFFSET :Number = 668;
		private static const BUTTON_X_DELTA :Number = 160;
		private static const BUTTON_Y_DELTA :Number = 52;
		private static const BUTTON_REAL_WIDTH :Number = 150;
		private static const BUTTON_REAL_HEIGHT :Number = 40;

		public var bottomButtonTexts :Array; // <TextField>
		public var bottomButtonBGs :Array; // <MovieClip>
		public var toolTip :ToolTipView;
		public var statsView :StatsView;

		public var _executeButtomButtonClick :Function;

		// protected var bottomButtonSettings :Array;

		protected var options :Object;
		protected var allButtons :Array;
		protected var callbacks :Object = {};

		protected var model :GameModel; // TODO: Need an actual class type.

		public function MainView( model :*, options :Object = null ) :void {
			// Note: Currently we can't touch this on construction
			// due to the code being a mess.  We'll fix that at some point.
			// maybe even get like update events or some shit like real MV*s or something.
			this.model = model;
			this.options = options || {};

			super();

			this.toolTipView = new ToolTipView( this, this.model );
			this.addChild( this.toolTipview )

			this.statsView = new StatsView( this, this.model );
			this.addChild( this.statsView );

			this.bottomButtonSettings = [];

			this.bottomButtonTexts = [
				b1Text, b2Text, b3Text, b4Text, b5Text,
				b6Text, b7Text, b8Text, b9Text, b0Text // wonky.
				];

			disableMouseForMostTextFields();
			createBottomButtons();

			this.allButtons = this.bottomButtonBGs.concat([
					newGameBG, dataBG, statsBG, levelBG, perksBG, appearanceBG
				]);

			hookBottomButtons();
			hookAllButtons();
		};



		//////// Initialization methods. /////////

		// Removes the need for some code in input.as and InitializeUI.as.
		protected function disableMouseForMostTextFields() :void {
			var ci :int, t :TextField;

			for( ci = 0; ci < this.numChildren; ++ci ) {
				t = this.getChildAt( ci ) as TextField;

				if( ! t ) {
					continue;
				}

				switch( t ) {
					case mainText:
					case imageText:
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
			var b :MovieClip, BCs :Array,
				bi :int, r :int, c: int,
				backgroundChildIndex :int;

			this.bottomButtonBGs = [];

			BCs = [ buttonBackground0,
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
				b = new (BCs[ bi ])();
				b.bottomIndex = bi;

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
				this.addEventListener( MouseEvent.ROLL_OVER, this.hoverButton );
				this.addEventListener( MouseEvent.ROLL_OUT, this.dimButton );
			}
		};



		//////// Internal view update methods ////////

		protected function showBottomButton( index :int ) :void {
			var buttonTF :TextField = this.bottomButtonTexts[ index ] as TextField,
				buttonBG :MovieClip = this.bottomButtonBGs[ index ] as MovieClip,
				buttonSettings = this.bottomButtonSettings[ index ];

			if( ! buttonSettings ) {
				trace( "MainView/showBottomButton: Done penissed up, button's settings are null.  Tried to show button", index );
				return;
			}

			this.bottomButtonBGs[ index ].visible = true;

			buttonTF.text = buttonSettings.label;
			buttonTF.visible = true;
		};

		protected function hideBottomButton( index :int ) {
			this.bottomButtonBGs[ index ].visible = false;
			this.bottomButtonTexts[ index ].visible = false;
		};



		//////// Internal event handlers ////////

		protected function executeBottomButtonClick( event :Event ) {
			var bottomButton :InteractiveObject,
				bottomButtonIndex :int;

			if( this._executeButtomButtonClick ) {
				this.toolTip.hide();
				bottomButton = (event.currentTarget as InteractiveObject);
				bottomButtonIndex = this.bottomButtonBGs.indexOf( bottomButton );
				this._executeButtomButtonClick( bottomButtonIndex );
			}

			// var b :MovieClip, bi :int, buttonSettings :*;

			// b = event.currentTarget as MovieClip;

			// if( ! b ) {
			// 	trace( "MainView.executeBottomButtonClick: Something done penissed up, button bg (event target) is not a movieclip:", event.currentTarget );
			// }

			// bi = b.bottomIndex;

			// buttonSettings = this.bottomButtonSettings[ bi ];

			// if( buttonSettings && buttonSettings.callback ) {
			// 	if( (typeof buttonSettings.callback) == 'function' )
			// 		buttonSettings.callback();
			// 	else {
			// 		trace( "Non-function event:", buttonSettings.callback, " Dropping on the ground for now." );
			// 	}
			// }
		};

		protected function hoverButton( event :MouseEvent ) {
			event.currentTarget.alpha = 0.5;
			trace( "MainView/hoverButton: Skipping showing toolTip" );
			// this.toolTip.showForButton(
			// 	event.currentTarget,
			// 	this.bottomButtonSettings[ event.currentTarget.bottomIndex ].toolTip );
		};

		protected function dimButton( event :MouseEvent ) {
			event.currentTarget.alpha = 1.0;
			trace( "MainView/dimButton: Skipping hiding toolTip" );
			// this.toolTip.hide();
		};



		//////// Public methods ////////

		public function showMenuButtons() {
			dataBG.visible = true;
			dataText.visible = true;
			appearanceText.visible = true;
			appearanceBG.visible = true;
			levelText2.visible = true;
			levelBG.visible = true;
			perksBG.visible = true;
			perksText.visible = true;
			statsText.visible = true;
			statsBG.visible = true;
		};

		public function hideMenuButtons() {
			dataBG.visible = false;
			dataText.visible = false;
			appearanceText.visible = false;
			appearanceBG.visible = false;
			levelText2.visible = false;
			levelBG.visible = false;
			perksBG.visible = false;
			perksText.visible = false;
			statsText.visible = false;
			statsBG.visible = false;
		};

		// tool tip gets passed in?  MainView will have nothing to do with storing those.
		// Ideally, the tool tips would be part of perks/items' definitions.
		// Perhaps not even need to be passed in, merely referenced in some model.
		public function setButton( index :int, label :String = null, callback :Function = null, toolTip :* = null ) {
			if( index < 0 || index >= BOTTOM_BUTTON_COUNT ) {
				trace( "MainView.setButton called with out of range index:", index );
				// throw new RangeError();
				return;
			}

			if( callback ) {
				this.bottomButtonSettings[ index ] = {
					label: label,
					callback: callback,
					toolTip: toolTip
				};

				showBottomButton( index );
			}
			else {
				this.bottomButtonSettings[ index ] = null;

				hideBottomButton( index );
			}
		};

		public function clearBottomButtons() :void {
			var i :int;

			for( i = 0; i < BOTTOM_BUTTON_COUNT; ++i ) {
				this.setButton( i );
			}
		};

		public function selectSprite( index :Number = 0 ) :void {
			if( choice < 0 || flags[ SHOW_SPRITES_FLAG ] )
				sprite.visible = false;
			else {
				sprite.visible = true;
				sprite.gotoAndStop(choice);
				sprite.scaleX = 3;
				sprite.scaleY = 3;
			}
		};

		public function outputText() :void {
			// ...
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
			trace( "MainView#setOutputText(): This is never called in the main outputText() function.  Possible bugs that were patched over by updating text manually?" );
			this.mainText.htmlText = text;
			this.scrollBar.update();
		};

		public function getButtonText( buttonName :String ) :String {
			var matches :*,
				buttonIndex :int;

			if( /^buttons\[[0-9]\]/.test( buttonName ) ) {
				matches = /^buttons\[([0-9])\]/.exec( buttonName );
				buttonIndex = parseInt( matches[ 1 ], 10 );
				return this.bottomButtonTexts[ buttonIndex ].text;
			}
			else if( /^b[0-9]Text$/.test( buttonName ) ) {
				return this[ buttonName ].text;
			}
		};



		//////// Setters ////////

		protected function setMenuButtonListener( button :InteractiveObject, callback :Function ) :void {
			if( this.callbacks[ button.name ] )
				button.removeEventListener( MouseEvent.CLICK, this.callbacks[ button.name ] );

			this.callbacks[ button.name ] = callback;
			button.addEventListener( MouseEvent.CLICK, callback );
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
	}
}