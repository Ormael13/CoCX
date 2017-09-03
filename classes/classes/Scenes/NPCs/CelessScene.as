package classes.Scenes.NPCs 
{
	import classes.BaseContent;
	import classes.CoC;
	import classes.Items.Useable;
	import classes.SaveAwareInterface;
	import classes.TimeAwareInterface;
	import coc.xxc.Story;
	/**
	 * ...
	 * @author Oxdeception
	 */
	public class CelessScene extends BaseContent implements TimeAwareInterface
	{
		private var _age:int=0;
		private var _corruption:int=0;
		private var _name:String = "Celess";
		private var _armorFound:Boolean = false;
		private var _story:Story;
		
		public function CelessScene() 
		{
			onGameInit(init);
		}
		public function init():void{
			const game:CoC = getGame();
			CoC.timeAwareClassAdd(this);
			_story=new Story("story", game.rootStory, "celess", true);
		}
		
		public function save(saveto:*):void{
			saveto.celess = {
				age:_age,
				corruption:_corruption,
				name:_name,
				armorFound:_armorFound
			}
		}
		public function load(loadfrom:*):void{
			if (loadfrom == undefined || loadfrom.celess == undefined){
				_age = 0;
				_corruption = 0;
				_name = "Celess";
				_armorFound = false;
			}
			else{
				_age = loadfrom.celess.age;
				_corruption = loadfrom.celess.corruption;
				_name = loadfrom.celess.name;
				_armorFound = loadfrom.celess.armorFound;
			}
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
		
		public function get getName():String{
			return _name;
		}
		public function get isFollower():Boolean{
			return _age != 0;
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
		
		public function campInteraction():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			_story.display(context, "strings/campInteraction", {$name:_name});
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
			_story.display(context, "strings/appearance",{$name:_name})
			addButton(0, "Back", campInteraction);
		}
		public function birthScene():void{
			if (_age == 0){
				_age =-2;
			}
			else{
				clearOutput();
				doNext(nameScene);
				_story.display(context, "strings/birth/intro");
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
			_story.display(context, "strings/birth/nameScene",{$name:_name});
			flushOutputTextToGUI();
			
		}
		public function playtimeScene():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			_story.display(context, "strings/playTime", {$name:_name, $dangerousPlants:(player.hasKeyItem("Dangerous Plants") >= 0)});
			flushOutputTextToGUI();
		}
		public function growUpScene():void{
			clearOutput();
			doNext(camp.returnToCampUseOneHour);
			_story.display(context, "strings/growUp", {$name:_name});
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
				_story.display(context, "strings/incest/corruptMenu",{$name:_name});
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
					_story.display(context, "strings/incest/fuckHer",{$name:_name});
					break;
				case 1:
					_story.display(context, "strings/incest/suckHerOff",{$name:_name});
					doHeatOrRut()
					break;
				case 2:
					_story.display(context, "strings/incest/getFucked",{$name:_name});
					doHeatOrRut()
					break;
				case 3:
					_story.display(context, "strings/incest/pureIncest",{$name:_name});
					doHeatOrRut()
					if (player.cor > 80){
						_corruption++;
						if (isCorrupt){
							addButton(0, "Next", incestScene, 6);
						}
						else{
							_story.display(context, "strings/incest/addCorruption", {$name:_name});
							dynStats("cor", -1);
						}
					}
					break;
				case 4:
					_story.display(context, "strings/incest/centaurToys",{$name:_name});
					break;
				case 5:
					_story.display(context, "strings/incest/masturbateHer",{$name:_name});
					break;
				case 6:
					_story.display(context, "strings/incest/pureCorruption",{$name:_name});
					doHeatOrRut()
			}
			flushOutputTextToGUI();
		}
		public function doHeatOrRut():void{
			_story.display(context, "strings/incest/doHeatOrRut",{$name:_name});
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
				_story.display(context, "strings/itemImprove/improveThatItem", {$name:_name});
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