//The code that is responsible for managing MainView.
package classes {
import classes.GlobalFlags.kFLAGS;

import coc.view.BitmapDataSprite;
import coc.view.MainView;
import coc.view.StatsView;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import flash.ui.Keyboard;
import flash.utils.Timer;
import flash.utils.getQualifiedClassName;


public class MainViewManager extends BaseContent {
	//Interface flags
	public var registeredShiftKey:Boolean = false;

	public const textColorArray:Array = [0, 0, 0, 0xFFFFFF, 0xFFFFFF, 0, 0, 0, 0, 0];
	public const darkThemes:Array = [false, false, false, false, true, false, false, false, false, false];
	public const barAlphaArray:Array  = [0.4, 0.4, 0.5, 1, 1, 1, 1, 1, 1, 1];

	public var statsHidden:Boolean    = false;
	public var buttonsTweened:Boolean = false;

	public function MainViewManager() {

	}

	//------------
	// SHOW/HIDE
	//------------
	public function darkThemeImpl():Boolean {
		return darkThemes[flags[kFLAGS.BACKGROUND_STYLE]];
	}

	public function setTheme():void {
		var i:int = 0; //Will be used for array.

		//Set background
		mainView.background.bitmapClass = MainView.Backgrounds[flags[kFLAGS.BACKGROUND_STYLE]];
		mainView.statsView.setBackground(StatsView.SidebarBackgrounds[flags[kFLAGS.BACKGROUND_STYLE]]);
		//Set font
		mainView.statsView.setTheme((flags[kFLAGS.USE_OLD_FONT] > 0) ? StatsView.ValueFontOld : StatsView.ValueFont,
				textColorArray[flags[kFLAGS.BACKGROUND_STYLE]],
				barAlphaArray[flags[kFLAGS.BACKGROUND_STYLE]]);
	}

	public function hideSprite():void {
		// Inlined from lib/src/coc/view/MainView.as
		mainView.sprite.visible = false;
	}
	public function showSpriteBitmap(bmp:BitmapData):void {
		if (!bmp) return;
		var element:BitmapDataSprite = mainView.sprite;
		element.visible              = true;
		var scale:Number             = 80 / bmp.height;
		element.scaleX               = scale;
		element.scaleY               = scale;
		element.graphics.clear();
		element.graphics.beginBitmapFill(bmp, null, false, false);
		element.graphics.drawRect(0, 0, bmp.width, bmp.height);
		element.graphics.endFill();
		element.x = mainView.width - element.width;
		element.y = mainView.height - element.height;
	}
	//------------
	// REFRESH
	//------------
	public function refreshStats():void {
		if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || prison.inPrison) && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75 && flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
			mainView.statsView.toggleHungerBar(true);
		} else {
			mainView.statsView.toggleHungerBar(false);
		}
		//Set theme!
		setTheme();
		mainView.statsView.refreshStats(getGame());
	}
	public function showPlayerDoll(reload:Boolean=false):void {
			tweenOutStats();
		if (reload) mainView.charView.reload("external");
		mainView.charView.setCharacter(player);
		mainView.charView.redraw();
		mainView.charView.visible = true;
	}
	public function hidePlayerDoll():void {
		mainView.charView.visible = false;
			tweenInStats();
	}

	//Show/hide stats bars.
	public function tweenInStats():void {
		var t:Timer = new Timer(20, 21);
		if (!statsHidden) return;
		statsHidden = false;
		t.addEventListener(TimerEvent.TIMER, function ():void {
			mainView.statsView.x += 10;
			mainView.statsView.alpha += 0.05;
		});
		t.addEventListener(TimerEvent.TIMER_COMPLETE, function ():void {
			mainView.statsView.x     = 0;
			mainView.statsView.alpha = 1;
		});
		t.start();
	}
	public function tweenOutStats():void {
		var t:Timer = new Timer(20, 21);
		if (statsHidden) return;
		statsHidden = true;
		t.addEventListener(TimerEvent.TIMER, function ():void {
			mainView.statsView.x -= 10;
			mainView.statsView.alpha -= 0.05;
			if (mainView.statsView.alpha < 0) mainView.statsView.alpha = 0;
		});
		t.addEventListener(TimerEvent.TIMER_COMPLETE, function ():void {
			mainView.statsView.x     = -200;
			mainView.statsView.alpha = 0;
		});
		t.start();
	}

	//Animate buttons for startup!
	public function startUpButtons():void {
		if (buttonsTweened) return;
		buttonsTweened = true;
		for (var i:int = 0; i < 15; i++) {
			mainView.bottomButtons[i].y += 140;
		}
		var t:Timer = new Timer(1000, 1);
		t.addEventListener(TimerEvent.TIMER, tweenButtonsIn);
		t.start();
	}
	private function tweenButtonsIn(e:TimerEvent = null):void {
		var t:Timer = new Timer(20, 28);
		t.addEventListener(TimerEvent.TIMER, moveButtonsIn);
		t.start();
	}
	private function moveButtonsIn(e:TimerEvent):void {
		for (var i:int = 0; i < 15; i++) {
			mainView.bottomButtons[i].y -= 5;
		}
	}

	//Allows shift key.
	public function registerShiftKeys():void {
		if (!registeredShiftKey) {
			mainView.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
			mainView.stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
			registeredShiftKey = true;
		}
	}

	public function keyPressed(event:KeyboardEvent):void {
		if (event.keyCode == Keyboard.SHIFT) {
			flags[kFLAGS.SHIFT_KEY_DOWN] = 1;
		}
	}
	public function keyReleased(event:KeyboardEvent):void {
		if (event.keyCode == Keyboard.SHIFT) {
			flags[kFLAGS.SHIFT_KEY_DOWN] = 0;
		}
	}
	public function traceSelf():String {
		function chdump(obj:DisplayObject, depth:int, alpha:Number, visible:Boolean, scaleX:Number, scaleY:Number):String {

			var s:String = repeatString("  ", depth);

			var className:String = getQualifiedClassName(obj)
					.replace("coc.view::", "<coc>::")
					.replace("spark.components::", "<s>::")
					.replace("spark.skins.spark::", "<spark>::")
					.replace("flash.display::", "<f>::")
					.replace("flash.text::", "<ft>::")
					.replace("flash.text.engine::", "<fte>::");
			s += className + " '" + obj.name + "' ";

			s += "xy=(" + (obj.x | 0) + "," + (obj.y | 0) + ") ";

			var smar:String = "";
			var spad:String = "";
			/*var uio:UIComponent = obj as UIComponent;
			 if (uio) {
			 spad = uio.getStyle("paddingTop") + "," + uio.getStyle("paddingRight") +
			 "," + uio.getStyle("paddingBottom") + "," + uio.getStyle("paddingLeft");
			 if (spad == "0,0,0,0") spad = ""; else spad = ", pad=[" + spad + "]";
			 /!*smar = uio.getStyle("marginTop")+","+uio.getStyle("marginRight")+
			 ","+uio.getStyle("marginBottom")+","+uio.getStyle("marginLeft");
			 if (smar == "0,0,0,0") smar = ""; else smar=", mar=["+smar+"]";*!/
			 }*/
			s += "sz=" + (obj.width | 0) + "x" + (obj.height | 0) + spad + smar;

			alpha             = alpha * obj.alpha;
			visible           = visible && obj.visible;
			scaleX            = scaleX * obj.scaleX;
			scaleY            = scaleY * obj.scaleY;
			var salpha:String = "";
			var svis:String   = "";
			var ssx:String    = "";
			var ssy:String    = "";
			if (alpha != 1.0) {
				salpha += ", a=" + obj.alpha;
				if (alpha != obj.alpha) salpha += "=" + alpha;
			}
			if (!visible) {
				svis += ", v=" + obj.visible;
				if (visible != obj.visible) svis += "=" + visible;
			}
			if (scaleX != 1.0 || obj.scaleX != 1.0) {
				ssx += ", sx=" + obj.scaleX;
				if (scaleX != obj.scaleX) ssx += "=" + scaleX;
			}
			if (scaleY != 1.0 || obj.scaleY != 1.0) {
				ssy += ", sy=" + obj.scaleY;
				if (scaleY != obj.scaleY) ssy += "=" + scaleY;
			}
			s += salpha + svis + ssx + ssy;

			/*var txt:IDisplayText = obj as IDisplayText;
			 if (txt) {
			 var ts:String = txt.text;
			 if (ts.length > 20) ts = ts.substr(0, 17) + "...";
			 s += ", txt='" + ts.replace(/[\r\n\t\0]/g, ' ') + "'";
			 }*/

			var doc:DisplayObjectContainer = obj as DisplayObjectContainer;
			if (doc /*&& !(obj is Label) && !(obj is ComboBox) && !(obj is TextArea) && !(obj is TextInput)*/) {
				var i:int, n:int = doc.numChildren, rslt:String;
				rslt             = "\n" + s;
				for (i = 0; i < n; i++) {
					var child:DisplayObject = doc.getChildAt(i);
					/*if (!(child is TextLine)) {*/
					rslt += chdump(child, depth + 1, alpha, visible, scaleX, scaleY);
					/*}*/
				}
				return rslt;
			} else {
				return "\n" + s;
			}
		}
		var obj:Stage = getGame().stage;
		return chdump(obj, 0, obj.alpha, obj.visible, obj.scaleX, obj.scaleY);
	}
}
}