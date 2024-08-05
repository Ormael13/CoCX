package classes{
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.internals.Utils;

import coc.view.MainView;

import flash.net.SharedObject;
import flash.ui.Keyboard;

internal class ControlBindings {
    public function ControlBindings() {

    }
    public function executeButtonClick(button:int = 0):void {
        CoC.instance.mainView.clickButton( button );
    }
    internal function run(inputManager:InputManager):void {
        var mainView:MainView = CoC.instance.mainView;
        inputManager.AddBindableControl(
                "Show Stats",
                "Show the stats pane when available",
                function ():void {
                    if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_STATS) && CoC.instance.player.str > 0) {
                        CoC.instance.playerInfo.displayStats();
                    }
                },
                mainView.statsButton);

        inputManager.AddBindableControl(
                "Level Up",
                "Show the level up page when available",
                function ():void {
                    if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_LEVEL) && CoC.instance.player.str > 0) {
                        CoC.instance.playerInfo.levelUpMenu();
                    }
                },
                mainView.levelButton);

            inputManager.AddBindableControl(
                    "Quicksave 1",
                    "Quicksave the current game to slot 1",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA) && CoC.instance.player.str > 0) {
                            CoC.instance.mainView.nameBox.text = "";
                            CoC.instance.saves.saveGameToSharedObject("CoC_1");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 1!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 2",
                    "Quicksave the current game to slot 2",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA) && CoC.instance.player.str > 0) {
                            CoC.instance.mainView.nameBox.text = "";
                            CoC.instance.saves.saveGameToSharedObject("CoC_2");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 2!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 3",
                    "Quicksave the current game to slot 2",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA) && CoC.instance.player.str > 0) {
                            CoC.instance.mainView.nameBox.text = "";
                            CoC.instance.saves.saveGameToSharedObject("CoC_3");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 3!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 4",
                    "Quicksave the current game to slot 4",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA) && CoC.instance.player.str > 0) {
                            CoC.instance.mainView.nameBox.text = "";
                            CoC.instance.saves.saveGameToSharedObject("CoC_4");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 4!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quicksave 5",
                    "Quicksave the current game to slot 5",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA) && CoC.instance.player.str > 0) {
                            CoC.instance.mainView.nameBox.text = "";
                            CoC.instance.saves.saveGameToSharedObject("CoC_5");
                            EngineCore.clearOutput();
                            EngineCore.outputText("Game saved to slot 5!");
                            EngineCore.doNext(EventParser.playerMenu);
                        }
                    });

            inputManager.AddBindableControl(
                    "Quickload 1",
                    "Quickload the current game from slot 1",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_1", "/");
                            if (saveFile.data.exists) {
                                if (CoC.instance.saves.loadGameFromSharedObject("CoC_1")) {
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
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_2", "/");
                            if (saveFile.data.exists) {
                                if (CoC.instance.saves.loadGameFromSharedObject("CoC_2")) {
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
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_3", "/");
                            if (saveFile.data.exists) {
                                if (CoC.instance.saves.loadGameFromSharedObject("CoC_3")) {
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
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_4", "/");
                            if (saveFile.data.exists) {
                                if (CoC.instance.saves.loadGameFromSharedObject("CoC_4")) {
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
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            var saveFile:* = SharedObject.getLocal("CoC_5", "/");
                            if (saveFile.data.exists) {
                                if (CoC.instance.saves.loadGameFromSharedObject("CoC_5")) {
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
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_NEW_MAIN) && CoC.instance.mainView.menuButtonHasLabel(MainView.MENU_NEW_MAIN, "Main Menu")) {
                            CoC.instance.mainMenu.mainMenu();
                        }
                    });

            inputManager.AddBindableControl(
                    "Data Menu",
                    "Show the save/load menu",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_DATA)) {
                            CoC.instance.saves.saveLoad(undefined);
                        }
                    },
                    mainView.dataButton);

            inputManager.AddBindableControl(
                    "Appearance Page",
                    "Show the appearance page",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_APPEARANCE)) {
                            CoC.instance.playerAppearance.appearance();
                        }
                    },
                    mainView.perksButton);

            inputManager.AddBindableControl(
                    "No",
                    "Respond no to any available prompt",
                    function ():void {
                        if (CoC.instance.mainView.getButtonText(1) == "No" && CoC.instance.mainView.buttonIsVisible(1)) {
                            executeButtonClick(1);
                        }
                    });

            inputManager.AddBindableControl(
                    "Yes",
                    "Respond yes to any available prompt",
                    function ():void {
                        if (CoC.instance.mainView.getButtonText(0) == "Yes" && CoC.instance.mainView.buttonIsVisible(0)) {
                            executeButtonClick(0);
                        }
                    });

            inputManager.AddBindableControl(
                    "Show Perks",
                    "Show the perks page",
                    function ():void {
                        if (CoC.instance.mainView.menuButtonIsVisible(MainView.MENU_PERKS)) {
                            CoC.instance.perkMenu.displayPerks();
                        }
                    },
                    mainView.perksButton);

            inputManager.AddBindableControl(
                    "Continue",
                    "Respond to continue",
                    function ():void {
                        // Button 9
                        if (CoC.instance.mainView.buttonIsVisible(9) && CoC.instance.mainView.buttonTextIsOneOf(9, ["Never mind", "Abandon", "Next", "Return", "Back", "Leave", "Resume"])) {
                            //trace( "keyboard(): processing space bar for button 9",
                            //	CoC.instance.mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
                            //	CoC.instance.mainView.getButtonText( 9 ) );
                            CoC.instance.mainView.toolTipView.hide();
                            executeButtonClick(9);
                            return;
                        }
                        // Button 14
                        if (EngineCore.buttonIsVisible(14) && EngineCore.buttonTextIsOneOf(14, ["Never mind", "Abandon", "Next", "Return", "Back", "Leave", "Resume"])) {
                            //trace( "keyboard(): processing space bar for button 9",
                            //	CoC.instance.mainView.buttonIsVisible( 9 ) ? "(visible)" : "(hidden)",
                            //	CoC.instance.mainView.getButtonText( 9 ) );
                            CoC.instance.mainView.toolTipView.hide();
                            executeButtonClick(14);
                            return;
                        }
                        // Button 0
                        if (CoC.instance.mainView.buttonIsVisible(0) && CoC.instance.mainView.buttonTextIsOneOf(0, ["Next", "Return", "Back"])) {
                            //trace( "keyboard(): processing space bar for button 0",
                            //	CoC.instance.mainView.buttonIsVisible( 0 ) ? "(visible)" : "(hidden)",
                            //	CoC.instance.mainView.getButtonText( 0 ) );
                            CoC.instance.mainView.toolTipView.hide();
                            executeButtonClick(0);
                            return;
                        }

                        // Button 4
                        if (CoC.instance.mainView.buttonIsVisible(4) && CoC.instance.mainView.buttonTextIsOneOf(4, ["Never mind", "Next", "Return", "Back", "Leave"])) {
                            //trace( "keyboard(): processing space bar for button 4",
                            //	CoC.instance.mainView.buttonIsVisible( 4 ) ? "(visible)" : "(hidden)",
                            //	CoC.instance.mainView.getButtonText( 4 ) );
                            CoC.instance.mainView.toolTipView.hide();
                            executeButtonClick(4);
                            return;
                        }

                        // Button 5
                        if (CoC.instance.mainView.buttonIsVisible(5) && CoC.instance.mainView.buttonTextIsOneOf(5, ["Next", "Return", "Back"])) {
                            //trace( "keyboard(): processing space bar for button 5",
                            //	CoC.instance.mainView.buttonIsVisible( 5 ) ? "(visible)" : "(hidden)",
                            //	CoC.instance.mainView.getButtonText( 5 ) );
                            CoC.instance.mainView.toolTipView.hide();
                            executeButtonClick(5);
                            //return;
                        }
                    });

            inputManager.AddBindableControl(
                    "Cycle Background",
                    "Cycle the background fill of the text display area",
                    function ():void {
                        if (!CoC.instance.mainView.textBGWhite.visible) {
                            CoC.instance.mainView.textBGWhite.visible = true;
                        }
                        else if (!CoC.instance.mainView.textBGTan.visible) {
                            CoC.instance.mainView.textBGTan.visible = true;
                        }
                        else {
                            CoC.instance.mainView.textBGWhite.visible = false;
                            CoC.instance.mainView.textBGTan.visible = false;
                        }

                    });

        for (var i:int = 0; i < 15; i++) {
            var callback:Function = Utils.curry(function (ii:int):void {
                if (CoC.instance.mainView.buttonIsVisible(ii)) {
                    CoC.instance.mainView.toolTipView.hide();
                    executeButtonClick(ii);
                }
            }, i);
            inputManager.AddBindableControl(
                    "Button "+(i+1),
                    "Activate button "+(i+1),
                    callback,
                    mainView.bottomButtons[i]);
        }
        
            inputManager.AddBindableControl(
                    "History",
                    "Show text history",
                    function ():void {
                        trace(CoC.instance.mainViewManager.traceSelf());
                        CoC.instance.outputHistory();
                    }
            );
            inputManager.AddBindableControl(
                    "Font Size+",
                    "Increase font size",
                    function():void{
                        CoC.instance.gameSettings.incFontSize();
                    }
            );
            inputManager.AddBindableControl(
                    "Font Size-",
                    "Decrease font size",
                    function():void{
                        CoC.instance.gameSettings.decFontSize();
                    }
            );
            inputManager.AddBindableControl(
                    "Cheat! Give Hummus",
                    "Cheat code to get free hummus",
                    function (keyCode:int):void {
                        if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 0) {
                            if (keyCode == 38) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 1) {
                            if (keyCode == 40) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 2) {
                            if (keyCode == 37) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] == 3) {
                            if (keyCode == 39) {
                                if (CoC.instance.player.str > 0 && CoC.instance.mainView.getButtonText(0).indexOf("Game Over") == -1) {
                                    SceneLib.inventory.giveHumanizer();
                                }
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER] = 0;
                            }
                        }
                    },
                    null,
                    InputManager.CHEATCONTROL);

            inputManager.AddBindableControl(
                    "Cheat! Access debug menu",
                    "Cheat code to access debug menu and spawn ANY items or change stats.",
                    function (keyCode:int):void {
                        if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 0) {
                            if (keyCode == Keyboard.D) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 1) {
                            if (keyCode == Keyboard.E) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 2) {
                            if (keyCode == Keyboard.B) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 3) {
                            if (keyCode == Keyboard.U) {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2]++;
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                        else if (CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] == 4) {
                            if (keyCode == Keyboard.G) {
                                if (CoC.instance.player && CoC.instance.player.str > 0 && CoC.instance.mainView.getButtonText(0).indexOf("Game Over") == -1 && CoC_Settings.debugBuild && !CoC.instance.lockCheats) {
                                    SceneLib.debugMenu.accessDebugMenu();
                                }
                            }
                            else {
                                CoC.instance.flags[kFLAGS.CHEAT_ENTERING_COUNTER_2] = 0;
                            }
                        }
                    },
                    null,
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
            inputManager.BindKeyToControl(187, "Font Size+");
            inputManager.BindKeyToControl(189, "Font Size-");

            inputManager.RegisterDefaults();


    }
}
}
