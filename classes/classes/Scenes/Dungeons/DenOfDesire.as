package classes.Scenes.Dungeons 
{
	import classes.*;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.BaseContent;
	import classes.Scenes.Dungeons.DungeonAbstractContent;
	import classes.Scenes.Dungeons.DungeonEngine;
	import classes.Scenes.Dungeons.DenOfDesire.*;
	//import classes.Scenes.NPCs.;
	import classes.PerkLib;
	
	public class DenOfDesire extends DungeonAbstractContent
	{
		private static const DUNGEON_DEN_OF_DESIRE_ENTRANCE:int  			= 64;
		private static const DUNGEON_DEN_OF_DESIRE_GREAT_HALL_AREA:int  	= 65;
		private static const DUNGEON_DEN_OF_DESIRE_LABORATORY:int  			= 66;
		private static const DUNGEON_DEN_OF_DESIRE_HERO_SLAYER_OMNIBUS:int  = 67;
		
		public function DenOfDesire() { }
		
		public function enterDungeon():void {
			kGAMECLASS.inDungeon = true;
			kGAMECLASS.dungeonLoc = 64;
			playerMenu();
		}
		public function exitDungeon():void {
			kGAMECLASS.inDungeon = false;
			clearOutput();
			outputText("You leave the den behind and take off through the ridge back towards camp.");
			doNext(camp.returnToCampUseOneHour);
		}
		
		//Rooms
		public function roomEntrance():void {
			kGAMECLASS.dungeonLoc = 64;
			clearOutput();
			outputText("<b><u>Entrance</u></b>\n");
			outputText("You stand in what looks like the entrance to some very old ruins, yet for some reason it's uncharacteristically tidy and clean. Likely something lives here, and not something friendly either.");
			dungeons.setDungeonButtons(roomGreatHallArea, null, null, null);
			addButton(11, "Leave", exitDungeon);
		}
		public function roomGreatHallArea():void {
			kGAMECLASS.dungeonLoc = 65;
			clearOutput();
			outputText("<b><u>Great Hall</u></b>\n");
			outputText("You stand in a great hall. Many statues line the walls here, giving the somewhat ominous feeling of being watched. The remains of the obsidian gargoyle still litter the floor.");
			dungeons.setDungeonButtons(roomLaboratory, roomEntrance, null, null);
			if(flags[kFLAGS.DEN_OF_DESIRE_BOSSES] < 2) {
				outputText("\n\nAs you set foot into a great hall, lined with obsidian statues depicting demons in various act of utter debauchery, one of the statues starts moving, turning its head toward you, as it slides off of the literally rock hard cock of the other statue on the pedestal representing a minor incubus.");
				outputText("\n\n\"<i>An intruder? Here? Please do me! Let me fuck your soul out! I've been starved for years and I'm pent up for a release. Master won't ever let me have release. I must.... FEED!</i>\"");
				outputText("\n\nThe lust crazed gargoyle, because it clearly is a gargoyle, is made out of carved obsidian and you can see the souls of dozens of people screaming for help within this abominations sparkling body. She starts walking toward you, fingering herself all the while with a dreamy expression.");
				startCombat(new ObsidianGargoyle(), true);
				//flags[kFLAGS.DEN_OF_DESIRE_BOSSES] = 2;
				doNext(playerMenu);
				return;
			}
		}
		public function roomLaboratory():void {
			kGAMECLASS.dungeonLoc = 66;
			clearOutput();
			outputText("<b><u>Laboratory</u></b>\n");
			outputText("This room seems to have served as a laboratory used to perform magical experiments on not so willing test subjects. Many lifeless corpses are stockpiled in a container, likely the bodies of failed experiments.");
			dungeons.setDungeonButtons(roomHeroSlayerOmnibusRoom, roomGreatHallArea, null, null);
		}
		public function roomHeroSlayerOmnibusRoom():void {
			kGAMECLASS.dungeonLoc = 67;
			clearOutput();
			outputText("<b><u>Hero slayer omnibus room</u></b>\n");
			outputText("This is where the Omnibus was practicing her horrifying research to create demonic gargoyles. Her blood is still warm on the floor; there is nothing left to do here.");
			dungeons.setDungeonButtons(null, roomLaboratory, null, null);/*
			if(flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] == 1) {
				outputText("\n\nA bat-shaped figures standing near you suddenly starting to move toward you with clearly hostile intentions.");
				startCombat(new LoliBatGolem(), true);
				flags[kFLAGS.HIDDEN_CAVE_LOLI_BAT_GOLEMS] = 2;
				doNext(playerMenu);
				return;
			}*/
		}
	}
}