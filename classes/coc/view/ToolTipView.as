package coc.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	public class ToolTipView extends Sprite {
		public var
			bg :Sprite,
			tf :TextField;

		protected var model :*; // TODO: Need an actual class type.

		public function ToolTipView( mainView :MovieClip, model :* ) :void {
			this.model = model;

			this.bg = mainView.popUpBG;
			this.tf = mainView.mouseOverText;

			this.tf.type = TextFieldType.DYNAMIC;

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