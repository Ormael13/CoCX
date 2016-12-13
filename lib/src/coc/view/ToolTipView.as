package coc.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	public class ToolTipView extends Sprite {
		public var
			bg :Sprite,
			tf :TextField;

		public function ToolTipView( mainView :MovieClip ) :void {
			this.bg = mainView.getChildByName( "popUpBG" ) as Sprite;
			this.tf = mainView.getChildByName( "mouseOverText" ) as TextField;

			this.bg.x = 0;
			this.bg.y = 0;

			this.tf.x = 22;
			this.tf.y = 22;

			this.tf.type = TextFieldType.DYNAMIC;

			this.addChild( this.bg );
			this.addChild( this.tf );
		};

		public function showForButton( button :DisplayObject ) {
			var bx = button.x,
				by = button.y;

			bx = (bx >= 688 ? 680: bx);
			this.x = bx - 13;
			this.y = by - 232;
			if (this.y < 0) this.y = by + 40;

			this.visible = true;
		};

		public function hide() {
			this.visible = false;
		};

		public function set text( newText :String ) :void {
			this.tf.htmlText = newText || '';
		};

		public function get text() :String {
			return this.tf.htmlText;
		};
	}
}