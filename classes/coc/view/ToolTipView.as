package coc.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;

	public class ToolTip extends Sprite {
		public var
			bg :Sprite,
			tf :TextField;

		public function ToolTip( mainView :MovieClip ) :void {
			this.bg = mainView.popUpBG;
			this.tf = mainView.mouseOverText;

			this.addChild( this.bg );
			this.addChild( this.tf );
		};

		public function showForButton( ... args ) {
			trace( "ToolTip.showForButton: stub" );
		};

		public function hide() {
			trace( "ToolTip.hide: stub" );
		};
	}
}