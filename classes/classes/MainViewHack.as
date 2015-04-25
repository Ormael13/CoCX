//The ultimate code to hack the main view. Because the SWC file isn't editable at the time, I've written this code to hack the main view.
package classes 
{
	import classes.*
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import coc.view.CoCButton;
	import flash.display.Shape;
	import flash.display.GradientType;
	import flash.events.TimerEvent;
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
	
	import flash.utils.Timer;
	
	//import fl.transition.Tween;
	//import fl.transition.easing.*
	
	public class MainViewHack extends BaseContent
	{
		public var registeredShiftKey:Boolean = false;
		public var reassigned:Boolean = false;
		public var minLustBar:MovieClip = new MovieClip();
		public var minLustBarCreated:Boolean = false;
		public var initializedThirdRow:Boolean = false;
		public var initializedGradients:Boolean = false;
		
		private var _textFormatButton:TextFormat;
		private var _textFont:Font;
		private var _textFormatMainText:TextFormat = new TextFormat();
		
		private var oldFormat:TextFormat;
		private var oldFormatLarge:TextFormat;
		private var timeTextFormat:TextFormat;
		
		public var statsHidden:Boolean = false;
		public var buttonsTweened:Boolean = false;
		
		private var colorableTexts:Array = [];
		private var colorableTextsLarge:Array = [];
		private var colorableTextsHeaders:Array = [];
		private var universalAlpha:Number = 0.4;
		
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
			//Min Lust
			if (minLustBar != null) {
				mainView.statsView.addChild(minLustBar);
			}
			if (mainView.statsView.getChildByName("minLustBar") != null) {
				mainView.statsView.setChildIndex(minLustBar, 1);
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
				mainView.hungerNum.selectable = true;
			}
			if (mainView.getChildByName("hungerText") != null) {
				mainView.statsView.addChild(mainView.hungerText);
			}
			if (mainView.statsView.getChildByName("hungerText") != null) {
				mainView.statsView.setChildIndex(mainView.hungerText, 1);
				mainView.hungerText.selectable = true;
			}
			if (mainView.getChildByName("hungerUp") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.hungerUp);
			}
			if (mainView.getChildByName("hungerDown") != null) {
				mainView.statsView.upDownsContainer.addChild(mainView.hungerDown);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("hungerUp") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.hungerUp, 1);
			}
			if (mainView.statsView.upDownsContainer.getChildByName("hungerDown") != null) {
				mainView.statsView.upDownsContainer.setChildIndex(mainView.hungerDown, 1);
			}
			
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
			
			//Prison stats
			if (mainView.statsView.getChildByName("hungerBar") != null) mainView.statsView.setChildIndex(mainView.hungerBar, 40);
			if (mainView.statsView.getChildByName("hungerText") != null) mainView.statsView.setChildIndex(mainView.hungerText, 40);
			if (mainView.statsView.getChildByName("hungerNum") != null) mainView.statsView.setChildIndex(mainView.hungerNum, 40);
			if (mainView.statsView.getChildByName("willBar") != null) mainView.statsView.setChildIndex(mainView.willBar, 40);
			if (mainView.statsView.getChildByName("willText") != null) mainView.statsView.setChildIndex(mainView.willText, 40);
			if (mainView.statsView.getChildByName("willNum") != null) mainView.statsView.setChildIndex(mainView.willNum, 40);
			if (mainView.statsView.getChildByName("esteemBar") != null) mainView.statsView.setChildIndex(mainView.esteemBar, 40);
			if (mainView.statsView.getChildByName("esteemText") != null) mainView.statsView.setChildIndex(mainView.esteemText, 40);
			if (mainView.statsView.getChildByName("esteemNum") != null) mainView.statsView.setChildIndex(mainView.esteemNum, 40);
			if (mainView.statsView.getChildByName("obeyBar") != null) mainView.statsView.setChildIndex(mainView.obeyBar, 40);
			if (mainView.statsView.getChildByName("obeyText") != null) mainView.statsView.setChildIndex(mainView.obeyText, 40);
			if (mainView.statsView.getChildByName("obeyNum") != null) mainView.statsView.setChildIndex(mainView.obeyNum, 50);
			mainView.statsView.setChildIndex(mainView.xpNum, 44);
			if (mainView.statsView.getChildByName("minLustBar") != null) mainView.statsView.setChildIndex(minLustBar, 44);
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
				//mainView.esteemBar.visible = false; //Needed for XP bar.
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
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.esteemBar.visible = false;
			}
		}
		public function showExperienceBar():void {
			if (mainView.statsView.getChildByName("esteemBar") != null) {
				mainView.esteemBar.visible = true;
			}
		}
		
		//Hide min lust bar. (For old menus)
		public function hideMinLustBar():void {
			if (mainView.statsView.getChildByName("minLustBar") != null) {
				minLustBar.visible = false;
			}
		}
		public function showMinLustBar():void {
			if (mainView.statsView.getChildByName("minLustBar") != null) {
				minLustBar.visible = true;
			}
		}
		
		public function setDarkTheme():void {
			var i:int = 0;
			if (oldFormat == null) oldFormat = mainView.strText.getTextFormat();
			if (oldFormatLarge == null) oldFormatLarge = mainView.strNum.getTextFormat();
			if (timeTextFormat == null) {
				timeTextFormat = mainView.strText.getTextFormat();
				timeTextFormat.size = 18;
			}
			//Main text format
			var mainfmt:TextFormat = new TextFormat();
			mainfmt = mainView.mainText.getTextFormat();
			//Regular font
			var fmt:TextFormat = new TextFormat(); //mainView.b0Text.getTextFormat();
			fmt.font = "Georgia";
			fmt.size = 18;
			//Large font
			var fmt2:TextFormat = new TextFormat(); //mainView.b0Text.getTextFormat();
			fmt2.font = "Georgia";
			fmt2.size = 24;
			if (flags[kFLAGS.USE_DARK_BACKGROUND] > 0) {
				mainfmt.color = 0xFFFFFF;
				mainView.background.alpha = 0;
				mainView.sideBarBG.alpha = 0;
				mainView.timeBG.alpha = 0;
				universalAlpha = 1;
				//Small text (attribute texts)
				for (i = 0; i < colorableTexts.length; i++) {
					if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) {
						colorableTexts[i].embedFonts = false;
						colorableTexts[i].defaultTextFormat = fmt;
						colorableTexts[i].setTextFormat(fmt);
					}
					else {
						colorableTexts[i].embedFonts = true;
						colorableTexts[i].defaultTextFormat = oldFormat;
						colorableTexts[i].setTextFormat(oldFormat);
					}
					colorableTexts[i].textColor = (0xFFFFFF);
				}
				//Large text (attribute numbers)
				for (i = 0; i < colorableTextsLarge.length; i++) {
					if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) {
						colorableTextsLarge[i].embedFonts = false;
						colorableTextsLarge[i].defaultTextFormat = fmt2;
						colorableTextsLarge[i].setTextFormat(fmt2);
					}
					else {
						colorableTextsLarge[i].embedFonts = true;
						colorableTextsLarge[i].defaultTextFormat = oldFormatLarge;
						colorableTextsLarge[i].setTextFormat(oldFormatLarge);
					}
					colorableTextsLarge[i].textColor = (0xFFFFFF);
				}
				for (i = 0; i < colorableTextsHeaders.length; i++) {
					colorableTextsHeaders[i].textColor = (0xFFFFFF);
				}
				_textFormatMainText.color = 0xFFFFFF;
				mainView.mainText.defaultTextFormat = _textFormatMainText;
			}
			else {
				mainfmt.color = null;
				mainView.background.alpha = 1;
				mainView.sideBarBG.alpha = 1;
				mainView.timeBG.alpha = 1;
				universalAlpha = (flags[kFLAGS.USE_OLD_INTERFACE] > 0 ? 1 : 0.4);
				for (i = 0; i < colorableTexts.length; i++) {
					if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) {
						colorableTexts[i].embedFonts = false;
						colorableTexts[i].defaultTextFormat = fmt;
						colorableTexts[i].setTextFormat(fmt);
					}
					else {
						colorableTexts[i].embedFonts = true;
						colorableTexts[i].defaultTextFormat = oldFormat;
						colorableTexts[i].setTextFormat(oldFormat);
					}
					colorableTexts[i].textColor = (0x000000);
				}
				for (i = 0; i < colorableTextsLarge.length; i++) {
					if (flags[kFLAGS.USE_OLD_INTERFACE] == 0) {
						colorableTextsLarge[i].embedFonts = false;
						colorableTextsLarge[i].defaultTextFormat = fmt2;
						colorableTextsLarge[i].setTextFormat(fmt2);
					}
					else {
						colorableTextsLarge[i].embedFonts = true;
						colorableTextsLarge[i].defaultTextFormat = oldFormatLarge;
						colorableTextsLarge[i].setTextFormat(oldFormatLarge);
					}
					colorableTextsLarge[i].textColor = (0x000000);
				}
				for (i = 0; i < colorableTextsHeaders.length; i++) {
					colorableTextsHeaders[i].textColor = (0x000000);
				}
				_textFormatMainText.color = 0x000000;
				mainView.mainText.defaultTextFormat = mainfmt;
			}
		}
		
		//------------
		// REFRESH
		//------------
		public function refreshStats():void {
			colorableTexts = [
				//Core stats
				mainView.strText,
				mainView.touText, 
				mainView.speText, 
				mainView.inteText, 
				mainView.libText, 
				mainView.senText, 
				mainView.corText, 
				//Combat stats 
				mainView.HPText, 
				mainView.lustText, 
				mainView.fatigueText, 
				mainView.hungerText, 
				//Prison stats
				mainView.willText, 
				mainView.esteemText, 
				mainView.obeyText, 
				//Advancement
				mainView.levelText, 
				mainView.xpText, 
				mainView.gemsText
			];
			colorableTextsLarge = [
				//Core stats
				mainView.strNum, 
				mainView.touNum, 
				mainView.speNum, 
				mainView.inteNum, 
				mainView.libNum, 
				mainView.senNum, 
				mainView.corNum, 
				//Combat stats 
				mainView.HPNum, 
				mainView.lustNum, 
				mainView.fatigueNum, 
				mainView.hungerNum, 
				//Prison stats
				mainView.willNum, 
				mainView.esteemNum, 
				mainView.obeyNum, 
				//Advancement
				mainView.levelNum, 
				mainView.xpNum, 
				mainView.gemsNum
			];
			colorableTextsHeaders = [
				mainView.coreStatsText,
				mainView.combatStatsText,
				mainView.advancementText
			];
			var posOffset:Number = 14;
			var posTextOffset:Number = 18;
			var arrowXOffset:Number = 3;
			var basePos:Number = 100;
			var basePos2:Number = 360;
			var basePos3:Number = 576;
			var baseHeight:Number = 26;
			var baseWidth:Number = 170;
			//var universalAlpha:Number = 0.4;
			var gapDiff:Number = 30;
			//Initialize min lust bar.
			if (!minLustBarCreated) {
				minLustBarCreated = true;
				minLustBar.graphics.beginFill(0x660000, 1);
				minLustBar.graphics.drawRect(mainView.statsView.x, mainView.statsView.y, baseWidth, baseHeight);
				minLustBar.graphics.endFill();
				minLustBar.height = baseHeight;
				minLustBar.width = baseWidth;
				minLustBar.x = mainView.lustBar.x;
				minLustBar.y = mainView.lustBar.y;
				minLustBar.alpha = 0.8;
				minLustBar.name = "minLustBar";
			}
			//Reassign parents.
			if (!reassigned){
				reassignParents();
				reassignIndex();
				reassigned = true;
			}
			
			//Old interface
			if (flags[kFLAGS.USE_OLD_INTERFACE] > 0) {
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
			}
			else {
				showHungerBar();
				showExperienceBar();
				showMinLustBar();	
				if (prison.inPrison) {
					showPrisonBar();
				}
				else {
					hidePrisonBar();
					showExperienceBar();
				}
			}
			//Dark background
			setDarkTheme();
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
			if (mainView.statsView.getChildByName("minLustBar") != null) {
				minLustBar.x = mainView.lustBar.x + (baseWidth / 2);
				minLustBar.y = mainView.lustBar.y;
				minLustBar.height = baseHeight;
				minLustBar.width = ((player.minLust() / player.maxLust() * 100) * (baseWidth / 100));
				minLustBar.alpha = universalAlpha;
			}
			//Hunger bar
			mainView.hungerBar.x = 6;
			mainView.hungerBar.y = basePos2 + (gapDiff * 5) - posOffset;
			mainView.hungerBar.width = (player.hunger * (baseWidth / 100));
			mainView.hungerBar.height = baseHeight;
			mainView.hungerBar.alpha = universalAlpha;
			//Experience bar.
			if (!prison.inPrison) {
				mainView.esteemBar.x = 6;
				mainView.esteemBar.y = basePos3 + (gapDiff * 1) - posOffset;
				mainView.esteemBar.alpha = universalAlpha;
				mainView.esteemBar.height = baseHeight;
				if (player.level < kGAMECLASS.levelCap) mainView.esteemBar.width = (((player.XP / player.requiredXP()) * 100) * (baseWidth / 100));
				else mainView.esteemBar.width = (100 * (baseWidth / 100)); //Level is capped at 100.
				if (player.XP >= player.requiredXP()) mainView.esteemBar.width = baseWidth; //Set to 100% if XP exceeds the requirement.
			}
			//Prison bars
			else {
				//Willpower
				mainView.willBar.x = 6;
				mainView.willBar.y = basePos3 + (gapDiff * 0) - posOffset;
				mainView.willBar.alpha = universalAlpha;
				mainView.willBar.height = baseHeight;
				mainView.willBar.width = (player.will * (baseWidth / 100));
				//Esteem
				mainView.esteemBar.x = 6;
				mainView.esteemBar.y = basePos3 + (gapDiff * 1) - posOffset;
				mainView.esteemBar.alpha = universalAlpha;
				mainView.esteemBar.height = baseHeight;
				mainView.esteemBar.width = (player.esteem * (baseWidth / 100));
				//Obedience
				mainView.obeyBar.x = 6;
				mainView.obeyBar.y = basePos3 + (gapDiff * 2) - posOffset;
				mainView.obeyBar.alpha = universalAlpha;
				mainView.obeyBar.height = baseHeight;
				mainView.obeyBar.width = (player.obey * (baseWidth / 100));
			}
			
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
			
			if ((flags[kFLAGS.HUNGER_ENABLED] > 0 || prison.inPrison) && flags[kFLAGS.URTA_QUEST_STATUS] != 0.75 && flags[kFLAGS.USE_OLD_INTERFACE] <= 0) {
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
			if (prison.inPrison) {
				showPrisonBar();
				mainView.willNum.x = 1;
				mainView.willNum.width = 170;
				mainView.willNum.text = Math.floor(player.will) + ""; //"/" + 100;
				mainView.willNum.y = mainView.levelNum.y;
				mainView.willText.x = 6;
				mainView.willText.y = mainView.levelText.y;
				mainView.esteemNum.x = 1;
				mainView.esteemNum.width = 170;
				mainView.esteemNum.text = Math.floor(player.esteem) + ""; //"/" + 100;
				mainView.esteemNum.y = mainView.xpNum.y;
				mainView.esteemText.x = 6;
				mainView.esteemText.y = mainView.xpText.y;
				mainView.gemsNum.text = Math.floor(player.obey) + ""; //Current workaround
				mainView.obeyNum.x = 1;
				mainView.obeyNum.width = 170;
				mainView.obeyNum.text = Math.floor(player.obey) + ""; //"/" + player.obeySoftCap ? 50 : 100;
				mainView.obeyNum.setTextFormat(mainView.esteemNum.getTextFormat());
				mainView.obeyNum.y = mainView.gemsNum.y;
				mainView.obeyText.x = 6;
				mainView.obeyText.y = mainView.gemsText.y;
			}
			else {
				hidePrisonBar();
			}
			//Display experience numbers.
			mainView.xpNum.x = 1;
			mainView.xpNum.width = 170;
			if (player.level < kGAMECLASS.levelCap) mainView.xpNum.text = Math.floor(player.XP) + "/" + Math.floor(player.requiredXP());
			else mainView.xpNum.text = "MAX";
			
			mainView.gemsNum.x = 1;
			mainView.gemsNum.width = 170;
			mainView.gemsNum.text = addComma(Math.floor(player.gems)) + "";
			//Re-position arrows
			//Core stats
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
			//Combat stats
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
			//Prison stats
			mainView.hungerUp.x = mainView.hungerNum.x + mainView.hungerNum.width + arrowXOffset;
			mainView.hungerUp.y = mainView.hungerNum.y;
			mainView.hungerDown.x = mainView.hungerNum.x + mainView.hungerNum.width + arrowXOffset;
			mainView.hungerDown.y = mainView.hungerNum.y;
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
			mainView.willText.width = 130;
			mainView.esteemText.width = 130;
			mainView.obeyText.width = 130;
			//Headers
			mainView.coreStatsText.text = "Name: " + player.short + "\nCore Stats";
			mainView.combatStatsText.text = "Combat Stats";
			if (prison.inPrison) mainView.advancementText.text = "Prison Stats";
			else mainView.advancementText.text = "Advancement";
			
			if (flags[kFLAGS.USE_OLD_INTERFACE] <= 0) mainView.combatStatsText.y = basePos2 - posTextOffset;
			else mainView.combatStatsText.y = basePos2 - 8;
			//Time display
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
			if (timeTextFormat != null) mainView.timeText.setTextFormat(timeTextFormat);
			mainView.timeText.textColor = flags[kFLAGS.USE_DARK_BACKGROUND] > 0 ? 0xFFFFFF : 0x000000
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