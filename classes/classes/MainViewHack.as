//The ultimate code to hack the main view. Because the SWC file isn't editable at the time, I've written this code to hack the main view.
package classes 
{
	import classes.*
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import coc.view.CoCButton;
	import flash.display.Shape;
	import flash.text.TextFormat;
	
	import coc.view.MainView;

	import flash.events.MouseEvent;

	import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.DisplayObject;
	import flash.display.DisplayObjectContainer;
	
    import flash.text.TextField;
	import flash.text.AntiAliasType;
	import flash.text.Font;
	import flash.text.TextFormat;
	import flash.text.TextFormatAlign;
	
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	
	public class MainViewHack extends BaseContent
	{
		public var registeredShiftKey:Boolean = false;
		public var reassigned:Boolean = false;
		public var minLustBar:* = null;
		public var initializedThirdRow:Boolean = false;
		
		private var _textFormatButton:TextFormat;
		private var _textFont:Font;
		
		public function MainViewHack() 
		{
			
		}
		
		//Add third row of buttons. (Buttons #11-15, will use numbers 10-14 for addButtons, only called once. If invoked, it blocks further invokements of this function.)
		public function addThirdRow():void {
			if (initializedThirdRow) return;
			var posOffset:int = 45;
			InitFormatting();
			//Push to text field
			var counter:Number = 0;
			while (counter < 5) {
				var field:TextField = new TextField;
				field.defaultTextFormat = _textFormatButton;
				field.antiAliasType = AntiAliasType.ADVANCED;
				field.embedFonts = true;
				mainView.bottomButtonTexts.push(field);
				counter++;
			}
			counter = 0;
			while (counter < 5) {
				mainView.bottomButtonBGs.push(new MovieClip);
				counter++;
			}
			counter = 0;
			while (counter < 5) {
				mainView.bottomButtonBGs.push(new MovieClip);
				counter++;
			}
			//Re-position buttons
			mainView.bottomButtons[5].y = mainView.bottomButtons[0].y + posOffset;
			mainView.bottomButtons[6].y = mainView.bottomButtons[1].y + posOffset;
			mainView.bottomButtons[7].y = mainView.bottomButtons[2].y + posOffset;
			mainView.bottomButtons[8].y = mainView.bottomButtons[3].y + posOffset;
			mainView.bottomButtons[9].y = mainView.bottomButtons[4].y + posOffset;
			//Create buttons
			var button10:CoCButton = new CoCButton(mainView.bottomButtonTexts[10], new buttonBackground0);
			var button11:CoCButton = new CoCButton(mainView.bottomButtonTexts[11], new buttonBackground1);
			var button12:CoCButton = new CoCButton(mainView.bottomButtonTexts[12], new buttonBackground2);
			var button13:CoCButton = new CoCButton(mainView.bottomButtonTexts[13], new buttonBackground3);
			var button14:CoCButton = new CoCButton(mainView.bottomButtonTexts[14], new buttonBackground4);
			mainView.bottomButtons.push(button10);
			mainView.bottomButtons[10].x = mainView.bottomButtons[5].x;
			mainView.bottomButtons[10].y = mainView.bottomButtons[5].y + posOffset;
			mainView.bottomButtons[10].width = mainView.bottomButtons[5].width;
			mainView.addChildAt(button10, 11);
			mainView.bottomButtons.push(button11);
			mainView.bottomButtons[11].x = mainView.bottomButtons[6].x;
			mainView.bottomButtons[11].y = mainView.bottomButtons[6].y + posOffset;
			mainView.bottomButtons[11].width = mainView.bottomButtons[6].width;
			mainView.addChildAt(button11, 12);
			mainView.bottomButtons.push(button12);
			mainView.bottomButtons[12].x = mainView.bottomButtons[7].x;
			mainView.bottomButtons[12].y = mainView.bottomButtons[7].y + posOffset;
			mainView.bottomButtons[12].width = mainView.bottomButtons[7].width;
			mainView.addChildAt(button12, 13);
			mainView.bottomButtons.push(button13);
			mainView.bottomButtons[13].x = mainView.bottomButtons[8].x;
			mainView.bottomButtons[13].y = mainView.bottomButtons[8].y + posOffset;
			mainView.bottomButtons[13].width = mainView.bottomButtons[8].width;
			mainView.addChildAt(button13, 14);
			mainView.bottomButtons.push(button14);
			mainView.bottomButtons[14].x = mainView.bottomButtons[9].x;
			mainView.bottomButtons[14].y = mainView.bottomButtons[9].y + posOffset;
			mainView.bottomButtons[14].width = mainView.bottomButtons[9].width;
			mainView.addChildAt(button14, 15);
			//Make hand cursor show up.
			mainView.newGameButton.mouseChildren = false;
			mainView.newGameButton.buttonMode = true;
			mainView.dataButton.mouseChildren = false;
			mainView.dataButton.buttonMode = true;
			mainView.statsButton.mouseChildren = false;
			mainView.statsButton.buttonMode = true;
			mainView.levelButton.mouseChildren = false;
			mainView.levelButton.buttonMode = true;
			mainView.perksButton.mouseChildren = false;
			mainView.perksButton.buttonMode = true;
			mainView.appearanceButton.mouseChildren = false;
			mainView.appearanceButton.buttonMode = true;
			var buttonId:Number = 0;
			while (buttonId < mainView.bottomButtons.length) {
				mainView.bottomButtons[buttonId].mouseChildren = false;
				mainView.bottomButtons[buttonId].buttonMode = true;
				mainView.bottomButtons[buttonId].addEventListener(MouseEvent.ROLL_OVER, hoverButton);
				mainView.bottomButtons[buttonId].addEventListener(MouseEvent.ROLL_OUT, dimButton);
				buttonId++;
			}
			initializedThirdRow = true;
		}
		
		protected function hoverButton(event:MouseEvent):void {
			var button:CoCButton;

			button = event.target as CoCButton;

			if(button && button.visible && button.toolTipText) {
				mainView.toolTipView.text = button.toolTipText;
				mainView.toolTipView.showForButton(button);
			}
			else {
				mainView.toolTipView.hide();
			}
		};

		protected function dimButton(event:MouseEvent):void {
			mainView.toolTipView.hide();
		};
		
		//Reassign parents
		private function reassignParents():void {
			//Experience
			if (mainView.getChildByName("obeyBar") != null) {
				mainView.statsView.addChild(mainView.obeyBar);
			}
			if (mainView.statsView.getChildByName("obeyBar") != null) {
				mainView.statsView.setChildIndex(mainView.obeyBar, 1);
			}
			
			//Min Lust
			if (mainView.getChildByName("esteemBar") != null) {
				mainView.statsView.addChild(mainView.esteemBar);
			}
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.statsView.setChildIndex(mainView.esteemBar, 1);
			}			
			
			//Hunger
			if (mainView.getChildByName("hungerBar") != null) {
				mainView.statsView.addChild(mainView.hungerBar);
			}
			if (mainView.statsView.getChildByName("hungerBar") != null) {
				mainView.statsView.setChildIndex(mainView.hungerBar, 1);
			}
			if (mainView.getChildByName("hungerNum") != null) {
				mainView.statsView.addChild(mainView.hungerNum);
			}
			if (mainView.statsView.getChildByName("hungerNum") != null) {
				mainView.statsView.setChildIndex(mainView.hungerNum, 1);
			}
			if (mainView.getChildByName("hungerText") != null) {
				mainView.statsView.addChild(mainView.hungerText);
			}
			if (mainView.statsView.getChildByName("hungerText") != null) {
				mainView.statsView.setChildIndex(mainView.hungerText, 1);
			}
			
		}
		
		private function InitFormatting():void
		{
			_textFont = new ButtonLabelFont();
			
			_textFormatButton = new TextFormat();
			_textFormatButton.font = _textFont.fontName;
			_textFormatButton.size = 18;
			_textFormatButton.align = TextFormatAlign.CENTER;
		}
		
		private function reassignIndex():void {
			//Bars
			mainView.statsView.setChildIndex(mainView.strBar, 20);
			mainView.statsView.setChildIndex(mainView.touBar, 21);
			mainView.statsView.setChildIndex(mainView.inteBar, 22);
			mainView.statsView.setChildIndex(mainView.speBar, 23);
			mainView.statsView.setChildIndex(mainView.libBar, 24);
			mainView.statsView.setChildIndex(mainView.sensBar, 25);
			mainView.statsView.setChildIndex(mainView.corBar, 26);
			
			mainView.statsView.setChildIndex(mainView.HPBar, 27);
			mainView.statsView.setChildIndex(mainView.lustBar, 28);
			mainView.statsView.setChildIndex(mainView.fatigueBar, 29);
			//Numbers
			mainView.statsView.setChildIndex(mainView.strNum, 30);
			mainView.statsView.setChildIndex(mainView.touNum, 31);
			mainView.statsView.setChildIndex(mainView.inteNum, 32);
			mainView.statsView.setChildIndex(mainView.speNum, 33);
			mainView.statsView.setChildIndex(mainView.libNum, 34);
			mainView.statsView.setChildIndex(mainView.senNum, 35);
			mainView.statsView.setChildIndex(mainView.corNum, 36);
			
			mainView.statsView.setChildIndex(mainView.HPNum, 37);
			mainView.statsView.setChildIndex(mainView.lustNum, 38);
			mainView.statsView.setChildIndex(mainView.fatigueNum, 39);
			
			if (mainView.statsView.getChildByName("hungerBar") != null) mainView.statsView.setChildIndex(mainView.hungerBar, 40);
			if (mainView.statsView.getChildByName("hungerText") != null) mainView.statsView.setChildIndex(mainView.hungerText, 41);
			if (mainView.statsView.getChildByName("hungerNum") != null) mainView.statsView.setChildIndex(mainView.hungerNum, 42);
			if (mainView.statsView.getChildByName("obeyBar") != null) mainView.statsView.setChildIndex(mainView.obeyBar, 43);
			if (mainView.statsView.getChildByName("esteemBar") != null) mainView.statsView.setChildIndex(mainView.esteemBar, 28);
			
			mainView.statsView.setChildIndex(mainView.xpNum, 44);
			//if (mainView.statsView.getChildByName("MinLustBar") != null) mainView.statsView.setChildIndex(minLustBar, 44);
			
		}
		
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
				mainView.hungerDown.visible = false;
				mainView.hungerUp.visible = false;
			}
		}
		
		//Hide XP bar. (For old menus)
		public function hideExperienceBar():void {
			if (mainView.statsView.getChildByName("obeyBar") != null) {
				mainView.obeyBar.visible = false;
			}
		}
		public function showExperienceBar():void {
			if (mainView.statsView.getChildByName("obeyBar") != null) {
				mainView.obeyBar.visible = true;
			}
		}
		
		//Hide min lust bar. (For old menus)
		public function hideMinLustBar():void {
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.obeyBar.visible = false;
			}
		}
		public function showMinLustBar():void {
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.obeyBar.visible = true;
			}
		}
		
		public function refreshStats():void {
			var posOffset:Number = 14;
			var posTextOffset:Number = 18;
			var arrowXOffset:Number = 3;
			var basePos:Number = 100;
			var basePos2:Number = 360;
			var baseHeight:Number = 26;
			var baseWidth:Number = 170;
			var universalAlpha:Number = 0.4;
			var gapDiff:Number = 30;
			
			if (flags[kFLAGS.USE_OLD_INTERFACE] >= 1) {
				posOffset = 10;
				posTextOffset = 28;
				basePos2 = 400;
				baseWidth = 115;
				baseHeight = 22;
				universalAlpha = 1;
				gapDiff = 40;
				hideHungerBar();
				hideExperienceBar();
				hideMinLustBar();
				//return;
			}
			else {
				showHungerBar();
				showExperienceBar();
				showMinLustBar();			
			}

			if (!reassigned){
				reassignParents();
				reassignIndex();
				reassigned = true;
			}

			//Set bars
			mainView.strBar.width = (player.str * (baseWidth / player.getMaxStats("str")));
			mainView.strBar.height = baseHeight;
			mainView.strBar.y = basePos + (gapDiff * 1) - posOffset;
			mainView.strBar.alpha = universalAlpha;
			mainView.touBar.width = (player.tou * (baseWidth / player.getMaxStats("tou")));
			mainView.touBar.height = baseHeight;
			mainView.touBar.y = basePos + (gapDiff * 2) - posOffset;
			mainView.touBar.alpha = universalAlpha;
			mainView.speBar.width = (player.spe * (baseWidth / player.getMaxStats("spe")));
			mainView.speBar.height = baseHeight;
			mainView.speBar.y = basePos + (gapDiff * 3) - posOffset;
			mainView.speBar.alpha = universalAlpha;
			mainView.inteBar.width = (player.inte * (baseWidth / player.getMaxStats("inte")));
			mainView.inteBar.height = baseHeight;
			mainView.inteBar.y = basePos + (gapDiff * 4) - posOffset;
			mainView.inteBar.alpha = universalAlpha;
			mainView.libBar.width = (player.lib * (baseWidth / 100));
			mainView.libBar.height = baseHeight;
			mainView.libBar.y = basePos + (gapDiff * 5) - posOffset;
			mainView.libBar.alpha = universalAlpha;
			mainView.sensBar.width = (player.sens * (baseWidth / 100));
			mainView.sensBar.height = baseHeight;
			mainView.sensBar.y = basePos + (gapDiff * 6) - posOffset;
			mainView.sensBar.alpha = universalAlpha;
			mainView.corBar.width = (player.cor * (baseWidth / 100));
			mainView.corBar.height = baseHeight;
			mainView.corBar.y = basePos + (gapDiff * 7) - posOffset;
			mainView.corBar.alpha = universalAlpha;

			mainView.HPBar.width = ((player.HP / player.maxHP() * 100) * (baseWidth / 100));
			mainView.HPBar.height = baseHeight;
			mainView.HPBar.y = basePos2 + (gapDiff * 1) - posOffset;
			mainView.HPBar.alpha = universalAlpha;
			mainView.lustBar.width = ((player.lust / player.maxLust() * 100) * (baseWidth / 100));
			mainView.lustBar.height = baseHeight;
			mainView.lustBar.y = basePos2 + (gapDiff * 2) - posOffset;
			mainView.lustBar.alpha = universalAlpha;
			mainView.fatigueBar.width = ((player.fatigue / player.maxFatigue() * 100) * (baseWidth / 100));
			mainView.fatigueBar.height = baseHeight;
			mainView.fatigueBar.y = basePos2 + (gapDiff * 3) - posOffset;
			mainView.fatigueBar.alpha = universalAlpha;
			//Minimum lust bar
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.esteemBar.x = mainView.lustBar.x;
				mainView.esteemBar.y = mainView.lustBar.y;
				mainView.esteemBar.height = mainView.lustBar.height;
				mainView.esteemBar.width = ((player.minLust() / player.maxLust() * 100) * (baseWidth / 100));
				mainView.esteemBar.alpha = universalAlpha;
			}
			
			//Hunger bar
			mainView.hungerBar.x = 6;
			mainView.hungerBar.y = basePos2 + (gapDiff * 5) - posOffset;
			mainView.hungerBar.width = (player.hunger * (baseWidth / 100));
			mainView.hungerBar.height = baseHeight;
			mainView.hungerBar.alpha = universalAlpha;
			
			//Experience bar.
			mainView.obeyBar.x = 6;
			mainView.obeyBar.y = 608 - posOffset;
			mainView.obeyBar.alpha = universalAlpha;
			mainView.obeyBar.height = baseHeight;
			if (player.level < kGAMECLASS.levelCap) mainView.obeyBar.width = (((player.XP / (player.level * 100)) * 100) * (baseWidth / 100));
			else mainView.obeyBar.width = (100 * (baseWidth / 100)); //Level is capped at 100.
			if (player.XP >= player.level * 100) mainView.obeyBar.width = baseWidth; //Set to 100% if XP exceeds the requirement.
			//Set numbers
			mainView.strText.y = basePos + (gapDiff * 1) - posTextOffset;
			mainView.strNum.y = basePos + (gapDiff * 1) - posTextOffset;
			mainView.touText.y = basePos + (gapDiff * 2) - posTextOffset;
			mainView.touNum.y = basePos + (gapDiff * 2) - posTextOffset;
			mainView.speText.y = basePos + (gapDiff * 3) - posTextOffset;
			mainView.speNum.y = basePos + (gapDiff * 3) - posTextOffset;
			mainView.inteText.y = basePos + (gapDiff * 4) - posTextOffset;
			mainView.inteNum.y = basePos + (gapDiff * 4) - posTextOffset;
			mainView.libText.y = basePos + (gapDiff * 5) - posTextOffset;
			mainView.libNum.y = basePos + (gapDiff * 5) - posTextOffset;
			mainView.senText.y = basePos + (gapDiff * 6) - posTextOffset;
			mainView.senNum.y = basePos + (gapDiff * 6) - posTextOffset;
			mainView.corText.y = basePos + (gapDiff * 7) - posTextOffset;
			mainView.corNum.y = basePos + (gapDiff * 7) - posTextOffset;
			
			mainView.HPNum.x = 1;
			mainView.HPNum.width = 170;
			if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) mainView.HPNum.text = Math.floor(player.HP) + "/" + Math.floor(player.maxHP());
			else mainView.HPNum.text = "" + Math.floor(player.HP);
			mainView.HPNum.y = basePos2 + (gapDiff * 1) - posTextOffset;
			mainView.HPText.y = basePos2 + (gapDiff * 1) - posTextOffset;
			
			mainView.lustNum.x = 1;
			mainView.lustNum.width = 170;
			if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) mainView.lustNum.text = Math.floor(player.lust) + "/" + player.maxLust();
			else mainView.lustNum.text = "" + Math.floor(player.lust);
			mainView.lustNum.y = basePos2 + (gapDiff * 2) - posTextOffset;
			mainView.lustText.y = basePos2 + (gapDiff * 2) - posTextOffset;
			
			mainView.fatigueNum.x = 1;
			mainView.fatigueNum.width = 170;
			if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) mainView.fatigueNum.text = Math.floor(player.fatigue) + "/" + player.maxFatigue();
			else Math.floor(player.fatigue);
			mainView.fatigueNum.y = basePos2 + (gapDiff * 3) - posTextOffset;
			mainView.fatigueText.y = basePos2 + (gapDiff * 3) - posTextOffset;
			
			if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || flags[kFLAGS.IN_PRISON] > 0) && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75 && flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
				showHungerBar();
				mainView.hungerNum.x = 1;
				mainView.hungerNum.width = 170;
				mainView.hungerNum.text = Math.floor(player.hunger) + "/" + 100;
				mainView.hungerNum.y = basePos2 + (gapDiff * 5) - posTextOffset;
				mainView.hungerText.x = 6;
				mainView.hungerText.y = basePos2 + (gapDiff * 5) - posTextOffset;
			}
			else {
				hideHungerBar();
			}
			
			mainView.xpNum.x = 1;
			mainView.xpNum.width = 170;
			if (player.level < kGAMECLASS.levelCap) mainView.xpNum.text = Math.floor(player.XP) + "/" + Math.floor(player.level * 100);
			else mainView.xpNum.text = "MAX";
			
			mainView.gemsNum.x = 1;
			mainView.gemsNum.width = 170;
			mainView.gemsNum.text = addComma(Math.floor(player.gems)) + "";
			
			//Re-position arrows
			mainView.strUp.x = mainView.strNum.x + mainView.strNum.width + arrowXOffset;
			mainView.strUp.y = mainView.strNum.y;
			mainView.strDown.x = mainView.strNum.x + mainView.strNum.width + arrowXOffset;
			mainView.strDown.y = mainView.strNum.y;
			mainView.touUp.x = mainView.touNum.x + mainView.touNum.width + arrowXOffset;
			mainView.touUp.y = mainView.touNum.y;
			mainView.touDown.x = mainView.touNum.x + mainView.touNum.width + arrowXOffset;
			mainView.touDown.y = mainView.touNum.y;
			mainView.speUp.x = mainView.speNum.x + mainView.speNum.width + arrowXOffset;
			mainView.speUp.y = mainView.speNum.y;
			mainView.speDown.x = mainView.speNum.x + mainView.speNum.width + arrowXOffset;
			mainView.speDown.y = mainView.speNum.y;
			mainView.inteUp.x = mainView.inteNum.x + mainView.inteNum.width + arrowXOffset;
			mainView.inteUp.y = mainView.inteNum.y;
			mainView.inteDown.x = mainView.inteNum.x + mainView.inteNum.width + arrowXOffset;
			mainView.inteDown.y = mainView.inteNum.y;
			mainView.libUp.x = mainView.libNum.x + mainView.libNum.width + arrowXOffset;
			mainView.libUp.y = mainView.libNum.y;
			mainView.libDown.x = mainView.libNum.x + mainView.libNum.width + arrowXOffset;
			mainView.libDown.y = mainView.libNum.y;
			mainView.sensUp.x = mainView.senNum.x + mainView.senNum.width + arrowXOffset;
			mainView.sensUp.y = mainView.senNum.y;
			mainView.sensDown.x = mainView.senNum.x + mainView.senNum.width + arrowXOffset;
			mainView.sensDown.y = mainView.senNum.y;
			mainView.corUp.x = mainView.corNum.x + mainView.corNum.width + arrowXOffset;
			mainView.corUp.y = mainView.corNum.y;
			mainView.corDown.x = mainView.corNum.x + mainView.corNum.width + arrowXOffset;
			mainView.corDown.y = mainView.corNum.y;
			
			mainView.hpUp.x = mainView.HPNum.x + mainView.HPNum.width + arrowXOffset;
			mainView.hpUp.y = mainView.HPNum.y;
			mainView.hpDown.x = mainView.HPNum.x + mainView.HPNum.width + arrowXOffset;
			mainView.hpDown.y = mainView.HPNum.y;
			mainView.lustUp.x = mainView.lustNum.x + mainView.lustNum.width + arrowXOffset;
			mainView.lustUp.y = mainView.lustNum.y;
			mainView.lustDown.x = mainView.lustNum.x + mainView.lustNum.width + arrowXOffset;
			mainView.lustDown.y = mainView.lustNum.y;
			mainView.fatigueUp.x = mainView.fatigueNum.x + mainView.fatigueNum.width + arrowXOffset;
			mainView.fatigueUp.y = mainView.fatigueNum.y;
			mainView.fatigueDown.x = mainView.fatigueNum.x + mainView.fatigueNum.width + arrowXOffset;
			mainView.fatigueDown.y = mainView.fatigueNum.y;
			mainView.hungerUp.x = mainView.hungerNum.x + mainView.hungerNum.width + arrowXOffset;
			mainView.hungerUp.y = mainView.hungerNum.y;
			mainView.hungerDown.x = mainView.hungerNum.x + mainView.hungerNum.width + arrowXOffset;
			mainView.hungerDown.y = mainView.hungerNum.y;
			
			//Re-position time display
			mainView.timeBG.x = 0;
			mainView.timeBG.y = 654;
			mainView.timeText.x = 4;
			mainView.timeText.y = 654;

			//Get rid of the space before colon. (For new)
			if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
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
			} else {
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
			}

			mainView.levelText.text = "Level:"
			mainView.levelText.width = 60;
			mainView.xpText.text = "XP:"
			mainView.xpText.width = 60;
			mainView.gemsText.text = "Gems:";
			mainView.gemsText.width = 60;
			
			mainView.hungerText.width = 70;
			
			mainView.coreStatsText.htmlText = "Name: " + player.short + "\nCore Stats";
			if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) mainView.combatStatsText.y = basePos2 - posTextOffset;
			else mainView.combatStatsText.y = basePos2 - 8;
			//Smoothes the text, currently inoperational and thus disabled.
			//mainView.timeText.antiAliasType = AntiAliasType.NORMAL;
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
		}
		
		public function setOldSprite():void {

		}

		public function registerShiftKeys():void {
			if (!registeredShiftKey) {
				mainView.stage.addEventListener(KeyboardEvent.KEY_DOWN, keyPressed);
				mainView.stage.addEventListener(KeyboardEvent.KEY_UP, keyReleased);
				registeredShiftKey = true;
			}
		}
		
		//Allows shift key.
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