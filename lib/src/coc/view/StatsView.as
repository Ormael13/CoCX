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