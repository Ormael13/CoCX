package coc.view {
import flash.display.Bitmap;
import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.display.DisplayObject;
import flash.events.MouseEvent;
import flash.text.TextField;
	import flash.text.TextFieldType;

	//import coc.model.GameModel;

	public class ToolTipView extends Block {
		[Embed(source='../../../res/ui/tooltip.png')]
		public static var tooltipBg:Class;
		public var
			bg:Sprite,
			ln:Sprite,
			hd:TextField,
			tf:TextField;

		//protected var model:GameModel;

		public function ToolTipView(mainView:MainView/*, model:GameModel*/):void {
			super();
			//this.model = model;

			this.bg = addBitmapDataSprite({
				x:0, y:0,
				width:350,height:239,stretch: true,
				bitmapClass: tooltipBg
			});
			this.ln = addBitmapDataSprite({
				x:15,y:40,
				width:320,height:1,fillColor:'#000000'
			});
			this.hd = addTextField({
				x:15,y:15,
				width:316,height:25.35,
				multiline:true,
				wordWrap:false,
				embedFonts:true,
				defaultTextFormat:{
					size: 18,
					font: CoCButton.ButtonLabelFontName
				}
			});
			this.tf = addTextField({
				x:15,y:40,
				width:316,height:176,
				multiline:true,wordWrap:true,
				defaultTextFormat:{
					size:15
				}
			});
		}

		public function showForButton(button:DisplayObject):void {
			var bx:Number = button.x,
				by:Number = button.y;

			// TODO: Should we try to remove some of these numbers?
			/*if (this.model.mobile) {
				bx = (bx >= 410 ? 405: bx);
				this.x = bx + 98;
				this.y = by - 347;
			}*/
			//else {
			bx = (bx >= 688 ? 680: bx);
			this.x = bx - 13;
			var y:Number = by - this.height - 2;
			if (y < 0) y = by + button.height + 6;
			this.y = y;
			//}

			this.visible = true;
		}

		public function hide():void {
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