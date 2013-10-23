package coc.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;

	public class ToolTipView extends Sprite {
		public var
			bg :Sprite,
			tf :TextField;

		public function ToolTipView( mainView :MovieClip ) :void {
			this.bg = mainView.popUpBG;
			this.tf = mainView.mouseOverText;

			this.addChild( this.bg );
			this.addChild( this.tf );
		};

		public function showForButton( ... args ) {
			trace( "ToolTipView.showForButton: stub, args:", args.join( ", " ) );
		};

		public function hide() {
			trace( "ToolTipView.hide: stub" );
		};
	}
}