package coc.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	import coc.model.GameModel;

	public class ToolTipView extends Sprite {
		public var
			bg :Sprite,
			tf :TextField;

		protected var model :GameModel;

		public function ToolTipView( mainView :MovieClip, model :GameModel ) :void {
			this.model = model;

			this.bg = mainView.popUpBG;
			this.tf = mainView.mouseOverText;

			this.tf.type = TextFieldType.DYNAMIC;

			this.addChild( this.bg );
			this.addChild( this.tf );
		};

		public function showForButton( button :DisplayObject ) {
			var bx = button.x,
				by = button.y;

			// TODO: Should we try to remove some of these numbers?
			if( this.model.mobile ) {
				bx = (bx >= 410 ? 405 : bx);
				this.x = bx + 98;
				this.y = by - 347;
			}
			else {
				bx = (bx >= 708 ? 700 : bx);
				this.x = bx - 13;
				this.y = by - 232;
			}

			this.visible = true;
		};

		public function hide() {
			this.visible = false;
		};

		public function set text( newText ) :void {
			this.tf.text = newText;
		};

		public function get text() :String {
			return this.tf.text;
		};
	}
}