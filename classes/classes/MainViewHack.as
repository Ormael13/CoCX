//The ultimate code to hack the main view. Because the SWC file isn't editable at the time, I've written this code to hack the main view.
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
	
    import flash.text.TextField;
	import flash.text.TextFieldType;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	import flash.text.TextFieldAutoSize;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	import flash.utils.Timer;
	
	//import fl.transition.Tween;
	//import fl.transition.easing.*
	
	public class MainViewHack extends BaseContent
	{
		//Interface flags
		public var registeredShiftKey:Boolean = false;
		public var reassigned:Boolean = false;
		//public var minLustBar:MovieClip = new MovieClip();
		//public var minLustBarCreated:Boolean = false;
		public var initializedThirdRow:Boolean = false;
		public var initializedGradients:Boolean = false;
		
		public const textColorArray:Array = [null, null, null, 0xFFFFFF, 0xFFFFFF, null, null, null, null, null];
		public const mainColorArray:Array = [null, null, null, null, 0xFFFFFF, null, null, null, null, null];
		public const barAlphaArray:Array = [0.4, 0.4, 0.5, 1, 1, 1, 1, 1, 1, 1];
		
		public var statsHidden:Boolean = false;
		public var buttonsTweened:Boolean = false;
		
		//Format		
		private var oldFormat:TextFormat;
		private var newFormat:TextFormat;
		private var sidebarTextSize:int;
		private var sidebarNumberSize:int;
		//private var oldFormatLarge:TextFormat;
		//private var timeTextFormat:TextFormat;
		
		private var arraySet:Boolean = false;
		public var colorableTexts:Array = [];
		public var fontableTexts:Array = []; //Will be used for font adjustment..
		public var bars:Array = [];

		private var universalAlpha:Number = 0.4;
		
		public function MainViewHack() 
		{
			
		}
		
		//Reassign parents
		private function reassignParents():void {
			//Willpower
			if (mainView.getChildByName("willBar") != null) {
				mainView.statsView.addChild(mainView.willBar);
			}
			if (mainView.statsView.getChildByName("willBar") != null) {
				mainView.statsView.setChildIndex(mainView.willBar, 1);
			}
			if (mainView.getChildByName("willNum") != null) {
				mainView.statsView.addChild(mainView.willNum);
			}
			if (mainView.statsView.getChildByName("willNum") != null) {
				mainView.statsView.setChildIndex(mainView.willNum, 1);
				mainView.willNum.selectable = true;
			}
			if (mainView.getChildByName("willText") != null) {
				mainView.statsView.addChild(mainView.willText);
			}
			if (mainView.statsView.getChildByName("willText") != null) {
				mainView.statsView.setChildIndex(mainView.willText, 1);
				mainView.willText.selectable = true;
			}
			if (mainView.getChildByName("willUp") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.willUp);
			}
			if (mainView.getChildByName("willDown") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.willDown);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("willUp") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.willUp, 1);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("willDown") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.willDown, 1);
			}
			
			//Esteem
			if (mainView.getChildByName("esteemBar") != null) {
				mainView.statsView.addChild(mainView.esteemBar);
			}
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.statsView.setChildIndex(mainView.esteemBar, 1);
			}
			if (mainView.getChildByName("esteemNum") != null) {
				mainView.statsView.addChild(mainView.esteemNum);
			}
			if (mainView.statsView.getChildByName("esteemNum") != null) {
				mainView.statsView.setChildIndex(mainView.esteemNum, 1);
				mainView.esteemNum.selectable = true;
			}
			if (mainView.getChildByName("esteemText") != null) {
				mainView.statsView.addChild(mainView.esteemText);
			}
			if (mainView.statsView.getChildByName("esteemText") != null) {
				mainView.statsView.setChildIndex(mainView.esteemText, 1);
				mainView.esteemText.selectable = true;
			}
			if (mainView.getChildByName("esteemUp") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.esteemUp);
			}
			if (mainView.getChildByName("esteemDown") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.esteemDown);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("esteemUp") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.esteemUp, 1);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("esteemDown") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.esteemDown, 1);
			}
			
			//Obedience
			if (mainView.getChildByName("obeyBar") != null) {
				mainView.statsView.addChild(mainView.obeyBar);
			}
			if (mainView.statsView.getChildByName("obeyBar") != null) {
				mainView.statsView.setChildIndex(mainView.obeyBar, 1);
			}
			if (mainView.getChildByName("obeyNum") != null) {
				mainView.statsView.addChild(mainView.obeyNum);
			}
			if (mainView.statsView.getChildByName("obeyNum") != null) {
				mainView.statsView.setChildIndex(mainView.obeyNum, 1);
				mainView.obeyNum.selectable = true;
			}
			if (mainView.getChildByName("obeyText") != null) {
				mainView.statsView.addChild(mainView.obeyText);
			}
			if (mainView.statsView.getChildByName("obeyText") != null) {
				mainView.statsView.setChildIndex(mainView.obeyText, 1);
				mainView.obeyText.selectable = true;
			}
			if (mainView.getChildByName("obeyUp") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.obeyUp);
			}
			if (mainView.getChildByName("obeyDown") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.obeyDown);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("obeyUp") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.obeyUp, 1);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("obeyDown") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.obeyDown, 1);
			}
		}
		
		private function reassignIndex():void {
			//Prison stats
			//if (mainView.statsView.getChildByName("hungerBar") != null) mainView.statsView.setChildIndex(mainView.hungerBar, 40);
			//if (mainView.statsView.getChildByName("hungerText") != null) mainView.statsView.setChildIndex(mainView.hungerText, 40);
			//if (mainView.statsView.getChildByName("hungerNum") != null) mainView.statsView.setChildIndex(mainView.hungerNum, 40);
			if (mainView.statsView.getChildByName("willBar") != null) mainView.statsView.setChildIndex(mainView.willBar, 40);
			if (mainView.statsView.getChildByName("willText") != null) mainView.statsView.setChildIndex(mainView.willText, 40);
			if (mainView.statsView.getChildByName("willNum") != null) mainView.statsView.setChildIndex(mainView.willNum, 40);
			if (mainView.statsView.getChildByName("esteemBar") != null) mainView.statsView.setChildIndex(mainView.esteemBar, 40);
			if (mainView.statsView.getChildByName("esteemText") != null) mainView.statsView.setChildIndex(mainView.esteemText, 40);
			if (mainView.statsView.getChildByName("esteemNum") != null) mainView.statsView.setChildIndex(mainView.esteemNum, 40);
			if (mainView.statsView.getChildByName("obeyBar") != null) mainView.statsView.setChildIndex(mainView.obeyBar, 40);
			if (mainView.statsView.getChildByName("obeyText") != null) mainView.statsView.setChildIndex(mainView.obeyText, 40);
			if (mainView.statsView.getChildByName("obeyNum") != null) mainView.statsView.setChildIndex(mainView.obeyNum, 50);
			//mainView.statsView.setChildIndex(mainView.xpNum, 44);
			//if (mainView.statsView.getChildByName("minLustBar") != null) mainView.statsView.setChildIndex(minLustBar, 44);
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
			}
		}
		public function showHungerBar():void {
			if (mainView.statsView.getChildByName("hungerBar") != null) {
				mainView.hungerBar.visible = true;
				mainView.hungerNum.visible = true;
				mainView.hungerText.visible = true;
				//mainView.hungerDown.visible = false;
				//mainView.hungerUp.visible = false;
			}
		}
		
		public function hidePrisonBar():void {
			mainView.levelNum.visible = true;
			mainView.levelText.visible = true;
			mainView.xpNum.visible = true;
			mainView.xpText.visible = true;
			mainView.gemsNum.visible = true;
			mainView.gemsText.visible = true;
			if (mainView.statsView.getChildByName("willBar") != null) {
				mainView.willBar.visible = false;
				mainView.willNum.visible = false;
				mainView.willText.visible = false;
				mainView.willDown.visible = false;
				mainView.willUp.visible = false;
			}
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.esteemBar.visible = false;
				mainView.esteemNum.visible = false;
				mainView.esteemText.visible = false;
				mainView.esteemDown.visible = false;
				mainView.esteemUp.visible = false;
			}
			if (mainView.statsView.getChildByName("obeyBar") != null) {
				mainView.obeyBar.visible = false;
				mainView.obeyNum.visible = false;
				mainView.obeyText.visible = false;
				mainView.obeyDown.visible = false;
				mainView.obeyUp.visible = false;
			}
		}
		public function showPrisonBar():void {
			mainView.levelNum.visible = false;
			mainView.levelText.visible = false;
			mainView.xpNum.visible = false;
			mainView.xpText.visible = false;
			mainView.gemsNum.visible = false;
			mainView.gemsText.visible = false;
			if (mainView.statsView.getChildByName("willBar") != null) {
				if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.willBar.visible = true;
				mainView.willNum.visible = true;
				mainView.willText.visible = true;
				//mainView.willDown.visible = false;
				//mainView.willUp.visible = false;
			}
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.esteemBar.visible = true;
				mainView.esteemNum.visible = true;
				mainView.esteemText.visible = true;
				//mainView.esteemDown.visible = false;
				//mainView.esteemUp.visible = false;
			}
			if (mainView.statsView.getChildByName("obeyBar") != null) {
				if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) mainView.obeyBar.visible = true;
				mainView.obeyNum.visible = true;
				mainView.obeyText.visible = true;
				//mainView.obeyDown.visible = false;
				//mainView.obeyUp.visible = false;
			}
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
				//sidebarTextSize = mainView.strText.getTextFormat().size;
				//sidebarNumSize = mainView.strNum.getTextFormat().size;
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
			var posOffset:Number = 14;
			var posTextOffset:Number = 18;
			var arrowXOffset:Number = 3;
			var basePos:Number = 120;
			var basePos2:Number = 360;
			var basePos3:Number = 530;
			var baseHeight:Number = 26;
			var baseWidth:Number = 170;
			//var universalAlpha:Number = 0.4;
			var gapDiff:Number = 30;
			//Initialize min lust bar.
			//Reassign parents.
			if (!reassigned) {
				reassignParents();
				reassignIndex();
				reassigned = true;
			}
			//Old interface
			/*if (flags[kFLAGS.USE_OLD_INTERFACE] > 0) {
				posOffset = 10;
				posTextOffset = 28;
				basePos2 = 400;
				baseWidth = 115;
				baseHeight = 22;
				universalAlpha = 1;
				gapDiff = 40;
				hideHungerBar();
				hidePrisonBar();
				hideExperienceBar();
				hideMinLustBar();
				//return;
			}*/
			else {
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
				else mainView.xpBar.width = (100 * (baseWidth / 100)); //Level is capped at 100.
				if (player.XP >= player.requiredXP()) mainView.xpBar.width = baseWidth; //Set to 100% if XP exceeds the requirement.
			}
			//Prison bars
			else {
				//Willpower
				mainView.willBar.x = mainView.levelText.x;
				mainView.willBar.y = mainView.levelText.y;
				mainView.willBar.alpha = universalAlpha;
				mainView.willBar.height = baseHeight;
				mainView.willBar.width = (player.will * (baseWidth / 100));
				//Esteem
				mainView.esteemBar.x = mainView.xpText.x;
				mainView.esteemBar.y = mainView.xpText.y;
				mainView.esteemBar.alpha = universalAlpha;
				mainView.esteemBar.height = baseHeight;
				mainView.esteemBar.width = (player.esteem * (baseWidth / 100));
				//Obedience
				mainView.obeyBar.x = mainView.gemsText.x;
				mainView.obeyBar.y = mainView.gemsText.y;
				mainView.obeyBar.alpha = universalAlpha;
				mainView.obeyBar.height = baseHeight;
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
				mainView.willNum.x = mainView.strNum.x;
				mainView.willNum.y = mainView.levelNum.y;
				mainView.willNum.width = mainView.strNum.width;
				mainView.willNum.text = Math.floor(player.will) + ""; //"/" + 100;
				mainView.willText.x = mainView.levelText.x;
				mainView.willText.y = mainView.levelText.y;
				mainView.esteemNum.x = mainView.strNum.x;
				mainView.esteemNum.y = mainView.xpNum.y;
				mainView.esteemNum.width = mainView.strNum.width;
				mainView.esteemNum.text = Math.floor(player.esteem) + ""; //"/" + 100;
				mainView.esteemText.x = mainView.xpText.x;
				mainView.esteemText.y = mainView.xpText.y;
				mainView.obeyNum.x = mainView.strNum.width;
				mainView.obeyNum.y = mainView.gemsNum.y;
				mainView.obeyNum.width = mainView.strNum.x;
				mainView.obeyNum.text = Math.floor(player.obey) + ""; //"/" + player.obeySoftCap ? 50 : 100;
				mainView.obeyText.x = mainView.gemsText.x;
				mainView.obeyText.y = mainView.gemsText.y;
			}
			else {
				hidePrisonBar();
			}
			//Display experience numbers.
			mainView.levelNum.text = String(player.level);
			if (player.level < kGAMECLASS.levelCap) mainView.xpNum.text = Math.floor(player.XP) + "/" + Math.floor(player.requiredXP());
			else mainView.xpNum.text = "MAX";
			mainView.gemsNum.text = addComma(Math.floor(player.gems)) + "";
			//Prison stats
			mainView.willUp.x = mainView.willNum.x + mainView.willNum.width + arrowXOffset;
			mainView.willUp.y = mainView.willNum.y;
			mainView.willDown.x = mainView.willNum.x + mainView.willNum.width + arrowXOffset;
			mainView.willDown.y = mainView.willNum.y;
			mainView.esteemUp.x = mainView.esteemNum.x + mainView.esteemNum.width + arrowXOffset;
			mainView.esteemUp.y = mainView.esteemNum.y;
			mainView.esteemDown.x = mainView.esteemNum.x + mainView.esteemNum.width + arrowXOffset;
			mainView.esteemDown.y = mainView.esteemNum.y;
			mainView.obeyUp.x = mainView.obeyNum.x + mainView.obeyNum.width + arrowXOffset;
			mainView.obeyUp.y = mainView.obeyNum.y;
			mainView.obeyDown.x = mainView.obeyNum.x + mainView.obeyNum.width + arrowXOffset;
			mainView.obeyDown.y = mainView.obeyNum.y;
			
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
				mainView.HPText.width = 50;
				mainView.lustText.text = "Lust:";
				mainView.lustText.width = 50;
				mainView.fatigueText.text = "Fatigue:";
				mainView.fatigueText.width = 80;
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
		
		public function setOldSprite():void {

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
	}
}