/****
	coc.view.MainView

	Constructor takes this options object:
		options = {
			onNewGameClick: callback,
			onDataClick: callback,
			onStatsClick: callback,
			onLevelClick: callback,
			onPerksClick: callback,
			onAppearanceClick: callback
			...?
		}

	Note: likely, things are going to be access via
		parent.globalThingHere and so on.
		where parent is an instance of CoC.
****/

package coc.view {
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;

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
		public var toolTip :*;
		public var statsView :*;

		protected var bottomButtonSettings :Array;

		protected var options :Object;
		protected var allButtons :Array;

		public function MainView() :void {
			// this.options = options;

			super();

			this.toolTipView = new ToolTipView( this );
			this.addChild( this.toolTipview )

			this.statsView = new StatsView( this );
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

			// hookTopButtons();
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

		// Top-button-specific hooks.
		public function hookTopButtons( callbacks ) :void {
			// It is an error if any of these callbacks are undefined.
			newGameBG.addEventListener( MouseEvent.CLICK, callbacks.onNewGameClick );
			dataBG.addEventListener( MouseEvent.CLICK, callbacks.onDataClick );
			statsBG.addEventListener( MouseEvent.CLICK, callbacks.onStatsClick );
			levelBG.addEventListener( MouseEvent.CLICK, callbacks.onLevelClick );
			perksBG.addEventListener( MouseEvent.CLICK, callbacks.onPerksClick );
			appearanceBG.addEventListener( MouseEvent.CLICK, callbacks.onAppearanceClick );
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
			var b :MovieClip, bi :int, buttonSettings :*;

			b = event.currentTarget as MovieClip;

			if( ! b ) {
				trace( "MainView.executeBottomButtonClick: Something done penissed up, button bg (event target) is not a movieclip:", event.currentTarget );
			}

			bi = b.bottomIndex;

			buttonSettings = this.bottomButtonSettings[ bi ];

			if( buttonSettings && buttonSettings.callback ) {
				if( (typeof buttonSettings.callback) == 'function' )
					buttonSettings.callback();
				else {
					trace( "Non-function event:", buttonSettings.callback, " Dropping on the ground for now." );
				}
			}
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
	}
}