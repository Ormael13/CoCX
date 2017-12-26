package classes.Scenes.NPCs 
{
import classes.EventParser;
import classes.ItemType;
import classes.PregnancyStore;
import classes.Scenes.Camp;
import classes.TimeAwareInterface;

import coc.view.ButtonDataList;

import flash.utils.getQualifiedClassName;

/**
	 * ...
	 * @author Oxdeception
	 */
	public class CelessScene extends XXCNPC implements TimeAwareInterface
	{
		private static var _instance:CelessScene;
		private var _age:int=0;
		private var _corruption:int=0;
		private var _name:String = "Celess";
		private var _armorFound:Boolean = false;

        private static const _ageIsAdult:int = -1;
        private static const _ageShouldDoBirth:int = -2;
        private static const _ageCanMeetNightmare:int = -3;

        private static function canMeetNightmare():Boolean{
            return instance._age == _ageCanMeetNightmare;
        }
		public function CelessScene()
		{
			if (!_instance){
				super("celess");
				EventParser.timeAwareClassAdd(this);
				Camp.addFollower(this);
                _instance = this;
				addSavedNPC(this);
			}
			else
			{
				throw new Error("Singleton. Use instance to access");
			}
		}
        public static function get instance():CelessScene {
	        if (!_instance){
		        new CelessScene();
	        }
	        return _instance;
        }
		public override function unload():void{
			EventParser.timeAwareClassRemove(_instance);
			Camp.removeFollower(_instance);
			_instance = null;
		}
		
		public override function save(saveto:*):void{
			saveto.celess = {
				myClass:getQualifiedClassName(this),
				age:_age,
				corruption:_corruption,
				name:_name,
				armorFound:_armorFound
			}
		}
		public override function load(loadfrom:*):void{
			if (loadfrom == undefined || loadfrom.celess == undefined){
				unload();
			}
			else{
				_age = loadfrom.celess.age;
				_corruption = loadfrom.celess.corruption;
				_name = loadfrom.celess.name;
				_armorFound = loadfrom.celess.armorFound;
			}
		}
        public override function checkCampEvent():Boolean{
            if (_age == _ageShouldDoBirth) {
                birthScene();
				hideMenus();
				return true;
			}
			return false;
		}

        //region INTERFACE classes.TimeAwareInterface
        public function timeChange():Boolean
		{
			if (_age > 0){_age++; }
			return false;
		}
		
		public function timeChangeLarge():Boolean 
		{
			if (_age > 720){
				growUpScene();
				_age = _ageIsAdult;
				EventParser.timeAwareClassRemove(instance);
				return true;
			}
			return false;
		}
        //endregion
		
		override public function get Name():String{
			return _name;
		}
		override public function isCompanion(type:int = -1):Boolean{
			if(type == COMPANION || type == FOLLOWER) return _age > 0 || _age == _ageIsAdult;
			return false;
		}
		public function get isCorrupt():Boolean{
			return _corruption >30;
		}
        public function get isAdult():Boolean{
			return _age == _ageIsAdult;
		}
		
		public function get armorFound():Boolean 
		{
			return _armorFound;
		}
		public function findArmor():void 
		{
			_armorFound = true;
		}
		
		override public function campDescription(buttons:ButtonDataList, menuType:int = -1):void
		{
			if (isCompanion(menuType)){
				outputText(Name+" is currently resting on all four in the nearby grassland area.\n\n");
                buttons.add(Name, campInteraction);
			}
		}
		public override function campInteraction():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			display("strings/campInteraction", {$name:_name});
			addButton(0, "Appearance", scene,"strings/appearance",{$name:_name},campInteraction);
			if (isAdult){
				if(isCorrupt || player.cor >= 20){addButton(1, "Incest", incestMenu);}
				addButton(2, "Items", itemImproveMenu);
			}
			else{
				addButton(1, "Play Time", scene,"strings/playTime", {$name:_name, $dangerousPlants:(player.hasKeyItem("Dangerous Plants") >= 0)});
			}
			addButton(14, "Back", camp.campFollowers);
			flushOutputTextToGUI();

            function incestMenu():void{
                if (isCorrupt){
                    clearOutput();
                    var menu:ButtonDataList = new ButtonDataList();
					display("strings/incest/corruptMenu",{$name:_name});
                    menu.add("Suck her off", curry(incestScene, "suckHerOff"));
					menu.add("Fuck Her", curry(incestScene, "fuckHer")).disableIf(!player.isMaleOrHerm());
					menu.add("Get Fucked", curry(incestScene, "getFucked")).disableIf(!player.isFemaleOrHerm());
					submenu(menu,campInteraction);
                }
                else{incestScene("pureIncest")}
            }
		}

		public function birthScene():void{
			if (_age == 0){
				_age =-2;
			}
			else{
				clearOutput();
				doNext(nameScene);
				display("strings/birth/intro");
				mainView.nameBox.text = "";
				flushOutputTextToGUI();
			}
            function nameScene():void{
                if (mainView.nameBox.text == ""){
                    clearOutput();
                    outputText("<b>You must name her.</b>");
                    mainView.nameBox.text = "Celess";
                    mainView.nameBox.visible = true;
                    mainView.nameBox.width = 165;
                    menu();
                    mainView.nameBox.x = mainView.mainText.x + 5;
                    mainView.nameBox.y = mainView.mainText.y + 3 + mainView.mainText.textHeight;
                    addButton(0, "Next", nameScene);
                    return;
                }
                _age = 1;
                _name = mainView.nameBox.text;
                _corruption = 0;
                if (player.cor > ((100 + player.corruptionTolerance()) / 2)){_corruption = 30;}

                mainView.nameBox.visible = false;
                clearOutput();
                doNext(camp.returnToCampUseFourHours);
                display("strings/birth/nameScene",{$name:_name});
                flushOutputTextToGUI();

            }
		}

		private function growUpScene():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			display("strings/growUp", {$name:_name});
			if (isCorrupt){
				addButton(0, "Masturbate Her", incestScene, "masturbateHer");
				if (player.isMaleOrHerm()){
					addButton(1, "Fuck Her", incestScene, "fuckHer");
				} else { addButtonDisabled(1, "Fuck Her"); }
				if (player.hasKeyItem("Fake Mare") + player.hasKeyItem("Centaur Pole") >= 0){
					addButton(2, "Centuar Toys", incestScene, "centaurToys");
				} else { addButtonDisabled(2, "Centaur Toys");}
			}
			flushOutputTextToGUI();
		}

		private function incestScene(sceneName:String):void{
			var toDisplay:String = "strings/incest/"+sceneName;
            scene(toDisplay,{$name:_name});
			if(sceneName == "pureIncest" && player.cor > 80){
				_corruption++;
				if (isCorrupt){
					addButton(0, "Next", incestScene, "pureCorruption");
				}
				else{
					display("strings/incest/addCorruption", {$name:_name});
					doNext(camp.returnToCampUseOneHour);
				}
			}
		}

		public function itemImproveMenu():void{
			/* Of the items in this array, the following are complete:
			 * CTPALAD - Centuar Paladin Armor
			 * CTBGUAR - Centuar Blackguard Armor
			 */
			var improvableItems:Array = [
					[weapons.BFSWORD,		weapons.NPHBLDE,		weapons.EBNYBLD],
					[weapons.MASTGLO,		weapons.KARMTOU,		weapons.YAMARG],
					[weapons.KATANA,		weapons.MASAMUN,		weapons.BLETTER],
					[weapons.W_STAFF,		weapons.U_STAFF,		weapons.N_STAFF],
				//	[weapons.DEMSCYT,		weapons.LHSCYTH,		null],
					[weapons.L__AXE,		weapons.WG_GAXE,		weapons.DE_GAXE],
					[weapons.SPEAR,			weapons.SESPEAR,		weapons.DSSPEAR],
					[weapons.JRAPIER,		weapons.Q_GUARD,		weapons.B_WIDOW],
					[weapons.OTETSU,		weapons.POCDEST,		weapons.DOCDEST],
					[weaponsrange.BOWLONG,	weaponsrange.ARTEMIS,	weaponsrange.WILDHUN],
					[weaponsrange.SHUNHAR,	weaponsrange.KSLHARP,	weaponsrange.LEVHARP],
					[shields.SANCTYN,		shields.SANCTYL,		shields.SANCTYD]//,
				//	[armors.CTPALAD,		null,					armors.CTBGUAR],
				//	[armors.LMARMOR,		armors.,			armors.]
				];
			clearOutput();
			outputText("<b>Not curruntly implemented</b>");

            var selectfrom:int = isCorrupt ? 2 : 1;
			var selectMenu:ButtonDataList = new ButtonDataList();
			for (var i:int = 0; i < improvableItems.length; i++){
				if(improvableItems[i][selectfrom] == null){/*do nothing*/}
				else{
					var item:ItemType = improvableItems[i][selectfrom];
					var from:ItemType = improvableItems[i][0];
					selectMenu.add(item.id,curry(improveItem,item,from)).disableIf(!player.hasItem(item));
				}
			}
			submenu(selectMenu,campInteraction);

			function improveItem(item:ItemType, from:ItemType):void{
                scene("strings/itemImprove/improveThatItem", {$name:_name});
                player.destroyItems(from, 1);
                inventory.takeItem(item, camp.returnToCampUseOneHour);
			}
		}
		public function celessUnicornIntro(stage:int = 0, wasMale:Boolean = false ):void{
            switch(stage){
                case 0:
					scene("strings/forest-unicorn/intro/intro");
					if(player.hasVirginVagina()){
						display("strings/forest-unicorn/intro/virgin");
						menu();
                        addButton(0, "Okay", celessUnicornIntro, (player.isMale() || player.isGenderless())?2:3);
                        if(player.hasCock()){addButton(1, "Fuck Her", celessUnicornIntro, 4);}
                        addButton(5, "NoWay", celessUnicornIntro, 1);
					} else {
						display("strings/forest-unicorn/intro/noVirgin");
						_age = _ageCanMeetNightmare;
						doNext(camp.returnToCampUseOneHour);
					}
                    break;
                case 1:
                    scene("strings/forest-unicorn/noway");
                    doNext(camp.returnToCampUseOneHour);
                    break;
                case 2:
                    if (player.bRows() == 0){
                        player.createBreastRow();
                    }
                    player.growTits(3, 1, false, 1);
                    scene("strings/forest-unicorn/okay-male");
                    while (player.hasCock()){
                        player.removeCock(0, 1);
                    }
                    player.createVagina();
                    addButton(0, "Next", celessUnicornIntro, 3,true);
                    break;
                case 3:
                    scene("strings/forest-unicorn/okay-female", {$wasMale:wasMale, $isTaur:player.isTaur()});
                    player.knockUpForce(PregnancyStore.PREGNANCY_CELESS, PregnancyStore.INCUBATION_CELESS);
                    inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
                    break;
                case 4:
                    scene("strings/forest-unicorn/fuck-her");
                    findArmor();
                    inventory.takeItem(shields.SANCTYN, camp.returnToCampUseOneHour);
                    break;
            }
        }
        public function celessArmor():void{
            scene("strings/forest-unicorn/armorScene");
            findArmor();
            inventory.takeItem(armors.CTPALAD, camp.returnToCampUseOneHour);
        }
    }
}
