package coc.view {
import classes.CoC_Settings;

import flash.display.DisplayObject;
import flash.display.Sprite;
import flash.geom.Point;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;

//import coc.model.GameModel;

	public class ToolTipView extends Block {
		[Embed(source='../../../res/ui/tooltip.png')]
		public static var tooltipBg:Class;
		public var
			bg:Sprite,
			ln:Sprite,
			hd:TextField,
			tf:TextField;

		private var mainView:MainView;
		private static const MIN_HEIGHT:Number = 239;
		private static const WIDTH:Number = 350;

		public function ToolTipView(mainView:MainView/*, model:GameModel*/):void {
			super();
			this.mainView = mainView;

			this.bg = addBitmapDataSprite({
				x:0, y:0,
				width: WIDTH,
				height:239,
				stretch: true,
				bitmapClass: tooltipBg
			});
			this.hd = addTextField({
				x:15,y:15,
				width: WIDTH-34,
				//height: 25.35,
				multiline:true,
				autosize: TextFieldAutoSize.LEFT,
				wordWrap:true,
				embedFonts:true,
				defaultTextFormat:{
					size: 18,
					font: CoCButton.ButtonLabelFontName
				}
			});
			this.ln = addBitmapDataSprite({
				x:15,y:40,
				width: WIDTH-30,
				height:1,
				fillColor:'#000000'
			});
			this.tf = addTextField({
				x:15,y:40,
				width: WIDTH-34,
				multiline:true,wordWrap:true,
				defaultTextFormat:{
					size:15
				}
			});
			this.tf.autoSize = TextFieldAutoSize.LEFT;
		}

		/**
		 * Display tooltip near rectangle with specified coordinates
		 */
		public function show(bx:Number, by:Number, bw:Number, bh:Number):void {
			if (CoC_Settings.mobileBuild) {
				bx -= 64;
				by -= 64;
				bw += 128;
				bh += 128;
			}
			this.x = bx;
			if (this.x < 0) {
				this.x = 0; // left border
			} else if (this.x + this.width > mainView.width) {
				this.x = mainView.width - this.width; // right border
			}
			autosize();
			if (by+bh < mainView.height/2) {
				// put to the bottom
				this.y = by + bh;
			} else {
				// put on top
				this.y = by - this.height;
			}
			this.visible = true;
			this.parent.addChild(this); // add on top
		}
		public function showForElement(e:DisplayObject, header:String, text:String):void {
			this.header = header;
			this.text = text;
			var lpt:Point = e.getRect(this.parent).topLeft;
			show(lpt.x, lpt.y, e.width, e.height);
		}

		public function hide():void {
			this.visible = false;
		}

		public function set header(newText:String):void {
			this.hd.htmlText = newText || '';
			autosize();
		}

		public function get header():String {
			return this.hd.htmlText;
		}
		
		public function set text(newText:String):void {
			this.tf.htmlText = newText || '';
			autosize();
		}

		public function get text():String {
			return this.tf.htmlText;
		}
		
		private function autosize():void {
			this.ln.y = Math.max(40, this.hd.x + this.hd.textHeight);
			this.tf.y = this.ln.y;
			bg.height = Math.max(tf.textHeight + tf.y + 23, MIN_HEIGHT);
		}
	}
}
