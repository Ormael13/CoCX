package classes{
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.Scenes.SceneLib;

import coc.view.MainView;

import flash.net.SharedObject;
import flash.ui.Keyboard;

internal class ControlBindings {
    public function ControlBindings() {

    }
    public function executeButtonClick(button:int = 0):void {
        kGAMECLASS.mainView.clickButton( button );
    }
    internal function run(inputManager:InputManager):void {
        inputManager.AddBindableControl(
                "Show Stats",
                "Show the stats pane when available",
                function ():void {
                    if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_STATS) && kGAMECLASS.player.str > 0) {
                        kGAMECLASS.playerInfo.displayStats();
                    }
                });

        inputManager.AddBindableControl(
                "Level Up",
                "Show the level up page when available",
                function ():void {
                    if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_LEVEL) && kGAMECLASS.player.str > 0) {
                        kGAMECLASS.playerInfo.levelUpGo();
                    }
                });

            inputManager.AddBindableControl(
                    "Quicksave 1",
                    "Quicksave the current game to slot 1",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA) && kGAMECLASS.player.str > 0) {
                            kGAMECLASS.mainView.nameBox.text = "";
                            kGAMECLASS.saves.saveGame("CoC_1");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 1!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 2",
                    "Quicksave the current game to slot 2",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA) && kGAMECLASS.player.str > 0) {
                            kGAMECLASS.mainView.nameBox.text = "";
                            kGAMECLASS.saves.saveGame("CoC_2");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 2!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 3",
                    "Quicksave the current game to slot 2",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA) && kGAMECLASS.player.str > 0) {
                            kGAMECLASS.mainView.nameBox.text = "";
                            kGAMECLASS.saves.saveGame("CoC_3");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 3!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 4",
                    "Quicksave the current game to slot 4",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA) && kGAMECLASS.player.str > 0) {
                            kGAMECLASS.mainView.nameBox.text = "";
                            kGAMECLASS.saves.saveGame("CoC_4");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 4!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 5",
                    "Quicksave the current game to slot 5",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA) && kGAMECLASS.player.str > 0) {
                            kGAMECLASS.mainView.nameBox.text = "";
                            kGAMECLASS.saves.saveGame("CoC_5");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 5!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quickload 1",
                    "Quickload the current game from slot 1",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_1", "/");
                            if (saveFile.data.exists) {
                                if (kGAMECLASS.saves.loadGame("CoC_1")) {
                                    EngineCore.showStats();
                                    EngineCore.statScreenRefresh();
                                    EngineCore.clearOutput();
                                    EngineCore.outputText("Slot 1 Loaded!");
                                    EngineCore.doNext(EventParser.playerMenu);
                                }
                            }
                        }
                    });

            inputManager.AddBindableControl(
                    "Quickload 2",
                    "Quickload the current game from slot 2",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_2", "/");
                            if (saveFile.data.exists) {
                                if (kGAMECLASS.saves.loadGame("CoC_2")) {
                                    EngineCore.showStats();
                                    EngineCore.statScreenRefresh();
                                    EngineCore.clearOutput();
                                    EngineCore.outputText("Slot 2 Loaded!");
                                    EngineCore.doNext(EventParser.playerMenu);
                                }
                            }
                        }
                    });

            inputManager.AddBindableControl(
                    "Quickload 3",
                    "Quickload the current game from slot 3",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_3", "/");
                            if (saveFile.data.exists) {
                                if (kGAMECLASS.saves.loadGame("CoC_3")) {
                                    EngineCore.showStats();
                                    EngineCore.statScreenRefresh();
                                    EngineCore.clearOutput();
                                    EngineCore.outputText("Slot 3 Loaded!");
                                    EngineCore.doNext(EventParser.playerMenu);
                                }
                            }
                        }
                    });

            inputManager.AddBindableControl(
                    "Quickload 4",
                    "Quickload the current game from slot 4",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_4", "/");
                            if (saveFile.data.exists) {
                                if (kGAMECLASS.saves.loadGame("CoC_4")) {
                                    EngineCore.showStats();
                                    EngineCore.statScreenRefresh();
                                    EngineCore.clearOutput();
                                    EngineCore.outputText("Slot 4 Loaded!");
                                    EngineCore.doNext(EventParser.playerMenu);
                                }
                            }
                        }
                    });

            inputManager.AddBindableControl(
                    "Quickload 5",
                    "Quickload the current game from slot 5",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_5", "/");
                            if (saveFile.data.exists) {
                                if (kGAMECLASS.saves.loadGame("CoC_5")) {
                                    EngineCore.showStats();
                                    EngineCore.statScreenRefresh();
                                    EngineCore.clearOutput();
                                    EngineCore.outputText("Slot 5 Loaded!");
                                    EngineCore.doNext(EventParser.playerMenu);
                                }
                            }
                        }
                    });

            inputManager.AddBindableControl(
                    "Show Menu",
                    "Show the main menu",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_NEW_MAIN) && kGAMECLASS.mainView.menuButtonHasLabel(MainView.MENU_NEW_MAIN, "Main Menu")) {
                            kGAMECLASS.mainMenu.mainMenu();
                        }
                    });

            inputManager.AddBindableControl(
                    "Data Menu",
                    "Show the save/load menu",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            kGAMECLASS.saves.saveLoad(undefined);
                        }
                    });

            inputManager.AddBindableControl(
                    "Appearance Page",
                    "Show the appearance page",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_APPEARANCE)) {
                            kGAMECLASS.playerAppearance.appearance();
                        }
                    });

            inputManager.AddBindableControl(
                    "No",
                    "Respond no to any available prompt",
                    function ():void {
                        if (kGAMECLASS.mainView.getButtonText(1) == "No" && kGAMECLASS.mainView.buttonIsVisible(1)) {
                            executeButtonClick(1);
                        }
                    });

            inputManager.AddBindableControl(
                    "Yes",
                    "Respond yes to any available prompt",
                    function ():void {
                        if (kGAMECLASS.mainView.getButtonText(0) == "Yes" && kGAMECLASS.mainView.buttonIsVisible(0)) {
                            executeButtonClick(0);
                        }
                    });

            inputManager.AddBindableControl(
                    "Show Perks",
                    "Show the perks page",
                    function ():void {
                        if (kGAMECLASS.mainView.menuButtonIsVisible(MainView.MENU_PERKS)) {
                            kGAMECLASS.perkMenu.displayPerks(null);
                        }
                    });

            inputManager.AddBindableControl(
                    "Continue",
                    "Respond to continue",
                    function ():void {
                        // Button 9
                        if (kGAMECLASS.mainView.buttonIsVisible(9) && kGAMECLASS.mainView.buttonTextIsOneOf(9, ["Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume"])) {
                            //trace( "keyboard(): processing space bar for button 9",
                            //	kGAMECLASS.mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
                            //	kGAMECLASS.mainView.getButtonText( 9 ) );
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(9);
                            return;
                        }
                        // Button 14
                        if (EngineCore.buttonIsVisible(14) && EngineCore.buttonTextIsOneOf(14, ["Nevermind", "Abandon", "Next", "Return", "Back", "Leave", "Resume"])) {
                            //trace( "keyboard(): processing space bar for button 9",
                            //	kGAMECLASS.mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
                            //	kGAMECLASS.mainView.getButtonText( 9 ) );
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(14);
                            return;
                        }
                        // Button 0
                        if (kGAMECLASS.mainView.buttonIsVisible(0) && kGAMECLASS.mainView.buttonTextIsOneOf(0, ["Next", "Return", "Back"])) {
                            //trace( "keyboard(): processing space bar for button 0",
                            //	kGAMECLASS.mainView.buttonIsVisible( 0 ) ? "(visible)" : "(hidden)",
                            //	kGAMECLASS.mainView.getButtonText( 0 ) );
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(0);
                            return;
                        }

                        // Button 4
                        if (kGAMECLASS.mainView.buttonIsVisible(4) && kGAMECLASS.mainView.buttonTextIsOneOf(4, ["Nevermind", "Next", "Return", "Back", "Leave"])) {
                            //trace( "keyboard(): processing space bar for button 4",
                            //	kGAMECLASS.mainView.buttonIsVisible( 4 ) ? "(visible)" : "(hidden)",
                            //	kGAMECLASS.mainView.getButtonText( 4 ) );
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(4);
                            return;
                        }

                        // Button 5
                        if (kGAMECLASS.mainView.buttonIsVisible(5) && kGAMECLASS.mainView.buttonTextIsOneOf(5, ["Next", "Return", "Back"])) {
                            //trace( "keyboard(): processing space bar for button 5",
                            //	kGAMECLASS.mainView.buttonIsVisible( 5 ) ? "(visible)" : "(hidden)",
                            //	kGAMECLASS.mainView.getButtonText( 5 ) );
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(5);
                            //return;
                        }
                    });

            inputManager.AddBindableControl(
                    "Cycle Background",
                    "Cycle the background fill of the text display area",
                    function ():void {
                        if (!kGAMECLASS.mainView.textBGWhite.visible) {
                            kGAMECLASS.mainView.textBGWhite.visible = true;
                        }
                        else if (!kGAMECLASS.mainView.textBGTan.visible) {
                            kGAMECLASS.mainView.textBGTan.visible = true;
                        }
                        else {
                            kGAMECLASS.mainView.textBGWhite.visible = false;
                            kGAMECLASS.mainView.textBGTan.visible = false;
                        }

                    });

            inputManager.AddBindableControl(
                    "Button 1",
                    "Activate button 1",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(0)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(0);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 2",
                    "Activate button 2",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(1)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(1);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 3",
                    "Activate button 3",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(2)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(2);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 4",
                    "Activate button 4",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(3)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(3);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 5",
                    "Activate button 5",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(4)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(4);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 6",
                    "Activate button 6",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(5)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(5);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 7",
                    "Activate button 7",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(6)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(6);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 8",
                    "Activate button 8",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(7)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(7);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 9",
                    "Activate button 9",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(8)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(8);
                        }
                    });

            inputManager.AddBindableControl(
                    "Button 10",
                    "Activate button 10",
                    function ():void {
                        if (kGAMECLASS.mainView.buttonIsVisible(9)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(9);
                        }
                    });

//Extra buttons
            inputManager.AddBindableControl(
                    "Button 11",
                    "Activate button 11",
                    function ():void {
                        if (EngineCore.buttonIsVisible(10)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(10);
                        }
                    });
            inputManager.AddBindableControl(
                    "Button 12",
                    "Activate button 12",
                    function ():void {
                        if (EngineCore.buttonIsVisible(11)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(11);
                        }
                    });
            inputManager.AddBindableControl(
                    "Button 13",
                    "Activate button 13",
                    function ():void {
                        if (EngineCore.buttonIsVisible(12)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(12);
                        }
                    });
            inputManager.AddBindableControl(
                    "Button 14",
                    "Activate button 14",
                    function ():void {
                        if (EngineCore.buttonIsVisible(13)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(13);
                        }
                    });
            inputManager.AddBindableControl(
                    "Button 15",
                    "Activate button 15",
                    function ():void {
                        if (EngineCore.buttonIsVisible(14)) {
                            kGAMECLASS.mainView.toolTipView.hide();
                            executeButtonClick(14);
                        }
                    });
            inputManager.AddBindableControl(
                    "History",
                    "Show text history",
                    function ():void {
                        trace(kGAMECLASS.mainViewManager.traceSelf());
                        kGAMECLASS.outputHistory();
                    }
            );
            inputManager.AddBindableControl(
                    "Cheat! Give Hummus",
                    "Cheat code to get free hummus",
                    function (keyCode:int):void {
                        if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 0) {
                            if (keyCode == 38) {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 1) {
                            if (keyCode == 40) {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 2) {
                            if (keyCode == 37) {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 3) {
                            if (keyCode == 39) {
                                if (kGAMECLASS.player.str > 0 && kGAMECLASS.mainView.getButtonText(0).indexOf("Game Over") == -1) {
                                    SceneLib.inventory.giveHumanizer();
                                }
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                    },
                    InputManager.CHEATCONTROL);

            inputManager.AddBindableControl(
                    "Cheat! Access debug menu",
                    "Cheat code to access debug menu and spawn ANY items or change stats.",
                    function (keyCode:int):void {
                        if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 0) {
                            if (keyCode == 68) {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 1) {
                            if (keyCode == 69) {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 2) {
                            if (keyCode == 66) {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 3) {
                            if (keyCode == 85) {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 4) {
                            if (keyCode == 71) {
                                if (kGAMECLASS.player && kGAMECLASS.player.str > 0 && kGAMECLASS.mainView.getButtonText(0).indexOf("Game Over") == -1 && (kGAMECLASS.debug && kGAMECLASS.flags[kFLAGS.HARDCORE_MODE] <= 0 || CoC_Settings.debugBuild)) {
                                    SceneLib.debugMenu.accessDebugMenu();
                                }
                            }
                            else {
                                kGAMECLASS.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
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
            inputManager.BindKeyToControl(Keyboard.H, "History");

            inputManager.RegisterDefaults();


    }
}
}