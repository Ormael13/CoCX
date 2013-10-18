package coc.view {
	import flash.display.MovieClip;
	import flash.text.TextField;

	public class MainView extends MovieClip {
		private static const BOTTOM_BUTTON_COUNT :int = 10;
		private static const BOTTOM_BUTTON_PER_ROW_COUNT :int = 5;

		private static const BUTTON_X_OFFSET :Number = 200;
		private static const BUTTON_Y_OFFSET :Number = 668;
		private static const BUTTON_X_DELTA :Number = 160;
		private static const BUTTON_Y_DELTA :Number = 52;
		private static const BUTTON_REAL_WIDTH :Number = 150;
		private static const BUTTON_REAL_HEIGHT :Number = 40;

		public var bottomButtons :Array; // <MovieClip>

		public function MainView() :void {
			super();

			disableMouseForMostTextFields();
			createBottomButtons();
		}

		// Removes the need for some code in input.as and InitializeUI.as.
		public function disableMouseForMostTextFields() {
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
				}
			}
		}

		public function createBottomButtons() {
			var b :MovieClip, BCs :Array,
				bi :int, r :int, c: int,
				backgroundChildIndex :int;

			this.bottomButtons = [];

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

				r = (bi / BOTTOM_BUTTON_PER_ROW_COUNT) << 0;
				c = bi % BOTTOM_BUTTON_PER_ROW_COUNT;

				b.x = BUTTON_X_OFFSET + c * BUTTON_X_DELTA;
				b.y = BUTTON_Y_OFFSET + r * BUTTON_Y_DELTA;
				b.width = BUTTON_REAL_WIDTH;   //The button symbols are actually 135 wide
				b.height = BUTTON_REAL_HEIGHT; //and 38 high. Not sure why the difference here.

				this.bottomButtons.push( b );
				this.addChildAt( b, backgroundChildIndex + 1 );
			}
		}
	}
}