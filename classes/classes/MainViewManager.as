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
		
		public const textColorArray:Array = [null, null, null, 0xFFFFFF, 0xFFFFFF, null, null, null, null, null];
		public const mainColorArray:Array = [null, null, null, null, 0xFFFFFF, null, null, null, null, null];
		public const barAlphaArray:Array = [0.4, 0.4, 0.5, 1, 1, 1, 1, 1, 1, 1];
		
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
		private function initializeMarkers():void {
			if (barsDecorated) return;
			barsDecorated = true;
			var barsToDecorate:Array = ["strBar", "touBar", "speBar", "inteBar", "libBar", "sensBar", "corBar", "HPBar", "lustBar", "fatigueBar", "hungerBar", "esteemBar", "willBar", "obeyBar", "xpBar"];
			for (var i:int = 0; i < barsToDecorate.length; i++) {
				var marker:Sprite = new StatsBarTrim() as Sprite;
				marker.name = barsToDecorate[i] + "Trim";
				marker.x = mainView[barsToDecorate[i]].x - 2;
				marker.y = mainView[barsToDecorate[i]].y + 18;
				mainView.statsView.addChildAt(marker, mainView.statsView.numChildren);
			}
		}
		
		//------------
		// SHOW/HIDE
		//------------
		//Hide hunger bar, necessary if either of the 2 conditions happen: We either switch to the old interface or we have hunger disabled.
		public function hideHungerBar():void {
			if (mainView.statsView.getChildByName("hungerBar") != null) {
				mainView.hungerBar.visible = false;
				mainView.hungerNum.visible = false;
				mainView.hungerText.visible = false;
				mainView.hungerDown.visible = false;
				mainView.hungerUp.visible = false;
				mainView.statsView.getChildByName("hungerBarTrim").visible = false;
			}
		}
		public function showHungerBar():void {
			if (mainView.statsView.getChildByName("hungerBar") != null) {
				mainView.hungerBar.visible = true;
				mainView.hungerNum.visible = true;
				mainView.hungerText.visible = true;
				//mainView.hungerDown.visible = false;
				//mainView.hungerUp.visible = false;
				mainView.statsView.getChildByName("hungerBarTrim").visible = true;
			}
		}
		
		public function hidePrisonBar():void {
			mainView.levelNum.visible = true;
			mainView.levelText.visible = true;
			mainView.xpNum.visible = true;
			mainView.xpText.visible = true;
			mainView.gemsNum.visible = true;
			mainView.gemsText.visible = true;
			//Hide willpower
			mainView.willBar.visible = false;
			mainView.willNum.visible = false;
			mainView.willText.visible = false;
			mainView.willDown.visible = false;
			mainView.willUp.visible = false;
			mainView.statsView.getChildByName("willBarTrim").visible = false;
			//Hide self-esteem
			mainView.esteemBar.visible = false;
			mainView.esteemNum.visible = false;
			mainView.esteemText.visible = false;
			mainView.esteemDown.visible = false;
			mainView.esteemUp.visible = false;
			mainView.statsView.getChildByName("esteemBarTrim").visible = false;
			//Hide obedience
			mainView.obeyBar.visible = false;
			mainView.obeyNum.visible = false;
			mainView.obeyText.visible = false;
			mainView.obeyDown.visible = false;
			mainView.obeyUp.visible = false;
			mainView.statsView.getChildByName("obeyBarTrim").visible = false;
		}
		public function showPrisonBar():void {
			mainView.levelNum.visible = false;
			mainView.levelText.visible = false;
			mainView.xpNum.visible = false;
			mainView.xpText.visible = false;
			mainView.gemsNum.visible = false;
			mainView.gemsText.visible = false;
			//Show willpower
			if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.willBar.visible = true;
			mainView.willNum.visible = true;
			mainView.willText.visible = true;
			//mainView.willDown.visible = false;
			//mainView.willUp.visible = false;
			mainView.statsView.getChildByName("willBarTrim").visible = true;
			//Show self-esteem
			if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.esteemBar.visible = true;
			mainView.esteemNum.visible = true;
			mainView.esteemText.visible = true;
			//mainView.esteemDown.visible = false;
			//mainView.esteemUp.visible = false;
			mainView.statsView.getChildByName("esteemBarTrim").visible = true;
			//Show obedience
			if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.obeyBar.visible = true;
			mainView.obeyNum.visible = true;
			mainView.obeyText.visible = true;
			//mainView.obeyDown.visible = false;
			//mainView.obeyUp.visible = false;
			mainView.statsView.getChildByName("obeyBarTrim").visible = true;
		}
		
		//Hide XP bar. (For old menus)
		public function hideExperienceBar():void {
			mainView.xpBar.visible = false;
		}
		public function showExperienceBar():void {
			mainView.xpBar.visible = true;
		}
		
		//Hide min lust bar. (For old menus)
		public function hideMinLustBar():void {
			mainView.minLustBar.visible = false;
		}
		public function showMinLustBar():void {
			mainView.minLustBar.visible = true;
		}
		
		public function setTheme():void {
			var i:int = 0; //Will be used for array.
			if (!arraySet) {
				arraySet = true;
				oldFormat = mainView.timeText.getTextFormat();
				oldFormat.size = null;
				oldFormat.align = null;
				newFormat = mainView.strNum.getTextFormat();
				newFormat.size = null;
				newFormat.align = null;
				colorableTexts.push(
					//Core stats
					mainView.strText, mainView.strNum, 
					mainView.touText, mainView.touNum, 
					mainView.speText, mainView.speNum, 
					mainView.inteText, mainView.inteNum, 
					mainView.libText, mainView.libNum, 
					mainView.senText, mainView.senNum, 
					mainView.corText, mainView.corNum, 
					//Combat stats
					mainView.HPText, mainView.HPNum, 
					mainView.lustText, mainView.lustNum, 
					mainView.fatigueText, mainView.fatigueNum,
					mainView.hungerText, mainView.hungerNum,
					//Prison stats
					mainView.willText, mainView.willNum, 
					mainView.esteemText, mainView.esteemNum, 
					mainView.obeyText, mainView.obeyNum,
					//Advancement
					mainView.levelText, mainView.levelNum, 
					mainView.xpText, mainView.xpNum, 
					mainView.gemsText, mainView.gemsNum,
					//Misc
					mainView.nameText,
					mainView.coreStatsText,
					mainView.combatStatsText,
					mainView.advancementText,
					mainView.timeText
				);
				fontableTexts.push(
					//Core stats
					mainView.strText, mainView.strNum, 
					mainView.touText, mainView.touNum, 
					mainView.speText, mainView.speNum, 
					mainView.inteText, mainView.inteNum, 
					mainView.libText, mainView.libNum, 
					mainView.senText, mainView.senNum, 
					mainView.corText, mainView.corNum, 
					//Combat stats
					mainView.HPText, mainView.HPNum, 
					mainView.lustText, mainView.lustNum, 
					mainView.fatigueText, mainView.fatigueNum,
					mainView.hungerText, mainView.hungerNum,
					//Prison stats
					mainView.willText, mainView.willNum, 
					mainView.esteemText, mainView.esteemNum, 
					mainView.obeyText, mainView.obeyNum,
					//Advancement
					mainView.levelText, mainView.levelNum, 
					mainView.xpText, mainView.xpNum, 
					mainView.gemsText, mainView.gemsNum
				);
				bars.push(
					//Core stats
					mainView.strBar,
					mainView.touBar,
					mainView.speBar,
					mainView.inteBar,
					mainView.libBar,
					mainView.sensBar,
					mainView.corBar,
					//Combat stats
					mainView.HPBar,
					mainView.lustBar,
					mainView.fatigueBar,
					mainView.hungerBar,
					//Prison stats
					mainView.willBar,
					mainView.esteemBar,
					mainView.obeyBar,
					//Advancement
					mainView.xpBar
				);
			}
			//Set background
			mainView.background.gotoAndStop(flags[kFLAGS.BACKGROUND_STYLE] + 1);
			mainView.sideBarBG.gotoAndStop(flags[kFLAGS.BACKGROUND_STYLE] + 1);
			//Set font
			if (flags[kFLAGS.USE_OLD_FONT] > 0) {
				for (i = 0; i < fontableTexts.length; i++) {
					fontableTexts[i].setTextFormat(oldFormat);
				}
			}
			else {
				for (i = 0; i < fontableTexts.length; i++) {
					fontableTexts[i].setTextFormat(newFormat);
				}
			}
			//Set text colour
			//mainView.mainText.textColor = mainColorArray[flags[kFLAGS.BACKGROUND_STYLE]];
			for (i = 0; i < colorableTexts.length; i++) {
				colorableTexts[i].textColor = textColorArray[flags[kFLAGS.BACKGROUND_STYLE]];
			}
			//Set bar opacity
			universalAlpha = barAlphaArray[flags[kFLAGS.BACKGROUND_STYLE]];
			for (i = 0; i < bars.length; i++) {
				bars[i].alpha = universalAlpha;
			}
			
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
				initializeMarkers();
			}
			showHungerBar();
			showExperienceBar();
			showMinLustBar();	
			if (prison.inPrison) {
				showPrisonBar();
				hideExperienceBar();
			}
			else {
				hidePrisonBar();
				showExperienceBar();
			}
			//Set bars
			mainView.strBar.width = (player.str * (baseWidth / player.getMaxStats("str")));
			mainView.touBar.width = (player.tou * (baseWidth / player.getMaxStats("tou")));
			mainView.speBar.width = (player.spe * (baseWidth / player.getMaxStats("spe")));
			mainView.inteBar.width = (player.inte * (baseWidth / player.getMaxStats("inte")));
			mainView.libBar.width = (player.lib * (baseWidth / 100));
			mainView.sensBar.width = (player.sens * (baseWidth / 100));
			mainView.corBar.width = (player.cor * (baseWidth / 100));

			mainView.HPBar.width = ((player.HP / player.maxHP() * 100) * (baseWidth / 100));
			mainView.lustBar.width = ((player.lust / player.maxLust() * 100) * (baseWidth / 100));
			mainView.minLustBar.width = ((player.minLust() / player.maxLust() * 100) * (baseWidth / 100));
			mainView.fatigueBar.width = ((player.fatigue / player.maxFatigue() * 100) * (baseWidth / 100));
			
			//Hunger bar
			mainView.hungerBar.width = (player.hunger * (baseWidth / 100));
			//Experience bar.
			if (!prison.inPrison) {
				if (player.level < kGAMECLASS.levelCap) mainView.xpBar.width = (((player.XP / player.requiredXP()) * 100) * (baseWidth / 100));
				else mainView.xpBar.width = (100 * (baseWidth / 100)); //Display XP bar at 100% if level is capped.
				if (player.XP >= player.requiredXP()) mainView.xpBar.width = baseWidth; //Set to 100% if XP exceeds the requirement.
			}
			//Prison bars
			else {
				mainView.esteemBar.width = (player.esteem * (baseWidth / 100));
				mainView.willBar.width = (player.will * (baseWidth / 100));
				mainView.obeyBar.width = (player.obey * (baseWidth / 100));
			}
			
			mainView.strNum.text = String(Math.floor(player.str));
			mainView.touNum.text = String(Math.floor(player.tou));
			mainView.speNum.text = String(Math.floor(player.spe));
			mainView.inteNum.text = String(Math.floor(player.inte));
			mainView.libNum.text = String(Math.floor(player.lib));
			mainView.senNum.text = String(Math.floor(player.sens));
			mainView.corNum.text = String(Math.floor(player.cor));
			//Old interface is removed for now.
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) 
			mainView.HPNum.text = Math.floor(player.HP) + "/" + Math.floor(player.maxHP());
			//else mainView.HPNum.text = "" + Math.floor(player.HP);
			
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) 
			mainView.lustNum.text = Math.floor(player.lust) + "/" + player.maxLust();
			//else mainView.lustNum.text = "" + Math.floor(player.lust);
			
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) 
			mainView.fatigueNum.text = Math.floor(player.fatigue) + "/" + player.maxFatigue();
			//else Math.floor(player.fatigue);
			
			if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || prison.inPrison) && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75 && flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
				showHungerBar();
				mainView.hungerNum.text = Math.floor(player.hunger) + "/" + 100;
			}
			else {
				hideHungerBar();
			}
			if (prison.inPrison) {
				showPrisonBar();
				mainView.willNum.text = Math.floor(player.will) + ""; //"/" + 100;
				mainView.esteemNum.text = Math.floor(player.esteem) + ""; //"/" + 100;
				mainView.obeyNum.text = Math.floor(player.obey) + ""; //"/" + player.obeySoftCap ? 50 : 100;
			}
			else {
				hidePrisonBar();
			}
			//Display experience numbers.
			mainView.levelNum.text = String(player.level);
			if (player.level < kGAMECLASS.levelCap) mainView.xpNum.text = Math.floor(player.XP) + "/" + Math.floor(player.requiredXP());
			else mainView.xpNum.text = "MAX";
			mainView.gemsNum.text = addComma(Math.floor(player.gems)) + "";
			
			//Get rid of the space before colon. (For new)
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
				mainView.strText.text = "Strength:";
				mainView.touText.text = "Toughness:";
				mainView.speText.text = "Speed:";
				mainView.inteText.text = "Intelligence:";
				mainView.libText.text = "Libido:";
				mainView.senText.text = "Sensitivity:";
				mainView.corText.text = "Corruption:";
				mainView.HPText.text = "HP:";
				mainView.lustText.text = "Lust:";
				mainView.fatigueText.text = "Fatigue:";
			/*} else {
				mainView.strText.text = "Strength    :";
				mainView.touText.text = "Toughness   :";
				mainView.speText.text = "Speed       :";
				mainView.inteText.text = "Intelligence:";
				mainView.libText.text = "Libido      :";
				mainView.senText.text = "Sensitivity :";
				mainView.corText.text = "Corruption  :";
				mainView.HPText.text = "HP          :";
				mainView.HPText.width = 130;
				mainView.lustText.text = "Lust        :";
				mainView.lustText.width = 130;
				mainView.fatigueText.text = "Fatigue     :";
				mainView.fatigueText.width = 130;
			}*/

			//Headers
			mainView.nameText.htmlText = "<b>Name: " + player.short + "</b>";
			if (prison.inPrison) mainView.advancementText.htmlText = "<b>Prison Stats</b>";
			else mainView.advancementText.htmlText = "<b>Advancement</b>";
			
			//Time display
			mainView.timeBG.alpha = 0;
			var minutesDisplay:String = "";
			if (model.time.minutes < 10) minutesDisplay = "0" + model.time.minutes;
			else minutesDisplay = "" + model.time.minutes;
			mainView.timeText.htmlText = "<u>Day#: " + model.time.days + "</u>\n";
			if (flags[kFLAGS.USE_12_HOURS] == 0) {
				mainView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "";
			}
			else {
				if (model.time.hours < 12) {
					if (model.time.hours == 0) mainView.timeText.htmlText += "Time: " + (model.time.hours + 12) + ":" + minutesDisplay + "am";
					else mainView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "am";
				}
				else {
					if (model.time.hours == 12) mainView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "pm";
					else mainView.timeText.htmlText += "Time: " + (model.time.hours - 12) + ":" + minutesDisplay + "pm";
				}
			}
			//if (timeTextFormat != null) mainView.timeText.setTextFormat(timeTextFormat);
			
			//Set theme!
			setTheme();
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
				flags[kFLAGS.SHIFT_KEY_DOWN] = 1;
			}
		}
		public function keyReleased(event:KeyboardEvent):void {
			if (event.keyCode == Keyboard.SHIFT) {
				flags[kFLAGS.SHIFT_KEY_DOWN] = 0;
			}
		}
	}
}