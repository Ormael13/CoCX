//We won't be needing this anymore!
package coc.view {
    import flash.display.MovieClip;
    import flash.display.Sprite;
    import flash.display.DisplayObject;

    import flash.text.TextField;

    //import coc.model.GameModel;

    // Remove dynamic once you've added all the DOs as instance properties.
    public dynamic class StatsView extends Sprite {
        // add things from main view here?
        // yes because we'll need to update all the TFs and progress bars.
        public var upDownsContainer:Sprite;
        public var levelUp:Sprite;

        //protected var model:GameModel;

        public function StatsView(mainView:MovieClip/*, model:GameModel*/) {
            super();

            if (! mainView) {
                return;
            }

            //this.model = model;

            var statsThingsNames:Array = [
                    "strText",     "strNum",     "strBar",      // "strUp",      "strDown",
                    "touText",     "touNum",     "touBar",      // "touUp",      "touDown",
                    "speText",     "speNum",     "speBar",      // "speUp",      "speDown",
                    "inteText",    "inteNum",    "inteBar",     // "inteUp",     "inteDown",
                    "libText",     "libNum",     "libBar",      // "libUp",      "libDown",
                    "senText",     "senNum",     "sensBar",     // "sensUp",     "sensDown",
                    "corText",     "corNum",     "corBar",      // "corUp",      "corDown",
					"HPText",      "HPNum",      "HPBar",       // "hpUp",       "hpDown",
                    "lustText",    "lustNum",    "lustBar",     // "lustUp",     "lustDown",
					"minLustBar",
                    "fatigueText", "fatigueNum", "fatigueBar",  // "fatigueUp",  "fatigueDown",
                    "hungerText",  "hungerNum",  "hungerBar",   // 
					"esteemText",  "esteemNum",  "esteemBar",   // 
					"willText",    "willNum",    "willBar",     // 
					"obeyText",    "obeyNum",    "obeyBar",     // 
                    "levelText",   "levelNum",                  // "levelUp",
                    "xpText",      "xpNum",      "xpBar",	    // "xpUp",       "xpDown",
					"nameText",
                    "coreStatsText",
                    "advancementText",
                    "combatStatsText",
                    "gemsText",   "gemsNum",
                    "timeText",
                    "timeBG",
                    "sideBarBG"
               ];

            var statsUpDownsNames:Array = [
                    "strUp",      "strDown",
                    "touUp",      "touDown",
                    "speUp",      "speDown",
                    "inteUp",     "inteDown",
                    "libUp",      "libDown",
                    "sensUp",     "sensDown",
                    "corUp",      "corDown",
					"hpUp",       "hpDown",
					"lustUp",     "lustDown",
                    "fatigueUp",  "fatigueDown",
                    "hungerUp",   "hungerDown",
					"esteemUp",   "esteemDown",
                    "willUp",     "willDown",
					"obeyUp",     "obeyDown",
                    // "levelUp",
                    "xpUp",       "xpDown"
               ];
            for each(var statsDOName:* in statsThingsNames) {
                // adding at 0 because BG is at the end.
                this.addChildAt(mainView.getChildByName(statsDOName), 0);
            }
            this.upDownsContainer = new Sprite();
            this.addChild(this.upDownsContainer);
            for each(var statsUpDownDOName:* in statsUpDownsNames) {
                if (statsUpDownDOName != null) this.upDownsContainer.addChild(mainView.getChildByName(statsUpDownDOName));
            }
            this.levelUp = mainView.getChildByName('levelUp') as Sprite;
            this.addChild(this.levelUp);
        }

		//Will be handled in one of class files.
        /*protected function setStatText(name:String, value:*) {
            if (/Num$/.test(name))
			{
				var fVal:* = Math.floor(value);
				var dispText:String;
				
				if (fVal >= 1000000)
				{
					dispText = "++++";
				}
				else
				{
					dispText = String(fVal);
				}
				
                (this.getChildByName(name) as TextField).htmlText = dispText
			}
            else
                (this.getChildByName(name) as TextField).htmlText = value;
        }*/

        /*protected function setStatBar(name:String, progress:Number) {
            this.getChildByName(name).width = Math.round(progress * 115);
        }*/

        // <- statsScreenRefresh (Will be done in class file.)
        /*public function refresh():void {
            // this.show();
            // this.visible = true;

            setStatText("coreStatsText",
                "<b><u>Name: {NAME}</u>\nCore Stats</b>"
                    .replace("{NAME}", model.player.short));

            setStatText("strNum", model.player.str);
            setStatText("touNum", model.player.tou);
            setStatText("speNum", model.player.spe);
            setStatText("inteNum", model.player.inte);
            setStatText("libNum", model.player.lib);
            setStatText("senNum", model.player.sens);
            setStatText("corNum", model.player.cor);
            setStatText("fatigueNum", model.player.fatigue + "/" + model.player.maxFatigue());
            setStatText("HPNum", model.player.HP + "/" + model.player.maxHP());
            setStatText("lustNum", model.player.lust + "/" + model.player.maxLust());
            setStatText("levelNum", model.player.level);
            setStatText("xpNum", model.player.XP + " / " + model.player.level * 100 + " (" + Math.floor(model.player.XP / (model.player.level * 100)) + "%)");

            setStatText("timeText",
                "<b><u>Day#: {DAYS}</u></b>\n<b>Time: {HOURS}:{MINUTES}</b>"
                    .replace("{DAYS}", model.time.days)
                    .replace("{HOURS}", model.time.hours) 
					.replace("{MINUTES}", model.time.minutes));

            setStatBar("strBar", model.player.str/100);
            setStatBar("touBar", model.player.tou/100);
            setStatBar("speBar", model.player.spe/100);
            setStatBar("inteBar", model.player.inte/100);
            setStatBar("libBar", model.player.lib/100);
            setStatBar("sensBar", model.player.sens/100);
            setStatBar("corBar", model.player.cor/100);
            setStatBar("fatigueBar", model.player.fatigue / model.player.maxFatigue());
            setStatBar("HPBar", model.player.HP / model.player.maxHP());
            setStatBar("lustBar", model.player.lust / model.player.maxLust());
			setStatBar("minLustBar", model.player.minLust / model.player.maxLust());
			setStatBar("XPBar", (model.player.XP / (model.player.level * 100)));
            setStatText("gemsNum", model.player.gems);
        }*/

        // <- showStats
        public function show() {
            // make all the stats DOs visible.
            //this.refresh();
            this.visible = true;
        }

        // <- hideStats
        public function hide() {
            // body...
            this.visible = false;
        }

        // <- hideUpDown
        public function hideUpDown() {
            var ci,
                cc = this.upDownsContainer.numChildren;

            this.upDownsContainer.visible = true; //Possible fix.

            // children also need to be hidden because they're selectively shown on change.
            for(ci = 0; ci < cc; ++ci) {
                this.upDownsContainer.getChildAt(ci).visible = false;
            }

            this.hideLevelUp();
        }

        /*public function showUpDown() { //Not used as it would crash.
            function _oldStatNameFor(statName:String) {
                return 'old' + statName.charAt(0).toUpperCase() + statName.substr(1);
            }

            var statName:String,
                oldStatName:String,
                allStats:Array;

            this.upDownsContainer.visible = true;

            allStats = ["str", "tou", "spe", "inte", "lib", "sens", "cor", "HP", "lust", "fatigue", "hunger"];

            for each(statName in allStats) {
                oldStatName = _oldStatNameFor(statName);

                if (this.model.player[statName] > this.model.oldStats[oldStatName]) {
                    this.showStatUp(statName);
                }
                if (this.model.player[statName] < this.model.oldStats[oldStatName]) {
                    this.showStatDown(statName);
                }
            }
        }*/

        public function showLevelUp():void {
            this.levelUp.visible = true;
        }

        public function hideLevelUp():void {
            this.levelUp.visible = false;
        }

        public function showStatUp(statName:String):void {
            var statUp:DisplayObject,
                statDown:DisplayObject;

            statUp = this.upDownsContainer.getChildByName(statName.toLowerCase() + 'Up');
            statDown = this.upDownsContainer.getChildByName(statName.toLowerCase() + 'Down');

            statUp.visible = true;
            statDown.visible = false;
        }

        public function showStatDown(statName:String):void {
            var statUp:DisplayObject,
                statDown:DisplayObject;

            statUp = this.upDownsContainer.getChildByName(statName.toLowerCase() + 'Up');
            statDown = this.upDownsContainer.getChildByName(statName.toLowerCase() + 'Down');

            statUp.visible = false;
            statDown.visible = true;
        }
    }
}