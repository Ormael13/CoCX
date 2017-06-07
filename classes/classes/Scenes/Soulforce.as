/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
	import classes.*
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	import classes.GlobalFlags.kGAMECLASS;
	import classes.GlobalFlags.kACHIEVEMENTS;
	import classes.Scenes.Places.Boat;
	import classes.Scenes.Places.Boat.Marae;
	import classes.Scenes.Areas.Forest.Tamani;
	import classes.Scenes.Areas.Forest.TamaniScene;
	import classes.Scenes.Areas.Forest.TamanisDaughters;
	import classes.Scenes.Areas.Forest.TamainsDaughtersScene;
	import classes.Scenes.Areas.Forest.WorldTree;
	import classes.Scenes.NPCs.Sonya;
	import classes.Scenes.NPCs.RyuBiDragon;
	import classes.Scenes.Areas.Forest.Alraune;
	
	use namespace kGAMECLASS;
	
	public class Soulforce extends BaseContent
	{
		public var tamaniDaughtersScene:TamainsDaughtersScene = new TamainsDaughtersScene();
		public var tamaniScene:TamaniScene = new TamaniScene();
		public var wolrdtreeScene:WorldTree = new WorldTree();
		
		
		public function accessSoulforceMenu():void {
			clearOutput();
			if (player.level >= 1 && player.findPerk(PerkLib.JobSoulCultivator) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 0) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 2 && player.findPerk(PerkLib.JobSoulCultivator) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 1) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 4 && player.findPerk(PerkLib.JobSoulCultivator) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 2) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 6 && player.findPerk(PerkLib.SoulApprentice) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 3) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 8 && player.findPerk(PerkLib.SoulApprentice) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 4) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 10 && player.findPerk(PerkLib.SoulApprentice) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 5) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 12 && player.findPerk(PerkLib.SoulPersonage) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 6) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 14 && player.findPerk(PerkLib.SoulPersonage) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 7) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 16 && player.findPerk(PerkLib.SoulPersonage) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 8) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 18 && player.findPerk(PerkLib.SoulWarrior) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 9) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 20 && player.findPerk(PerkLib.SoulWarrior) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 10) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 22 && player.findPerk(PerkLib.SoulWarrior) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 11) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 24 && player.findPerk(PerkLib.SoulSprite) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 12) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 26 && player.findPerk(PerkLib.SoulSprite) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 13) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 28 && player.findPerk(PerkLib.SoulSprite) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 14) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 30 && player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 15) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 32 && player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 16) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 34 && player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 17) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 36 && player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 18) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 38 && player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 19) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 40 && player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 20) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 42 && player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 21) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 44 && player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 22) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 46 && player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 23) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 48 && player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 24) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 50 && player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 25) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 52 && player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 26) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 54 && player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 27) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 56 && player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 28) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 58 && player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 29) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			outputText("<b>Cultivation stage:</b> ");
			if (player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 30)
				outputText("Late Soul Emperor\n");
			else if (player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 29)
				outputText("Middle Soul Emperor\n");
			else if (player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 28)
				outputText("Early Soul Emperor\n");
			else if (player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 27)
				outputText("Late Soul King\n");
			else if (player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 26)
				outputText("Middle Soul King\n");
			else if (player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 25)
				outputText("Early Soul King\n");
			else if (player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 24)
				outputText("Late Soul Tyrant\n");
			else if (player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 23)
				outputText("Middle Soul Tyrant\n");
			else if (player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 22)
				outputText("Early Soul Tyrant\n");
			else if (player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 21)
				outputText("Late Soul Overlord\n");
			else if (player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 20)
				outputText("Middle Soul Overlord\n");
			else if (player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 19)
				outputText("Early Soul Overlord\n");
			else if (player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 18)
				outputText("Late Soul Exalt\n");
			else if (player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 17)
				outputText("Middle Soul Exalt\n");
			else if (player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 16)
				outputText("Early Soul Exalt\n");
			else if (player.findPerk(PerkLib.SoulSprite) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 15)
				outputText("Late Soul Sprite\n");
			else if (player.findPerk(PerkLib.SoulSprite) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 14)
				outputText("Middle Soul Sprite\n");
			else if (player.findPerk(PerkLib.SoulSprite) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 13)
				outputText("Early Soul Sprite\n");
			else if (player.findPerk(PerkLib.SoulWarrior) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 12)
				outputText("Late Soul Warrior\n");
			else if (player.findPerk(PerkLib.SoulWarrior) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 11)
				outputText("Middle Soul Warrior\n");
			else if (player.findPerk(PerkLib.SoulWarrior) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 10)
				outputText("Early Soul Warrior\n");
			else if (player.findPerk(PerkLib.SoulPersonage) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 9)
				outputText("Late Soul Personage\n");
			else if (player.findPerk(PerkLib.SoulPersonage) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 8)
				outputText("Middle Soul Personage\n");
			else if (player.findPerk(PerkLib.SoulPersonage) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 7)
				outputText("Early Soul Personage\n");
			else if (player.findPerk(PerkLib.SoulApprentice) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 6)
				outputText("Late Soul Apprentice\n");
			else if (player.findPerk(PerkLib.SoulApprentice) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 5)
				outputText("Middle Soul Apprentice\n");
			else if (player.findPerk(PerkLib.SoulApprentice) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 4)
				outputText("Early Soul Apprentice\n");
			else
				outputText("Mortal\n");
			outputText("<b>Cultivation level:</b> " + flags[kFLAGS.SOUL_CULTIVATION] + "\n");
			outputText("<b>Spirit Stones:</b> " + flags[kFLAGS.SPIRIT_STONES] + "\n");
			outputText("<b>Additional Soulforce from training:</b> " + flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] + " / 310\n");
		/*	outputText("<b>Progress toward clearing next meridian: </b>");
			if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 2)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 1)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
		*/	outputText("<b>Current soulpower:</b> " + player.soulforce + " / " + player.maxSoulforce() + " \n");
			outputText("<b>Wisdom:</b> " + player.wis + " / " + player.getMaxStats("wis") + " \n");
			var dailySoulforceUsesLimit:Number = 0;
			if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
			menu();
			addButton(0, "Cultivate", SoulforceRegeneration, null, null, null, "Spend some time on restoring some of the used soulforce.");
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(1, "Self-sustain", SelfSustain, null, null, null, "Spend some soulforce on suppresing hunger for a while."); //zamiana soulforce na satiety w stosunku 1:5
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(2, "Repres. Lust", RepresLust, null, null, null, "Spend some soulforce on calming your sexual urges."); //używanie soulforce do zmniejszania lust w stosunku 1:2
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(4, "Adj. Corr.", CorruptionAndSoulforce, null, null, null, "Spend some soulforce on affecting your current corruption."); //używanie soulforce do zmniejszania corruption w stosunku 1:100 a zdobywanie corruption w stosunku 1:50
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(3, "Mana", ManaAndSoulforce, null, null, null, "Convert some soulforce into fatigue or vice versa."); //używanie soulforce do zmniejszania fatigue w stosunku 1:1 a fatigue do soulforce 1:2, używalne nawet w walce też ale z wiekszym kosztem przeliczania czyli 1:2 i 1:4
			//addButton(5, "Upgrade", UpgradeItems, null, null, null, "."); //ulepszanie itemów
			if (player.findPerk(PerkLib.Metamorph) >= 0) addButton(6, "Metamorf", kGAMECLASS.metamorph.accessMetamorphMenu, null, null, null, "Use your soulforce to mold freely your body.")//używanie metamorfowania z użyciem soulforce
			if (player.findPerk(PerkLib.SoulSense) >= 0) addButton(7, "Soul Sense", SoulSense, null, null, null, "Use your soul sense to trigger specific encounter."); //używanie divine sense aby znaleść określone event encounters: Tamani (lvl 6+), Tamani daugthers (lvl 6+), Kitsune mansion (lvl 12+), Izumi (lvl 18/24+), itp.
		//	addButton(10, "Cheats", SoulforceCheats, null, null, null, "Well as title saying those are cheats ^^");//block this option at each public version
			addButton(14, "Back", playerMenu);
		}//w lini 28 w oOnLoadVariables zmian wprowadzić i w lini conditionalConverters w folderze parser zmian dot. wraith wprowadzić, zablokować perki soul tyrant i dual wield w momencie robienia release version
		public function SoulforceCheats():void {
			clearOutput();
			outputText("Collection of current used cheats that with time will be removed or replaced by new ones.");
			outputText("\n\nAscension points: " + player.ascensionPerkPoints + "");
			menu();
			addButton(0, "Stats Adj.", StatsMenu, null, null, null, "For more precise adjusting each of 7 main stats.");
			addButton(1, "P/G/XP/LvL", PerksGemsEXPLvL, null, null, null, "Adding/Removing perk points and adding gems/exp/lvl.");
			addButton(2, "Equip", EquipmentMenu, null, null, null, "For creting various equipment items for tests.");
			addButton(3, "NonEquip", NonEquipmentMenu, null, null, null, "For creting various non-equipment items for tests.");
			addButton(4, "Materials", MaterialMenu, null, null, null, "For creting various materials for tests.");
			addButton(5, "Enemies", EnemiesMenu, null, null, null, "For spawning various enemies to test fight them.");
			addButton(6, "Ascension", AscensionMenu, null, null, null, "Submenu for Ascension related stuff.");
			addButton(7, "TonsOfPerks", GiveTonsOfPermablePerks, null, null, null, "Give All unowned permable perks (for perm glitch test at ascension)");
			addButton(8, "RevertCabin", RevertCabinProgress, null, null, null, "Revert cabin flag back to value 2 (for bug fix test)");
			addButton(9, "Gargoyle", GargoyleMenu, null, null, null, "To Be or Not To Be Gargoyle that is a question.");
			addButton(10, "<<< 10 >>>", kGAMECLASS.doNothing);
			addButton(11, "<<< 11 >>>", kGAMECLASS.doNothing);
			addButton(12, "<<< 12 >>>", kGAMECLASS.doNothing);
			addButton(13, "<<< 13 >>>", kGAMECLASS.doNothing);
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function StatsMenu():void {
			menu();
			addButton(0, "Str", StatsMenuStr, null, null, null, "Adj Str.");
			addButton(1, "Tou", StatsMenuTou, null, null, null, "Adj Tou.");
			addButton(2, "Spe", StatsMenuSpe, null, null, null, "Adj Spe.");
			addButton(3, "Inte", StatsMenuInte, null, null, null, "Adj Inte.");
			addButton(4, "Wis", StatsMenuWis, null, null, null, "Adj Wis.");
			addButton(5, "Lib", StatsMenuLib, null, null, null, "Adj Lib.");
			addButton(6, "Sens", StatsMenuSens, null, null, null, "Adj Sens.");
			addButton(7, "Cor", StatsMenuCor, null, null, null, "Adj Cor.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function StatsMenuStr():void {
			menu();
			addButton(0, "Str Up 1", AddStr1, null, null, null, "Add 1 to Str.");
			addButton(5, "Str Down 1", SubStr1, null, null, null, "Substract 1 from Str.");
			addButton(1, "Str Up 2", AddStr2, null, null, null, "Add 10 to Str.");
			addButton(6, "Str Down 2", SubStr2, null, null, null, "Substract 10 from Str.");
			addButton(2, "Str Up 3", AddStr3, null, null, null, "Add 50 to Str.");
			addButton(7, "Str Down 3", SubStr3, null, null, null, "Substract 50 from Str.");
			addButton(14, "Back", StatsMenu);
		}
		public function StatsMenuTou():void {
			menu();
			addButton(0, "Tou Up 1", AddTou1, null, null, null, "Add 1 to Tou.");
			addButton(5, "Tou Down 1", SubTou1, null, null, null, "Substract 1 from Tou.");
			addButton(1, "Tou Up 2", AddTou2, null, null, null, "Add 10 to Tou.");
			addButton(6, "Tou Down 2", SubTou2, null, null, null, "Substract 10 from Tou.");
			addButton(2, "Tou Up 3", AddTou3, null, null, null, "Add 50 to Tou.");
			addButton(7, "Tou Down 3", SubTou3, null, null, null, "Substract 50 from Tou.");
			addButton(14, "Back", StatsMenu);
		}
		public function StatsMenuSpe():void {
			menu();
			addButton(0, "Spe Up 1", AddSpe1, null, null, null, "Add 1 to Spe.");
			addButton(5, "Spe Down 1", SubSpe1, null, null, null, "Substract 1 from Spe.");
			addButton(1, "Spe Up 2", AddSpe2, null, null, null, "Add 10 to Spe.");
			addButton(6, "Spe Down 2", SubSpe2, null, null, null, "Substract 10 from Spe.");
			addButton(2, "Spe Up 3", AddSpe3, null, null, null, "Add 50 to Spe.");
			addButton(7, "Spe Down 3", SubSpe3, null, null, null, "Substract 50 from Spe.");
			addButton(14, "Back", StatsMenu);
		}
		public function StatsMenuInte():void {
			menu();
			addButton(0, "Inte Up 1", AddInte1, null, null, null, "Add 1 to Inte.");
			addButton(5, "Inte Down 1", SubInte1, null, null, null, "Substract 1 from Inte.");
			addButton(1, "Inte Up 2", AddInte2, null, null, null, "Add 10 to Inte.");
			addButton(6, "Inte Down 2", SubInte2, null, null, null, "Substract 10 from Inte.");
			addButton(2, "Inte Up 3", AddInte3, null, null, null, "Add 50 to Inte.");
			addButton(7, "Inte Down 3", SubInte3, null, null, null, "Substract 50 from Inte.");
			addButton(14, "Back", StatsMenu);
		}
		public function StatsMenuWis():void {
			menu();
			addButton(0, "Wis Up 1", AddWis1, null, null, null, "Add 1 to Wis.");
			addButton(5, "Wis Down 1", SubWis1, null, null, null, "Substract 1 from Wis.");
			addButton(1, "Wis Up 2", AddWis2, null, null, null, "Add 10 to Wis.");
			addButton(6, "Wis Down 2", SubWis2, null, null, null, "Substract 10 from Wis.");
			addButton(2, "Wis Up 3", AddWis3, null, null, null, "Add 50 to Wis.");
			addButton(7, "Wis Down 3", SubWis3, null, null, null, "Substract 50 from Wis.");
			addButton(14, "Back", StatsMenu);
		}
		public function StatsMenuLib():void {
			menu();
			addButton(0, "Lib Up 1", AddLib1, null, null, null, "Add 1 to Lib.");
			addButton(5, "Lib Down 1", SubLib1, null, null, null, "Substract 1 from Lib.");
			addButton(1, "Lib Up 2", AddLib2, null, null, null, "Add 10 to Lib.");
			addButton(6, "Lib Down 2", SubLib2, null, null, null, "Substract 10 from Lib.");
			addButton(2, "Lib Up 3", AddLib3, null, null, null, "Add 50 to Lib.");
			addButton(7, "Lib Down 3", SubLib3, null, null, null, "Substract 50 from Lib.");
			addButton(14, "Back", StatsMenu);
		}
		public function StatsMenuSens():void {
			menu();
			addButton(1, "Sens Up 1", AddSens1, null, null, null, "Add 1 to Sens.");
			addButton(6, "Sens Down 1", SubSens1, null, null, null, "Substract 1 from Sens.");
			addButton(1, "Sens Up 2", AddSens2, null, null, null, "Add 10 to Sens.");
			addButton(6, "Sens Down 2", SubSens2, null, null, null, "Substract 10 from Sens.");
			addButton(1, "Sens Up 3", AddSens3, null, null, null, "Add 50 to Sens.");
			addButton(6, "Sens Down 3", SubSens3, null, null, null, "Substract 50 from Sens.");
			addButton(14, "Back", StatsMenu);
		}
		public function StatsMenuCor():void {
			menu();
			addButton(0, "Cor Up 1", AddCor1, null, null, null, "Add 1 to Cor.");
			addButton(5, "Cor Down 1", SubCor1, null, null, null, "Substract 1 from Cor.");
			addButton(1, "Cor Up 2", AddCor2, null, null, null, "Add 10 to Cor.");
			addButton(6, "Cor Down 2", SubCor2, null, null, null, "Substract 10 from Cor.");
			addButton(2, "Cor Up 3", AddCor3, null, null, null, "Add 50 to Cor.");
			addButton(7, "Cor Down 3", SubCor3, null, null, null, "Substract 50 from Cor.");
			addButton(14, "Back", StatsMenu);
		}
		public function PerksGemsEXPLvL():void {
			menu();
			addButton(0, "Add 1 PerkP", AddPerkPoint, null, null, null, "Add 1 perk point.");
			addButton(1, "Add 5 PerkP", AddPerkPoints, null, null, null, "Add 5 perk points.");
			addButton(2, "Sub 10 PerkP", SubPerkPoints, null, null, null, "Substract 10 perk points.");
			addButton(3, "Add Gems 1", AddGems1, null, null, null, "Add 100 gems.");
			addButton(4, "Add Gems 2", AddGems2, null, null, null, "Add 1000 gems.");
			addButton(5, "Add EXP 1", AddEXP1, null, null, null, "Add 100 EXP.");
			addButton(6, "Add EXP 2", AddEXP2, null, null, null, "Add 1000 EXP.");
			addButton(7, "Add EXP 3", AddEXP3, null, null, null, "Add 10000 EXP.");
			addButton(8, "Add EXP 4", AddEXP4, null, null, null, "Add 100000 EXP.");
			if (player.level < 149) addButton(10, "Add 1 LvL", AddLvL1, null, null, null, "Add 1 Level (with stat and perk points).");
			if (player.level < 139) addButton(11, "Add 10 LvL's", AddLvL2, null, null, null, "Add 10 Levels (with stat and perk points).");
			if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) < 0) addButton(12, "Trib Perks", TribulationPerks, null, null, null, "Add 2 Tribulation perks.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function TribulationPerks():void {
			if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) < 0) {
				player.createPerk(PerkLib.HclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: H class Heaven Tribulation Survivor!)</b>");
			}
			if (player.findPerk(PerkLib.GclassHeavenTribulationSurvivor) < 0) {
				player.createPerk(PerkLib.GclassHeavenTribulationSurvivor, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: G class Heaven Tribulation Survivor!)</b>");
			}
			doNext(SoulforceCheats);
		}
		public function EquipmentMenu():void {
			menu();
			addButton(0, "Rap. Perk", AddRapPerk, null, null, null, "Add Raphael Rapier Perk and 1 Dragon Rapier.  USE only ONCE to not break the game!");
			addButton(1, "Sky Pearl", AddSkyPoisonPearl, null, null, null, "Add 1 Sky Poison Pearl.");
			addButton(2, "L Ayo Arm", AddLightAyoArmor, null, null, null, "Add 1 Light Ayo Armor for testing purposes.");
			addButton(2, "Staff", AddStaff, null, null, null, "Add 1 Eldritch Staff.");
			addButton(3, "Evelyn", AddTheEvelyn, null, null, null, "Add 1 Evelyn Crossbow.");
			addButton(4, "E. Ribbon", AddEldritchRibbon, null, null, null, "Add 1 Eldritch Ribbon.");
			addButton(5, "G.Thr.Axes", AddGnollThrowingAxes, null, null, null, "Add 1 Gnoll Throwing Axes.");
			addButton(6, "Ascensus", AddTheStaffs, null, null, null, "Add set of items for Ascensus.");
			addButton(7, "DualSwords", AddDualSwords, null, null, null, "Add 1 pair of Dual Swords for testing purposes.");
			addButton(8, "DualLAxes", AddDualMinoAxes, null, null, null, "Add 1 pair of Large Axes for testing purposes.");
			//addButton(9, "Kelt Bow", AddTheBowKelt, null, null, null, "Add 1 Tainted Bow.");
			//addButton(10, "BlunderR", AddTheBlunderbussRifle, null, null, null, "Add 1 Blunderbuss Rifle.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function NonEquipmentMenu():void {
			menu();
			addButton(0, "Fox Jewel", AddFoxJewel, null, null, null, "Add 1 Fox Jewel.");
			addButton(1, "Fish", AddFish, null, null, null, "Add 1 Fish.")
			addButton(2, "BehemothCum", AddBehemothCum, null, null, null, "Add 1 bottle of Behemoth Cum.");
			addButtonDisabled(4, "AbyssalInk", "Not yet ready for test and just for future use put here already ^^ (Add 1 Abyssal Ink.)");
			addButton(5, "Gorgon Oil", AddGorgonOil, null, null, null, "Add 1 vial of Gorgon Oil.");
			addButton(6, "Vouivre Oil", AddVouivreOil, null, null, null, "Add 1 vial of Vouivre Oil.");
			addButton(7, "Couatl Oil", AddCouatlOil, null, null, null, "Add 1 vial of Couatl Oil.");
			//addButton(6, "ManticoreV", AddManticoreVenom, null, null, null, "Add 1 Manticore Venom. (1st iteration - still incomplete TF)");
			addButton(10, "White B.", AddWhiteBook, null, null, null, "Add 1 White Book.");
			addButton(11, "Black B.", AddBlackBook, null, null, null, "Add 1 Black Book.");
			addButton(12, "Grey B.", AddGreyBook, null, null, null, "Add 1 Grey Book.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function MaterialMenu():void {
			menu();
			addButton(0, "Wood", AddWood, null, null, null, "Add 100 Wood (game not check for limits so not go overboard with using this cheat).");
			addButton(1, "Nails", AddNail, null, null, null, "Add 50 Nails (game not check for limits so not go overboard with using this cheat).");
			addButton(2, "Stone", AddStone, null, null, null, "Add 100 Stone (game not check for limits so not go overboard with using this cheat).");
			addButton(3, "SpiderSilk", AddSpiderSilk, null, null, null, "Add 1 Spider Silk.");
			addButton(4, "Ebonbloom", AddEbonbloom, null, null, null, "Add 1 Ebonbloom.");
			addButton(5, "WorldTreeB.", AddWorldTreeBranch, null, null, null, "Add 1 World Tree Branch.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function EnemiesMenu():void {
			menu();
			addButton(0, "FightForPearl", FightForPearl, null, null, null, "Test fight to get Sky Poison Pearl legally (aside we cheat to start fight)");
			addButton(1, "MaraeFight", FightMarae, null, null, null, "Test fight with Marae (depending on game stage she can be buffed or unbuffed).");
			addButton(2, "SonyaFight", FightSonya, null, null, null, "Test fight with Sonya.");
			addButton(3, "RyuBiFight", FightRyuBi, null, null, null, "Test fight with RyuBi.");
			addButton(4, "Alraune", FightAlraune, null, null, null, "Test fight with Alraune.");
			addButton(10, "LvLUP Eva", LvLUPEva, null, null, null, "LvL UP forcefully Evangeline for testing purpose up to the limit.");
			addButton(11, "DELvL Eva", DELvLEva, null, null, null, "DE LvL forcefully Evangeline for testing purpose down toward the lvl 12.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function AscensionMenu():void {
			menu();
			addButton(0, "EarlyAscension", EarlyAscension, null, null, null, "Allowing to premature ascension (not yet usefull for testing purpose at least until I not get to testing of ascension rework).");
			addButton(1, "AscenPerks01", AddAscensionPerkPoints1, null, null, null, "Add 1 ascension perk point for use during ascending to the next NG+ tier.");
			addButton(2, "AscenPerks05", AddAscensionPerkPoints2, null, null, null, "Add 5 ascension perk points for use during ascending to the next NG+ tier.");
			addButton(3, "AscenPerks10", AddAscensionPerkPoints3, null, null, null, "Add 10 ascension perk points for use during ascending to the next NG+ tier.");
			addButton(4, "AscenPerks50", AddAscensionPerkPoints4, null, null, null, "Add 50 ascension perk points for use during ascending to the next NG+ tier.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function AddStaff():void {
			outputText("\n\n<b>(Gained 1 Eldritch Staff!)</b>\n\n");
			inventory.takeItem(weapons.E_STAFF, EquipmentMenu);
		}
		public function AddSpiderSilk():void {
			outputText("\n\n<b>(Gained 1 Spider Silk!)</b>\n\n");
			inventory.takeItem(useables.T_SSILK, MaterialMenu);
		}
		public function AddFish():void {
			outputText("\n\n<b>(Gained 1 Fish!)</b>\n\n");
			inventory.takeItem(consumables.FISHFIL, NonEquipmentMenu);
		}
		public function AddFoxJewel():void {
			outputText("\n\n<b>(Gained 1 Fox Jewel!)</b>\n\n");
			inventory.takeItem(consumables.FOXJEWL, NonEquipmentMenu);
		}
		public function AddManticoreVenom():void {
			outputText("\n\n<b>(Gained 1 vial of Manticore Venom!)</b>\n\n");
			inventory.takeItem(consumables.MANTICV, SoulforceCheats);
		}
		public function AddBladeGrass():void {
			outputText("\n\n<b>(Gained 1 Blade Grass!)</b>\n\n");
			inventory.takeItem(consumables.BLADEGR, SoulforceCheats);
		}
		public function AddGorgonOil():void {
			outputText("\n\n<b>(Gained 1 vial of Gorgon Oil!)</b>\n\n");
			inventory.takeItem(consumables.GORGOIL, NonEquipmentMenu);
		}
		public function AddVouivreOil():void {
			outputText("\n\n<b>(Gained 1 vial of Vouivre Oil!)</b>\n\n");
			inventory.takeItem(consumables.VOUIOIL, NonEquipmentMenu);
		}
		public function AddCouatlOil():void {
			outputText("\n\n<b>(Gained 1 vial of Couatl Oil!)</b>\n\n");
			inventory.takeItem(consumables.COUAOIL, NonEquipmentMenu);
		}
		public function AddBehemothCum():void {
			outputText("\n\n<b>(Gained 1 vial of Behemoth Cum!)</b>\n\n");
			inventory.takeItem(consumables.BHMTCUM, NonEquipmentMenu);
		}
		public function AddEbonbloom():void {
			outputText("\n\n<b>(Gained 1 Ebonbloom!)</b>\n\n");
			inventory.takeItem(useables.EBONBLO, MaterialMenu);
		}
		public function AddWorldTreeBranch():void {
			outputText("\n\n<b>(Gained 1 Wold Tree branch!)</b>\n\n");
			inventory.takeItem(useables.WT_BRAN, MaterialMenu);
		}
		public function AddTheStaffs():void {
			outputText("\n\n<b>(Gained set of items to make Ascensus!)</b>\n\n");
			inventory.takeItem(useables.TBAPLAT, AddTheStaffs1);
		}
		public function AddTheStaffs1():void {
			outputText("\n\n");
			inventory.takeItem(useables.DBAPLAT, AddTheStaffs2);
		}
		public function AddTheStaffs2():void {
			outputText("\n\n");
			inventory.takeItem(weapons.W_STAFF, EquipmentMenu);
		}
		public function AddYetiCum():void {
			outputText("\n\n<b>(Gained 1 Yeti Cum!)</b>\n\n");
			inventory.takeItem(consumables.YETICUM, EquipmentMenu);
		}
		public function AddTheBlunderbussRifle():void {
			outputText("\n\n<b>(Gained 1 Blunderbuss Rifle!)</b>\n\n");
			inventory.takeItem(weaponsrange.BLUNDER, EquipmentMenu);
		}
		public function AddTheEvelyn():void {
			outputText("\n\n<b>(Gained 1 Evelyn Crossbow!)</b>\n\n");
			inventory.takeItem(weaponsrange.EVELYN_, EquipmentMenu);
		}
		public function AddEldritchRibbon():void {
			outputText("\n\n<b>(Gained 1 Eldritch Ribbon!)</b>\n\n");
			inventory.takeItem(weapons.ERIBBON, EquipmentMenu);
		}
		public function AddGnollThrowingAxes():void {
			outputText("\n\n<b>(Gained 1 Gnoll Throwing Axes!)</b>\n\n");
			inventory.takeItem(weaponsrange.GTHRAXE, EquipmentMenu);
		}
		public function EarlyAscension():void {
			if (flags[kFLAGS.LETHICE_DEFEATED] < 1) {
				flags[kFLAGS.LETHICE_DEFEATED] = 1;
				outputText("\n\n<b>You can Ascend now even if you not beaten Lethice yet!</b>");
			}
			else outputText("\n\n<b>You already used this cheat code!</b>");
			doNext(AscensionMenu);
		}
		public function AddAscensionPerkPoints1():void {
			outputText("\n\n<b>You gained 1 Ascension Perk Point!</b>");
			player.ascensionPerkPoints += 1;
			doNext(AscensionMenu);
		}
		public function AddAscensionPerkPoints2():void {
			outputText("\n\n<b>You gained 5 Ascension Perk Points!</b>");
			player.ascensionPerkPoints += 5;
			doNext(AscensionMenu);
		}
		public function AddAscensionPerkPoints3():void {
			outputText("\n\n<b>You gained 10 Ascension Perk Points!</b>");
			player.ascensionPerkPoints += 10;
			doNext(AscensionMenu);
		}
		public function AddAscensionPerkPoints4():void {
			outputText("\n\n<b>You gained 50 Ascension Perk Points!</b>");
			player.ascensionPerkPoints += 50;
			doNext(AscensionMenu);
		}
		public function AddStr1():void {
			player.str = player.str + 1;
			statScreenRefresh();
			StatsMenuStr();
		}
		public function AddStr2():void {
			player.str = player.str + 10;
			statScreenRefresh();
			StatsMenuStr();
		}
		public function AddStr3():void {
			player.str = player.str + 50;
			statScreenRefresh();
			StatsMenuStr();
		}
		public function AddTou1():void {
			player.tou = player.tou + 1;
			statScreenRefresh();
			StatsMenuTou();
		}
		public function AddTou2():void {
			player.tou = player.tou + 10;
			statScreenRefresh();
			StatsMenuTou();
		}
		public function AddTou3():void {
			player.tou = player.tou + 50;
			statScreenRefresh();
			StatsMenuTou();
		}
		public function AddSpe1():void {
			player.spe = player.spe + 1;
			statScreenRefresh();
			StatsMenuSpe();
		}
		public function AddSpe2():void {
			player.spe = player.spe + 10;
			statScreenRefresh();
			StatsMenuSpe();
		}
		public function AddSpe3():void {
			player.spe = player.spe + 50;
			statScreenRefresh();
			StatsMenuSpe();
		}
		public function AddInte1():void {
			player.inte = player.inte + 1;
			statScreenRefresh();
			StatsMenuInte();
		}
		public function AddInte2():void {
			player.inte = player.inte + 10;
			statScreenRefresh();
			StatsMenuInte();
		}
		public function AddInte3():void {
			player.inte = player.inte + 50;
			statScreenRefresh();
			StatsMenuInte();
		}
		public function AddWis1():void {
			player.wis = player.wis + 1;
			statScreenRefresh();
			StatsMenuWis();
		}
		public function AddWis2():void {
			player.wis = player.wis + 10;
			statScreenRefresh();
			StatsMenuWis();
		}
		public function AddWis3():void {
			player.wis = player.wis + 50;
			statScreenRefresh();
			StatsMenuWis();
		}
		public function AddLib1():void {
			player.lib = player.lib + 1;
			statScreenRefresh();
			StatsMenuLib();
		}
		public function AddLib2():void {
			player.lib = player.lib + 10;
			statScreenRefresh();
			StatsMenuLib();
		}
		public function AddLib3():void {
			player.lib = player.lib + 50;
			statScreenRefresh();
			StatsMenuLib();
		}
		public function AddSens1():void {
			player.sens = player.sens + 1;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function AddSens2():void {
			player.sens = player.sens + 10;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function AddSens3():void {
			player.sens = player.sens + 50;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function AddCor1():void {
			player.cor = player.cor + 1
			statScreenRefresh();
			StatsMenuCor();
		}
		public function AddCor2():void {
			player.cor = player.cor + 10;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function AddCor3():void {
			player.cor = player.cor + 50;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function SubStr1():void {
			player.str = player.str - 1;
			statScreenRefresh();
			StatsMenuStr();
		}
		public function SubStr2():void {
			player.str = player.str - 10;
			statScreenRefresh();
			StatsMenuStr();
		}
		public function SubStr3():void {
			player.str = player.str - 50;
			statScreenRefresh();
			StatsMenuStr();
		}
		public function SubTou1():void {
			player.tou = player.tou - 1;
			statScreenRefresh();
			StatsMenuTou();
		}
		public function SubTou2():void {
			player.tou = player.tou - 10;
			statScreenRefresh();
			StatsMenuTou();
		}
		public function SubTou3():void {
			player.tou = player.tou - 50;
			statScreenRefresh();
			StatsMenuTou();
		}
		public function SubSpe1():void {
			player.spe = player.spe - 1;
			statScreenRefresh();
			StatsMenuSpe();
		}
		public function SubSpe2():void {
			player.spe = player.spe - 10;
			statScreenRefresh();
			StatsMenuSpe();
		}
		public function SubSpe3():void {
			player.spe = player.spe - 50;
			statScreenRefresh();
			StatsMenuSpe();
		}
		public function SubInte1():void {
			player.inte = player.inte - 1;
			statScreenRefresh();
			StatsMenuInte();
		}
		public function SubInte2():void {
			player.inte = player.inte - 10;
			statScreenRefresh();
			StatsMenuInte();
		}
		public function SubInte3():void {
			player.inte = player.inte - 50;
			statScreenRefresh();
			StatsMenuInte();
		}
		public function SubWis1():void {
			player.wis = player.wis - 1;
			statScreenRefresh();
			StatsMenuWis();
		}
		public function SubWis2():void {
			player.wis = player.wis - 10;
			statScreenRefresh();
			StatsMenuWis();
		}
		public function SubWis3():void {
			player.wis = player.wis - 50;
			statScreenRefresh();
			StatsMenuWis();
		}
		public function SubLib1():void {
			player.lib = player.lib - 1;
			statScreenRefresh();
			StatsMenuLib();
		}
		public function SubLib2():void {
			player.lib = player.lib - 10;
			statScreenRefresh();
			StatsMenuLib();
		}
		public function SubLib3():void {
			player.lib = player.lib - 50;
			statScreenRefresh();
			StatsMenuLib();
		}
		public function SubSens1():void {
			player.sens = player.sens - 1;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function SubSens2():void {
			player.sens = player.sens - 10;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function SubSens3():void {
			player.sens = player.sens - 50;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function SubCor1():void {
			player.cor = player.cor - 1;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function SubCor2():void {
			player.cor = player.cor - 10;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function SubCor3():void {
			player.cor = player.cor - 50;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function AddPerkPoint():void {
			player.perkPoints = player.perkPoints + 1;
			PerksGemsEXPLvL();
		}
		public function AddPerkPoints():void {
			player.perkPoints = player.perkPoints + 5;
			PerksGemsEXPLvL();
		}
		public function SubPerkPoints():void {
			player.perkPoints = player.perkPoints - 10;
			PerksGemsEXPLvL();
		}
		public function AddGems1():void {
			player.gems = player.gems + 100;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddGems2():void {
			player.gems = player.gems + 1000;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddEXP1():void {
			player.XP = player.XP + 100;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddEXP2():void {
			player.XP = player.XP + 1000;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddEXP3():void {
			player.XP = player.XP + 10000;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddEXP4():void {
			player.XP = player.XP + 100000;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddLvL1():void {
			player.level = player.level + 1;
			player.statPoints += 5;
			player.perkPoints = player.perkPoints + 1;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddLvL2():void {
			player.level = player.level + 10;
			player.statPoints += 50;
			player.perkPoints = player.perkPoints + 10;
			statScreenRefresh();
			PerksGemsEXPLvL();
		}
		public function AddRapPerk():void {
			flags[kFLAGS.RAPHAEL_RAPIER_TRANING] = 4;
			player.createPerk(PerkLib.RapierTraining, 0, 0, 0, 0);
			outputText("\n\n<b>(Gained Perk: Rapier Training and 1 Dragon Rapier!)</b>\n\n");
			inventory.takeItem(weapons.DRAPIER, EquipmentMenu);
		}
		public function AddSkyPoisonPearl():void {
			outputText("\n\n<b>(Gained 1 Sky Poison Pearl!)</b>\n\n");
			inventory.takeItem(consumables.SPPEARL, EquipmentMenu);
		}
		public function AddLightAyoArmor():void {
			outputText("\n\n<b>(Gained 1 Light Ayo Armor!)</b>\n\n");
			inventory.takeItem(armors.LAYOARM, EquipmentMenu);
		}
		public function AddDualSwords():void {
			outputText("\n\n<b>(Gained 1 pair of Dual Swords!)</b>\n\n");
			inventory.takeItem(weapons.DSWORD_, EquipmentMenu);
		}
		public function AddDualMinoAxes():void {
			outputText("\n\n<b>(Gained 1 pair of Large Axes!)</b>\n\n");
			inventory.takeItem(weapons.DL_AXE_, EquipmentMenu);
		}
		public function AddWhiteBook():void {
			outputText("\n\n<b>(Gained 1 White Book!)</b>\n\n");
			inventory.takeItem(consumables.W__BOOK, NonEquipmentMenu);
		}
		public function AddBlackBook():void {
			outputText("\n\n<b>(Gained 1 Black Book!)</b>\n\n");
			inventory.takeItem(consumables.B__BOOK, NonEquipmentMenu);
		}
		public function AddGreyBook():void {
			outputText("\n\n<b>(Gained 1 Grey Book!)</b>\n\n");
			inventory.takeItem(consumables.G__BOOK, NonEquipmentMenu);
		}
		public function AddWood():void {
			outputText("\n\n<b>(Gained 100 Wood!)</b>");
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 100;
			statScreenRefresh();
			MaterialMenu();
		}
		public function AddNail():void {
			outputText("\n\n<b>(Gained 50 Nails!)</b>");
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += 50;
			statScreenRefresh();
			MaterialMenu();
		}
		public function AddStone():void {
			outputText("\n\n<b>(Gained 100 Stones!)</b>");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 100;
			statScreenRefresh();
			MaterialMenu();
		}
		public function FightForPearl():void {
			clearOutput();
			outputText("Entering battle with Krakken Boss! Enjoy ^^");
			startCombat(new Krakken());
		}
		public function FightMarae():void {
			clearOutput();
			outputText("Entering battle with Marae Boss! Enjoy ^^");
			startCombat(new Marae());
		}
		public function FightSonya():void {
			clearOutput();
			outputText("Entering battle with Sonya! Enjoy ^^");
			startCombat(new Sonya());
		}
		public function FightRyuBi():void {
			clearOutput();
			outputText("Entering battle with RyuBi! Enjoy ^^");
			startCombat(new RyuBiDragon());
		}
		public function FightAlraune():void {
			clearOutput();
			outputText("Entering battle with Alraune! Enjoy ^^");
			startCombat(new Alraune());
		}
		public function LvLUPEva():void {
			outputText("\n\n<b>Evangeline get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 42))</b>");
			if (flags[kFLAGS.EVANGELINE_LVL_UP] < 17) flags[kFLAGS.EVANGELINE_LVL_UP]++;
			doNext(EnemiesMenu);
		}
		public function DELvLEva():void {
			outputText("\n\n<b>Evangeline get weaker! (cheat stop working when she reach lvl 12)</b>");
			if (flags[kFLAGS.EVANGELINE_LVL_UP] > 6) flags[kFLAGS.EVANGELINE_LVL_UP]--;
			doNext(EnemiesMenu);
		}
		public function GiveTonsOfPermablePerks():void {
			if (player.findPerk(PerkLib.CorruptedKitsune) < 0) {
				player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Corrupted Kitsune!)</b>");
			}
			if (player.findPerk(PerkLib.CorruptedNinetails) < 0) {
				player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Corrupted Ninetails!)</b>");
			}
			if (player.findPerk(PerkLib.DarkCharm) < 0) {
				player.createPerk(PerkLib.DarkCharm, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Dark Charm!)</b>");
			}
			if (player.findPerk(PerkLib.DragonFireBreath) < 0) {
				player.createPerk(PerkLib.DragonFireBreath, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Dragon Fire Breath!)</b>");
			}
			if (player.findPerk(PerkLib.DragonIceBreath) < 0) {
				player.createPerk(PerkLib.DragonIceBreath, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Dragon Ice Breath!)</b>");
			}
			if (player.findPerk(PerkLib.EnlightenedKitsune) < 0) {
				player.createPerk(PerkLib.EnlightenedKitsune, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Enlightened Kitsune!)</b>");
			}
			if (player.findPerk(PerkLib.EnlightenedNinetails) < 0) {
				player.createPerk(PerkLib.EnlightenedNinetails, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Enlightened Ninetails!)</b>");
			}
			if (player.findPerk(PerkLib.FerasBoonAlpha) < 0) {
				player.createPerk(PerkLib.FerasBoonAlpha, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Feras Boon Alpha!)</b>");
			}
			if (player.findPerk(PerkLib.FerasBoonBreedingBitch) < 0) {
				player.createPerk(PerkLib.FerasBoonBreedingBitch, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Feras Boon Breeding Bitch!)</b>");
			}
			if (player.findPerk(PerkLib.FerasBoonMilkingTwat) < 0) {
				player.createPerk(PerkLib.FerasBoonMilkingTwat, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Feras Boon Milking Twat!)</b>");
			}
			if (player.findPerk(PerkLib.FerasBoonSeeder) < 0) {
				player.createPerk(PerkLib.FerasBoonSeeder, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Feras Boon Seeder!)</b>");
			}
			if (player.findPerk(PerkLib.FireLord) < 0) {
				player.createPerk(PerkLib.FireLord, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Fire Lord!)</b>");
			}
			if (player.findPerk(PerkLib.Flexibility) < 0) {
				player.createPerk(PerkLib.Flexibility, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Flexibility!)</b>");
			}
			if (player.findPerk(PerkLib.Hellfire) < 0) {
				player.createPerk(PerkLib.Hellfire, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Hellfire!)</b>");
			}
			if (player.findPerk(PerkLib.InkSpray) < 0) {
				player.createPerk(PerkLib.InkSpray, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Ink Spray!)</b>");
			}
			if (player.findPerk(PerkLib.LizanRegeneration) < 0) {
				player.createPerk(PerkLib.LizanRegeneration, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Lizan Regeneration!)</b>");
			}
			if (player.findPerk(PerkLib.Lustzerker) < 0) {
				player.createPerk(PerkLib.Lustzerker, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Lustzerker!)</b>");
			}
			if (player.findPerk(PerkLib.MagicalFertility) < 0) {
				player.createPerk(PerkLib.MagicalFertility, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Magical Fertility!)</b>");
			}
			if (player.findPerk(PerkLib.MagicalVirility) < 0) {
				player.createPerk(PerkLib.MagicalVirility, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Magical Virility!)</b>");
			}
			if (player.findPerk(PerkLib.MaraesGiftButtslut) < 0) {
				player.createPerk(PerkLib.MaraesGiftButtslut, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Maraes Gift Buttslut!)</b>");
			}
			if (player.findPerk(PerkLib.MaraesGiftFertility) < 0) {
				player.createPerk(PerkLib.MaraesGiftFertility, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Maraes Gift Fertility!)</b>");
			}
			if (player.findPerk(PerkLib.MaraesGiftProfractory) < 0) {
				player.createPerk(PerkLib.MaraesGiftProfractory, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Maraes Gift Profractory!)</b>");
			}
			if (player.findPerk(PerkLib.MaraesGiftStud) < 0) {
				player.createPerk(PerkLib.MaraesGiftStud, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Maraes Gift Stud!)</b>");
			}
			if (player.findPerk(PerkLib.MilkMaid) < 0) {
				player.createPerk(PerkLib.MilkMaid, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: MilkMaid!)</b>");
			}
			if (player.findPerk(PerkLib.OneTrackMind) < 0) {
				player.createPerk(PerkLib.OneTrackMind, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: One Track Mind!)</b>");
			}
			if (player.findPerk(PerkLib.PureAndLoving) < 0) {
				player.createPerk(PerkLib.PureAndLoving, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Pure And Loving!)</b>");
			}
			if (player.findPerk(PerkLib.PurityBlessing) < 0) {
				outputText("\n\n<b>(Gained Perk: Purity Blessing!)</b>");
				player.createPerk(PerkLib.PurityBlessing, 0, 0, 0, 0);
			}
			if (player.findPerk(PerkLib.SensualLover) < 0) {
				player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Sensual Lover!)</b>");
			}
			doNext(SoulforceCheats);
		}
		public function RevertCabinProgress():void {
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
			SoulforceCheats()
		}
		public function GargoyleMenu():void {
			menu();
			addButton(0, "Human", BackToHumanForm, null, null, null, "Return to been fully human from gargoyle form test.");
			addButton(1, "Marble", MarbleGargoyleForm, null, null, null, "Turn into marble gargoyle form for tests.");
			addButton(2, "Alabaster", AlabasterGargoyleForm, null, null, null, "Turn into alabaster gargoyle form for tests.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function BackToHumanForm():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 0;
			player.armType = ARM_TYPE_HUMAN;
			player.eyeType = EYES_HUMAN;
			player.antennae = ANTENNAE_NONE;
			player.lowerBody = LOWER_BODY_TYPE_HUMAN;
			player.legCount = 2;
			player.wingType = WING_TYPE_NONE;
			player.wingDesc = "non-existant";
			player.tongueType = TONUGE_HUMAN;
			player.tailType = TAIL_TYPE_NONE;
			player.tailRecharge = 0;
			player.horns = 0;
			player.hornType = HORNS_NONE;
			player.earType = EARS_HUMAN;
			player.skin.restore();
			clearOutput();
			outputText("You have become fully human again.");
			doNext(SoulforceCheats);
		}
		public function MarbleGargoyleForm():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
			player.skinTone = "light grey";
			player.hairColor = "light grey";
			clearOutput();
			outputText("You have become marble gargoyle. Now choose your wing shape.");
			doNext(WingShapeChoices);
		}
		public function AlabasterGargoyleForm():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 2;
			player.skinTone = "quartz white";
			player.hairColor = "quartz white";
			clearOutput();
			outputText("You have become alabaster gargoyle. Now choose your wing shape.");
			doNext(WingShapeChoices);
		}
		public function WingShapeChoices():void {
			menu();
			addButton(0, "Bird", BirdWings);
			addButton(1, "Bat's", BatsWings);
		}
		public function BirdWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
			doNext(GargoyleBodyChanges);
		}
		public function BatsWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
			doNext(GargoyleBodyChanges);
		}
		public function GargoyleBodyChanges():void {
			player.skin.setBaseOnly({type:SKIN_TYPE_STONE});
			player.hairType = HAIR_NORMAL;
			player.faceType = FACE_HUMAN;
			player.hornType = HORNS_GARGOYLE;
			player.horns = 12 + rand(4); 
			player.armType = ARM_TYPE_GARGOYLE;
			player.tailType = TAIL_TYPE_GARGOYLE;
			player.tailRecharge = 0;
			player.wingType = WING_TYPE_GARGOYLE_LIKE_LARGE;
			player.lowerBody = LOWER_BODY_TYPE_GARGOYLE;
			player.legCount = 2;
			player.eyeType = EYES_HUMAN;
			player.antennae = ANTENNAE_NONE;
			player.tongueType = TONUGE_HUMAN;
			player.earType = EARS_HUMAN;
			player.gillType = GILLS_NONE;
			player.rearBody = REAR_BODY_NONE;
			if (player.hasStatusEffect(StatusEffects.BlackNipples)) player.removeStatusEffect(StatusEffects.BlackNipples);
		//	if (player.averageNipplesPerBreast() > 1) player.breastRows[x].nipplesPerBreast = 1;
			if (player.hasStatusEffect(StatusEffects.Feeder)) {
				player.removeStatusEffect(StatusEffects.Feeder);
				player.removePerk(PerkLib.Feeder);
			}
			doNext(SoulforceCheats);
		}
		public function SoulforceRegeneration():void {
			menu();
			addButton(0, "1 hour", SoulforceRegeneration1, null, null, null, "Cultivate for 1 hour (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(10) + " soulforce).");
			addButton(1, "2 hours", SoulforceRegeneration2, null, null, null, "Cultivate for 2 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(30) + " soulforce).");
			addButton(2, "4 hours", SoulforceRegeneration3, null, null, null, "Cultivate for 4 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(70) + " soulforce).");
			addButton(3, "6 hours", SoulforceRegeneration4, null, null, null, "Cultivate for 6 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(110) + " soulforce).");
			addButton(4, "8 hours", SoulforceRegeneration5, null, null, null, "Cultivate for 8 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(150) + " soulforce).");
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function SoulforceRegeneration1():void {
			clearOutput();
			var soulforceamountrestored:int = 8;
			if (player.alicornScore() >= 6) soulforceamountrestored += 10;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 10;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 40;
			if (player.unicornScore() >= 5) soulforceamountrestored += 5;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 8;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 8;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor") {
				var bonussoulforce:Number = 0;
				if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor") {
					bonussoulforce += 5;
				}
				else {
					if (player.weaponName == "training soul axe") bonussoulforce += 1;
					if (player.weaponRangeName == "training soul crossbow") bonussoulforce += 1;
					if (player.shieldName == "training soul buckler") bonussoulforce += 1;
					if (player.armorName == "training soul armor") bonussoulforce += 1;
				}
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			doNext(camp.returnToCampUseOneHour);
		}
		public function SoulforceRegeneration2():void {
			clearOutput();
			var soulforceamountrestored:int = 26;
			if (player.alicornScore() >= 6) soulforceamountrestored += 30;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 30;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 120;
			if (player.unicornScore() >= 5) soulforceamountrestored += 15;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 26;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 26;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor") {
				var bonussoulforce:Number = 0;
				if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor") {
					bonussoulforce += 5;
				}
				else {
					if (player.weaponName == "training soul axe") bonussoulforce += 1;
					if (player.weaponRangeName == "training soul crossbow") bonussoulforce += 1;
					if (player.shieldName == "training soul buckler") bonussoulforce += 1;
					if (player.armorName == "training soul armor") bonussoulforce += 1;
				}
				bonussoulforce *= 2;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			doNext(camp.returnToCampUseTwoHours);
		}
		public function SoulforceRegeneration3():void {
			clearOutput();
			var soulforceamountrestored:int = 62;
			if (player.alicornScore() >= 6) soulforceamountrestored += 70;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 70;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 280;
			if (player.unicornScore() >= 5) soulforceamountrestored += 35;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 62;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 62;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor") {
				var bonussoulforce:Number = 0;
				if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor") {
					bonussoulforce += 5;
				}
				else {
					if (player.weaponName == "training soul axe") bonussoulforce += 1;
					if (player.weaponRangeName == "training soul crossbow") bonussoulforce += 1;
					if (player.shieldName == "training soul buckler") bonussoulforce += 1;
					if (player.armorName == "training soul armor") bonussoulforce += 1;
				}
				bonussoulforce *= 4;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			doNext(camp.returnToCampUseFourHours);
		}
		public function SoulforceRegeneration4():void {
			clearOutput();
			var soulforceamountrestored:int = 98;
			if (player.alicornScore() >= 6) soulforceamountrestored += 110;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 110;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 440;
			if (player.unicornScore() >= 5) soulforceamountrestored += 55;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 98;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 98;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor") {
				var bonussoulforce:Number = 0;
				if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor") {
					bonussoulforce += 5;
				}
				else {
					if (player.weaponName == "training soul axe") bonussoulforce += 1;
					if (player.weaponRangeName == "training soul crossbow") bonussoulforce += 1;
					if (player.shieldName == "training soul buckler") bonussoulforce += 1;
					if (player.armorName == "training soul armor") bonussoulforce += 1;
				}
				bonussoulforce *= 6;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			doNext(camp.returnToCampUseSixHours);
		}
		public function SoulforceRegeneration5():void {
			clearOutput();
			var soulforceamountrestored:int = 134;
			if (player.alicornScore() >= 6) soulforceamountrestored += 150;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 150;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 600;
			if (player.unicornScore() >= 5) soulforceamountrestored += 75;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 134;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 134;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor") {
				var bonussoulforce:Number = 0;
				if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor") {
					bonussoulforce += 5;
				}
				else {
					if (player.weaponName == "training soul axe") bonussoulforce += 1;
					if (player.weaponRangeName == "training soul crossbow") bonussoulforce += 1;
					if (player.shieldName == "training soul buckler") bonussoulforce += 1;
					if (player.armorName == "training soul armor") bonussoulforce += 1;
				}
				bonussoulforce *= 8;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			doNext(camp.returnToCampUseEightHours);
		}
		public function SoulforceGainedFromCultivation():void {
			var bonussoulforce2:Number = 0;//razem może mieć max 310
			if (player.weaponName == "training soul axe") bonussoulforce2 += 80;
			if (player.weaponRangeName == "training soul crossbow") bonussoulforce2 += 50;
			if (player.shieldName == "training soul buckler") bonussoulforce2 += 60;
			if (player.armorName == "training soul armor") bonussoulforce2 += 120;
			if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > 0) {
				if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2]) flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2];
				else flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += (bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]);
			}
		}
		public function AmountOfSoulforceRecoveredDuringCultivation(mod:Number):Number {
			var costPercent:Number = 100;
			if (player.alicornScore() >= 6) costPercent += 100;
			if (player.kitsuneScore() >= 6) costPercent += 100;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) costPercent += 400;
			if (player.unicornScore() >= 5) costPercent += 50;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulKing) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) costPercent += 100;
			mod *= costPercent/100;
			return mod;
		}
		public function SelfSustain():void {
			clearOutput();
			outputText("Use some of your soulforce to partialy sate your hunger. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
			outputText("So what amount of your soulforce do you want to use?");
			menu();
			addButton(0, "V. Low", SelfSustain1, null, null, null, "Spend 50 soulforce for 10 hunger.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(1, "Low", SelfSustain2, null, null, null, "Spend 100 soulforce for 20 hunger.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(2, "Medium", SelfSustain3, null, null, null, "Spend 200 soulforce for 40 hunger.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(3, "High", SelfSustain4, null, null, null, "Spend 400 soulforce for 80 hunger.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(4, "V. High", SelfSustain5, null, null, null, "Spend 800 soulforce for 160 hunger.");
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function SelfSustain1():void {
			clearOutput();
			if (player.soulforce >= 50) {
				outputText("Consuming a little of soulforce you feel slightly less hungry.");
				player.soulforce -= 50;
				player.refillHunger(10);
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SelfSustain);
			}
		}
		public function SelfSustain2():void {
			clearOutput();
			if (player.soulforce >= 100) {
				outputText("Consuming a little of soulforce you feel a little less hungry.");
				player.soulforce -= 100;
				player.refillHunger(20);
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SelfSustain);
			}
		}
		public function SelfSustain3():void {
			clearOutput();
			if (player.soulforce >= 200) {
				outputText("Consuming some of your soulforce you feel a little less hungry than before.");
				player.soulforce -= 200;
				player.refillHunger(40);
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SelfSustain);
			}
		}
		public function SelfSustain4():void {
			clearOutput();
			if (player.soulforce >= 400) {
				outputText("Consuming some of your soulforce you feel your hungry decreasing slightly.");
				player.soulforce -= 400;
				player.refillHunger(80);
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SelfSustain);
			}
		}
		public function SelfSustain5():void {
			clearOutput();
			if (player.soulforce >= 800) {
				outputText("Consuming not a small amount of your soulforce you feel your hungry decreasing noticable.");
				player.soulforce -= 800;
				player.refillHunger(160);
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SelfSustain);
			}
		}
		public function RepresLust():void {
			clearOutput();
			outputText("Use some of your soulforce to partialy suppress your lust. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
			outputText("So what amount of your soulforce do you want to use?");
			menu();
			addButton(0, "V. Low", RepresLust1, null, null, null, "Spend 40 soulforce for 20 lust.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(1, "Low", RepresLust2, null, null, null, "Spend 80 soulforce for 40 lust.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(2, "Medium", RepresLust3, null, null, null, "Spend 200 soulforce for 100 lust.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(3, "High", RepresLust4, null, null, null, "Spend 400 soulforce for 200 lust.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(4, "V. High", RepresLust5, null, null, null, "Spend 800 soulforce for 400 lust.");
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function RepresLust1():void {
			clearOutput();
			if (player.soulforce >= 40) {
				outputText("Consuming a little of soulforce you lust lowered very slightly.");
				player.soulforce -= 40;
				player.lust -= 20;
				if (player.lust < 0) player.lust = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(RepresLust);
			}
		}
		public function RepresLust2():void {
			clearOutput();
			if (player.soulforce >= 80) {
				outputText("Consuming a little of soulforce you lust lowered a little bit.");
				player.soulforce -= 80;
				player.lust -= 40;
				if (player.lust < 0) player.lust = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(RepresLust);
			}
		}
		public function RepresLust3():void {
			clearOutput();
			if (player.soulforce >= 200) {
				outputText("Consuming some of your soulforce you lust noticable lowered.");
				player.soulforce -= 200;
				player.lust -= 100;
				if (player.lust < 0) player.lust = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(RepresLust);
			}
		}
		public function RepresLust4():void {
			clearOutput();
			if (player.soulforce >= 400) {
				outputText("Consuming some of your soulforce medicore amount of lust are gone.");
				player.soulforce -= 400;
				player.lust -= 200;
				if (player.lust < 0) player.lust = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(RepresLust);
			}
		}
		public function RepresLust5():void {
			clearOutput();
			if (player.soulforce >= 800) {
				outputText("Consuming not a small amount of your soulforce most of your lust is gone.");
				player.soulforce -= 800;
				player.lust -= 400;
				if (player.lust < 0) player.lust = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(RepresLust);
			}
		}
		public function ManaAndSoulforce():void {
			clearOutput();
			outputText("Use some of your soulforce to slowly conver it into fatigue or some fatigue in soulforce. The higher your cultivation is the more you could convert without hurting yourself.\n\n");
			outputText("So what amount of your soulforce/fatigue do you want to convert?");
			menu();
		//	if (kGAMECLASS.inCombat) {
		//		addButton(14, "Back", kGAMECLASS.combatMenu);
		//	}
		//	else {
				addButton(0, "100", Covert100Soulforce, null, null, null, "Convert 100 soulforce to 100 fatigue.");
				if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(1, "200", Covert200Soulforce, null, null, null, "Convert 200 soulforce to 200 fatigue.");
				if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(2, "500", Covert500Soulforce, null, null, null, "Convert 500 soulforce to 500 fatigue.");
				if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(3, "1000", Covert1000Soulforce, null, null, null, "Convert 1000 soulforce to 1000 fatigue.");
				if (player.findPerk(PerkLib.SoulExalt) >= 0) addButton(4, "2000", Covert2000Soulforce, null, null, null, "Convert 2000 soulforce to 2000 fatigue.");
				addButton(5, "100", Covert100Fatigue, null, null, null, "Convert 100 fatigue to 50 soulforce.");
				if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(6, "200", Covert200Fatigue, null, null, null, "Convert 200 fatigue to 100 soulforce.");
				if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(7, "500", Covert500Fatigue, null, null, null, "Convert 500 fatigue to 250 soulforce.");
				if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(8, "1000", Covert1000Fatigue, null, null, null, "Convert 1000 fatigue to 500 soulforce.");
				if (player.findPerk(PerkLib.SoulExalt) >= 0) addButton(9, "2000", Covert2000Fatigue, null, null, null, "Convert 2000 fatigue to 1000 soulforce.");
				addButton(14, "Back", accessSoulforceMenu);
		//	}
		}
		public function Covert100Soulforce():void {
			clearOutput();
			if (player.soulforce >= 100) {
				outputText("You sit down and focus your spiritual power to recover some of your physical stamina, within moments, you feel rested and refreshed.");
				player.soulforce -= 100;
				player.fatigue -= 100;
				if (player.fatigue < 0) player.fatigue = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(ManaAndSoulforce);
			}
		}
		public function Covert200Soulforce():void {
			clearOutput();
			if (player.soulforce >= 200) {
				outputText("You sit down and focus your spiritual power to recover some of your physical stamina, within moments, you feel rested and refreshed.");
				player.soulforce -= 200;
				player.fatigue -= 200;
				if (player.fatigue < 0) player.fatigue = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(ManaAndSoulforce);
			}
		}
		public function Covert500Soulforce():void {
			clearOutput();
			if (player.soulforce >= 500) {
				outputText("You sit down and focus your spiritual power to recover some of your physical stamina, within moments, you feel rested and refreshed.");
				player.soulforce -= 500;
				player.fatigue -= 500;
				if (player.fatigue < 0) player.fatigue = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(ManaAndSoulforce);
			}
		}
		public function Covert1000Soulforce():void {
			clearOutput();
			if (player.soulforce >= 1000) {
				outputText("You sit down and focus your spiritual power to recover some of your physical stamina, within moments, you feel rested and refreshed.");
				player.soulforce -= 1000;
				player.fatigue -= 1000;
				if (player.fatigue < 0) player.fatigue = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(ManaAndSoulforce);
			}
		}
		public function Covert2000Soulforce():void {
			clearOutput();
			if (player.soulforce >= 2000) {
				outputText("You sit down and focus your spiritual power to recover some of your physical stamina, within moments, you feel rested and refreshed.");
				player.soulforce -= 2000;
				player.fatigue -= 2000;
				if (player.fatigue < 0) player.fatigue = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(ManaAndSoulforce);
			}
		}
		public function Covert100Fatigue():void {
			clearOutput();
			if (player.fatigue >= player.maxFatigue() - 100) {
				outputText("Your current fatigue is too high.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power,  draining your physical stamina to replenish your soul force.");
				player.fatigue += 100;
				player.soulforce += 50;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert200Fatigue():void {
			clearOutput();
			if (player.fatigue >= player.maxFatigue() - 200) {
				outputText("Your current fatigue is too high.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power,  draining your physical stamina to replenish your soul force.");
				player.fatigue += 200;
				player.soulforce += 100;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert500Fatigue():void {
			clearOutput();
			if (player.fatigue >= player.maxFatigue() - 500) {
				outputText("Your current fatigue is too high.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power,  draining your physical stamina to replenish your soul force.");
				player.fatigue += 500;
				player.soulforce += 250;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert1000Fatigue():void {
			clearOutput();
			if (player.fatigue >= player.maxFatigue() - 1000) {
				outputText("Your current fatigue is too high.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power,  draining your physical stamina to replenish your soul force.");
				player.fatigue += 1000;
				player.soulforce += 500;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert2000Fatigue():void {
			clearOutput();
			if (player.fatigue >= player.maxFatigue() - 2000) {
				outputText("Your current fatigue is too high.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power,  draining your physical stamina to replenish your soul force.");
				player.fatigue += 2000;
				player.soulforce += 1000;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function CorruptionAndSoulforce():void {
			clearOutput();
			outputText("Use some of your soulforce to slowly purify or...corrupt yourself. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
			outputText("So what amount of your soulforce do you want to use?");
			menu();
			addButton(0, "V. Low", CorrDrop1, null, null, null, "Spend 100 soulforce for lowering corruption by 1.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(1, "Low", CorrDrop2, null, null, null, "Spend 200 soulforce for lowering corruption by 2.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(2, "Medium", CorrDrop3, null, null, null, "Spend 500 soulforce for lowering corruption by 5.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(3, "High", CorrDrop4, null, null, null, "Spend 1000 soulforce for lowering corruption by 10.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(4, "V. High", CorrDrop5, null, null, null, "Spend 2000 soulforce for lowering corruption by 20.");
			addButton(5, "V. Low", CorrRise1, null, null, null, "Spend 50 soulforce for rising corruption by 1.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(6, "Low", CorrRise2, null, null, null, "Spend 100 soulforce for rising corruption by 2.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(7, "Medium", CorrRise3, null, null, null, "Spend 250 soulforce for rising corruption by 5.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(8, "High", CorrRise4, null, null, null, "Spend 500 soulforce for rising corruption by 10.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(9, "V. High", CorrRise5, null, null, null, "Spend 1000 soulforce for rising corruption by 20.");
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function CorrDrop1():void {
			clearOutput();
			if (player.soulforce >= 100) {
				outputText("Consuming a little of soulforce you corruption lowered very slightly.");
				player.soulforce -= 100;
				player.cor -= 1;
				if (player.cor < 0) player.cor = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrDrop2():void {
			clearOutput();
			if (player.soulforce >= 200) {
				outputText("Consuming a little of soulforce you corruption lowered a little bit.");
				player.soulforce -= 200;
				player.cor -= 2;
				if (player.cor < 0) player.cor = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrDrop3():void {
			clearOutput();
			if (player.soulforce >= 500) {
				outputText("Consuming some of your soulforce you corruption lowered noticable lowered.");
				player.soulforce -= 500;
				player.cor -= 5;
				if (player.cor < 0) player.cor = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrDrop4():void {
			clearOutput();
			if (player.soulforce >= 1000) {
				outputText("Consuming some of your soulforce medicore amount of corruption are gone.");
				player.soulforce -= 1000;
				player.cor -= 10;
				if (player.cor < 0) player.cor = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrDrop5():void {
			clearOutput();
			if (player.soulforce >= 2000) {
				outputText("Consuming not a small amount of your soulforce you corruption most of your corruption is gone.");
				player.soulforce -= 2000;
				player.cor -= 20;
				if (player.cor < 0) player.cor = 0;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrRise1():void {
			clearOutput();
			if (player.soulforce >= 50) {
				outputText("Consuming a little of soulforce you corruption rised very slightly.");
				player.soulforce -= 50;
				player.cor += 1;
				if (player.cor > 100) player.cor = 100;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrRise2():void {
			clearOutput();
			if (player.soulforce >= 100) {
				outputText("Consuming a little of soulforce you corruption rised a little bit.");
				player.soulforce -= 100;
				player.cor += 2;
				if (player.cor > 100) player.cor = 100;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrRise3():void {
			clearOutput();
			if (player.soulforce >= 250) {
				outputText("Consuming some of your soulforce you corruption noticable rised.");
				player.soulforce -= 250;
				player.cor += 5;
				if (player.cor > 100) player.cor = 100;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrRise4():void {
			clearOutput();
			if (player.soulforce >= 500) {
				outputText("Consuming some of your soulforce your corruption rised by a medicore amount.");
				player.soulforce -= 500;
				player.cor += 10;
				if (player.cor > 100) player.cor = 100;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function CorrRise5():void {
			clearOutput();
			if (player.soulforce >= 1000) {
				outputText("Consuming not a small amount of your soulforce you gained much corruption.");
				player.soulforce -= 1000;
				player.cor += 20;
				if (player.cor > 100) player.cor = 100;
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(CorruptionAndSoulforce);
			}
		}
		public function SoulSense():void {
			clearOutput();
			outputText("Using a tiny amount of soulforce you could try to use soul sense to locate some of people you meet of location you found before without wasting hours for that. Especialy if those people are usualy roaming around or places that constantly changing their location.");
			outputText("\n\nAmount of soulforce used to locate them using soul sense depening of relative power of searched person or location.");
			menu();
			if (flags[kFLAGS.SOUL_SENSE_TAMANI] == 5) addButton(0, "Tamani", TamaniEnc);
			if (flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] == 5) addButton(1, "Tamani D.", TamaniDaughtersEnc);
			if (flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] == 5) addButton(2, "KitsuMansion", KitsuneMansion);
			if (flags[kFLAGS.SOUL_SENSE_WORLD_TREE] == 1) addButton(10, "WorldTree", findWorldTree);
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function TamaniEnc():void {
			if (player.soulforce >= 80) {
				player.soulforce -= 80;
				statScreenRefresh();
				tamaniScene.encounterTamani();
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SoulSense);
			}
		}
		public function TamaniDaughtersEnc():void {
			if (player.soulforce >= 10 * (8 + (Math.floor(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20)))) {
				player.soulforce -= 10 * (8 + (Math.floor(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20)));
				statScreenRefresh();
				tamaniDaughtersScene.encounterTamanisDaughters();
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SoulSense);
			}
		}
		public function KitsuneMansion():void {
			if (player.soulforce >= 90) {
				player.soulforce -= 90;
				statScreenRefresh();
				kGAMECLASS.kitsuneScene.enterTheTrickster();
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SoulSense);
			}
		}
		public function findWorldTree():void {
			if (player.soulforce >= 100) {
				player.soulforce -= 100;
				statScreenRefresh();
				wolrdtreeScene.YggdrasilDiscovery();
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SoulSense);
			}
		}
	}
}