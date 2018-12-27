/**
 * ...
 * @author Ormael
 */
package classes.Scenes 
{
import classes.*;
import classes.BodyParts.Antennae;
import classes.BodyParts.Arms;
import classes.BodyParts.Ears;
import classes.BodyParts.Eyes;
import classes.BodyParts.Face;
import classes.BodyParts.Gills;
import classes.BodyParts.Hair;
import classes.BodyParts.Horns;
import classes.BodyParts.LowerBody;
import classes.BodyParts.RearBody;
import classes.BodyParts.Skin;
import classes.BodyParts.Tail;
import classes.BodyParts.Tongue;
import classes.BodyParts.Wings;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.DeepSea.Kraken;
import classes.Scenes.Areas.Forest.Alraune;
import classes.Scenes.Areas.Forest.TamainsDaughtersScene;
import classes.Scenes.Areas.Forest.TamaniScene;
import classes.Scenes.Areas.Forest.WorldTree;
import classes.Scenes.Areas.HighMountains.IzumiScene;
import classes.Scenes.Dungeons.DenOfDesire.HeroslayerOmnibus;
import classes.Scenes.Dungeons.DenOfDesire.ObsidianGargoyle;
import classes.Scenes.Monsters.DarkElfRanger;
import classes.Scenes.Monsters.DarkElfScout;
import classes.Scenes.Monsters.DarkElfSlaver;
import classes.Scenes.Monsters.DarkElfSniper;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.NPCs.Diana;
import classes.Scenes.NPCs.Electra;
import classes.Scenes.NPCs.RyuBiDragon;
import classes.Scenes.NPCs.Sonya;
import classes.Scenes.Places.Boat.Marae;
import classes.Scenes.Areas.Forest.Nightmare;
import classes.Player;
import classes.Items.*;

use namespace CoC;
	
	public class Soulforce extends BaseContent
	{
		public var tamaniDaughtersScene:TamainsDaughtersScene = new TamainsDaughtersScene();
		public var tamaniScene:TamaniScene = new TamaniScene();
		public var izumiScenes:IzumiScene = new IzumiScene();
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
			if (player.level >= 30 && player.findPerk(PerkLib.SoulScholar) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 15) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 32 && player.findPerk(PerkLib.SoulScholar) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 16) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 34 && player.findPerk(PerkLib.SoulScholar) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 17) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 36 && player.findPerk(PerkLib.SoulElder) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 18) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 38 && player.findPerk(PerkLib.SoulElder) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 19) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 40 && player.findPerk(PerkLib.SoulElder) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 20) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 42 && player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 21) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 44 && player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 22) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 46 && player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 23) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 48 && player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 24) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 50 && player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 25) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 52 && player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 26) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 54 && player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 27) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 56 && player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 28) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 58 && player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 29) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 60 && player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 30) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 62 && player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 31) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 64 && player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 32) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 66 && player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 33) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 68 && player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 34) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 70 && player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 35) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 72 && player.findPerk(PerkLib.SoulAncestor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 36) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 74 && player.findPerk(PerkLib.SoulAncestor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 37) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			if (player.level >= 76 && player.findPerk(PerkLib.SoulAncestor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 38) flags[kFLAGS.SOUL_CULTIVATION] += 1;
			outputText("<b>Cultivation stage:</b> ");
			if (player.findPerk(PerkLib.SoulAncestor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 39)
				outputText("Late Soul Ancestor\n");
			else if (player.findPerk(PerkLib.SoulAncestor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 38)
				outputText("Middle Soul Ancestor\n");
			else if (player.findPerk(PerkLib.SoulAncestor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 37)
				outputText("Early Soul Ancestor\n");
			else if (player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 36)
				outputText("Late Soul Emperor\n");
			else if (player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 35)
				outputText("Middle Soul Emperor\n");
			else if (player.findPerk(PerkLib.SoulEmperor) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 34)
				outputText("Early Soul Emperor\n");
			else if (player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 33)
				outputText("Late Soul King\n");
			else if (player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 32)
				outputText("Middle Soul King\n");
			else if (player.findPerk(PerkLib.SoulKing) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 31)
				outputText("Early Soul King\n");
			else if (player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 30)
				outputText("Late Soul Tyrant\n");
			else if (player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 29)
				outputText("Middle Soul Tyrant\n");
			else if (player.findPerk(PerkLib.SoulTyrant) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 28)
				outputText("Early Soul Tyrant\n");
			else if (player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 27)
				outputText("Late Soul Overlord\n");
			else if (player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 26)
				outputText("Middle Soul Overlord\n");
			else if (player.findPerk(PerkLib.SoulOverlord) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 25)
				outputText("Early Soul Overlord\n");
			else if (player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 24)
				outputText("Late Soul Exalt\n");
			else if (player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 23)
				outputText("Middle Soul Exalt\n");
			else if (player.findPerk(PerkLib.SoulExalt) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 22)
				outputText("Early Soul Exalt\n");
			else if (player.findPerk(PerkLib.SoulElder) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 21)
				outputText("Late Soul Elder\n");
			else if (player.findPerk(PerkLib.SoulElder) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 20)
				outputText("Middle Soul Elder\n");
			else if (player.findPerk(PerkLib.SoulElder) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 19)
				outputText("Early Soul Elder\n");
			else if (player.findPerk(PerkLib.SoulScholar) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 18)
				outputText("Late Soul Scholar\n");
			else if (player.findPerk(PerkLib.SoulScholar) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 17)
				outputText("Middle Soul Scholar\n");
			else if (player.findPerk(PerkLib.SoulScholar) >= 0 && flags[kFLAGS.SOUL_CULTIVATION] == 16)
				outputText("Early Soul Scholar\n");
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
			outputText("<b>Additional Soulforce from training:</b> " + flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] + " / 1430\n");
		/*	outputText("<b>Progress toward clearing next meridian: </b>");
			if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 2)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 1)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
		*/	var dailySoulforceUsesLimit:Number = 0;
			if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulElder) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
			menu();
			addButton(0, "Cultivate", SoulforceRegeneration).hint("Spend some time on restoring some of the used soulforce.");
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(1, "Self-sustain", SelfSustain).hint("Spend some soulforce on suppresing hunger for a while."); //zamiana soulforce na satiety w stosunku 1:5
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(2, "Repres. Lust", RepresLust).hint("Spend some soulforce on calming your sexual urges."); //używanie soulforce do zmniejszania lust w stosunku 1:2
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(4, "Adj. Corr.", CorruptionAndSoulforce).hint("Spend some soulforce on affecting your current corruption."); //używanie soulforce do zmniejszania corruption w stosunku 1:100 a zdobywanie corruption w stosunku 1:50
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(3, "Mana", ManaAndSoulforce).hint("Convert some soulforce into mana or vice versa."); //używanie soulforce do zamiany na mane w stosunku 1:1 a many do soulforce 1:2, używalne nawet w walce też ale z wiekszym kosztem przeliczania czyli 1:2 i 1:4
			//addButton(5, "Upgrade", UpgradeItems).hint("."); //ulepszanie itemów
			if (player.findPerk(PerkLib.Metamorph) >= 0) addButton(6, "Metamorf", SceneLib.metamorph.accessMetamorphMenu).hint("Use your soulforce to mold freely your body.");//używanie metamorfowania z użyciem soulforce
			if (player.findPerk(PerkLib.SoulSense) >= 0) addButton(7, "Soul Sense", SoulSense).hint("Use your soul sense to trigger specific encounter."); //używanie divine sense aby znaleść określone event encounters: Tamani (lvl 6+), Tamani daugthers (lvl 6+), Kitsune mansion (lvl 12+), Izumi (lvl 18/24+), itp.
			//addButton(10, "Cheats", SoulforceCheats).hint("Well as title saying those are cheats ^^");//block this option at each public version
			addButton(14, "Back", playerMenu);
		}//w lini 28 w oOnLoadVariables zmian wprowadzić i w lini conditionalConverters w folderze parser zmian dot. wraith wprowadzić, zablokować perki soul king to soul ancestor w momencie robienia release version
		public function SoulforceCheats():void {
			clearOutput();
			outputText("Collection of current used cheats that with time will be removed or replaced by new ones.");
			outputText("\n\nAscension points: " + player.ascensionPerkPoints + "");
			menu();
			addButton(0, "StatsAdj/Ascen", StatsAscensionMenu).hint("For more precise adjusting each of 8 main stats and Ascension related stuff.");
			addButton(1, "P/G/XP/LvL", PerksGemsEXPLvL).hint("Adding/Removing perk points and adding gems/exp/lvl.");
			addButton(2, "Equip", EquipmentMenu).hint("For creting various equipment items for tests.");
			addButton(3, "NonEquip", NonEquipmentMenu).hint("For creting various non-equipment items for tests.");
			addButton(4, "Materials", MaterialMenu).hint("For creting various materials for tests.");
			addButton(5, "Enemies", EnemiesMenu).hint("For spawning various enemies to test fight them.");
			addButton(6, "Camp NPC's", FasterOrInstantCampNPCRecruitment).hint("Menu to speed up recruitment of camp npc's due to testing needs.");
			addButton(7, "RevertCabin", RevertCabinProgress).hint("Revert cabin flag back to value 2 (for bug fix test)");
			addButton(8, "Celess", celessIntroForced).hint("Due to hard time getting her intro here it's.");
			addButton(10, "BodyPartEditor", SceneLib.debugMenu.bodyPartEditorRoot);
			addButton(11, "Gargoyle", GargoyleMenu).hint("To Be or Not To Be Gargoyle that is a question.");
			addButton(14, "Back", accessSoulforceMenu);
		}
public function celessIntroForced():void {
	clearOutput();
	CelessScene.instance.birthScene();
}
public function FightNightmare():void {
	clearOutput();
	outputText("Entering battle with Nightmare! Enjoy ^^");
	startCombat(new Nightmare());
}
		public function StatsAscensionMenu():void {
			menu();
			addButton(0, "EarlyAscension", EarlyAscension).hint("Allowing to premature ascension.");
			addButton(1, "AscenPerks01", AddAscensionPerkPoints1).hint("Add 1 ascension perk point for use during ascending to the next NG+ tier.");
			addButton(2, "AscenPerks05", AddAscensionPerkPoints2).hint("Add 5 ascension perk points for use during ascending to the next NG+ tier.");
			addButton(3, "AscenPerks10", AddAscensionPerkPoints3).hint("Add 10 ascension perk points for use during ascending to the next NG+ tier.");
			addButton(4, "AscenPerks50", AddAscensionPerkPoints4).hint("Add 50 ascension perk points for use during ascending to the next NG+ tier.");
			addButton(5, "Str", StatsMenuStr).hint("Adj Str.");
			addButton(6, "Tou", StatsMenuTou).hint("Adj Tou.");
			addButton(7, "Spe", StatsMenuSpe).hint("Adj Spe.");
			addButton(8, "Inte", StatsMenuInte).hint("Adj Inte.");
			addButton(9, "Wis", StatsMenuWis).hint("Adj Wis.");
			addButton(10, "Tone/Thicc", StatsMenuToneThickness).hint("Adj Tone/Thickness.");
			addButton(11, "Lib", StatsMenuLib).hint("Adj Lib.");
			addButton(12, "Sens", StatsMenuSens).hint("Adj Sens.");
			addButton(13, "Cor", StatsMenuCor).hint("Adj Cor.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function StatsMenuStr():void {
			menu();
			addButton(0, "Str Up 1", AddStr1).hint("Add 1 to Str.");
			addButton(5, "Str Down 1", SubStr1).hint("Substract 1 from Str.");
			addButton(1, "Str Up 2", AddStr2).hint("Add 10 to Str.");
			addButton(6, "Str Down 2", SubStr2).hint("Substract 10 from Str.");
			addButton(2, "Str Up 3", AddStr3).hint("Add 50 to Str.");
			addButton(7, "Str Down 3", SubStr3).hint("Substract 50 from Str.");
			addButton(3, "Str Up 4", AddStr4).hint("Add 200 to Str.");
			addButton(8, "Str Down 4", SubStr4).hint("Substract 200 from Str.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuTou():void {
			menu();
			addButton(0, "Tou Up 1", AddTou1).hint("Add 1 to Tou.");
			addButton(5, "Tou Down 1", SubTou1).hint("Substract 1 from Tou.");
			addButton(1, "Tou Up 2", AddTou2).hint("Add 10 to Tou.");
			addButton(6, "Tou Down 2", SubTou2).hint("Substract 10 from Tou.");
			addButton(2, "Tou Up 3", AddTou3).hint("Add 50 to Tou.");
			addButton(7, "Tou Down 3", SubTou3).hint("Substract 50 from Tou.");
			addButton(3, "Tou Up 4", AddTou4).hint("Add 200 to Tou.");
			addButton(8, "Tou Down 4", SubTou4).hint("Substract 200 from Tou.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuSpe():void {
			menu();
			addButton(0, "Spe Up 1", AddSpe1).hint("Add 1 to Spe.");
			addButton(5, "Spe Down 1", SubSpe1).hint("Substract 1 from Spe.");
			addButton(1, "Spe Up 2", AddSpe2).hint("Add 10 to Spe.");
			addButton(6, "Spe Down 2", SubSpe2).hint("Substract 10 from Spe.");
			addButton(2, "Spe Up 3", AddSpe3).hint("Add 50 to Spe.");
			addButton(7, "Spe Down 3", SubSpe3).hint("Substract 50 from Spe.");
			addButton(3, "Spe Up 4", AddSpe4).hint("Add 200 to Spe.");
			addButton(8, "Spe Down 4", SubSpe4).hint("Substract 200 from Spe.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuInte():void {
			menu();
			addButton(0, "Inte Up 1", AddInte1).hint("Add 1 to Inte.");
			addButton(5, "Inte Down 1", SubInte1).hint("Substract 1 from Inte.");
			addButton(1, "Inte Up 2", AddInte2).hint("Add 10 to Inte.");
			addButton(6, "Inte Down 2", SubInte2).hint("Substract 10 from Inte.");
			addButton(2, "Inte Up 3", AddInte3).hint("Add 50 to Inte.");
			addButton(7, "Inte Down 3", SubInte3).hint("Substract 50 from Inte.");
			addButton(3, "Inte Up 4", AddInte4).hint("Add 200 to Inte.");
			addButton(8, "Inte Down 4", SubInte4).hint("Substract 200 from Inte.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuWis():void {
			menu();
			addButton(0, "Wis Up 1", AddWis1).hint("Add 1 to Wis.");
			addButton(5, "Wis Down 1", SubWis1).hint("Substract 1 from Wis.");
			addButton(1, "Wis Up 2", AddWis2).hint("Add 10 to Wis.");
			addButton(6, "Wis Down 2", SubWis2).hint("Substract 10 from Wis.");
			addButton(2, "Wis Up 3", AddWis3).hint("Add 50 to Wis.");
			addButton(7, "Wis Down 3", SubWis3).hint("Substract 50 from Wis.");
			addButton(3, "Wis Up 4", AddWis4).hint("Add 200 to Wis.");
			addButton(8, "Wis Down 4", SubWis4).hint("Substract 200 from Wis.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuLib():void {
			menu();
			addButton(0, "Lib Up 1", AddLib1).hint("Add 1 to Lib.");
			addButton(5, "Lib Down 1", SubLib1).hint("Substract 1 from Lib.");
			addButton(1, "Lib Up 2", AddLib2).hint("Add 10 to Lib.");
			addButton(6, "Lib Down 2", SubLib2).hint("Substract 10 from Lib.");
			addButton(2, "Lib Up 3", AddLib3).hint("Add 50 to Lib.");
			addButton(7, "Lib Down 3", SubLib3).hint("Substract 50 from Lib.");
			addButton(3, "Lib Up 4", AddLib4).hint("Add 200 to Lib.");
			addButton(8, "Lib Down 4", SubLib4).hint("Substract 200 from Lib.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuSens():void {
			menu();
			addButton(0, "Sens Up 1", AddSens1).hint("Add 1 to Sens.");
			addButton(5, "Sens Down 1", SubSens1).hint("Substract 1 from Sens.");
			addButton(1, "Sens Up 2", AddSens2).hint("Add 10 to Sens.");
			addButton(6, "Sens Down 2", SubSens2).hint("Substract 10 from Sens.");
			addButton(2, "Sens Up 3", AddSens3).hint("Add 50 to Sens.");
			addButton(7, "Sens Down 3", SubSens3).hint("Substract 50 from Sens.");
			addButton(3, "Sens Up 4", AddSens4).hint("Add 200 to Sens.");
			addButton(8, "Sens Down 4", SubSens4).hint("Substract 200 from Sens.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuCor():void {
			menu();
			addButton(0, "Cor Up 1", AddCor1).hint("Add 1 to Cor.");
			addButton(5, "Cor Down 1", SubCor1).hint("Substract 1 from Cor.");
			addButton(1, "Cor Up 2", AddCor2).hint("Add 5 to Cor.");
			addButton(6, "Cor Down 2", SubCor2).hint("Substract 5 from Cor.");
			addButton(2, "Cor Up 3", AddCor3).hint("Add 10 to Cor.");
			addButton(7, "Cor Down 3", SubCor3).hint("Substract 10 from Cor.");
			addButton(3, "Cor Up 4", AddCor4).hint("Add 50 to Cor.");
			addButton(8, "Cor Down 4", SubCor4).hint("Substract 50 from Cor.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function StatsMenuToneThickness():void {
			menu();
			addButton(0, "Tone Up 1", AddTone1).hint("Add 1 to Tone.");
			addButton(5, "Tone Down 1", SubTone1).hint("Substract 1 from Tone.");
			addButton(1, "Tone Up 2", AddTone2).hint("Add 10 to Tone.");
			addButton(6, "Tone Down 2", SubTone2).hint("Substract 10 from Tone.");
			addButton(2, "Thickness Up 1", AddThickness1).hint("Add 1 to Thickness.");
			addButton(7, "Thickness Down 1", SubThickness1).hint("Substract 1 from Thickness.");
			addButton(3, "Thickness Up 2", AddThickness2).hint("Add 10 to Thickness.");
			addButton(8, "Thickness Down 2", SubThickness2).hint("Substract 10 from Thickness.");
			addButton(14, "Back", StatsAscensionMenu);
		}
		public function PerksGemsEXPLvL():void {
			menu();
			addButton(0, "Add 1 PerkP", AddPerkPoint).hint("Add 1 perk point.");
			addButton(1, "Add 5 PerkP", AddPerkPoints).hint("Add 5 perk points.");
			addButton(2, "Sub 10 PerkP", SubPerkPoints).hint("Substract 10 perk points.");
			addButton(3, "Add Gems 1", AddGems1).hint("Add 100 gems.");
			addButton(4, "Add Gems 2", AddGems2).hint("Add 1000 gems.");
			addButton(5, "Add EXP 1", AddEXP1).hint("Add 100 EXP.");
			addButton(6, "Add EXP 2", AddEXP2).hint("Add 1000 EXP.");
			addButton(7, "Add EXP 3", AddEXP3).hint("Add 10000 EXP.");
			addButton(8, "Add EXP 4", AddEXP4).hint("Add 100000 EXP.");
			if (player.findPerk(PerkLib.HclassHeavenTribulationSurvivor) < 0) addButton(10, "Trib Perks", TribulationPerks).hint("Add 2 Tribulation perks.");
			if (player.findPerk(PerkLib.SoulAncestor) < 0) addButton(11, "10-12 St.", Stage10to12SoulPerks).hint("Add all soul cultivator related perks for stages 10-12 of cultivation.");
			if (player.level < 150) addButton(12, "Add 1 LvL", AddLvL1).hint("Add 1 Level (with stat and perk points).");
			if (player.level < 140) addButton(13, "Add 10 LvL's", AddLvL2).hint("Add 10 Levels (with stat and perk points).");
			addButton(14, "Back", SoulforceCheats);
		}
		public function FasterOrInstantCampNPCRecruitment():void {
			menu();
			addButton(0, "E.I.K.", EmberIsabellaKiha).hint("Ember / Isabella / Kiha (If PC have all 3 nothing will happen after choosing this option.)");
			if (flags[kFLAGS.ETNA_FOLLOWER] < 2) addButton(1, "Etna", SuccubusishMantioreOnLeash);
			if (flags[kFLAGS.KINDRA_FOLLOWER] < 1) addButton(2, "Kindra", KindraMemory5);
			if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 6) addButton(3, "Kindra 1UP", Kindra1stLvLUp);
			if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 7) addButton(3, "Kindra 2UP", Kindra2ndLvLUp);
			if (flags[kFLAGS.KINDRA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KINDRA_LVL_UP] == 8) addButton(3, "Kindra 3UP", Kindra3rdLvLUp);
			if (flags[kFLAGS.KINDRA_LVL_UP] >= 7) addButton(4, "Kindra DeLvL", KindraTestDeLvL);
			if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] < 1) addButton(5, "Ember 1UP", Ember1stLvLUp);
			if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 1) addButton(5, "Ember 2UP", Ember2ndLvLUp);
			if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 2) addButton(5, "Ember 3UP", Ember3rdLvLUp);
			if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 3) addButton(5, "Ember 4UP", Ember4thLvLUp);
			if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 4) addButton(5, "Ember 5UP", Ember5thLvLUp);
			if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 5) addButton(5, "Ember 6UP", Ember6thLvLUp);
			if (flags[kFLAGS.EMBER_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.EMBER_LVL_UP] == 6) addButton(5, "Ember 7UP", Ember7thLvLUp);
			if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] < 1) addButton(6, "Isabella 1UP", Isabella1stLvLUp);
			if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 1) addButton(6, "Isabella 2UP", Isabella2ndLvLUp);
			if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 2) addButton(6, "Isabella 3UP", Isabella3rdLvLUp);
			if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 3) addButton(6, "Isabella 4UP", Isabella4thLvLUp);
			if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 4) addButton(6, "Isabella 5UP", Isabella5thLvLUp);
			if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 5) addButton(6, "Isabella 6UP", Isabella6thLvLUp);
			if (flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ISABELLA_LVL_UP] == 6) addButton(6, "Isabella 7UP", Isabella7thLvLUp);
			if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] < 1) addButton(7, "Kiha 1UP", Kiha1stLvLUp);
			if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 1) addButton(7, "Kiha 2UP", Kiha2ndLvLUp);
			if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 2) addButton(7, "Kiha 3UP", Kiha3rdLvLUp);
			if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 3) addButton(7, "Kiha 4UP", Kiha4thLvLUp);
			if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 4) addButton(7, "Kiha 5UP", Kiha5thLvLUp);
			if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 5) addButton(7, "Kiha 6UP", Kiha6thLvLUp);
			if (flags[kFLAGS.KIHA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.KIHA_LVL_UP] == 6) addButton(7, "Kiha 7UP", Kiha7thLvLUp);
			if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] < 1) addButton(8, "Etna 1UP", Etna1stLvLUp);
			if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 1) addButton(8, "Etna 2UP", Etna2ndLvLUp);
			if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 2) addButton(8, "Etna 3UP", Etna3rdLvLUp);
			if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 3) addButton(8, "Etna 4UP", Etna4thLvLUp);
			if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 4) addButton(8, "Etna 5UP", Etna5thLvLUp);
			if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 5) addButton(8, "Etna 6UP", Etna6thLvLUp);
			if (flags[kFLAGS.ETNA_DEFEATS_COUNTER] >= 1 && flags[kFLAGS.ETNA_LVL_UP] == 6) addButton(8, "Etna 7UP", Etna7thLvLUp);
			if (flags[kFLAGS.EMBER_LVL_UP] >= 1) addButton(10, "Ember DeLvL", EmberTestDeLvL);
			if (flags[kFLAGS.ISABELLA_LVL_UP] >= 1) addButton(11, "Isabella DeLvL", IsabellaTestDeLvL);
			if (flags[kFLAGS.KIHA_LVL_UP] >= 1) addButton(12, "Kiha DeLvL", KihaTestDeLvL);
			if (flags[kFLAGS.ETNA_LVL_UP] >= 1) addButton(13, "Etna DeLvL", EtnaTestDeLvL);
			addButton(14, "Back", SoulforceCheats);
		}
		public function EmberIsabellaKiha():void {
			if (flags[kFLAGS.EMBER_HATCHED] < 1 && flags[kFLAGS.TOOK_EMBER_EGG] < 1) InstaEmberEggInCamp();
			if (flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] < 1) LilCocksLoverSummoning();
			if (flags[kFLAGS.KIHA_FOLLOWER] < 1) ResidentCampDragonishTsundere();
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function InstaEmberEggInCamp():void {
			player.createKeyItem("Dragon Egg", 0, 0, 0, 0);
			flags[kFLAGS.TOOK_EMBER_EGG] = 1;
			flags[kFLAGS.EMBER_COR] = 50;
			outputText("\n\n<b>Ember Egg put in camp.</b>");
		}
		public function LilCocksLoverSummoning():void {
			flags[kFLAGS.ISABELLA_COUNTDOWN_TO_CONTRACEPTIONS] = 240;
			flags[kFLAGS.ISABELLA_AFFECTION] = 100;
			flags[kFLAGS.ISABELLA_FOLLOWER_ACCEPTED] = 1;
			flags[kFLAGS.ISABELLA_PLAINS_DISABLED] = 1;
			outputText("\n\n<b>I heard you love cows loving small cocks...so here you will get Isabella *wink wink*</b>");
		}
		public function ResidentCampDragonishTsundere():void {
			flags[kFLAGS.KIHA_AFFECTION_LEVEL] = 2;
			flags[kFLAGS.KIHA_AFFECTION] = 100;
			flags[kFLAGS.KIHA_MOVE_IN_OFFER] = 1;
			flags[kFLAGS.KIHA_FOLLOWER] = 1;
			outputText("\n\n<b>We need more...yandered dragon-like waifu. Or was it only more of Kiha?</b>");
		}
		public function KindraMemory5():void {
			flags[kFLAGS.KINDRA_LVL_UP] = 6;
			flags[kFLAGS.KINDRA_FOLLOWER] = 1;
			flags[kFLAGS.KINDRA_AFFECTION] = 5;
			outputText("\n\n<b>Kindra... and everything is clear.</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function SuccubusishMantioreOnLeash():void {
			flags[kFLAGS.ETNA_AFFECTION] = 80;
			flags[kFLAGS.ETNA_FOLLOWER] = 2;
			flags[kFLAGS.ETNA_DAILY_VENOM_VIAL] = 0;
			outputText("\n\n<b>Watch for Etna is in da hous... err camp.</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Ember1stLvLUp():void {
			flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.EMBER_LVL_UP] = 1;
			outputText("\n\n<b>Ember 1st LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Ember2ndLvLUp():void {
			flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.EMBER_LVL_UP] = 2;
			outputText("\n\n<b>Ember 2nd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Ember3rdLvLUp():void {
			flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.EMBER_LVL_UP] = 3;
			outputText("\n\n<b>Ember 3rd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Ember4thLvLUp():void {
			flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.EMBER_LVL_UP] = 4;
			outputText("\n\n<b>Ember 4th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Ember5thLvLUp():void {
			flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.EMBER_LVL_UP] = 5;
			outputText("\n\n<b>Ember 5th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Ember6thLvLUp():void {
			flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.EMBER_LVL_UP] = 6;
			outputText("\n\n<b>Ember 6th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Ember7thLvLUp():void {
			flags[kFLAGS.EMBER_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.EMBER_LVL_UP] = 7;
			outputText("\n\n<b>Ember 7th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function EmberTestDeLvL():void {
			flags[kFLAGS.EMBER_LVL_UP]--;
			outputText("\n\n<b>Ember been De-LvL'd!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Isabella1stLvLUp():void {
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ISABELLA_LVL_UP] = 1;
			outputText("\n\n<b>Isabella 1st LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Isabella2ndLvLUp():void {
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ISABELLA_LVL_UP] = 2;
			outputText("\n\n<b>Isabella 2nd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Isabella3rdLvLUp():void {
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ISABELLA_LVL_UP] = 3;
			outputText("\n\n<b>Isabella 3rd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Isabella4thLvLUp():void {
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ISABELLA_LVL_UP] = 4;
			outputText("\n\n<b>Isabella 4th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Isabella5thLvLUp():void {
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ISABELLA_LVL_UP] = 5;
			outputText("\n\n<b>Isabella 5th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Isabella6thLvLUp():void {
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ISABELLA_LVL_UP] = 6;
			outputText("\n\n<b>Isabella 6th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Isabella7thLvLUp():void {
			flags[kFLAGS.ISABELLA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ISABELLA_LVL_UP] = 7;
			outputText("\n\n<b>Isabella 7th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function IsabellaTestDeLvL():void {
			flags[kFLAGS.ISABELLA_LVL_UP]--;
			outputText("\n\n<b>Isabella been De-LvL'd!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kiha1stLvLUp():void {
			flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KIHA_LVL_UP] = 1;
			outputText("\n\n<b>Kiha 1st LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kiha2ndLvLUp():void {
			flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KIHA_LVL_UP] = 2;
			outputText("\n\n<b>Kiha 2nd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kiha3rdLvLUp():void {
			flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KIHA_LVL_UP] = 3;
			outputText("\n\n<b>Kiha 3rd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kiha4thLvLUp():void {
			flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KIHA_LVL_UP] = 4;
			outputText("\n\n<b>Kiha 4th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kiha5thLvLUp():void {
			flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KIHA_LVL_UP] = 5;
			outputText("\n\n<b>Kiha 5th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kiha6thLvLUp():void {
			flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KIHA_LVL_UP] = 6;
			outputText("\n\n<b>Kiha 6th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kiha7thLvLUp():void {
			flags[kFLAGS.KIHA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KIHA_LVL_UP] = 7;
			outputText("\n\n<b>Kiha 7th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function KihaTestDeLvL():void {
			flags[kFLAGS.KIHA_LVL_UP]--;
			outputText("\n\n<b>Kiha been De-LvL'd!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kindra1stLvLUp():void {
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 7;
			outputText("\n\n<b>Kindra 1st LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kindra2ndLvLUp():void {
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 8;
			outputText("\n\n<b>Kindra 2nd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Kindra3rdLvLUp():void {
			flags[kFLAGS.KINDRA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.KINDRA_LVL_UP] = 9;
			outputText("\n\n<b>Kindra 3rd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function KindraTestDeLvL():void {
			flags[kFLAGS.KINDRA_LVL_UP]--;
			outputText("\n\n<b>Kindra been De-LvL'd!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Etna1stLvLUp():void {
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 1;
			outputText("\n\n<b>Etna 1st LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Etna2ndLvLUp():void {
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 2;
			outputText("\n\n<b>Etna 2nd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Etna3rdLvLUp():void {
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 3;
			outputText("\n\n<b>Etna 3rd LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Etna4thLvLUp():void {
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 4;
			outputText("\n\n<b>Etna 4th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Etna5thLvLUp():void {
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 5;
			outputText("\n\n<b>Etna 5th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Etna6thLvLUp():void {
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 6;
			outputText("\n\n<b>Etna 6th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function Etna7thLvLUp():void {
			flags[kFLAGS.ETNA_DEFEATS_COUNTER] = 0;
			flags[kFLAGS.ETNA_LVL_UP] = 7;
			outputText("\n\n<b>Etna 7th LvL-Up!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
		}
		public function EtnaTestDeLvL():void {
			flags[kFLAGS.ETNA_LVL_UP]--;
			outputText("\n\n<b>Etna been De-LvL'd!!!</b>");
			doNext(FasterOrInstantCampNPCRecruitment);
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
		public function Stage10to12SoulPerks():void {
			if (player.findPerk(PerkLib.FleshBodyOverlordStage) < 0) {
				player.createPerk(PerkLib.FleshBodyOverlordStage, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Flesh Body Overlord Stage!)</b>");
			}
			if (player.findPerk(PerkLib.DaoistOverlordStage) < 0) {
				player.createPerk(PerkLib.DaoistOverlordStage, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Daoist Overlord Stage!)</b>");
			}
			if (player.findPerk(PerkLib.SoulKing) < 0) {
				player.createPerk(PerkLib.SoulKing, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Soul King!)</b>");
			}
			if (player.findPerk(PerkLib.SoulEmperor) < 0) {
				player.createPerk(PerkLib.SoulEmperor, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Soul Emperor!)</b>");
			}
			if (player.findPerk(PerkLib.SoulAncestor) < 0) {
				player.createPerk(PerkLib.SoulAncestor, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Soul Ancestor!)</b>");
			}
			doNext(SoulforceCheats);
		}
		public function EquipmentMenu():void {
			menu();
			addButton(0, "Rap. Perk", AddRapPerk).hint("Add Raphael Rapier Perk and 1 Dragon Rapier.  USE only ONCE to not break the game!");
			addButton(1, "Sky Pearl", AddSkyPoisonPearl).hint("Add 1 Sky Poison Pearl.");
			addButton(2, "Staff", AddStaff).hint("Add 1 Eldritch Staff.");
			addButton(3, "Evelyn", AddTheEvelyn).hint("Add 1 Evelyn Crossbow.");
			addButton(4, "MasterGloves", AddMasterGloves).hint("Add 1 master Gloves.");
			addButton(5, "G.Thr.Axes", AddGnollThrowingAxes).hint("Add 1 Gnoll Throwing Axes.");
			addButton(6, "Ascensus", AddTheStaffs).hint("Add set of items for Ascensus.");
			addButton(7, "DualLAxes", AddDualMinoAxes).hint("Add 1 pair of Large Axes.");
		//	addButton(8, "NineTailWhip", AddNineTailWhip).hint("Add 1 Nine Tail Whip.");
			addButton(8, "SH/SPK/OBN", AddTheSeerHairpinAndCo).hint("Add 1 Seer's Hairpin, Sakura Petal Kimono and Oni bead necklace.");
			addButton(9, "Hodr's Bow", AddHodrsBow).hint("Add 1 Hodr's Bow.");
		//	addButton(9, "L Ayo Arm", AddLightAyoArmor).hint("Add 1 Light Ayo Armor for testing purposes.");
			addButton(10, "TruestriekSword", AddTruestrikeSword).hint("Add 1 Truestrike Sword.");
			addButton(11, "ScepterComm", AddSceptreOfCommand).hint("Add 1 Sceptre of Command.");
			addButton(12, "D.Scythe", AddTheDemonicScythe).hint("Add 1 Demonic Scythe.");
		//	addButton(12, "CatONIneTWhip", AddCatONineTailWhip).hint("Add 1 Bastet Whip.");
			addButton(13, "InqTome", AddTheInquisitorsTome).hint("Add 1 Inquisitor's Tome.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function NonEquipmentMenu():void {
			menu();
			addButton(0, "Fox Jewel", AddFoxJewel).hint("Add 1 Fox Jewel.");
			addButton(1, "F.Fish", AddFreshFish).hint("Add 1 Fresh Fish.");
			addButton(2, "BehemothCum", AddBehemothCum).hint("Add 1 bottle of Behemoth Cum.");
			addButton(3, "Naga Oils", AddGorgonOil).hint("Add 1 vial of Gorgon, Vouivre and Couatl Oil.");
			addButton(4, "SkybornSeed", AddSkybornSeed).hint("Add 1 Skyborn Seed.");
			//addButton(4, "AbyssalInk", "Not yet ready for test and just for future use put here already ^^ (Add 1 Abyssal Ink.)");
			addButton(5, "Enigmanium", AddEnigmanium).hint("Add 1 vial of Enigmanium.");
			addButton(6, "VoltageTopaz", AddVoltageTopaz).hint("Add 1 Voltage Topaz.");
			addButton(7, "Red Vial", AddRedBlood).hint("Add 1 vial of Red Blood (Bat TF).");
			addButton(8, "WonderFruit", AddWonderFruit).hint("Add 1 Wonder Fruit.");
			//addButton(7, "V.D.ARC", AddVeryDilutedArcaneRegenConcotion).hint("Add 1 very diluted Arcane Regen Concotion.");
			//addButton(8, "D.ARC", AddDilutedArcaneRegenConcotion).hint("Add 1 diluted Arcane Regen Concotion.");
			addButton(9, "SBMan", AddSoulBlastManual).hint("Add 1 Soul Blast manual.");
			addButton(10, "White B.", AddWhiteBook).hint("Add 1 White Book.");
			addButton(11, "Black B.", AddBlackBook).hint("Add 1 Black Book.");
			addButton(12, "Grey B.", AddGreyBook).hint("Add 1 Grey Book.");
			if (player.findPerk(PerkLib.ElementalConjurerMindAndBodySacrifice) < 0) addButton(13, "E.Pearls", AddThePearls).hint("Add all three Elemental Pearls.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function MaterialMenu():void {
			menu();
			addButton(0, "Wood", AddWood).hint("Add 100 Wood (game not check for limits so not go overboard with using this cheat).");
			addButton(1, "Nails", AddNail).hint("Add 50 Nails (game not check for limits so not go overboard with using this cheat).");
			addButton(2, "Stone", AddStone).hint("Add 100 Stone (game not check for limits so not go overboard with using this cheat).");
			addButton(3, "SpiderSilk", AddSpiderSilk).hint("Add 1 Spider Silk.");
			addButton(4, "Ebonbloom", AddEbonbloom).hint("Add 1 Ebonbloom.");
			addButton(5, "WorldTreeB.", AddWorldTreeBranch).hint("Add 1 World Tree Branch.");
			addButton(6, "ChitinShard", AddBeeChitin).hint("Add 1 Chitin shard.");
			addButton(7, "GreenGel", AddGreenGel).hint("Add 1 Green Gel.");
			addButton(8, "DragonScale", AddDragonscale).hint("Add 1 Dragonscale.");
			addButton(9, "F.Imp S.", AddFeralImpSkull).hint("Add 1 Feral Imp Skull.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function EnemiesMenu():void {
			menu();
			addButton(0, "FightForPearl", FightForPearl).hint("Test fight to get Sky Poison Pearl legally (aside we cheat to start fight)");
			addButton(1, "Marae", FightMarae).hint("Test fight with Marae (depending on game stage she can be buffed or unbuffed).");
			addButton(2, "Sonya", FightSonya).hint("Test fight with Sonya.");
			addButton(3, "RyuBi", FightRyuBi).hint("Test fight with RyuBi.");
			addButton(4, "Nightmare", FightNightmare).hint("Test fight with Nightmare.");
			addButton(5, "DE Scout", FightDarkElfScout).hint("Test fight with Dark Elf Scout. (lvl 15)");
			addButton(6, "DE Slaver", FightDarkElfSlaver).hint("Test fight with Dark Elf Slaver. (lvl 27)");
			addButton(7, "DE Ranger", FightDarkElfRanger).hint("Test fight with Dark Elf Ranger. (lvl 39)");
			addButton(8, "DE Sniper", FightDarkElfSniper).hint("Test fight with Dark Elf Sniper. (lvl 51)");
			addButton(9, "Electra", FightElectra).hint("Test fight with Electra.");
			addButton(10, "LvLUP Eva", LvLUPEva).hint("LvL UP forcefully Evangeline for testing purpose up to the limit.");
			addButton(11, "DELvL Eva", DELvLEva).hint("DE LvL forcefully Evangeline for testing purpose down toward the lvl 12.");
			addButton(14, "Back", SoulforceCheats);
		}/*
		public function AddBladeGrass():void {
			outputText("\n\n<b>(Gained 1 Blade Grass!)</b>\n\n");
			inventory.takeItem(consumables.BLADEGR, SoulforceCheats);
		}*/
		public function AddFeralImpSkull():void {
			outputText("\n\n<b>(Gained 1 Feral Imp Skull!)</b>\n\n");
			inventory.takeItem(useables.FIMPSKL, MaterialMenu);
		}
		public function AddStaff():void {
			outputText("\n\n<b>(Gained 1 Eldritch Staff!)</b>\n\n");
			inventory.takeItem(weapons.E_STAFF, EquipmentMenu);
		}
		public function AddSpiderSilk():void {
			outputText("\n\n<b>(Gained 1 Spider Silk!)</b>\n\n");
			inventory.takeItem(useables.T_SSILK, MaterialMenu);
		}
		public function AddBeeChitin():void {
			outputText("\n\n<b>(Gained 1 Chitin Shard!)</b>\n\n");
			inventory.takeItem(useables.B_CHITN, MaterialMenu);
		}
		public function AddGreenGel():void {
			outputText("\n\n<b>(Gained 1 Green Gel!)</b>\n\n");
			inventory.takeItem(useables.GREENGL, MaterialMenu);
		}
		public function AddDragonscale():void {
			outputText("\n\n<b>(Gained 1 Dragonscale!)</b>\n\n");
			inventory.takeItem(useables.D_SCALE, MaterialMenu);
		}
		public function AddFreshFish():void {
			outputText("\n\n<b>(Gained 1 Fresh Fish!)</b>\n\n");
			inventory.takeItem(consumables.FREFISH, NonEquipmentMenu);
		}
		public function AddFoxJewel():void {
			outputText("\n\n<b>(Gained 1 Fox Jewel!)</b>\n\n");
			inventory.takeItem(consumables.FOXJEWL, NonEquipmentMenu);
		}
		public function AddVoltageTopaz():void {
			outputText("\n\n<b>(Gained 1 Voltage Topaz!)</b>\n\n");
			inventory.takeItem(consumables.VOLTTOP, NonEquipmentMenu);
		}
		public function AddRedBlood():void {
			outputText("\n\n<b>(Gained 1 vial of red blood!)</b>\n\n");
			inventory.takeItem(consumables.REDVIAL, NonEquipmentMenu);
		}
		public function AddWonderFruit():void {
			outputText("\n\n<b>(Gained 1 Wonder Fruit!)</b>\n\n");
			inventory.takeItem(consumables.WOFRUIT, NonEquipmentMenu);
		}
		public function AddGorgonOil():void {
			outputText("\n\n<b>(Gained 1 vial of Gorgon Oil!)</b>\n\n");
			inventory.takeItem(consumables.GORGOIL, AddVouivreOil);
		}
		public function AddVouivreOil():void {
			outputText("\n\n<b>(Gained 1 vial of Vouivre Oil!)</b>\n\n");
			inventory.takeItem(consumables.VOUIOIL, AddCouatlOil);
		}
		public function AddCouatlOil():void {
			outputText("\n\n<b>(Gained 1 vial of Couatl Oil!)</b>\n\n");
			inventory.takeItem(consumables.COUAOIL, NonEquipmentMenu);
		}
		public function AddEnigmanium():void {
			outputText("\n\n<b>(Gained 1 vial of Enigmanium!)</b>\n\n");
			inventory.takeItem(consumables.ENIGMANIUM, NonEquipmentMenu);
		}
		public function AddVeryDilutedArcaneRegenConcotion():void {
			outputText("\n\n<b>(Gained 1 very diluted Arcane Regen Concotion!)</b>\n\n");
			inventory.takeItem(consumables.VDARCON, NonEquipmentMenu);
		}
		public function AddDilutedArcaneRegenConcotion():void {
			outputText("\n\n<b>(Gained 1 diluted Arcane Regen Concotion!)</b>\n\n");
			inventory.takeItem(consumables.D_ARCON, NonEquipmentMenu);
		}
		public function AddSoulBlastManual():void {
			outputText("\n\n<b>(Gained 1 Soul Blast Manual!)</b>\n\n");
			inventory.takeItem(consumables.SOBLMAN, NonEquipmentMenu);
		}
		public function AddSkybornSeed():void {
			outputText("\n\n<b>(Gained 1 Skyborn Seed!)</b>\n\n");
			inventory.takeItem(consumables.SKYSEED, NonEquipmentMenu);
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
		public function AddCatONineTailWhip():void {
			outputText("\n\n<b>(Gained 1 Bastet Whip!)</b>\n\n");
			inventory.takeItem(weapons.CNTWHIP, EquipmentMenu);
		}
		public function AddTheEvelyn():void {
			outputText("\n\n<b>(Gained 1 Evelyn Crossbow!)</b>\n\n");
			inventory.takeItem(weaponsrange.EVELYN_, EquipmentMenu);
		}
		public function AddMasterGloves():void {
			outputText("\n\n<b>(Gained 1 Master Gloves!)</b>\n\n");
			inventory.takeItem(weapons.MASTGLO, EquipmentMenu);
		}
		public function AddGnollThrowingAxes():void {
			outputText("\n\n<b>(Gained 1 Gnoll Throwing Axes!)</b>\n\n");
			inventory.takeItem(weaponsrange.GTHRAXE, EquipmentMenu);
		}
		public function AddHodrsBow():void {
			outputText("\n\n<b>(Gained 1 Hodr's Bow!)</b>\n\n");
			inventory.takeItem(weaponsrange.BOWHODR, EquipmentMenu);
		}
		public function AddTheSeerHairpinAndCo():void {
			outputText("\n\n<b>(Gained 1 Seer's Hairpin!)</b>\n\n");
			inventory.takeItem(headjewelries.SEERPIN, AddTheSeerHairpinAndCo1);
		}
		public function AddTheSeerHairpinAndCo1():void {
			outputText("\n\n<b>(Gained 1 Sakura Petal Kimono!)</b>\n\n");
			inventory.takeItem(armors.SPKIMO, AddTheSeerHairpinAndCo2);
		}
		public function AddTheSeerHairpinAndCo2():void {
			outputText("\n\n<b>(Gained 1 Oni bead necklace!)</b>\n\n");
			inventory.takeItem(necklaces.OBNECK, EquipmentMenu);
		}
		public function AddTruestrikeSword():void {
			outputText("\n\n<b>(Gained 1 Truestrike Sword!)</b>\n\n");
			inventory.takeItem(weapons.TRSTSWO, EquipmentMenu);
		}
		public function AddTheDemonicScythe():void {
			outputText("\n\n<b>(Gained 1 Demonic Scythe!)</b>\n\n");
			inventory.takeItem(weapons.DEMSCYT, EquipmentMenu);
		}
		public function AddSceptreOfCommand():void {
			outputText("\n\n<b>(Gained 1 Sceptre of Command!)</b>\n\n");
			inventory.takeItem(weapons.SCECOMM, EquipmentMenu);
		}
		public function AddTheInquisitorsTome():void {
			outputText("\n\n<b>(Gained 1 Inquisitor's Tome!)</b>\n\n");
			inventory.takeItem(weaponsrange.I_TOME_, EquipmentMenu);
		}
		public function EarlyAscension():void {
			if (flags[kFLAGS.LETHICE_DEFEATED] == 1) {
				outputText("\n\n<b>You already used this cheat code!</b>");
			}
			else {
				flags[kFLAGS.LETHICE_DEFEATED] = 1;
				outputText("\n\n<b>You can Ascend now even if you not beaten Lethice yet!</b>");
			}
			doNext(StatsAscensionMenu);
		}
		public function AddAscensionPerkPoints1():void {
			outputText("\n\n<b>You gained 1 Ascension Perk Point!</b>");
			player.ascensionPerkPoints += 1;
			doNext(StatsAscensionMenu);
		}
		public function AddAscensionPerkPoints2():void {
			outputText("\n\n<b>You gained 5 Ascension Perk Points!</b>");
			player.ascensionPerkPoints += 5;
			doNext(StatsAscensionMenu);
		}
		public function AddAscensionPerkPoints3():void {
			outputText("\n\n<b>You gained 10 Ascension Perk Points!</b>");
			player.ascensionPerkPoints += 10;
			doNext(StatsAscensionMenu);
		}
		public function AddAscensionPerkPoints4():void {
			outputText("\n\n<b>You gained 50 Ascension Perk Points!</b>");
			player.ascensionPerkPoints += 50;
			doNext(StatsAscensionMenu);
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
		public function AddStr4():void {
			player.str = player.str + 200;
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
		public function AddTou4():void {
			player.tou = player.tou + 200;
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
		public function AddSpe4():void {
			player.spe = player.spe + 200;
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
		public function AddInte4():void {
			player.inte = player.inte + 200;
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
		public function AddWis4():void {
			player.wis = player.wis + 200;
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
		public function AddLib4():void {
			player.lib = player.lib + 200;
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
		public function AddSens4():void {
			player.sens = player.sens + 200;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function AddCor1():void {
			player.cor = player.cor + 1;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function AddCor2():void {
			player.cor = player.cor + 5;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function AddCor3():void {
			player.cor = player.cor + 10;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function AddCor4():void {
			player.cor = player.cor + 50;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function AddTone1():void {
			player.tone = player.tone + 1;
			statScreenRefresh();
			StatsMenuToneThickness();
		}
		public function AddTone2():void {
			player.tone = player.tone + 10;
			statScreenRefresh();
			StatsMenuToneThickness();
		}
		public function AddThickness1():void {
			player.thickness = player.thickness + 1;
			statScreenRefresh();
			StatsMenuToneThickness();
		}
		public function AddThickness2():void {
			player.thickness = player.thickness + 10;
			statScreenRefresh();
			StatsMenuToneThickness();
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
		public function SubStr4():void {
			player.str = player.str - 200;
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
		public function SubTou4():void {
			player.tou = player.tou - 200;
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
		public function SubSpe4():void {
			player.spe = player.spe - 200;
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
		public function SubInte4():void {
			player.inte = player.inte - 200;
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
		public function SubWis4():void {
			player.wis = player.wis - 200;
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
		public function SubLib4():void {
			player.lib = player.lib - 200;
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
		public function SubSens4():void {
			player.sens = player.sens - 200;
			statScreenRefresh();
			StatsMenuSens();
		}
		public function SubCor1():void {
			player.cor = player.cor - 1;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function SubCor2():void {
			player.cor = player.cor - 5;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function SubCor3():void {
			player.cor = player.cor - 10;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function SubCor4():void {
			player.cor = player.cor - 50;
			statScreenRefresh();
			StatsMenuCor();
		}
		public function SubTone1():void {
			player.tone = player.tone - 1;
			statScreenRefresh();
			StatsMenuToneThickness();
		}
		public function SubTone2():void {
			player.tone = player.tone - 10;
			statScreenRefresh();
			StatsMenuToneThickness();
		}
		public function SubThickness1():void {
			player.thickness = player.thickness - 1;
			statScreenRefresh();
			StatsMenuToneThickness();
		}
		public function SubThickness2():void {
			player.thickness = player.thickness - 10;
			statScreenRefresh();
			StatsMenuToneThickness();
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
		public function AddNineTailWhip():void {
			outputText("\n\n<b>(Gained 1 Nine Tail Whip!)</b>\n\n");
			inventory.takeItem(weapons.NTWHIP, EquipmentMenu);
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
		public function AddThePearls():void {
			outputText("\n\n<b>(Gained set of items to get all perks countering Elemental Conjuer perks negative effects on stat caps!)</b>\n\n");
			inventory.takeItem(consumables.E3PEARL, AddThePearls1);
		}
		public function AddThePearls1():void {
			outputText("\n\n");
			inventory.takeItem(consumables.E_PEARL, AddThePearls2);
		}
		public function AddThePearls2():void {
			outputText("\n\n");
			inventory.takeItem(consumables.E7PEARL, NonEquipmentMenu);
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
			outputText("Entering battle with Deep Sea Kraken Boss! Enjoy ^^");
			startCombat(new Kraken());
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
		public function FightDarkElfScout():void {
			clearOutput();
			outputText("Entering battle with Dark Elf Scout! Enjoy ^^");
			startCombat(new DarkElfScout());
		}
		public function FightDarkElfSlaver():void {
			clearOutput();
			outputText("Entering battle with Dark Elf Slaver! Enjoy ^^");
			startCombat(new DarkElfSlaver());
		}
		public function FightDarkElfRanger():void {
			clearOutput();
			outputText("Entering battle with Dark Elf Ranger! Enjoy ^^");
			startCombat(new DarkElfRanger());
		}
		public function FightDarkElfSniper():void {
			clearOutput();
			outputText("Entering battle with Dark Elf Sniper! Enjoy ^^");
			startCombat(new DarkElfSniper());
		}
		public function FightElectra():void {
			clearOutput();
			outputText("Entering battle with Electra! Enjoy ^^");
			startCombat(new Electra());
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
		public function RevertCabinProgress():void {
			flags[kFLAGS.CAMP_CABIN_PROGRESS] = 2;
			SoulforceCheats()
		}
		public function GargoyleMenu():void {
			menu();
			addButton(0, "Human", BackToHumanForm).hint("Return to been fully human from gargoyle form test.");
			addButton(1, "Marble", MarbleGargoyleForm).hint("Turn into marble gargoyle form for tests.");
			addButton(2, "Alabaster", AlabasterGargoyleForm).hint("Turn into alabaster gargoyle form for tests.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function BackToHumanForm():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 0;
			player.skin.setBaseOnly({type:Skin.PLAIN});
			player.hairType = Hair.NORMAL;
			player.faceType = Face.HUMAN;
			player.tongue.type = Tongue.HUMAN;
			player.horns.type = Horns.NONE;
			player.beardLength = 0;
			player.beardStyle = 0;
			player.arms.type = Arms.HUMAN;
			player.tailType = Tail.NONE;
			player.tailRecharge = 0;
			player.wings.type = Wings.NONE;
			player.lowerBody = LowerBody.HUMAN;
			player.legCount = 2;
			player.eyes.type = Eyes.HUMAN;
			player.antennae.type = Antennae.NONE;
			player.ears.type = Ears.HUMAN;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
			player.skin.restore();
			if (player.(PerkLib.GargoylePure)) player.removePerk(PerkLib.GargoylePure);
			if (player.(PerkLib.GargoyleCorrupted)) player.removePerk(PerkLib.GargoyleCorrupted);
			player.removePerk(PerkLib.TransformationImmunity);
			clearOutput();
			outputText("You have become fully human again.");
			doNext(SoulforceCheats);
		}
		public function MarbleGargoyleForm():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 1;
			player.skinTone = "light grey";
			player.hairColor = "light grey";
			clearOutput();
			outputText("You have become marble gargoyle. Now choose your wings shape.");
			doNext(WingShapeChoices);
		}
		public function AlabasterGargoyleForm():void {
			flags[kFLAGS.GARGOYLE_BODY_MATERIAL] = 2;
			player.skinTone = "quartz white";
			player.hairColor = "quartz white";
			clearOutput();
			outputText("You have become alabaster gargoyle. Now choose your wings shape.");
			doNext(WingShapeChoices);
		}
		public function WingShapeChoices():void {
			menu();
			addButton(0, "Bird", BirdWings);
			addButton(1, "Bat's", BatsWings);
		}
		public function BirdWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 1;
			clearOutput();
			outputText("Now choose your arms shape.");
			doNext(ArmTypeChoices);
		}
		public function BatsWings():void {
			flags[kFLAGS.GARGOYLE_WINGS_TYPE] = 2;
			clearOutput();
			outputText("Now choose your arms shape.");
			doNext(ArmTypeChoices);
		}
		public function ArmTypeChoices():void {
			menu();
			addButton(0, "Gargy", BirdArms);
			addButton(1, "Human", BatsWings);
		}
		public function BirdArms():void {
			player.arms.type = Arms.GARGOYLE;
			clearOutput();
			outputText("Now choose your tail shape.");
			doNext(TailTypeChoices);
		}
		public function BatsArms():void {
			player.arms.type = Arms.GARGOYLE_2;
			clearOutput();
			outputText("Now choose your tail shape.");
			doNext(TailTypeChoices);
		}
		public function TailTypeChoices():void {
			menu();
			addButton(0, "Whip-like", BirdTail);
			addButton(1, "Mace-like", BatsTail);
		}
		public function BirdTail():void {
			player.tailType = Tail.GARGOYLE;
			clearOutput();
			outputText("Now choose your legs shape.");
			doNext(LegsTypeChoices);
		}
		public function BatsTail():void {
			player.tailType = Tail.GARGOYLE_2;
			clearOutput();
			outputText("Now choose your legs shape.");
			doNext(LegsTypeChoices);
		}
		public function LegsTypeChoices():void {
			menu();
			addButton(0, "Gargy", BirdLegs);
			addButton(1, "Human", BatsLegs);
		}
		public function BirdLegs():void {
			player.lowerBody = LowerBody.GARGOYLE;
			clearOutput();
			outputText("Now choose your feeding style.");
			doNext(SustainTypeChoices);
		}
		public function BatsLegs():void {
			player.lowerBody = LowerBody.GARGOYLE_2;
			clearOutput();
			outputText("Now choose your feeding style.");
			doNext(SustainTypeChoices);
		}
		public function SustainTypeChoices():void {
			menu();
			addButton(0, "Soulforce", BirdSustain);
			addButton(1, "Milk & Cum", BatsSustain);
		}
		public function BirdSustain():void {
			player.createPerk(PerkLib.GargoylePure,0,0,0,0);
			player.createPerk(PerkLib.TransformationImmunity, 0, 0, 0, 0);
			clearOutput();
			outputText("Now your PC will became Prototype Gargoyle ^^");
			doNext(GargoyleBodyChanges);
		}
		public function BatsSustain():void {
			player.createPerk(PerkLib.GargoyleCorrupted,0,0,0,0);
			player.createPerk(PerkLib.TransformationImmunity,0,0,0,0);
			clearOutput();
			outputText("Now your PC will became Prototype Gargoyle ^^");
			doNext(GargoyleBodyChanges);
		}
		public function GargoyleBodyChanges():void {
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 1) {
				player.skinTone = "light grey";
				player.hairColor = "light grey";
			}
			if (flags[kFLAGS.GARGOYLE_BODY_MATERIAL] == 2) {
				player.skinTone = "quartz white";
				player.hairColor = "quartz white";
			}
			player.skin.setBaseOnly({type:Skin.STONE});
			player.hairType = Hair.NORMAL;
			player.faceType = Face.DEVIL_FANGS;
			player.tongue.type = Tongue.DEMONIC;
			player.horns.type = Horns.GARGOYLE;
			player.horns.count = 12 + rand(4);
			player.beardLength = 0;
			player.beardStyle = 0;
			player.tailRecharge = 0;
			player.wings.type = Wings.GARGOYLE_LIKE_LARGE;
			player.legCount = 2;
			player.eyes.type = Eyes.GEMSTONES;
			player.antennae.type = Antennae.NONE;
			player.tongue.type = Tongue.DEMONIC;
			player.ears.type = Ears.ELFIN;
			player.gills.type = Gills.NONE;
			player.rearBody.type = RearBody.NONE;
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
			addButton(0, "1 hour", SoulforceRegeneration1).hint("Cultivate for 1 hour (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(20) + " soulforce).");
			addButton(1, "2 hours", SoulforceRegeneration2).hint("Cultivate for 2 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(60) + " soulforce).");
			addButton(2, "4 hours", SoulforceRegeneration3).hint("Cultivate for 4 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(140) + " soulforce).");
			addButton(3, "6 hours", SoulforceRegeneration4).hint("Cultivate for 6 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(220) + " soulforce).");
			addButton(4, "8 hours", SoulforceRegeneration5).hint("Cultivate for 8 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(300) + " soulforce).");
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function SoulforceRegeneration1():void {
			clearOutput();
			var soulforceamountrestored:int = 16;
			if (player.alicornScore() >= 12) soulforceamountrestored += 20;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 20;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 80;
			if (player.unicornScore() >= 10) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 20;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 20;
			if (player.findPerk(PerkLib.DaoistElderStage) >= 0) soulforceamountrestored += 20;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 20;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 20;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulScholar) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulElder) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 16;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) soulforceamountrestored += 16;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.headjewelryName == "training soul ring") {
				var bonussoulforce:Number = 0;
				bonussoulforce += SoulforceGainedFromCultivation1();
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation2();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(20);
			doNext(camp.returnToCampUseOneHour);
		}
		public function SoulforceRegeneration2():void {
			clearOutput();
			var soulforceamountrestored:int = 52;
			if (player.alicornScore() >= 12) soulforceamountrestored += 60;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 60;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 240;
			if (player.unicornScore() >= 10) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 60;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 60;
			if (player.findPerk(PerkLib.DaoistElderStage) >= 0) soulforceamountrestored += 60;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 60;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 60;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulScholar) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulElder) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 52;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) soulforceamountrestored += 52;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.headjewelryName == "training soul ring") {
				var bonussoulforce:Number = 0;
				bonussoulforce += SoulforceGainedFromCultivation1() * 2;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation2();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(40);
			doNext(camp.returnToCampUseTwoHours);
		}
		public function SoulforceRegeneration3():void {
			clearOutput();
			var soulforceamountrestored:int = 124;
			if (player.alicornScore() >= 12) soulforceamountrestored += 140;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 140;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 560;
			if (player.unicornScore() >= 10) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 140;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 140;
			if (player.findPerk(PerkLib.DaoistElderStage) >= 0) soulforceamountrestored += 140;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 140;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 140;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulScholar) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulElder) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 124;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) soulforceamountrestored += 124;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.headjewelryName == "training soul ring") {
				var bonussoulforce:Number = 0;
				bonussoulforce += SoulforceGainedFromCultivation1() * 4;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation2();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(80);
			doNext(camp.returnToCampUseFourHours);
		}
		public function SoulforceRegeneration4():void {
			clearOutput();
			var soulforceamountrestored:int = 196;
			if (player.alicornScore() >= 12) soulforceamountrestored += 220;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 220;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 880;
			if (player.unicornScore() >= 10) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 220;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 220;
			if (player.findPerk(PerkLib.DaoistElderStage) >= 0) soulforceamountrestored += 220;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 220;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 220;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulScholar) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulElder) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 196;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) soulforceamountrestored += 196;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.headjewelryName == "training soul ring") {
				var bonussoulforce:Number = 0;
				bonussoulforce += SoulforceGainedFromCultivation1() * 6;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation2();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(120);
			doNext(camp.returnToCampUseSixHours);
		}
		public function SoulforceRegeneration5():void {
			clearOutput();
			var soulforceamountrestored:int = 268;
			if (player.alicornScore() >= 12) soulforceamountrestored += 300;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 300;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) soulforceamountrestored += 1200;
			if (player.unicornScore() >= 10) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) soulforceamountrestored += 300;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) soulforceamountrestored += 300;
			if (player.findPerk(PerkLib.DaoistElderStage) >= 0) soulforceamountrestored += 300;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) soulforceamountrestored += 300;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) soulforceamountrestored += 300;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulScholar) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulElder) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulKing) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) soulforceamountrestored += 268;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) soulforceamountrestored += 268;
			player.soulforce += soulforceamountrestored;
			if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.headjewelryName == "training soul ring") {
				var bonussoulforce:Number = 0;
				bonussoulforce += SoulforceGainedFromCultivation1() * 8;
				flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
				SoulforceGainedFromCultivation2();
			}
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			outputText("You find a flat, comfortable rock to sit down on and cultivate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
			outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
			outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(160);
			doNext(camp.returnToCampUseEightHours);
		}
		public function SoulforceGainedFromCultivation1():Number {
			var cumulativegains:Number = 0;
			if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor" && player.upperGarmentName == "soul training shirt" && player.lowerGarmentName == "soul training panties"
				&& player.headjewelryName == "training soul hairpin" && player.necklaceName == "training soul necklace" && player.headjewelryName == "training soul ring") {
				cumulativegains += 13;//+45% jak wszystkie 9 slotów - każdy kolejny dodany slot dodaje kolejne 5%
			}
			else {
				if (player.weaponName == "training soul axe") cumulativegains += 1;
				if (player.weaponRangeName == "training soul crossbow") cumulativegains += 1;
				if (player.shieldName == "training soul buckler") cumulativegains += 1;
				if (player.armorName == "training soul armor") cumulativegains += 1;
				if (player.upperGarmentName == "soul training shirt") cumulativegains += 1;
				if (player.lowerGarmentName == "soul training panties") cumulativegains += 1;
				if (player.headjewelryName == "training soul hairpin") cumulativegains += 1;
				if (player.necklaceName == "training soul necklace") cumulativegains += 1;
				if (player.jewelryName == "training soul ring") cumulativegains += 1;
			}
			return cumulativegains;
		}
		public function SoulforceGainedFromCultivation2():void {
			var bonussoulforce2:Number = 0;//razem może mieć max 1430
			if (player.weaponName == "training soul axe") bonussoulforce2 += 80;
			if (player.weaponRangeName == "training soul crossbow") bonussoulforce2 += 50;
			if (player.shieldName == "training soul buckler") bonussoulforce2 += 60;
			if (player.armorName == "training soul armor") bonussoulforce2 += 240;
			if (player.upperGarmentName == "soul training shirt") bonussoulforce2 += 200;
			if (player.lowerGarmentName == "soul training panties") bonussoulforce2 += 200;
			if (player.headjewelryName == "training soul hairpin") bonussoulforce2 += 200;
			if (player.necklaceName == "training soul necklace") bonussoulforce2 += 300;
				if (player.jewelryName == "training soul ring") bonussoulforce2 += 100;
			if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > 0) {
				if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2]) flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2];
				else flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += (bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]);
			}
		}
		public function AmountOfSoulforceRecoveredDuringCultivation(mod:Number):Number {
			var costPercent:Number = 100;
			if (player.alicornScore() >= 12) costPercent += 100;
			if (player.kitsuneScore() >= 6) costPercent += 100;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailCount == 9) costPercent += 400;
			if (player.unicornScore() >= 10) costPercent += 50;
			if (player.findPerk(PerkLib.DaoistCultivator) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistApprenticeStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistWarriorStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistElderStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistOverlordStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.DaoistTyrantStage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) costPercent += 150;
			if (player.findPerk(PerkLib.SoulScholar) >= 0) costPercent += 150;
			if (player.findPerk(PerkLib.SoulElder) >= 0) costPercent += 150;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) costPercent += 200;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) costPercent += 200;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) costPercent += 200;
			if (player.findPerk(PerkLib.SoulKing) >= 0) costPercent += 250;
			if (player.findPerk(PerkLib.SoulEmperor) >= 0) costPercent += 250;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) costPercent += 250;
			mod *= costPercent/100;
			return mod;
		}
		public function SelfSustain():void {
			clearOutput();
			outputText("Use some of your soulforce to partialy sate your hunger. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
			outputText("So what amount of your soulforce do you want to use?");
			menu();
			addButton(0, "V. Low", SelfSustain1).hint("Spend 50 soulforce for 10 hunger.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(1, "Low", SelfSustain2).hint("Spend 100 soulforce for 20 hunger.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(2, "Medium", SelfSustain3).hint("Spend 200 soulforce for 40 hunger.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(3, "High", SelfSustain4).hint("Spend 400 soulforce for 80 hunger.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(4, "V. High", SelfSustain5).hint("Spend 800 soulforce for 160 hunger.");
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function SelfSustain1():void {
			clearOutput();
			if (player.soulforce >= 50) {
				outputText("Consuming a little of soulforce you feel slightly less hungry.");
				player.soulforce -= 50;
				player.refillHunger(10);
				if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(10);
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
				if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(20);
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
				if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(40);
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
				if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(80);
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
				if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(160);
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
			addButton(0, "V. Low", RepresLust1).hint("Spend 40 soulforce for 20 lust.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(1, "Low", RepresLust2).hint("Spend 80 soulforce for 40 lust.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(2, "Medium", RepresLust3).hint("Spend 200 soulforce for 100 lust.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(3, "High", RepresLust4).hint("Spend 400 soulforce for 200 lust.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(4, "V. High", RepresLust5).hint("Spend 800 soulforce for 400 lust.");
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
			outputText("Use some of your soulforce to slowly conver it into mana or some mana in soulforce. The higher your cultivation is the more you could convert without hurting yourself.\n\n");
			outputText("So what amount of your soulforce/mana do you want to convert?");
			menu();
		//	if (CoC.instance.inCombat) {
		//		addButton(14, "Back", CoC.instance.combatMenu);
		//	}You sit down and focus your spiritual power to recover some of your physical stamina, within moments, you feel rested and refreshed. - może do wykorzystania potem gdzieś?
		//	else {
				addButton(0, "100", Covert100Soulforce).hint("Convert 100 soulforce to 100 mana.");
				if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(1, "200", Covert200Soulforce).hint("Convert 200 soulforce to 200 mana.");
				if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(2, "500", Covert500Soulforce).hint("Convert 500 soulforce to 500 mana.");
				if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(3, "1000", Covert1000Soulforce).hint("Convert 1000 soulforce to 1000 mana.");
				if (player.findPerk(PerkLib.SoulExalt) >= 0) addButton(4, "2000", Covert2000Soulforce).hint("Convert 2000 soulforce to 2000 mana.");
				addButton(5, "100", Covert100Mana).hint("Convert 100 mana to 50 soulforce.");
				if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(6, "200", Covert200Mana).hint("Convert 200 mana to 100 soulforce.");
				if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(7, "500", Covert500Mana).hint("Convert 500 mana to 250 soulforce.");
				if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(8, "1000", Covert1000Mana).hint("Convert 1000 mana to 500 soulforce.");
				if (player.findPerk(PerkLib.SoulExalt) >= 0) addButton(9, "2000", Covert2000Mana).hint("Convert 2000 mana to 1000 soulforce.");
				addButton(14, "Back", accessSoulforceMenu);
		//	}
		}
		public function Covert100Soulforce():void {
			clearOutput();
			if (player.soulforce >= 100) {
				outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
				player.soulforce -= 100;
				player.mana += 100;
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
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
				outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
				player.soulforce -= 200;
				player.mana += 200;
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
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
				outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
				player.soulforce -= 500;
				player.mana += 500;
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
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
				outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
				player.soulforce -= 1000;
				player.mana += 1000;
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
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
				outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
				player.soulforce -= 2000;
				player.mana += 2000;
				if (player.mana > player.maxMana()) player.mana = player.maxMana();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(ManaAndSoulforce);
			}
		}
		public function Covert100Mana():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your current mana is too low.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
				player.mana -= 100;
				player.soulforce += 50;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert200Mana():void {
			clearOutput();
			if (player.mana < 200) {
				outputText("Your current mana is too low.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
				player.mana -= 200;
				player.soulforce += 100;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert500Mana():void {
			clearOutput();
			if (player.mana < 500) {
				outputText("Your current mana is too low.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
				player.mana -= 500;
				player.soulforce += 250;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert1000Mana():void {
			clearOutput();
			if (player.mana < 1000) {
				outputText("Your current mana is too low.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
				player.mana -= 1000;
				player.soulforce += 500;
				if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
				statScreenRefresh();
				flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
				doNext(playerMenu);
			}
		}
		public function Covert2000Mana():void {
			clearOutput();
			if (player.mana < 2000) {
				outputText("Your current mana is too low.");
				doNext(ManaAndSoulforce);
			}
			else {
				outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
				player.mana -= 2000;
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
			addButton(0, "V. Low", CorrDrop1).hint("Spend 100 soulforce for lowering corruption by 1.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(1, "Low", CorrDrop2).hint("Spend 200 soulforce for lowering corruption by 2.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(2, "Medium", CorrDrop3).hint("Spend 500 soulforce for lowering corruption by 5.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(3, "High", CorrDrop4).hint("Spend 1000 soulforce for lowering corruption by 10.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(4, "V. High", CorrDrop5).hint("Spend 2000 soulforce for lowering corruption by 20.");
			addButton(5, "V. Low", CorrRise1).hint("Spend 50 soulforce for rising corruption by 1.");
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(6, "Low", CorrRise2).hint("Spend 100 soulforce for rising corruption by 2.");
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) addButton(7, "Medium", CorrRise3).hint("Spend 250 soulforce for rising corruption by 5.");
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) addButton(8, "High", CorrRise4).hint("Spend 500 soulforce for rising corruption by 10.");
			if (player.findPerk(PerkLib.SoulSprite) >= 0) addButton(9, "V. High", CorrRise5).hint("Spend 1000 soulforce for rising corruption by 20.");
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
			if (flags[kFLAGS.SOUL_SENSE_TAMANI] >= 3) addButton(0, "Tamani", TamaniEnc);
			if (flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] >= 3) addButton(1, "Tamani D.", TamaniDaughtersEnc);
			if (flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] >= 3) addButton(2, "KitsuMansion", KitsuneMansion);
			if (flags[kFLAGS.SOUL_SENSE_IZUMI] >= 3) addButton(3, "Izumi", IzumiEnc);
			if (flags[kFLAGS.SOUL_SENSE_WORLD_TREE] >= 1) addButton(10, "WorldTree", findWorldTree);
			if (flags[kFLAGS.SOUL_SENSE_GIACOMO] >= 3) addButton(13, "Giacomo", findGiacomo);
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
				SceneLib.kitsuneScene.enterTheTrickster();
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SoulSense);
			}
		}
		public function IzumiEnc():void {
			if (player.soulforce >= 300) {
				player.soulforce -= 300;
				statScreenRefresh();
				izumiScenes.encounter();
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
		public function findGiacomo():void {
			if (player.soulforce >= 100) {
				player.soulforce -= 100;
				statScreenRefresh();
				SceneLib.giacomoShop.giacomoEncounter();
			}
			else {
				outputText("Your current soulforce is too low.");
				doNext(SoulSense);
			}
		}
	}
}