//The code that is responsible for managing MainView.
package classes 
{
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;

import coc.view.BitmapDataSprite;
import coc.view.MainView;
import coc.view.StatsLayout;

import flash.display.BitmapData;
import flash.display.DisplayObject;
import flash.display.DisplayObjectContainer;
import flash.display.Sprite;
import flash.display.Stage;
import flash.events.KeyboardEvent;
import flash.events.TimerEvent;
import flash.text.TextFormat;
import flash.ui.Keyboard;
import flash.utils.Timer;
import flash.utils.getQualifiedClassName;

//import flash.text.TextField;
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
		
		/*public var soulforceBar : MovieClip;
		public var soulforceDown : MovieClip;
		public var soulforceNum : TextField;
		public var soulforceText : TextField;
		public var soulforceUp : MovieClip;
		*/
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
				var marker:Sprite = new BitmapDataSprite(MainView.StatsBarTrim);
				marker.name = barsToDecorate[i] + "Trim";
				marker.x = mainView.statsView[barsToDecorate[i]].x - 2;
				marker.y = mainView.statsView[barsToDecorate[i]].y + 18;
				mainView.statsView.addChildAt(marker, mainView.statsView.numChildren);
			}
		}
		
		//------------
		// SHOW/HIDE
		//------------
		//Hide hunger bar, necessary if either of the 2 conditions happen: We either switch to the old interface or we have hunger disabled.
		public function hideHungerBar():void {
			if (mainView.statsView.hungerBar != null) {
				mainView.statsView.hungerBar.visible = false;
				mainView.statsView.hungerNum.visible = false;
				mainView.statsView.hungerText.visible = false;
				mainView.statsView.hungerDown.visible = false;
				mainView.statsView.hungerUp.visible = false;
				mainView.statsView.getChildByName("hungerBarTrim").visible = false;
			}
		}
		public function showHungerBar():void {
			if (mainView.statsView.hungerBar != null) {
				mainView.statsView.hungerBar.visible = true;
				mainView.statsView.hungerNum.visible = true;
				mainView.statsView.hungerText.visible = true;
				//mainView.hungerDown.visible = false;
				//mainView.hungerUp.visible = false;
				mainView.statsView.getChildByName("hungerBarTrim").visible = true;
			}
		}
		/*
		//Hide soulforce bar, necessary if either of the 2 conditions happen: We either switch to the old interface or PC not have Job: Soul Cultivator perk.
		public function hideSoulforceBar():void {
			if (mainView.statsView.getChildByName("soulforceBar") != null) {
				mainView.soulforceBar.visible = false;
				mainView.soulforceNum.visible = false;
				mainView.soulforceText.visible = false;
				mainView.soulforceDown.visible = false;
				mainView.soulforceUp.visible = false;
				mainView.statsView.getChildByName("soulforceBarTrim").visible = false;
			}
		}
		public function showSoulforceBar():void {
			if (mainView.statsView.getChildByName("soulforceBar") != null) {
				mainView.soulforceBar.visible = true;
				mainView.soulforceNum.visible = true;
				mainView.soulforceText.visible = true;
				mainView.soulforceDown.visible = true;
				mainView.soulforceUp.visible = true;
				mainView.statsView.getChildByName("soulforceBarTrim").visible = true;
			}
		}
		*/
		public function hidePrisonBar():void {
			mainView.statsView.levelNum.visible = true;
			mainView.statsView.levelText.visible = true;
			mainView.statsView.xpNum.visible = true;
			mainView.statsView.xpText.visible = true;
			mainView.statsView.gemsNum.visible = true;
			mainView.statsView.gemsText.visible = true;
			//Hide willpower
			mainView.statsView.willBar.visible = false;
			mainView.statsView.willNum.visible = false;
			mainView.statsView.willText.visible = false;
			mainView.statsView.willDown.visible = false;
			mainView.statsView.willUp.visible = false;
			mainView.statsView.getChildByName("willBarTrim").visible = false;
			//Hide self-esteem
			mainView.statsView.esteemBar.visible = false;
			mainView.statsView.esteemNum.visible = false;
			mainView.statsView.esteemText.visible = false;
			mainView.statsView.esteemDown.visible = false;
			mainView.statsView.esteemUp.visible = false;
			mainView.statsView.getChildByName("esteemBarTrim").visible = false;
			//Hide obedience
			mainView.statsView.obeyBar.visible = false;
			mainView.statsView.obeyNum.visible = false;
			mainView.statsView.obeyText.visible = false;
			mainView.statsView.obeyDown.visible = false;
			mainView.statsView.obeyUp.visible = false;
			mainView.statsView.getChildByName("obeyBarTrim").visible = false;
		}
		public function showPrisonBar():void {
			mainView.statsView.levelNum.visible = false;
			mainView.statsView.levelText.visible = false;
			mainView.statsView.xpNum.visible = false;
			mainView.statsView.xpText.visible = false;
			mainView.statsView.gemsNum.visible = false;
			mainView.statsView.gemsText.visible = false;
			//Show willpower
			if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.statsView.willBar.visible = true;
			mainView.statsView.willNum.visible = true;
			mainView.statsView.willText.visible = true;
			//mainView.willDown.visible = false;
			//mainView.willUp.visible = false;
			mainView.statsView.getChildByName("willBarTrim").visible = true;
			//Show self-esteem
			if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.statsView.esteemBar.visible = true;
			mainView.statsView.esteemNum.visible = true;
			mainView.statsView.esteemText.visible = true;
			//mainView.esteemDown.visible = false;
			//mainView.esteemUp.visible = false;
			mainView.statsView.getChildByName("esteemBarTrim").visible = true;
			//Show obedience
			if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.statsView.obeyBar.visible = true;
			mainView.statsView.obeyNum.visible = true;
			mainView.statsView.obeyText.visible = true;
			//mainView.obeyDown.visible = false;
			//mainView.obeyUp.visible = false;
			mainView.statsView.getChildByName("obeyBarTrim").visible = true;
		}
		
		//Hide XP bar. (For old menus)
		public function hideExperienceBar():void {
			mainView.statsView.xpBar.visible = false;
		}
		public function showExperienceBar():void {
			mainView.statsView.xpBar.visible = true;
		}
		
		//Hide min lust bar. (For old menus)
		public function hideMinLustBar():void {
			mainView.statsView.minLustBar.visible = false;
		}
		public function showMinLustBar():void {
			mainView.statsView.minLustBar.visible = true;
		}
		
		public function setTheme():void {
			var i:int = 0; //Will be used for array.
			if (!arraySet) {
				arraySet = true;
				oldFormat = mainView.statsView.timeText.getTextFormat();
				oldFormat.size = null;
				oldFormat.align = null;
				newFormat = mainView.statsView.strNum.getTextFormat();
				newFormat.size = null;
				newFormat.align = null;
				colorableTexts.push(
					//Core stats
					mainView.statsView.strText, mainView.statsView.strNum,
					mainView.statsView.touText, mainView.statsView.touNum,
					mainView.statsView.speText, mainView.statsView.speNum,
					mainView.statsView.inteText, mainView.statsView.inteNum,
					mainView.statsView.libText, mainView.statsView.libNum,
					mainView.statsView.senText, mainView.statsView.senNum,
					mainView.statsView.corText, mainView.statsView.corNum,
					//Combat stats
					mainView.statsView.HPText, mainView.statsView.HPNum,
					mainView.statsView.lustText, mainView.statsView.lustNum,
					mainView.statsView.fatigueText, mainView.statsView.fatigueNum,
					//mainView.soulforceText, mainView.soulforceNum,
					mainView.statsView.hungerText, mainView.statsView.hungerNum,
					//Prison stats
					mainView.statsView.willText, mainView.statsView.willNum,
					mainView.statsView.esteemText, mainView.statsView.esteemNum,
					mainView.statsView.obeyText, mainView.statsView.obeyNum,
					//Advancement
					mainView.statsView.levelText, mainView.statsView.levelNum,
					mainView.statsView.xpText, mainView.statsView.xpNum,
					mainView.statsView.gemsText, mainView.statsView.gemsNum,
					//Misc
					mainView.statsView.nameText,
					mainView.statsView.coreStatsText,
					mainView.statsView.combatStatsText,
					mainView.statsView.advancementText,
					mainView.statsView.timeText
				);
				fontableTexts.push(
					//Core stats
					mainView.statsView.strText, mainView.statsView.strNum,
					mainView.statsView.touText, mainView.statsView.touNum,
					mainView.statsView.speText, mainView.statsView.speNum,
					mainView.statsView.inteText, mainView.statsView.inteNum,
					mainView.statsView.libText, mainView.statsView.libNum,
					mainView.statsView.senText, mainView.statsView.senNum,
					mainView.statsView.corText, mainView.statsView.corNum,
					//Combat stats
					mainView.statsView.HPText, mainView.statsView.HPNum,
					mainView.statsView.lustText, mainView.statsView.lustNum,
					mainView.statsView.fatigueText, mainView.statsView.fatigueNum,
						//mainView.soulforceText, mainView.soulforceNum,
					mainView.statsView.hungerText, mainView.statsView.hungerNum,
					//Prison stats
					mainView.statsView.willText, mainView.statsView.willNum,
					mainView.statsView.esteemText, mainView.statsView.esteemNum,
					mainView.statsView.obeyText, mainView.statsView.obeyNum,
					//Advancement
					mainView.statsView.levelText, mainView.statsView.levelNum,
					mainView.statsView.xpText, mainView.statsView.xpNum,
					mainView.statsView.gemsText, mainView.statsView.gemsNum
				);
				bars.push(
					//Core stats
					mainView.statsView.strBar,
					mainView.statsView.touBar,
					mainView.statsView.speBar,
					mainView.statsView.inteBar,
					mainView.statsView.libBar,
					mainView.statsView.sensBar,
					mainView.statsView.corBar,
					//Combat stats
					mainView.statsView.HPBar,
					mainView.statsView.lustBar,
					mainView.statsView.fatigueBar,
					//mainView.statsView.soulforceBar,
					mainView.statsView.hungerBar,
					//Prison stats
					mainView.statsView.willBar,
					mainView.statsView.esteemBar,
					mainView.statsView.obeyBar,
					//Advancement
					mainView.statsView.xpBar
				);
			}
			//Set background
			mainView.background.bitmapClass          = MainView.Backgrounds[flags[kFLAGS.BACKGROUND_STYLE]];
			mainView.statsView.sideBarBG.bitmapClass = StatsLayout.SidebarBackgrounds[flags[kFLAGS.BACKGROUND_STYLE]];
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

		public function hideSprite():void {
			// Inlined from lib/src/coc/view/MainView.as
			mainView.sprite.visible = false;
		}
		public function showSpriteBitmap(bmp:BitmapData):void {
			if (!bmp) return;
			var element:BitmapDataSprite = mainView.sprite;
			element.visible = true;
			var scale:Number = 80 / bmp.height;
			element.scaleX = scale;
			element.scaleY = scale;
			element.graphics.clear();
			element.graphics.beginBitmapFill(bmp,null,false,false);
			element.graphics.drawRect(0, 0, bmp.width, bmp.height);
			element.graphics.endFill();
		}
		//------------
		// REFRESH
		//------------
		public function refreshStats():void {
			Begin("MainViewManager","refreshStats");
			var baseHeight:Number = 26;
			var baseWidth:Number = 170;
			//var universalAlpha:Number = 0.4;
			var gapDiff:Number = 30;
			if (!barsDecorated) {
				initializeMarkers();
			}
			//showSoulforceBar()
			Begin("MainViewManager","refreshStats.showHideBars");
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
			End("MainViewManager","refreshStats.showHideBars");
			Begin("MainViewManager","refreshStats.calc");
			var maxes:Object = player.getAllMaxStats();
			var maxStr:int        = maxes.str;
			var maxTou:int        = maxes.tou;
			var maxSpe:int        = maxes.spe;
			var maxInt:int        = maxes.inte;
			var maxLib:int        = maxes.lib;
			var maxHP:Number      = player.maxHP();
			var maxLust:Number    = player.maxLust();
			var maxFatigue:Number = player.maxFatigue();
			var maxHunger:Number  = player.maxHunger();
			var requiredXP:int    = player.requiredXP();
			End("MainViewManager","refreshStats.calc");
			//Set bars
			Begin("MainViewManager","refreshStats.bars");
			mainView.statsView.strBar.width  = (player.str * (baseWidth / maxStr));
			mainView.statsView.touBar.width  = (player.tou * (baseWidth / maxTou));
			mainView.statsView.speBar.width  = (player.spe * (baseWidth / maxSpe));
			mainView.statsView.inteBar.width = (player.inte * (baseWidth / maxInt));
			mainView.statsView.libBar.width  = (player.lib * (baseWidth / maxLib));
			mainView.statsView.sensBar.width = (player.sens * (baseWidth / 100));
			mainView.statsView.corBar.width  = (player.cor * (baseWidth / 100));

			mainView.statsView.HPBar.width      = ((player.HP / maxHP * 100) * (baseWidth / 100));
			mainView.statsView.lustBar.width    = ((player.lust / maxLust * 100) * (baseWidth / 100));
			mainView.statsView.minLustBar.width = ((player.minLust() / maxLust * 100) * (baseWidth / 100));
			mainView.statsView.fatigueBar.width = ((player.fatigue / maxFatigue * 100) * (baseWidth / 100));
			//mainView.soulforceBar.width = ((player.soulforce / player.maxSoulforce() * 100) * (baseWidth / 100));
			
			//Hunger bar
			mainView.statsView.hungerBar.width = ((player.hunger / maxHunger * 100) * (baseWidth / 100));
			//Experience bar.
			if (!prison.inPrison) {
				if (player.level < kGAMECLASS.levelCap) mainView.statsView.xpBar.width = (((player.XP / requiredXP) * 100) * (baseWidth / 100));
				else mainView.statsView.xpBar.width = (100 * (baseWidth / 100)); //Display XP bar at 100% if level is capped.
				if (player.XP >= requiredXP) mainView.statsView.xpBar.width = baseWidth; //Set to 100% if XP exceeds the requirement.
			}
			//Prison bars
			else {
				mainView.statsView.esteemBar.width = (player.esteem * (baseWidth / 100));
				mainView.statsView.willBar.width = (player.will * (baseWidth / 100));
				mainView.statsView.obeyBar.width = (player.obey * (baseWidth / 100));
			}
			End("MainViewManager","refreshStats.bars");
			Begin("MainViewManager","refreshStats.stats");
			mainView.statsView.strNum.text = String(Math.floor(player.str));
			mainView.statsView.touNum.text = String(Math.floor(player.tou));
			mainView.statsView.speNum.text = String(Math.floor(player.spe));
			mainView.statsView.inteNum.text = String(Math.floor(player.inte));
			mainView.statsView.libNum.text = String(Math.floor(player.lib));
			mainView.statsView.senNum.text = String(Math.floor(player.sens));
			mainView.statsView.corNum.text = String(Math.floor(player.cor));
			//Old interface is removed for now.
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) 
			mainView.statsView.HPNum.text = Math.floor(player.HP) + "/" + Math.floor(maxHP);
			//else mainView.HPNum.text = "" + Math.floor(player.HP);
			
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) 
			mainView.statsView.lustNum.text = Math.floor(player.lust) + "/" + maxLust;
			//else mainView.lustNum.text = "" + Math.floor(player.lust);
			
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) 
			mainView.statsView.fatigueNum.text = Math.floor(player.fatigue) + "/" + maxFatigue;
			//else Math.floor(player.fatigue);
			
			/*if (player.findPerk(PerkLib.JobSoulCultivator) >= 0 && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75 && flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
				showSoulforceBar();
				mainView.soulforceNum.text = Math.floor(player.soulforce) + "/" + player.maxSoulforce();
			}
			else {
				hideSoulforceBar();
			}
			*/
			if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || prison.inPrison) && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75 && flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
				showHungerBar();
				mainView.statsView.hungerNum.text = Math.floor(player.hunger) + "/" + maxHunger;
			}
			else {
				hideHungerBar();
			}
			End("MainViewManager","refreshStats.stats");
			Begin("MainViewManager","refreshStats.hacks");
			if (prison.inPrison) {
				showPrisonBar();
				mainView.statsView.willNum.text = Math.floor(player.will) + ""; //"/" + 100;
				mainView.statsView.esteemNum.text = Math.floor(player.esteem) + ""; //"/" + 100;
				mainView.statsView.obeyNum.text = Math.floor(player.obey) + ""; //"/" + player.obeySoftCap ? 50 : 100;
			}
			else {
				hidePrisonBar();
			}
			//Display experience numbers.
			mainView.statsView.levelNum.text = String(player.level);
			if (player.level < kGAMECLASS.levelCap) mainView.statsView.xpNum.text = Math.floor(player.XP) + "/" + Math.floor(requiredXP);
			else mainView.statsView.xpNum.text = "MAX";
			mainView.statsView.gemsNum.text = addComma(Math.floor(player.gems)) + "";
			
			//Get rid of the space before colon. (For new)
			//if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
				mainView.statsView.strText.text = "Strength:";
				mainView.statsView.touText.text = "Toughness:";
				mainView.statsView.speText.text = "Speed:";
				mainView.statsView.inteText.text = "Intelligence:";
				mainView.statsView.libText.text = "Libido:";
				mainView.statsView.senText.text = "Sensitivity:";
				mainView.statsView.corText.text = "Corruption:";
				mainView.statsView.HPText.text = "HP:";
				mainView.statsView.lustText.text = "Lust:";
				mainView.statsView.fatigueText.text = "Fatigue:";
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
			mainView.statsView.nameText.htmlText = "<b>Name: " + player.short + "</b>";
			if (prison.inPrison) mainView.statsView.advancementText.htmlText = "<b>Prison Stats</b>";
			else mainView.statsView.advancementText.htmlText = "<b>Advancement</b>";
			
			//Time display
			End("MainViewManager","refreshStats.hacks");
			Begin("MainViewManager","refreshStats.time");
			mainView.statsView.timeBG.alpha = 0;
			var minutesDisplay:String = "";
			if (model.time.minutes < 10) minutesDisplay = "0" + model.time.minutes;
			else minutesDisplay = "" + model.time.minutes;
			mainView.statsView.timeText.htmlText = "<u>Day#: " + model.time.days + "</u>\n";
			if (flags[kFLAGS.USE_12_HOURS] == 0) {
				mainView.statsView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "";
			}
			else {
				if (model.time.hours < 12) {
					if (model.time.hours == 0) mainView.statsView.timeText.htmlText += "Time: " + (model.time.hours + 12) + ":" + minutesDisplay + "am";
					else mainView.statsView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "am";
				}
				else {
					if (model.time.hours == 12) mainView.statsView.timeText.htmlText += "Time: " + model.time.hours + ":" + minutesDisplay + "pm";
					else mainView.statsView.timeText.htmlText += "Time: " + (model.time.hours - 12) + ":" + minutesDisplay + "pm";
				}
			}
			//if (timeTextFormat != null) mainView.timeText.setTextFormat(timeTextFormat);

			End("MainViewManager","refreshStats.time");
			Begin("MainViewManager","setTheme");
			//Set theme!
			setTheme();
			End("MainViewManager","setTheme");
			End("MainViewManager","refreshStats");
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
			if(event.keyCode == Keyboard.SHIFT) {
				flags[kFLAGS.SHIFT_KEY_DOWN] = 1;
			}
		}
		public function keyReleased(event:KeyboardEvent):void {
			if(event.keyCode == Keyboard.SHIFT) {
				flags[kFLAGS.SHIFT_KEY_DOWN] = 0;
			}
		}
		public function traceSelf():void {
			function chdump(obj:DisplayObject, depth:int, alpha:Number, visible:Boolean, scaleX:Number, scaleY:Number):void {
				alpha = alpha*obj.alpha;
				visible = visible && obj.visible;
				scaleX = scaleX * obj.scaleX;
				scaleY = scaleY * obj.scaleY;
				var s:String = repeatString("  ",depth) +
							   getQualifiedClassName(obj) +
							   " '" + obj.name + "' ("
							   + (obj.x|0) + ","+(obj.y|0)+"; "
							   + (obj.width|0)+"x"+(obj.height|0)+
							   "), a="+obj.alpha+"="+alpha+
							   ", v="+obj.visible+"="+visible+
							   ", sx="+obj.scaleX+"="+scaleX+
							   ", sy="+obj.scaleY+"="+scaleY;
				if (obj is DisplayObjectContainer) {
					var doc:DisplayObjectContainer = obj as DisplayObjectContainer;
					var i:int, n:int= doc.numChildren;
					trace(s+":");
					for (i = 0; i < n; i++) {
						var child:DisplayObject = doc.getChildAt(i);
						chdump(child, depth + 1,alpha,visible,scaleX,scaleY);
					}
				} else {
					trace(s+";");
				}
			}
			var obj:Stage = getGame().stage;
			chdump(obj, 0, obj.alpha,obj.visible,obj.scaleX,obj.scaleY);
		}
	}
}