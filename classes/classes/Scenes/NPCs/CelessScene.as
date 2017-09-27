package classes.Scenes.NPCs 
{
import classes.CoC;
import classes.Items.Useable;
import classes.Scenes.Camp;
import classes.TimeAwareInterface;

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

		public function CelessScene() 
		{
			if (!_instance){
				super("celess");
				CoC.timeAwareClassAdd(this);
				Camp.addFollower(this);
                _instance = this;
				addSavedNPC(this);
			}
			else
			{
				throw new Error("Singleton. Use getInstance();");
			}
		}
		public static function getInstance():CelessScene
		{
			if (!_instance){
				new CelessScene();
			}
			return _instance;
		}
        public static function get instance():CelessScene {
            return getInstance();
        }
		public override function unload():void{
			CoC.timeAwareClassRemove(_instance);
			Camp.removeFollower(_instance);
			removeSavedNPC(_instance);
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
			if (shouldDoBirth()){
				birthScene();
				hideMenus();
				return true;
			}
			return false;
		}
		
		/* INTERFACE classes.TimeAwareInterface */
		
		public function timeChange():Boolean 
		{
			if (_age > 0){_age++; }
			return false;
		}
		
		public function timeChangeLarge():Boolean 
		{
			if (_age > 720){
				growUpScene();
				_age = -1;
				return true;
			}
			return false;
		}
		// End Interface implementation
		
		override public function get Name():String{
			return _name;
		}
		override public function isCompanion(type:int = -1):Boolean{
			if(type == COMPANION || type == FOLLOWER) return _age != 0;
			return false;
		}
		public function get isCorrupt():Boolean{
			return _corruption >30;
		}
		public function get isAdult():Boolean{
			return _age == -1;
		}
		public function shouldDoBirth():Boolean{
			return _age == -2;
		}
		
		public function get armorFound():Boolean 
		{
			return _armorFound;
		}
		public function findArmor():void 
		{
			_armorFound = true;
		}
		
		override public function campDescription(menuType:int=-1, descOnly:Boolean=false):Boolean
		{
			if (isCompanion(menuType)){
				outputText(Name+" is currently resting on all four in the nearby grassland area.\n\n");
                addButton(3, Name, campInteraction);
				return descOnly;
			}
			return false;
		}
		public override function campInteraction():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			story.display("strings/campInteraction", {$name:_name});
			addButton(0, "Appearance", appearance);
			if (isAdult){
				addButton(1, "Incest", incestMenu);
				addButton(2, "Items", itemImproveMenu);
			}
			else{
				addButton(1, "Play Time", playtimeScene);
			}
			addButton(14, "Back", camp.campFollowers);
			flushOutputTextToGUI();
		}
		public function appearance():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			story.display("strings/appearance",{$name:_name});
			addButton(0, "Back", campInteraction);
		}
		public function birthScene():void{
			if (_age == 0){
				_age =-2;
			}
			else{
				clearOutput();
				doNext(nameScene);
				story.display("strings/birth/intro");
				mainView.nameBox.text = "";
				flushOutputTextToGUI();
			}
			
		}
		public function nameScene():void{
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
			story.display("strings/birth/nameScene",{$name:_name});
			flushOutputTextToGUI();
			
		}
		public function playtimeScene():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			story.display("strings/playTime", {$name:_name, $dangerousPlants:(player.hasKeyItem("Dangerous Plants") >= 0)});
			flushOutputTextToGUI();
		}
		public function growUpScene():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			story.display("strings/growUp", {$name:_name});
			if (isCorrupt){
				doHeatOrRut();
				addButton(0, "Masturbate Her", incestScene, 5);
				if (player.isMaleOrHerm()){
					addButton(1, "Fuck Her", incestScene, 0);
				}
				else{addButtonDisabled(1, "Fuck Her"); }	
				if (player.hasKeyItem("Fake Mare") + player.hasKeyItem("Centaur Pole") >= 0){addButton(2, "Centuar Toys", incestScene, 4); }
				else{addButtonDisabled(2, "Centaur Toys");}
			}
			flushOutputTextToGUI();
		}
		public function incestMenu():void{
			if (isCorrupt){
				clearOutput();
				story.display("strings/incest/corruptMenu",{$name:_name});
				addButton(0, "Suck her off", incestScene, 1);
				if (player.isMaleOrHerm()){
					addButton(1, "Fuck Her", incestScene, 0);
				}
				else{addButtonDisabled(1, "Fuck Her"); }
				if (player.isFemaleOrHerm()){
					addButton(1, "Get Fucked", incestScene, 2);
				}
				else{addButtonDisabled(1, "Get Fucked"); }
				addButton(5, "Back", campInteraction);
				flushOutputTextToGUI();
			}
			else{incestScene(3)}
		}
		public function incestScene(scene:int):void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			switch(scene){
				case 0:
					story.display("strings/incest/fuckHer",{$name:_name});
					break;
				case 1:
					story.display("strings/incest/suckHerOff",{$name:_name});
					doHeatOrRut();
					break;
				case 2:
					story.display("strings/incest/getFucked",{$name:_name});
					doHeatOrRut();
					break;
				case 3:
					story.display("strings/incest/pureIncest",{$name:_name});
					doHeatOrRut();
					if (player.cor > 80){
						_corruption++;
						if (isCorrupt){
							addButton(0, "Next", incestScene, 6);
						}
						else{
							story.display("strings/incest/addCorruption", {$name:_name});
							dynStats("cor", -1);
						}
					}
					break;
				case 4:
					story.display("strings/incest/centaurToys",{$name:_name});
					break;
				case 5:
					story.display("strings/incest/masturbateHer",{$name:_name});
					break;
				case 6:
					story.display("strings/incest/pureCorruption",{$name:_name});
					doHeatOrRut()
			}
			flushOutputTextToGUI();
		}
		public function doHeatOrRut():void{
			story.display("strings/incest/doHeatOrRut",{$name:_name});
			if (!player.goIntoHeat(true, 10)){player.goIntoRut(true, 10); }	
		}
		
		
		public function itemImproveMenu(item:Useable = null, from:Useable = null ):void{
			/*
			 * Of the items in this array, the following are complete:
			 * Q_GUARD - Queen's Guard Rapier
			 * B_WIDOW - Black Widow Rapier
			 * CTPALAD - Centuar Paladin Armor
			 * CTBGUAR - Centuar Blackguard Armor
			 * SANCTYN - Sanctuary unenchanted
			 * SANCTYL - Sanctuary pure enchant
			 * SANCTYD - Sanctuary dark aegis
			 * 
			 * The rest need either damage effects, perks, or both
			 * I have used the sanctuary perk as a placeholder on some of these items.
			 */
			var improvableItems:Array = [
					[weapons.BFSWORD,		weapons.NPHBLDE,	weapons.EBNYBLD],
					[weapons.KATANA,		weapons.MASAMUN,	weapons.BLETTER],
					[weapons.W_STAFF,		weapons.U_STAFF,	weapons.N_STAFF],
					[shields.SANCTYN,		shields.SANCTYL,	shields.SANCTYD],
					[weapons.DEMSCYT,		weapons.LHSCYTH,	null],
					[weaponsrange.BOWLONG,	weaponsrange.ARTEMIS,	weaponsrange.WILDHUN],
					[weapons.KIHAAXE,		weapons.WG_GAXE,	weapons.DE_GAXE],
					[weapons.SPEAR,			weapons.SESPEAR,	weapons.DSSPEAR],
					[weapons.JRAPIER,		weapons.Q_GUARD,	weapons.B_WIDOW],
					[armors.CTPALAD,		null,				armors.CTBGUAR]
				];
			var selectfrom:int = 1;
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			outputText("<b>Not curruntly implemented</B>");
			if (item != null){
				story.display("strings/itemImprove/improveThatItem", {$name:_name});
				player.destroyItems(from, 1);
				inventory.takeItem(item, camp.returnToCampUseOneHour);
				return;
			}
			if (isCorrupt){selectfrom = 2; }
			for (var i:int = 0; i < improvableItems.length; i++){
				if(improvableItems[i][selectfrom] == null){/*do nothing*/}
				else if (player.hasItem(improvableItems[i][0], 1)){
					addButton(i, (improvableItems[i][selectfrom])/*.id*/, itemImproveMenu,(improvableItems[i][selectfrom]),improvableItems[i][0]);
				}
				else{
					addButtonDisabled(i, (improvableItems[i][selectfrom]).id);
				}
			}
			addButton(14, "Back", campInteraction);
		}
    }
}