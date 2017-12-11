package classes.Scenes.NPCs 
{
import classes.Scenes.Camp;

import coc.view.ButtonDataList;

public class SamirahScene extends XXCNPC
	{
		private static var _instance:SamirahScene;
        private var _status:int = 0;
        private var _hypnosisStage:int = 0;
        private var _lastLearned:int = 0;
        private var _clothesGiven:Boolean = false;

		public function SamirahScene() 
		{
            if (!_instance) {
                super("samirah");
                _instance = this;
                Camp.addFollower(this);
            } else {
                throw new Error("Singleton class. Use getInstance()");
            }
        }
        static public function get instance():SamirahScene
		{
			if (_instance == null){
				new SamirahScene();
			}
			return _instance;
		}

        override public function campDescription(buttons:ButtonDataList, menuType:int = -1):void {
            if (_status == -1) {
                display("strings/campDescription");
            }
            buttons.add("???").disable("We have been entangled since the beginning.");
        }

        override public function campInteraction():void {
            menu();
            addButton(0, "Talk", talkScene);
            addButton(1, "Sex", sexScene);
            addButton(14, "Back", camp.campLoversMenu);
        }

        public function sexScene(sceneName:String = "sexMenu"):void {
            if (sceneName == "sexMenu") {
                scene("strings/sexMenu/menu");
                addButtonDisabled(0, "Fuck Her");
                addButtonDisabled(1, "Fuck Her Wild");
                addButtonDisabled(2, "Tongue Job");
                addButtonDisabled(3, "Tail Pen");
                addButtonDisabled(4, "Twin Tail");
                if (player.hasCock()) {
                    addButton(0, "Fuck Her", sexScene, "fuckHer");
                    addButton(1, "Fuck Her Wild", sexScene, "fuckHerWild");
                    addButton(2, "Tongue Job", sexScene, "tongueJob");
                }
                if (player.hasVagina()) {
                    addButton(3, "Tail Pen", sexScene, "tailPen");
                    if (player.isNaga()) {
                        addButton(4, "Twin Tail", sexScene, "twinTail");
                    }
                }
                addButton(14, "Back", campInteraction);
                return;
            }
            scene("strings/sexMenu/" + sceneName);
        }

        public function talkScene(sceneName:int = -1):void {
            if (sceneName == -1) {
                scene("strings/talkMenu/menu");
                addButton(0, "Her", talkScene, 0);
                addButton(1, "Naga", talkScene, 1);
                addButton(2, "Clothes", clothesMenu);
                addButton(3, "Hypnosis", hypnosisTraining);
                addButton(14, "Back", campInteraction);
                return;
            }
            if (sceneName === 0) {
                scene("strings/talkMenu/her");
            } else if (sceneName === 1) {
                scene("strings/talkMenu/naga");
            }
        }

        private function clothesMenu():void {
            if (!_clothesGiven) {
                scene("strings/talkMenu/clothes/intro");
                if (player.isNaga() && player.isFemale()) {
					selectColor();
                }
                return;
            }
			scene("strings/talkMenu/clothes/colorChoose");
			addButtonDisabled(0,"Yes","You probably should have the dress in your inventory.");
			if (player.hasItem(armors.NAGASLK)){
				addButton(0,"Yes",selectColor);
			}
			addButton(1,"No",decline);

            function selectColor():void {
                var _clothesColors:Array = ["Blue", "Black", "Pink", "Purple", "Green"];
                menu();
                for (var i:int = 0; i < _clothesColors.length; i++) {
                    addButton(i, _clothesColors[i], takeClothes, _clothesColors[i]);
                }
                if (_clothesGiven) {
                    display("strings/talkMenu/clothes/colorChoose");
                    addButton(14, "Back", decline);
                }
            }

            function decline():void {
                display("strings/talkMenu/clothes/nah");
                doNext(talkScene);
            }

            function takeClothes(color:String):void {
                armors.NAGASLK.setColor(color.toLowerCase());
				if(_clothesGiven){
					scene("strings/talkMenu/clothes/colorChange");
				}
				else{
                    display("strings/talkMenu/clothes/clothesGet");
                    if (player.armorName == "nothing") {
                        player.setArmor(armors.NAGASLK);
                    }
                    else if (player.armorName != "goo armor") {
                        inventory.takeItem(player.setArmor(armors.NAGASLK), camp.returnToCampUseOneHour);
                    }
                    else {
                        player.armor.removeText();
                        player.setArmor(armors.NAGASLK);
                        doNext(camp.returnToCampUseOneHour);
                    }
					_clothesGiven = true;
					doNext(camp.returnToCampUseOneHour);
				}
            }
        }

        private function hypnosisTraining():void {
            if (_hypnosisStage === 0) {
                scene("strings/talkMenu/hypnosis/intro");
                if (player.isNaga()) _hypnosisStage++;
                return;
            }
            if (_lastLearned == model.time.days) {
                scene("strings/talkMenu/hypnosis/calmDown");
                return;
            }
            if (_hypnosisStage === 1 || _hypnosisStage === 2) {
                scene("strings/talkMenu/hyponsis/training");
                _hypnosisStage++;
                _lastLearned = model.time.days;
            } else if (_hypnosisStage === 3) {
                scene("strings/talkMenu/hypnosis/trainingDone");
                _hypnosisStage = -1;
                // TODO add hypnosis perk to player
            }
        }

        override public function isCompanion(type:int = -1):Boolean {
            return _status == -1;
        }
	}
}