import classes.GlobalFlags.kGAMECLASS;
import flash.ui.Keyboard;
import coc.view.MainView;

use namespace kGAMECLASS;

inputManager.AddBindableControl(
	"Show Stats",
	"Show the stats pane when available",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_STATS) && player.str > 0)
		{
			kGAMECLASS.playerInfo.displayStats();
		}
	});

inputManager.AddBindableControl(
	"Level Up",
	"Show the level up page when available",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_LEVEL) && player.str > 0)
		{
			kGAMECLASS.playerInfo.levelUpGo();
		}
	});

inputManager.AddBindableControl(
	"Quicksave 1",
	"Quicksave the current game to slot 1",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saves.saveGame("CoC_1");
			outputText("Game saved to slot 1!", true);
			doNext(playerMenu);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 2",
	"Quicksave the current game to slot 2",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saves.saveGame("CoC_2");
			outputText("Game saved to slot 2!", true);
			doNext(playerMenu);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 3",
	"Quicksave the current game to slot 2",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saves.saveGame("CoC_3");
			outputText("Game saved to slot 3!", true);
			doNext(playerMenu);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 4",
	"Quicksave the current game to slot 4",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saves.saveGame("CoC_4");
			outputText("Game saved to slot 4!", true);
			doNext(playerMenu);
		}
	});
	
inputManager.AddBindableControl(
	"Quicksave 5",
	"Quicksave the current game to slot 5",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA) && player.str > 0)
		{
			mainView.nameBox.text = "";
			saves.saveGame("CoC_5");
			outputText("Game saved to slot 5!", true);
			doNext(playerMenu);
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 1",
	"Quickload the current game from slot 1",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_1", "/");
			if (saveFile.data.exists)
			{
				if (saves.loadGame("CoC_1"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 1 Loaded!", true);
					doNext(playerMenu);
				}
			}
		}
	});

inputManager.AddBindableControl(
	"Quickload 2",
	"Quickload the current game from slot 2",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_2", "/");
			if (saveFile.data.exists)
			{
				if (saves.loadGame("CoC_2"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 2 Loaded!", true);
					doNext(playerMenu);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 3",
	"Quickload the current game from slot 3",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_3", "/");
			if (saveFile.data.exists)
			{
				if (saves.loadGame("CoC_3"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 3 Loaded!", true);
					doNext(playerMenu);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 4",
	"Quickload the current game from slot 4",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_4", "/");
			if (saveFile.data.exists)
			{
				if (saves.loadGame("CoC_4"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 4 Loaded!", true);
					doNext(playerMenu);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Quickload 5",
	"Quickload the current game from slot 5",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			var saveFile:* = SharedObject.getLocal("CoC_5", "/");
			if (saveFile.data.exists)
			{
				if (saves.loadGame("CoC_5"))
				{
					showStats();
					statScreenRefresh();
					outputText("Slot 5 Loaded!", true);
					doNext(playerMenu);
				}
			}
		}
	});
	
inputManager.AddBindableControl(
	"Show Menu",
	"Show the main menu",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_NEW_MAIN) && mainView.menuButtonHasLabel(MainView.MENU_NEW_MAIN, "Main Menu"))
		{
			mainMenu(undefined);
		}
	});

inputManager.AddBindableControl(
	"Data Menu",
	"Show the save/load menu",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_DATA))
		{
			saves.saveLoad(undefined);
		}
	});
	
inputManager.AddBindableControl(
	"Appearance Page",
	"Show the appearance page",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_APPEARANCE))
		{
			kGAMECLASS.playerAppearance.appearance();
		}
	});
	
inputManager.AddBindableControl(
	"No",
	"Respond no to any available prompt",
	function():void {
		if (mainView.getButtonText(1) == "No" && mainView.buttonIsVisible(1))
		{
			executeButtonClick(1);
		}
	});
	
inputManager.AddBindableControl(
	"Yes",
	"Respond yes to any available prompt",
	function():void {
		if (mainView.getButtonText(0) == "Yes" && mainView.buttonIsVisible(0))
		{
			executeButtonClick(0);
		}
	});
	
inputManager.AddBindableControl(
	"Show Perks",
	"Show the perks page",
	function():void {
		if (mainView.menuButtonIsVisible(MainView.MENU_PERKS))
		{
			kGAMECLASS.playerInfo.displayPerks();
		}
	});

inputManager.AddBindableControl(
	"Continue",
	"Respond to continue",
	function():void {
		// Button 9
		if (mainView.buttonIsVisible(9) && mainView.buttonTextIsOneOf(9, [ "Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume" ]))
		{
			//trace( "keyboard(): processing space bar for button 9",
			//	mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
			//	mainView.getButtonText( 9 ) );
			mainView.toolTipView.hide();
			executeButtonClick(9);
			return;
		}
		// Button 14
		if (kGAMECLASS.buttonIsVisible(14) && kGAMECLASS.buttonTextIsOneOf(14, [ "Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume" ]))
		{
			//trace( "keyboard(): processing space bar for button 9",
			//	mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
			//	mainView.getButtonText( 9 ) );
			mainView.toolTipView.hide();
			executeButtonClick(14);
			return;
		}		
		// Button 0
		if (mainView.buttonIsVisible(0) && mainView.buttonTextIsOneOf(0, [ "Next", "Return", "Back" ]))
		{
			//trace( "keyboard(): processing space bar for button 0",
			//	mainView.buttonIsVisible( 0 ) ? "(visible)" : "(hidden)",
			//	mainView.getButtonText( 0 ) );
			mainView.toolTipView.hide();
			executeButtonClick(0);
			return;
		}
		
		// Button 4
		if (mainView.buttonIsVisible(4) && mainView.buttonTextIsOneOf(4, [ "Nevermind", "Next", "Return", "Back", "Leave" ]))
		{
			//trace( "keyboard(): processing space bar for button 4",
			//	mainView.buttonIsVisible( 4 ) ? "(visible)" : "(hidden)",
			//	mainView.getButtonText( 4 ) );
			mainView.toolTipView.hide();
			executeButtonClick(4);
			return;
		}
		
		// Button 5
		if (mainView.buttonIsVisible(5) && mainView.buttonTextIsOneOf(5, [ "Next", "Return", "Back" ]))
		{
			//trace( "keyboard(): processing space bar for button 5",
			//	mainView.buttonIsVisible( 5 ) ? "(visible)" : "(hidden)",
			//	mainView.getButtonText( 5 ) );
			mainView.toolTipView.hide();
			executeButtonClick(5);
			return;
		}
	});
	
inputManager.AddBindableControl(
	"Cycle Background",
	"Cycle the background fill of the text display area",
	function():void {
		if (!mainView.textBGWhite.visible)
		{
			mainView.textBGWhite.visible = true;
		}
		else if (!mainView.textBGTan.visible)
		{
			mainView.textBGTan.visible = true;
		}
		else
		{
			mainView.textBGWhite.visible = false;
			mainView.textBGTan.visible = false;
		}
		
	});
	
inputManager.AddBindableControl(
	"Button 1",
	"Activate button 1",
	function():void {
		if (mainView.buttonIsVisible(0))
		{
			mainView.toolTipView.hide();
			executeButtonClick(0);
		}
	});

inputManager.AddBindableControl(
	"Button 2",
	"Activate button 2",
	function():void {
		if (mainView.buttonIsVisible(1))
		{
			mainView.toolTipView.hide();
			executeButtonClick(1);
		}
	});
	
inputManager.AddBindableControl(
	"Button 3",
	"Activate button 3",
	function():void {
		if (mainView.buttonIsVisible(2))
		{
			mainView.toolTipView.hide();
			executeButtonClick(2);
		}
	});
	
inputManager.AddBindableControl(
	"Button 4",
	"Activate button 4",
	function():void {
		if (mainView.buttonIsVisible(3))
		{
			mainView.toolTipView.hide();
			executeButtonClick(3);
		}
	});
	
inputManager.AddBindableControl(
	"Button 5",
	"Activate button 5",
	function():void {
		if (mainView.buttonIsVisible(4))
		{
			mainView.toolTipView.hide();
			executeButtonClick(4);
		}
	});
	
inputManager.AddBindableControl(
	"Button 6",
	"Activate button 6",
	function():void {
		if (mainView.buttonIsVisible(5))
		{
			mainView.toolTipView.hide();
			executeButtonClick(5);
		}
	});
	
inputManager.AddBindableControl(
	"Button 7",
	"Activate button 7",
	function():void {
		if (mainView.buttonIsVisible(6))
		{
			mainView.toolTipView.hide();
			executeButtonClick(6);
		}
	});
	
inputManager.AddBindableControl(
	"Button 8",
	"Activate button 8",
	function():void {
		if (mainView.buttonIsVisible(7))
		{
			mainView.toolTipView.hide();
			executeButtonClick(7);
		}
	});
	
inputManager.AddBindableControl(
	"Button 9",
	"Activate button 9",
	function():void {
		if (mainView.buttonIsVisible(8))
		{
			mainView.toolTipView.hide();
			executeButtonClick(8);
		}
	});
	
inputManager.AddBindableControl(
	"Button 10",
	"Activate button 10",
	function():void {
		if (mainView.buttonIsVisible(9))
		{
			mainView.toolTipView.hide();
			executeButtonClick(9);
		}
	});
	
//Extra buttons
inputManager.AddBindableControl(
	"Button 11",
	"Activate button 11",
	function():void {
		if (kGAMECLASS.buttonIsVisible(10))
		{
			mainView.toolTipView.hide();
			executeButtonClick(10);
		}
	});
inputManager.AddBindableControl(
	"Button 12",
	"Activate button 12",
	function():void {
		if (kGAMECLASS.buttonIsVisible(11))
		{
			mainView.toolTipView.hide();
			executeButtonClick(11);
		}
	});
inputManager.AddBindableControl(
	"Button 13",
	"Activate button 13",
	function():void {
		if (kGAMECLASS.buttonIsVisible(12))
		{
			mainView.toolTipView.hide();
			executeButtonClick(12);
		}
	});
inputManager.AddBindableControl(
	"Button 14",
	"Activate button 14",
	function():void {
		if (kGAMECLASS.buttonIsVisible(13))
		{
			mainView.toolTipView.hide();
			executeButtonClick(13);
		}
	});
inputManager.AddBindableControl(
	"Button 15",
	"Activate button 15",
	function():void {
		if (kGAMECLASS.buttonIsVisible(14))
		{
			mainView.toolTipView.hide();
			executeButtonClick(14);
		}
	});

inputManager.AddBindableControl(
	"Cheat! Give Hummus",
	"Cheat code to get free hummus",
	function(keyCode:int):void {
		if (flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 0)
		{
			if (keyCode == 38)
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
			}
		}
		else if (flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 1)
		{
			if (keyCode == 40)
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
			}
		}
		else if (flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 2)
		{
			if (keyCode == 37)
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
			}
		}
		else if (flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 3)
		{
			if (keyCode == 39)
			{
				if (player.str > 0 && mainView.getButtonText(0).indexOf("Game Over") == -1)
				{
					kGAMECLASS.inventory.giveHumanizer();
				}
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
			}
		}
	},
	InputManager.CHEATCONTROL);

inputManager.AddBindableControl(
	"Cheat! Access debug menu",
	"Cheat code to access debug menu and spawn ANY items or change stats.",
	function(keyCode:int):void {
		if (flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 0)
		{
			if (keyCode == 68)
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
			}
		}
		else if (flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 1)
		{
			if (keyCode == 69)
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
			}
		}
		else if (flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 2)
		{
			if (keyCode == 66)
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
			}
		}
		else if (flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 3)
		{
			if (keyCode == 85)
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
			}
		}
		else if (flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 4)
		{
			if (keyCode == 71)
			{
				if (player.str > 0 && mainView.getButtonText(0).indexOf("Game Over") == -1 && (debug && flags[kFLAGS.HARDCORE_MODE] <= 0 || CoC_Settings.debugBuild))
				{
					kGAMECLASS.debugMenu.accessDebugMenu();
				}
			}
			else
			{
				flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
			}
		}
	},
	InputManager.CHEATCONTROL);

	
// Insert the default bindings
inputManager.BindKeyToControl(83, "Show Stats");
inputManager.BindKeyToControl(76, "Level Up");
inputManager.BindKeyToControl(112, "Quicksave 1");
inputManager.BindKeyToControl(113, "Quicksave 2");
inputManager.BindKeyToControl(114, "Quicksave 3");
inputManager.BindKeyToControl(115, "Quicksave 4");
inputManager.BindKeyToControl(116, "Quicksave 5");
inputManager.BindKeyToControl(117, "Quickload 1");
inputManager.BindKeyToControl(118, "Quickload 2");
inputManager.BindKeyToControl(119, "Quickload 3");
inputManager.BindKeyToControl(120, "Quickload 4");
inputManager.BindKeyToControl(121, "Quickload 5");
inputManager.BindKeyToControl(8, "Show Menu");
inputManager.BindKeyToControl(68, "Data Menu");
inputManager.BindKeyToControl(65, "Appearance Page");
inputManager.BindKeyToControl(78, "No");
inputManager.BindKeyToControl(89, "Yes");
inputManager.BindKeyToControl(80, "Show Perks");
inputManager.BindKeyToControl(13, "Continue");
inputManager.BindKeyToControl(32, "Continue", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(36, "Cycle Background");
inputManager.BindKeyToControl(49, "Button 1");
inputManager.BindKeyToControl(50, "Button 2");
inputManager.BindKeyToControl(51, "Button 3");
inputManager.BindKeyToControl(52, "Button 4");
inputManager.BindKeyToControl(53, "Button 5");
inputManager.BindKeyToControl(54, "Button 6");
inputManager.BindKeyToControl(55, "Button 7");
inputManager.BindKeyToControl(56, "Button 8");
inputManager.BindKeyToControl(57, "Button 9");
inputManager.BindKeyToControl(48, "Button 10");
inputManager.BindKeyToControl(Keyboard.Q, "Button 6", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.W, "Button 7", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.E, "Button 8", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.R, "Button 9", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.T, "Button 10", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.A, "Button 11", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.S, "Button 12", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.D, "Button 13", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.F, "Button 14", InputManager.SECONDARYKEY);
inputManager.BindKeyToControl(Keyboard.G, "Button 15", InputManager.SECONDARYKEY);

inputManager.RegisterDefaults();