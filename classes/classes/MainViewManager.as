//The code that is responsible for managing MainView.
package classes 
{
	import classes.*
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import flash.display.Shape;
	import flash.display.GradientType;
	import flash.events.Event;
	import flash.events.TimerEvent;
	import flash.text.TextFormat;
	
	import coc.view.MainView;
	import coc.view.CoCButton;
	
	import flash.events.MouseEvent;

	import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import flash.utils.Timer;
	
	//import fl.transition.Tween;
	//import fl.transition.easing.*
	
	public class MainViewManager extends BaseContent
	{
		//Interface flags
		public var registeredShiftKey:Boolean = false;
		//public var minLustBar:MovieClip = new MovieClip();
		//public var minLustBarCreated:Boolean = false;
		public var initializedThirdRow:Boolean = false;
		public var initializedGradients:Boolean = false;
		
		public const textColorArray:Array = [null, null, null, 0xC0C0C0, 0xC0C0C0, null, null, null, null, null];
		public const mainColorArray:Array = [null, null, null, null, 0xC0C0C0, null, null, null, null, null];
		public const barAlphaArray:Array = [0.4, 0.4, 0.5, 1, 1, 1, 1, 1, 1, 0.4];
		
		public var statsHidden:Boolean = false;
		public var buttonsTweened:Boolean = false;
		public var barsDecorated:Boolean = false;
		
		//Format		
		private var oldFormat:TextFormat;
		private var newFormat:TextFormat;
		//private var oldFormatLarge:TextFormat;
		//private var timeTextFormat:TextFormat;
		
		private var arraySet:Boolean = false;
		public var colorableTexts:Array = [];
		public var fontableTexts:Array = []; //Will be used for font adjustment.
		public var bars:Array = [];

		private var universalAlpha:Number = 0.4;
		
		public function MainViewManager() 
		{
			
		}
		
		//------------
		// INITIALIZE
		//------------
		//For now
		private function initializeSideBar():void {
			if (barsDecorated) return;
			barsDecorated = true;
			var barsToDecorate:Array = ["strBar", "touBar", "speBar", "inteBar", "libBar", "sensBar", "corBar", "HPBar", "lustBar", "fatigueBar", "xpBar"];
			for (var i:int = 0; i < barsToDecorate.length; i++) {
				var marker:Sprite = new StatsBarTrim() as Sprite;
				marker.name = barsToDecorate[i] + "Trim";
				marker.x = mainView[barsToDecorate[i]].x - 2;
				marker.y = mainView[barsToDecorate[i]].y + 18;
				mainView.statsView.addChildAt(marker, mainView.statsView.numChildren);
			}
			
			mainView.hungerBar.visible = false;
			mainView.esteemBar.visible = false;
			mainView.willBar.visible = false;
			mainView.obeyBar.visible = false;
			
			mainView.hungerNum.visible = false;
			mainView.esteemNum.visible = false;
			mainView.willNum.visible = false;
			mainView.obeyNum.visible = false;
		}
		
		//------------
		// REFRESH
		//------------
		public function refreshStats():void {
			var baseHeight:Number = 26;
			var baseWidth:Number = 170;
			//var universalAlpha:Number = 0.4;
			var gapDiff:Number = 30;
			if (!barsDecorated) {
				initializeSideBar();
			}
			//Set bars
			mainView.strBar.width = (player.str * (baseWidth / 100));
			mainView.touBar.width = (player.tou * (baseWidth / 100));
			mainView.speBar.width = (player.spe * (baseWidth / 100));
			mainView.inteBar.width = (player.inte * (baseWidth / 100));
			mainView.libBar.width = (player.lib * (baseWidth / 100));
			mainView.sensBar.width = (player.sens * (baseWidth / 100));
			mainView.corBar.width = (player.cor * (baseWidth / 100));

			mainView.HPBar.width = ((player.HP / player.maxHP() * 100) * (baseWidth / 100));
			mainView.lustBar.width = ((player.lust / player.maxLust() * 100) * (baseWidth / 100));
			mainView.minLustBar.width = ((player.minLust() / player.maxLust() * 100) * (baseWidth / 100));
			mainView.fatigueBar.width = ((player.fatigue / player.maxFatigue() * 100) * (baseWidth / 100));
			
			//Experience bar.
			if (player.level < kGAMECLASS.levelCap) mainView.xpBar.width = (((player.XP / player.requiredXP()) * 100) * (baseWidth / 100));
			else mainView.xpBar.width = (100 * (baseWidth / 100)); //Display XP bar at 100% if level is capped.
			if (player.XP >= player.requiredXP()) mainView.xpBar.width = baseWidth; //Set to 100% if XP exceeds the requirement.
			
			mainView.strNum.text = String(Math.floor(player.str));
			mainView.touNum.text = String(Math.floor(player.tou));
			mainView.speNum.text = String(Math.floor(player.spe));
			mainView.inteNum.text = String(Math.floor(player.inte));
			mainView.libNum.text = String(Math.floor(player.lib));
			mainView.senNum.text = String(Math.floor(player.sens));
			mainView.corNum.text = String(Math.floor(player.cor));
			mainView.HPNum.text = Math.floor(player.HP) + "/" + Math.floor(player.maxHP());
			mainView.lustNum.text = Math.floor(player.lust) + "/" + player.maxLust();
			mainView.fatigueNum.text = Math.floor(player.fatigue) + "/" + player.maxFatigue();
			
			//Display experience numbers.
			mainView.levelNum.text = String(player.level);
			if (player.level < kGAMECLASS.levelCap) mainView.xpNum.text = Math.floor(player.XP) + "/" + Math.floor(player.requiredXP());
			else mainView.xpNum.text = "MAX";
			mainView.gemsNum.text = addComma(Math.floor(player.gems)) + "";
			
			//Time display
			//var minutesDisplay:String = "";
			//if (model.time.minutes < 10) minutesDisplay = "0" + model.time.minutes;
			//else minutesDisplay = "" + model.time.minutes;
			mainView.timeText.htmlText = "<u>Day#: " + model.time.days + "</u>\n";
			//if (flags[kFLAGS.USE_12_HOURS] == 0) {
				mainView.timeText.htmlText += "Time: " + model.time.hours + ":00";
			/*}
			else {
				if (model.time.hours < 12) {
					if (model.time.hours == 0) mainView.timeText.htmlText += "Time: " + (model.time.hours + 12) + ":" + minutesDisplay + "am";
					else mainView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "am";
				}
				else {
					if (model.time.hours == 12) mainView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "pm";
					else mainView.timeText.htmlText += "Time: " + (model.time.hours - 12) + ":" + minutesDisplay + "pm";
				}
			}*/
			//if (timeTextFormat != null) mainView.timeText.setTextFormat(timeTextFormat);
		}
		
		//Show/hide stats bars.
		public function tweenInStats():void {
			var t:Timer = new Timer(20, 21);
			if (!statsHidden) return;
			statsHidden = false;
			t.addEventListener(TimerEvent.TIMER, function():void { mainView.statsView.x += 10; mainView.statsView.alpha += 0.05; if (mainView.statsView.alpha > 1) mainView.statsView.alpha = 1;} );
			t.start();
		}
		public function tweenOutStats():void {
			var t:Timer = new Timer(20, 21);
			if (statsHidden) return;
			statsHidden = true;
			t.addEventListener(TimerEvent.TIMER, function():void { mainView.statsView.x -= 10; mainView.statsView.alpha -= 0.05; if (mainView.statsView.alpha < 0) mainView.statsView.alpha = 0; } );
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
				getGame().shiftKeyDown = true;
			}
		}
		public function keyReleased(event:KeyboardEvent):void {
			if (event.keyCode == Keyboard.SHIFT) {
				getGame().shiftKeyDown = false;
			}
		}
	}
}