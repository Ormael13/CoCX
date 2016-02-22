package coc.view {
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
	import flash.text.TextField;
	import flash.text.TextFieldType;

	//import coc.model.GameModel;

	public class ToolTipView extends Sprite {
		public var
			bg:Sprite,
			ln:Sprite,
			hd:TextField,
			tf:TextField;

		//protected var model:GameModel;

		public function ToolTipView(mainView:MovieClip/*, model:GameModel*/):void {
			//this.model = model;

			this.bg = mainView.getChildByName("popUpBG") as Sprite;
			this.ln = mainView.getChildByName("mouseOverLine") as Sprite;
			this.hd = mainView.getChildByName("mouseOverHeader") as TextField;
			this.tf = mainView.getChildByName("mouseOverText") as TextField;

			this.bg.x = 0;
			this.bg.y = 0;
			
			this.ln.x = 15;
			this.ln.y = 40;
			
			this.hd.x = 15;
			this.hd.y = 15;
			
			this.tf.x = 15;
			this.tf.y = 40;

			this.hd.type = TextFieldType.DYNAMIC;
			this.tf.type = TextFieldType.DYNAMIC;

			this.addChild(this.bg);
			this.addChild(this.ln);
			this.addChild(this.hd);
			this.addChild(this.tf);
		}

		public function showForButton(button:DisplayObject) {
			var bx = button.x,
				by = button.y;

			// TODO: Should we try to remove some of these numbers?
			/*if (this.model.mobile) {
				bx = (bx >= 410 ? 405: bx);
				this.x = bx + 98;
				this.y = by - 347;
			}*/
			//else {
				bx = (bx >= 688 ? 680: bx);
				this.x = bx - 13;
				this.y = by - 232;
				if (this.y < 0) this.y = by + 40;
			//}

			this.visible = true;
		}

		public function hide() {
			this.visible = false;
		}

		public function set header(newText:String):void {
			this.hd.htmlText = newText || '';
		}

		public function get header():String {
			return this.hd.htmlText;
		}
		
		public function set text(newText:String):void {
			this.tf.htmlText = newText || '';
		}

		public function get text():String {
			return this.tf.htmlText;
		}
	}
}