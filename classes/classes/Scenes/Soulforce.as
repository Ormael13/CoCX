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
import classes.Scenes.Areas.Forest.Nightmare;
import classes.Scenes.Areas.Forest.TamainsDaughtersScene;
import classes.Scenes.Areas.Forest.TamaniScene;
import classes.Scenes.Areas.Forest.TentacleBeastRaging;
import classes.Scenes.Areas.Forest.WorldTree;
import classes.Scenes.Areas.HighMountains.IzumiScene;
import classes.Scenes.Dungeons.D3.Lethice;
import classes.Scenes.Dungeons.DenOfDesire.HeroslayerOmnibus;
import classes.Scenes.Dungeons.DenOfDesire.ObsidianGargoyle;
import classes.Scenes.Dungeons.EbonLabyrinth.*;
import classes.Scenes.Explore.Pierce;
import classes.Scenes.Monsters.DarkElfRanger;
import classes.Scenes.Monsters.DarkElfScout;
import classes.Scenes.Monsters.DarkElfSlaver;
import classes.Scenes.Monsters.DarkElfSniper;
import classes.Scenes.Monsters.Malikore;
import classes.Scenes.Monsters.Manticore;
import classes.Scenes.NPCs.Alvina;
import classes.Scenes.NPCs.Aria;
import classes.Scenes.NPCs.Aurora;
import classes.Scenes.NPCs.CelessScene;
import classes.Scenes.NPCs.Diana;
import classes.Scenes.NPCs.Electra;
import classes.Scenes.NPCs.Neisa;
import classes.Scenes.NPCs.RyuBiDragon;
import classes.Scenes.NPCs.Sonya;
import classes.Scenes.Places.Boat.Marae;
import classes.Player;
import classes.Items.*;
import classes.Scenes.Quests.UrtaQuest.MinotaurLord;

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
			var dailySoulforceUsesLimit:Number = 0;
			if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulElder) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulTyrant) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulAncestor) >= 0) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
			outputText("<b>Cultivation level:</b> " + flags[kFLAGS.SOUL_CULTIVATION] + "\n");
			outputText("<b>Additional Soulforce from training:</b> " + flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] + " / 1430\n");
		/*	outputText("<b>Progress toward clearing next meridian: </b>");
			if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 2)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 1)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
		*/	outputText("<b>Uses of soulforce per day (for 4 first option beside cultivate):</b> " + flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] + " / " + dailySoulforceUsesLimit + "\n");
			if (player.hasStatusEffect(StatusEffects.TelAdreTripxi)) {
				outputText("<b>TelAdre Tripxi Guns general timer:</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxi) + "\n");
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns1)) {
					outputText("<b>TelAdre Tripxi Guns 1 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns1) + " (Desert Eagle)\n");
					outputText("<b>TelAdre Tripxi Guns 1 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns1) + " (Dart pistol)\n");
					outputText("<b>TelAdre Tripxi Guns 1 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns1) + "\n");
					outputText("<b>TelAdre Tripxi Guns 1 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns1) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns2)) {
					outputText("<b>TelAdre Tripxi Guns 2 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns2) + " (M1 Cerberus)\n");
					outputText("<b>TelAdre Tripxi Guns 2 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns2) + " (Twin Dart pistol)\n");
					outputText("<b>TelAdre Tripxi Guns 2 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns2) + "\n");
					outputText("<b>TelAdre Tripxi Guns 2 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns2) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns3)) {
					outputText("<b>TelAdre Tripxi Guns 3 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns3) + " (Tripxi Fatbilly)\n");
					outputText("<b>TelAdre Tripxi Guns 3 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns3) + " (Harpoon Gun)\n");
					outputText("<b>TelAdre Tripxi Guns 3 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns3) + "\n");
					outputText("<b>TelAdre Tripxi Guns 3 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns3) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns4)) {
					outputText("<b>TelAdre Tripxi Guns 4 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns4) + " (Snippler)\n");
					outputText("<b>TelAdre Tripxi Guns 4 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns4) + "\n");
					outputText("<b>TelAdre Tripxi Guns 4 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns4) + "\n");
					outputText("<b>TelAdre Tripxi Guns 4 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns4) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns5)) {
					outputText("<b>TelAdre Tripxi Guns 5 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns5) + " (Touhouna M3)\n");
					outputText("<b>TelAdre Tripxi Guns 5 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns5) + " (Derpnade Launcher)\n");
					outputText("<b>TelAdre Tripxi Guns 5 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns5) + "\n");
					outputText("<b>TelAdre Tripxi Guns 5 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns5) + "\n");
				}
				if (player.hasStatusEffect(StatusEffects.TelAdreTripxiGuns6)) {
					outputText("<b>TelAdre Tripxi Guns 6 (v1):</b> " + player.statusEffectv1(StatusEffects.TelAdreTripxiGuns6) + " (Twin Grakaturd)\n");
					outputText("<b>TelAdre Tripxi Guns 6 (v2):</b> " + player.statusEffectv2(StatusEffects.TelAdreTripxiGuns6) + "\n");
					outputText("<b>TelAdre Tripxi Guns 6 (v3):</b> " + player.statusEffectv3(StatusEffects.TelAdreTripxiGuns6) + "\n");
					outputText("<b>TelAdre Tripxi Guns 6 (v4):</b> " + player.statusEffectv4(StatusEffects.TelAdreTripxiGuns6) + "\n");
				}
			}
			menu();
			if (player.hasPerk(PerkLib.EnergyDependent)) addButtonDisabled(0, "Cultivate", "You're unable to recover soulforce by cultivating.");
			else addButton(0, "Cultivate", SoulforceRegeneration).hint("Spend some time on restoring some of the used soulforce.");
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(1, "Self-sustain", SelfSustain).hint("Spend some soulforce on suppresing hunger for a while."); //zamiana soulforce na satiety w stosunku 1:5
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(2, "Repres. Lust", RepresLust).hint("Spend some soulforce on calming your sexual urges."); //używanie soulforce do zmniejszania lust w stosunku 1:2
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(4, "Adj. Corr.", CorruptionAndSoulforce).hint("Spend some soulforce on affecting your current corruption."); //używanie soulforce do zmniejszania corruption w stosunku 1:100 a zdobywanie corruption w stosunku 1:50
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit && player.findPerk(PerkLib.SoulApprentice) >= 0) addButton(3, "Mana", ManaAndSoulforce).hint("Convert some soulforce into mana or vice versa."); //używanie soulforce do zamiany na mane w stosunku 1:1 a many do soulforce 1:2, używalne nawet w walce też ale z wiekszym kosztem przeliczania czyli 1:2 i 1:4
			//addButton(5, "Upgrade", UpgradeItems).hint("."); //ulepszanie itemów
			if (player.findPerk(PerkLib.Metamorph) >= 0) addButton(6, "Metamorf", SceneLib.metamorph.accessMetamorphMenu).hint("Use your soulforce to mold freely your body.");//używanie metamorfowania z użyciem soulforce
			if (player.findPerk(PerkLib.SoulSense) >= 0) addButton(7, "Soul Sense", SoulSense).hint("Use your soul sense to trigger specific encounter."); //używanie divine sense aby znaleść określone event encounters: Tamani (lvl 6+), Tamani daugthers (lvl 6+), Kitsune mansion (lvl 12+), Izumi (lvl 18/24+), itp.
			addButton(10, "Cheats", SoulforceCheats).hint("Well as title saying those are cheats ^^");//block this option at each public version
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
			addButton(7, "Body State", BodyStateMenu).hint("For more precise adjusting of few other body values or parts than Stats Adj option.");
			addButton(8, "RevertCabin", RevertCabinProgress).hint("Revert cabin flag back to value 2 (for bug fix test)");
			//if (flags[kFLAGS.SAMIRAH_FOLLOWER] < 8) addButton(8, "Repta-Tongue", AddReptaTongue).hint("Items bungle for Repta-Tongue Potion.");
			if (player.hasPerk(PerkLib.Metamorph)) addButton(9, "MetamorphFull", AllMetamorphOptionsUnlock).hint("Metamorph all options unlock.");
			//addButton(9, "ChimeraBodyUlt", ChimeraBodyUltimateStage).hint("Ultimate Stage of Chimera Body for tests and lulz. Now with on/off switch for more lulz.");
			if ((player.hasPerk(PerkLib.TitanGripEx) && !player.hasPerk(PerkLib.GigantGripEx)) || player.hasPerk(PerkLib.LegendaryGolemMaker)) addButton(10, "PerkFixes", AddMaxBackpack).hint("Fix testers saves perks for Giant's Grip (Ex) and above Epic Golem maker");
			//addButton(10, "Gargoyle", GargoyleMenu).hint("To Be or Not To Be Gargoyle that is a question.");
			addButton(11, "PerkGalore1", PerkGalore1);
			addButton(12, "PerkGalore2", PerkGalore2);
			addButton(13, "BodyPartEditor", SceneLib.debugMenu.bodyPartEditorRoot);
			addButton(14, "Back", accessSoulforceMenu);
		}
		public function AddMaxBackpack():void {
			if (player.hasPerk(PerkLib.TitanGripEx)) {
				player.removePerk(PerkLib.TitanGripEx);
				player.createPerk(PerkLib.GigantGripEx, 0, 0, 0, 0);
			}
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) {
				player.removePerk(PerkLib.LegendaryGolemMaker);
				player.createPerk(PerkLib.EpicGolemMaker2ndCircle, 0, 0, 0, 0);
			}
			doNext(SoulforceCheats);
		}
public function FightAria():void {
	clearOutput();
	outputText("Entering battle with Melkie! Enjoy ^^");
	startCombat(new Aria());
}
public function FightLethice():void {
	clearOutput();
	outputText("Entering battle with Lethice! Enjoy ^^");
	startCombat(new Lethice());
}
public function FightNeisa():void {
	clearOutput();
	outputText("Entering battle with Neisa! Enjoy ^^");
	startCombat(new Neisa());
}
public function FightAlvina():void {
	clearOutput();
	outputText("Entering battle with Alvina! Enjoy ^^");
	startCombat(new Alvina());
}
public function FightChaosChimera():void {
	clearOutput();
	outputText("Entering battle with Chaos Chimera! Enjoy ^^");
	startCombat(new ChaosChimera());
}
public function FightDarkSlimeEmpress():void {
	clearOutput();
	outputText("Entering battle with Dark Slime Empress! Enjoy ^^");
	if (rand(2) == 0) player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,65,0,0,0);
	else {
		if (rand(2) == 0) player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,70,0,0,0);
		else player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
	}
	startCombat(new DarkSlimeEmpress());
}
public function FightHydra():void {
	clearOutput();
	outputText("Entering battle with Hydra! Enjoy ^^");
	if (rand(2) == 0) player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,65,0,0,0);
	else {
		if (rand(2) == 0) player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,70,0,0,0);
		else player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
	}
	startCombat(new Hydra());
}
public function FightHellfireSnail():void {
	clearOutput();
	outputText("Entering battle with Hellfire Snail! Enjoy ^^");
	if (rand(2) == 0) player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,65,0,0,0);
	else {
		if (rand(2) == 0) player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,70,0,0,0);
		else player.createStatusEffect(StatusEffects.EbonLabyrinthBoss,75,0,0,0);
	}
	startCombat(new HellfireSnail());
}
		public function AddReptaTongue():void {
			outputText("\n\n<b>(Gained set of items to make Repta-Tongue Potion!)</b>\n\n");
			inventory.takeItem(consumables.HUMMUS_, AddReptaTongue1);
		}
		public function AddReptaTongue1():void {
			outputText("\n\n");
			inventory.takeItem(consumables.REPTLUM, AddReptaTongue2);
		}
		public function AddReptaTongue2():void {
			outputText("\n\n");
			inventory.takeItem(consumables.OVIELIX, SoulforceCheats);
		}
		public function ChimeraBodyUltimateStage():void {
			if (player.hasPerk(PerkLib.ChimericalBodyUltimateStage)) {
				player.removePerk(PerkLib.ChimericalBodyUltimateStage);
				outputText("\n\n<b>(Lost Perk: Chimerical Body: Ultimate Stage!)</b>");
			}
			else {
				player.createPerk(PerkLib.ChimericalBodyUltimateStage, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Chimerical Body: Ultimate Stage!)</b>");
			}
			doNext(SoulforceCheats);
		}
		public function AllMetamorphOptionsUnlock():void {
			if (!player.hasStatusEffect(StatusEffects.UnlockedFur)) player.createStatusEffect(StatusEffects.UnlockedFur,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedScales)) player.createStatusEffect(StatusEffects.UnlockedScales,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedChitin)) player.createStatusEffect(StatusEffects.UnlockedChitin,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDragonScales)) player.createStatusEffect(StatusEffects.UnlockedDragonScales,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedTattoed)) player.createStatusEffect(StatusEffects.UnlockedTattoed,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBattleTattoed)) player.createStatusEffect(StatusEffects.UnlockedBattleTattoed,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLightningTattoed)) player.createStatusEffect(StatusEffects.UnlockedLightningTattoed,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedScarTattoed)) player.createStatusEffect(StatusEffects.UnlockedScarTattoed,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFishGills)) player.createStatusEffect(StatusEffects.UnlockedFishGills,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanLowerBody)) player.createStatusEffect(StatusEffects.UnlockedHumanLowerBody,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanSkin)) player.createStatusEffect(StatusEffects.UnlockedHumanSkin,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanArms)) player.createStatusEffect(StatusEffects.UnlockedHumanArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanFace)) player.createStatusEffect(StatusEffects.UnlockedHumanFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanTongue)) player.createStatusEffect(StatusEffects.UnlockedHumanTongue,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanEyes)) player.createStatusEffect(StatusEffects.UnlockedHumanEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanEars)) player.createStatusEffect(StatusEffects.UnlockedHumanEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanHair)) player.createStatusEffect(StatusEffects.UnlockedHumanHair,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern)) player.createStatusEffect(StatusEffects.UnlockedHumanNoSkinPattern,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanNoGills)) player.createStatusEffect(StatusEffects.UnlockedHumanNoGills,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanNoAntennae)) player.createStatusEffect(StatusEffects.UnlockedHumanNoAntennae,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanNoHorns)) player.createStatusEffect(StatusEffects.UnlockedHumanNoHorns,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanNoWings)) player.createStatusEffect(StatusEffects.UnlockedHumanNoWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanNoTail)) player.createStatusEffect(StatusEffects.UnlockedHumanNoTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHumanNoRearBody)) player.createStatusEffect(StatusEffects.UnlockedHumanNoRearBody,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxLowerBody)) player.createStatusEffect(StatusEffects.UnlockedFoxLowerBody,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxArms)) player.createStatusEffect(StatusEffects.UnlockedFoxArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxEars)) player.createStatusEffect(StatusEffects.UnlockedFoxEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail)) player.createStatusEffect(StatusEffects.UnlockedFoxTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxFace)) player.createStatusEffect(StatusEffects.UnlockedFoxFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxEyes)) player.createStatusEffect(StatusEffects.UnlockedFoxEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail2nd)) player.createStatusEffect(StatusEffects.UnlockedFoxTail2nd,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail3rd)) player.createStatusEffect(StatusEffects.UnlockedFoxTail3rd,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail4th)) player.createStatusEffect(StatusEffects.UnlockedFoxTail4th,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail5th)) player.createStatusEffect(StatusEffects.UnlockedFoxTail5th,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail6th)) player.createStatusEffect(StatusEffects.UnlockedFoxTail6th,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedKitsuneArms)) player.createStatusEffect(StatusEffects.UnlockedKitsuneArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonTail)) player.createStatusEffect(StatusEffects.UnlockedDemonTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonHorns)) player.createStatusEffect(StatusEffects.UnlockedDemonHorns,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonTonuge)) player.createStatusEffect(StatusEffects.UnlockedDemonTonuge,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonHighHeels)) player.createStatusEffect(StatusEffects.UnlockedDemonHighHeels,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonClawedLegs)) player.createStatusEffect(StatusEffects.UnlockedDemonClawedLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonTinyBatWings)) player.createStatusEffect(StatusEffects.UnlockedDemonTinyBatWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings)) player.createStatusEffect(StatusEffects.UnlockedDemonLargeBatWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2)) player.createStatusEffect(StatusEffects.UnlockedDemonLargeBatWings2,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLizardLegs)) player.createStatusEffect(StatusEffects.UnlockedLizardLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLizardArms)) player.createStatusEffect(StatusEffects.UnlockedLizardArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLizardTail)) player.createStatusEffect(StatusEffects.UnlockedLizardTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLizardEyes)) player.createStatusEffect(StatusEffects.UnlockedLizardEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLizardEars)) player.createStatusEffect(StatusEffects.UnlockedLizardEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLizardFace)) player.createStatusEffect(StatusEffects.UnlockedLizardFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBeeAntennae)) player.createStatusEffect(StatusEffects.UnlockedBeeAntennae,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBeeArms)) player.createStatusEffect(StatusEffects.UnlockedBeeArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBeeLegs)) player.createStatusEffect(StatusEffects.UnlockedBeeLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBeeTail)) player.createStatusEffect(StatusEffects.UnlockedBeeTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBeeWingsSmall)) player.createStatusEffect(StatusEffects.UnlockedBeeWingsSmall,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBeeWingsLarge)) player.createStatusEffect(StatusEffects.UnlockedBeeWingsLarge,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHarpyLegs)) player.createStatusEffect(StatusEffects.UnlockedHarpyLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHarpyTail)) player.createStatusEffect(StatusEffects.UnlockedHarpyTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHarpyArms)) player.createStatusEffect(StatusEffects.UnlockedHarpyArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHarpyHair)) player.createStatusEffect(StatusEffects.UnlockedHarpyHair,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHarpyWings)) player.createStatusEffect(StatusEffects.UnlockedHarpyWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedElfinEars)) player.createStatusEffect(StatusEffects.UnlockedElfinEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSpiderFourEyes)) player.createStatusEffect(StatusEffects.UnlockedSpiderFourEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSpiderFangs)) player.createStatusEffect(StatusEffects.UnlockedSpiderFangs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSpiderArms)) player.createStatusEffect(StatusEffects.UnlockedSpiderArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSpiderLegs)) player.createStatusEffect(StatusEffects.UnlockedSpiderLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSpiderTail)) player.createStatusEffect(StatusEffects.UnlockedSpiderTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDriderLegs)) player.createStatusEffect(StatusEffects.UnlockedDriderLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSharkTeeth)) player.createStatusEffect(StatusEffects.UnlockedSharkTeeth,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSharkTail)) player.createStatusEffect(StatusEffects.UnlockedSharkTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSharkLegs)) player.createStatusEffect(StatusEffects.UnlockedSharkLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSharkArms)) player.createStatusEffect(StatusEffects.UnlockedSharkArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSharkFin)) player.createStatusEffect(StatusEffects.UnlockedSharkFin,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicX2)) player.createStatusEffect(StatusEffects.UnlockedDraconicX2,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicX4)) player.createStatusEffect(StatusEffects.UnlockedDraconicX4,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail7th)) player.createStatusEffect(StatusEffects.UnlockedFoxTail7th,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail8th)) player.createStatusEffect(StatusEffects.UnlockedFoxTail8th,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedFoxTail9th)) player.createStatusEffect(StatusEffects.UnlockedFoxTail9th,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSalamanderTail)) player.createStatusEffect(StatusEffects.UnlockedSalamanderTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSalamanderLegs)) player.createStatusEffect(StatusEffects.UnlockedSalamanderLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSalamanderArms)) player.createStatusEffect(StatusEffects.UnlockedSalamanderArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSalamanderFace)) player.createStatusEffect(StatusEffects.UnlockedSalamanderFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedPhoenixArms)) player.createStatusEffect(StatusEffects.UnlockedPhoenixArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedPhoenixWings)) player.createStatusEffect(StatusEffects.UnlockedPhoenixWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcaLegs)) player.createStatusEffect(StatusEffects.UnlockedOrcaLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcaArms)) player.createStatusEffect(StatusEffects.UnlockedOrcaArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcaTail)) player.createStatusEffect(StatusEffects.UnlockedOrcaTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcaEars)) player.createStatusEffect(StatusEffects.UnlockedOrcaEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcaFace)) player.createStatusEffect(StatusEffects.UnlockedOrcaFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcaBlowhole)) player.createStatusEffect(StatusEffects.UnlockedOrcaBlowhole,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSnakeTongue)) player.createStatusEffect(StatusEffects.UnlockedSnakeTongue,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSnakeFangs)) player.createStatusEffect(StatusEffects.UnlockedSnakeFangs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSnakeLowerBody)) player.createStatusEffect(StatusEffects.UnlockedSnakeLowerBody,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSnakeEyes)) player.createStatusEffect(StatusEffects.UnlockedSnakeEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSnakeEars)) player.createStatusEffect(StatusEffects.UnlockedSnakeEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedGorgonHair)) player.createStatusEffect(StatusEffects.UnlockedGorgonHair,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedGorgonEyes)) player.createStatusEffect(StatusEffects.UnlockedGorgonEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicEars)) player.createStatusEffect(StatusEffects.UnlockedDraconicEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsSmall)) player.createStatusEffect(StatusEffects.UnlockedDraconicWingsSmall,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsLarge)) player.createStatusEffect(StatusEffects.UnlockedDraconicWingsLarge,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicWingsHuge)) player.createStatusEffect(StatusEffects.UnlockedDraconicWingsHuge,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicEyes)) player.createStatusEffect(StatusEffects.UnlockedDraconicEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicTongue)) player.createStatusEffect(StatusEffects.UnlockedDraconicTongue,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicFace)) player.createStatusEffect(StatusEffects.UnlockedDraconicFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicFangs)) player.createStatusEffect(StatusEffects.UnlockedDraconicFangs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicLegs)) player.createStatusEffect(StatusEffects.UnlockedDraconicLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicArms)) player.createStatusEffect(StatusEffects.UnlockedDraconicArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDraconicTail)) player.createStatusEffect(StatusEffects.UnlockedDraconicTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHoofedLegs)) player.createStatusEffect(StatusEffects.UnlockedHoofedLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCowTail)) player.createStatusEffect(StatusEffects.UnlockedCowTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCowEars)) player.createStatusEffect(StatusEffects.UnlockedCowEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurFace)) player.createStatusEffect(StatusEffects.UnlockedCowMinotaurFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCowMinotaurHorns)) player.createStatusEffect(StatusEffects.UnlockedCowMinotaurHorns,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedClovenHoofedLegs)) player.createStatusEffect(StatusEffects.UnlockedClovenHoofedLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedGoatTail)) player.createStatusEffect(StatusEffects.UnlockedGoatTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedGoatHorns)) player.createStatusEffect(StatusEffects.UnlockedGoatHorns,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedGoatEars)) player.createStatusEffect(StatusEffects.UnlockedGoatEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDevilArms)) player.createStatusEffect(StatusEffects.UnlockedDevilArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDevilFangs)) player.createStatusEffect(StatusEffects.UnlockedDevilFangs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDevilEyes)) player.createStatusEffect(StatusEffects.UnlockedDevilEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedMantisAntennae)) player.createStatusEffect(StatusEffects.UnlockedMantisAntennae,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedMantisLegs)) player.createStatusEffect(StatusEffects.UnlockedMantisLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedMantisArms)) player.createStatusEffect(StatusEffects.UnlockedMantisArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedMantisTail)) player.createStatusEffect(StatusEffects.UnlockedMantisTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedMantisWingsSmall)) player.createStatusEffect(StatusEffects.UnlockedMantisWingsSmall,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedMantisWingsLarge)) player.createStatusEffect(StatusEffects.UnlockedMantisWingsLarge,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedElfLegs)) player.createStatusEffect(StatusEffects.UnlockedElfLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedElfArms)) player.createStatusEffect(StatusEffects.UnlockedElfArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedElfEars)) player.createStatusEffect(StatusEffects.UnlockedElfEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedElfEyes)) player.createStatusEffect(StatusEffects.UnlockedElfEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedElfHair)) player.createStatusEffect(StatusEffects.UnlockedElfHair,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedElfTongue)) player.createStatusEffect(StatusEffects.UnlockedElfTongue,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOniLegs)) player.createStatusEffect(StatusEffects.UnlockedOniLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOniArms)) player.createStatusEffect(StatusEffects.UnlockedOniArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOniEyes)) player.createStatusEffect(StatusEffects.UnlockedOniEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOniEars)) player.createStatusEffect(StatusEffects.UnlockedOniEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOniFace)) player.createStatusEffect(StatusEffects.UnlockedOniFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOniSingleHorn)) player.createStatusEffect(StatusEffects.UnlockedOniSingleHorn,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOniTwinHorns)) player.createStatusEffect(StatusEffects.UnlockedOniTwinHorns,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuLegs)) player.createStatusEffect(StatusEffects.UnlockedRaijuLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuArms)) player.createStatusEffect(StatusEffects.UnlockedRaijuArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuTail)) player.createStatusEffect(StatusEffects.UnlockedRaijuTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuMane)) player.createStatusEffect(StatusEffects.UnlockedRaijuMane,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuFace)) player.createStatusEffect(StatusEffects.UnlockedRaijuFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuEars)) player.createStatusEffect(StatusEffects.UnlockedRaijuEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuEyes)) player.createStatusEffect(StatusEffects.UnlockedRaijuEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuHair)) player.createStatusEffect(StatusEffects.UnlockedRaijuHair,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuArms2)) player.createStatusEffect(StatusEffects.UnlockedRaijuArms2,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRaijuThunderousAura)) player.createStatusEffect(StatusEffects.UnlockedRaijuThunderousAura,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBatEars)) player.createStatusEffect(StatusEffects.UnlockedBatEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBatWings)) player.createStatusEffect(StatusEffects.UnlockedBatWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBatCollar)) player.createStatusEffect(StatusEffects.UnlockedBatCollar,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedVampireEars)) player.createStatusEffect(StatusEffects.UnlockedVampireEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedVampireWings)) player.createStatusEffect(StatusEffects.UnlockedVampireWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedVampireFace)) player.createStatusEffect(StatusEffects.UnlockedVampireFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedVampireEyes)) player.createStatusEffect(StatusEffects.UnlockedVampireEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedPigEars)) player.createStatusEffect(StatusEffects.UnlockedPigEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedPigTail)) player.createStatusEffect(StatusEffects.UnlockedPigTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedPigArms)) player.createStatusEffect(StatusEffects.UnlockedPigArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedPigFace)) player.createStatusEffect(StatusEffects.UnlockedPigFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBoarFace)) player.createStatusEffect(StatusEffects.UnlockedBoarFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBoarArms)) player.createStatusEffect(StatusEffects.UnlockedBoarArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcLegs)) player.createStatusEffect(StatusEffects.UnlockedOrcLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcArms)) player.createStatusEffect(StatusEffects.UnlockedOrcArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcFangs)) player.createStatusEffect(StatusEffects.UnlockedOrcFangs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedOrcEyes)) player.createStatusEffect(StatusEffects.UnlockedOrcEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHorseFace)) player.createStatusEffect(StatusEffects.UnlockedHorseFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHorseEars)) player.createStatusEffect(StatusEffects.UnlockedHorseEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHorseTail)) player.createStatusEffect(StatusEffects.UnlockedHorseTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedUnicornHorn)) player.createStatusEffect(StatusEffects.UnlockedUnicornHorn,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedAlicornWings)) player.createStatusEffect(StatusEffects.UnlockedAlicornWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedBicornHorns)) player.createStatusEffect(StatusEffects.UnlockedBicornHorns,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedNightmareWings)) player.createStatusEffect(StatusEffects.UnlockedNightmareWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRedPandaEars)) player.createStatusEffect(StatusEffects.UnlockedRedPandaEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRedPandaFace)) player.createStatusEffect(StatusEffects.UnlockedRedPandaFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRedPandaArms)) player.createStatusEffect(StatusEffects.UnlockedRedPandaArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRedPandaLegs)) player.createStatusEffect(StatusEffects.UnlockedRedPandaLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedRedPandaTail)) player.createStatusEffect(StatusEffects.UnlockedRedPandaTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatEars)) player.createStatusEffect(StatusEffects.UnlockedCatEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatTail)) player.createStatusEffect(StatusEffects.UnlockedCatTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatLegs)) player.createStatusEffect(StatusEffects.UnlockedCatLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatArms)) player.createStatusEffect(StatusEffects.UnlockedCatArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatFace)) player.createStatusEffect(StatusEffects.UnlockedCatFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatFangs)) player.createStatusEffect(StatusEffects.UnlockedCatFangs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatTongue)) player.createStatusEffect(StatusEffects.UnlockedCatTongue,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatEyes)) player.createStatusEffect(StatusEffects.UnlockedCatEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCheshireFace)) player.createStatusEffect(StatusEffects.UnlockedCheshireFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCheshireSmile)) player.createStatusEffect(StatusEffects.UnlockedCheshireSmile,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLionEars)) player.createStatusEffect(StatusEffects.UnlockedLionEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDisplacerEars)) player.createStatusEffect(StatusEffects.UnlockedDisplacerEars,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDisplacerEyes)) player.createStatusEffect(StatusEffects.UnlockedDisplacerEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDisplacerArms)) player.createStatusEffect(StatusEffects.UnlockedDisplacerArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedDisplacerBTentacles)) player.createStatusEffect(StatusEffects.UnlockedDisplacerBTentacles,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningTail)) player.createStatusEffect(StatusEffects.UnlockedHellcatBurningTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes)) player.createStatusEffect(StatusEffects.UnlockedHellcatInfernalEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedHellcatBurningHair)) player.createStatusEffect(StatusEffects.UnlockedHellcatBurningHair,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail1)) player.createStatusEffect(StatusEffects.UnlockedNekomataForkedTail1,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedNekomataForkedTail2)) player.createStatusEffect(StatusEffects.UnlockedNekomataForkedTail2,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedCatTail2nd)) player.createStatusEffect(StatusEffects.UnlockedCatTail2nd,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLionMane)) player.createStatusEffect(StatusEffects.UnlockedLionMane,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLionLegs)) player.createStatusEffect(StatusEffects.UnlockedLionLegs,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedLionArms)) player.createStatusEffect(StatusEffects.UnlockedLionArms,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedScorpionTail)) player.createStatusEffect(StatusEffects.UnlockedScorpionTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedManticoreTail)) player.createStatusEffect(StatusEffects.UnlockedManticoreTail,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsSmall)) player.createStatusEffect(StatusEffects.UnlockedManticoreWingsSmall,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedManticoreWingsLarge)) player.createStatusEffect(StatusEffects.UnlockedManticoreWingsLarge,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedManticoreFace)) player.createStatusEffect(StatusEffects.UnlockedManticoreFace,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedManticoreEyes)) player.createStatusEffect(StatusEffects.UnlockedManticoreEyes,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSphinxWings)) player.createStatusEffect(StatusEffects.UnlockedSphinxWings,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.UnlockedSphinxArms)) player.createStatusEffect(StatusEffects.UnlockedSphinxArms,0,0,0,0);/*
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);
			if (!player.hasStatusEffect(StatusEffects.)) player.createStatusEffect(StatusEffects.,0,0,0,0);*/
			doNext(SoulforceCheats);
		}
		public function PerkGalore1():void {
			if (player.findPerk(PerkLib.CorruptedKitsune) < 0) {
				player.createPerk(PerkLib.CorruptedKitsune, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Corrupted Kitsune!)</b>");
			}
			if (player.findPerk(PerkLib.CorruptedNinetails) < 0) {
				player.createPerk(PerkLib.CorruptedNinetails, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Corrupted Ninetails!)</b>");
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
				outputText("\n\n<b>(Gained Perk: FireLord!)</b>");
			}
			if (player.findPerk(PerkLib.Hellfire) < 0) {
				player.createPerk(PerkLib.Hellfire, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Hellfire!)</b>");
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
			if (player.findPerk(PerkLib.NinetailsKitsuneOfBalance) < 0) {
				player.createPerk(PerkLib.NinetailsKitsuneOfBalance, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: 9T Kitsune Of Balance!)</b>");
			}
			if (player.findPerk(PerkLib.MilkMaid) < 0) {
				player.createPerk(PerkLib.MilkMaid, 1, 0, 0, 0);
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
				player.createPerk(PerkLib.PurityBlessing, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Purity Blessing!)</b>");
			}
			if (player.findPerk(PerkLib.SensualLover) < 0) {
				player.createPerk(PerkLib.SensualLover, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Sensual Lover!)</b>");
			}
			if (player.findPerk(PerkLib.Perfection) >= 0 && player.findPerk(PerkLib.Creationism) < 0) {
				player.createPerk(PerkLib.Creationism, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Creationism!)</b>");
			}
			if (player.findPerk(PerkLib.SoulPowered) >= 0 && player.findPerk(PerkLib.AllSeeing) < 0) {
				player.createPerk(PerkLib.AllSeeing, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: All-Seeing!)</b>");
			}
			if (player.findPerk(PerkLib.SoulOfSteel) >= 0 && player.findPerk(PerkLib.GodOfSteel) < 0) {
				player.createPerk(PerkLib.GodOfSteel, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: God of Steel!)</b>");
			}
			if (player.findPerk(PerkLib.BlessedByLadyGodiva) >= 0 && player.findPerk(PerkLib.LadyGodivasFavoriteChild) < 0) {
				player.createPerk(PerkLib.LadyGodivasFavoriteChild, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Lady Godiva's favorite Child!)</b>");
			}
			if (player.findPerk(PerkLib.Surgeon) >= 0 && player.findPerk(PerkLib.Medic) < 0) {
				player.createPerk(PerkLib.Medic, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: MEDIC!!!!)</b>");
			}
			if (player.findPerk(PerkLib.Cardinal) >= 0 && player.findPerk(PerkLib.Pope) < 0) {
				player.createPerk(PerkLib.Pope, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Pope!)</b>");
			}
			if (player.findPerk(PerkLib.President) >= 0 && player.findPerk(PerkLib.Nerd) < 0) {
				player.createPerk(PerkLib.Nerd, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: NERD!!!!)</b>");
			}
			if (player.findPerk(PerkLib.SpysEnemy) >= 0 && player.findPerk(PerkLib.ShitYouTouchedSasha) < 0) {
				player.createPerk(PerkLib.ShitYouTouchedSasha, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: SHIT YOU TOUCHED SASHA!!!)</b>");
			}
			if (player.findPerk(PerkLib.ZZZ) >= 0 && player.findPerk(PerkLib.Lazy) < 0) {
				player.createPerk(PerkLib.Lazy, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: LAZY!!!!)</b>");
			}/*		Slut
			if (player.findPerk(PerkLib.) >= 0 && player.findPerk(PerkLib.) < 0) {
				player.createPerk(PerkLib., 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: !)</b>");
				player.createPerk(PerkLib., 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: !)</b>");
				player.createPerk(PerkLib., 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: !)</b>");
			}*/
			if (player.findPerk(PerkLib.Weap0n) >= 0 && player.findPerk(PerkLib.Arm0r) < 0) {
				player.createPerk(PerkLib.Arm0r, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Armor!)</b>");
			}
			if (player.findPerk(PerkLib.SexChampion) >= 0 && player.findPerk(PerkLib.SexDeity) < 0) {
				player.createPerk(PerkLib.SexDeity, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Sex Deity!)</b>");
			}
			doNext(SoulforceCheats);
		}
		public function PerkGalore2():void {
			if (player.findPerk(PerkLib.PrestigeJobNecromancer) < 0) {
				player.createPerk(PerkLib.PrestigeJobNecromancer, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Prestige Job: Necromancer!)</b>");
			}
			if (player.findPerk(PerkLib.PrestigeJobSeer) < 0) {
				player.createPerk(PerkLib.PrestigeJobSeer, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Prestige Job: Seer!)</b>");
			}
			if (player.findPerk(PerkLib.PrestigeJobSoulArcher) < 0) {
				player.createPerk(PerkLib.PrestigeJobSoulArcher, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Prestige Job: Soul Archer!)</b>");
			}
			if (player.findPerk(PerkLib.PrestigeJobGreySage) < 0) {
				player.createPerk(PerkLib.PrestigeJobGreySage, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Prestige Job: Grey Sage!)</b>");
			}
			if (player.findPerk(PerkLib.PrestigeJobSpellKnight) < 0) {
				player.createPerk(PerkLib.PrestigeJobSpellKnight, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Prestige Job: Spell Knight!)</b>");
			}
			if (player.findPerk(PerkLib.PrestigeJobWarlock) < 0) {
				player.createPerk(PerkLib.PrestigeJobWarlock, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Prestige Job: Warlock!)</b>");
			}
			if (player.findPerk(PerkLib.PiercedCrimstone) < 0) {
				player.createPerk(PerkLib.PiercedCrimstone, 5, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Pierced: Crimstone!)</b>");
			}
			if (player.findPerk(PerkLib.PiercedFertite) < 0) {
				player.createPerk(PerkLib.PiercedFertite, 5, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Pierced: Fertite!)</b>");
			}
			if (player.findPerk(PerkLib.PiercedFurrite) < 0) {
				player.createPerk(PerkLib.PiercedFurrite, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Pierced: Furrite!)</b>");
			}
			if (player.findPerk(PerkLib.PiercedLethite) < 0) {
				player.createPerk(PerkLib.PiercedLethite, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Pierced: Lethite!)</b>");
			}
			if (player.findPerk(PerkLib.BroodMother) < 0) {
				player.createPerk(PerkLib.BroodMother, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Brood Mother!)</b>");
			}
			if (player.findPerk(PerkLib.Androgyny) < 0) {
				player.createPerk(PerkLib.Androgyny, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Androgyny!)</b>");
			}
			if (player.findPerk(PerkLib.BasiliskWomb) < 0) {
				player.createPerk(PerkLib.BasiliskWomb, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Basilisk Womb!)</b>");
			}
			if (player.findPerk(PerkLib.BunnyEggs) < 0) {
				player.createPerk(PerkLib.BunnyEggs, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Bunny Eggs!)</b>");
			}
			if (player.findPerk(PerkLib.DeityJobMunchkin) < 0) {
				player.createPerk(PerkLib.DeityJobMunchkin, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Deity Job: Munchkin!)</b>");
			}
			if (player.findPerk(PerkLib.Diapause) < 0) {
				player.createPerk(PerkLib.Diapause, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Diapause!)</b>");
			}
			if (player.findPerk(PerkLib.Feeder) < 0) {
				player.createPerk(PerkLib.Feeder, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Feeder!)</b>");
			}
			if (player.findPerk(PerkLib.HarpyWomb) < 0) {
				player.createPerk(PerkLib.HarpyWomb, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Harpy Womb!)</b>");
			}
			if (player.findPerk(PerkLib.ImprovedVenomGland) < 0) {
				player.createPerk(PerkLib.ImprovedVenomGland, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Improved Venom Gland!)</b>");
			}
			if (player.findPerk(PerkLib.MinotaurCumResistance) < 0) {
				player.createPerk(PerkLib.MinotaurCumResistance, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Minotaur Cum Resistance!)</b>");
			}
			if (player.findPerk(PerkLib.BasiliskResistance) < 0) {
				player.createPerk(PerkLib.BasiliskResistance, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Basilisk Resistance!)</b>");
			}
			if (player.findPerk(PerkLib.Cornucopia) < 0) {
				player.createPerk(PerkLib.Cornucopia, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Cornucopia!)</b>");
			}
			if (player.findPerk(PerkLib.DemonicLethicite) < 0) {
				player.createPerk(PerkLib.DemonicLethicite, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Demonic Lethicite!)</b>");
			}
			if (player.findPerk(PerkLib.DemonSlayer) < 0) {
				player.createPerk(PerkLib.DemonSlayer, 0.1, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Demon Slayer!)</b>");
			}
			if (player.findPerk(PerkLib.ElvenBounty) < 0) {
				player.createPerk(PerkLib.ElvenBounty, 0, 15, 0, 0);
				outputText("\n\n<b>(Gained Perk: Elven Bounty!)</b>");
			}
			if (player.findPerk(PerkLib.FeralHunter) < 0) {
				player.createPerk(PerkLib.FeralHunter, 0.1, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Feral Hunter!)</b>");
			}
			if (player.findPerk(PerkLib.MarbleResistant) < 0) {
				player.createPerk(PerkLib.MarbleResistant, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Marble Resistant!)</b>");
			}
			if (player.findPerk(PerkLib.Misdirection) < 0) {
				player.createPerk(PerkLib.Misdirection, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Misdirection!)</b>");
			}
			if (player.findPerk(PerkLib.OmnibusGift) < 0) {
				player.createPerk(PerkLib.OmnibusGift, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Omnibus Gift!)</b>");
			}
			if (player.findPerk(PerkLib.PilgrimsBounty) < 0) {
				player.createPerk(PerkLib.PilgrimsBounty, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Pilgrims Bounty!)</b>");
			}
			if (player.findPerk(PerkLib.ProductivityDrugs) < 0) {
				player.createPerk(PerkLib.ProductivityDrugs,player.cor,10,player.lib,0);
				outputText("\n\n<b>(Gained Perk: Productivity Drugs!)</b>");
			}
			if (player.findPerk(PerkLib.SenseCorruption) < 0) {
				player.createPerk(PerkLib.SenseCorruption, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Sense Corruption!)</b>");
			}
			if (player.findPerk(PerkLib.SenseWrath) < 0) {
				player.createPerk(PerkLib.SenseWrath, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Sense Wrath!)</b>");
			}
			if (player.findPerk(PerkLib.Whispered) < 0) {
				player.createPerk(PerkLib.Whispered, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Whispered!)</b>");
			}
			if (player.findPerk(PerkLib.ControlledBreath) < 0) {
				player.createPerk(PerkLib.ControlledBreath, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Controlled Breath!)</b>");
			}
			if (player.findPerk(PerkLib.CleansingPalm) < 0) {
				player.createPerk(PerkLib.CleansingPalm, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Cleansing Palm!)</b>");
			}
			if (player.findPerk(PerkLib.Enlightened) < 0) {
				player.createPerk(PerkLib.Enlightened, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: Enlightened!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryAlchemist) < 0 && player.findPerk(PerkLib.PastLifeAlchemist) < 0) {
				player.createPerk(PerkLib.HistoryAlchemist, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Alchemist!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryCultivator) < 0 && player.findPerk(PerkLib.PastLifeCultivator) < 0) {
				player.createPerk(PerkLib.HistoryCultivator, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Cultivator!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryFighter) < 0 && player.findPerk(PerkLib.PastLifeFighter) < 0) {
				player.createPerk(PerkLib.HistoryFighter, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Fighter!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryFortune) < 0 && player.findPerk(PerkLib.PastLifeFortune) < 0) {
				player.createPerk(PerkLib.HistoryFortune, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Fortune!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryHealer) < 0 && player.findPerk(PerkLib.PastLifeHealer) < 0) {
				player.createPerk(PerkLib.HistoryHealer, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Healer!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryReligious) < 0 && player.findPerk(PerkLib.PastLifeReligious) < 0) {
				player.createPerk(PerkLib.HistoryReligious, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Religious!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryScholar) < 0 && player.findPerk(PerkLib.PastLifeScholar) < 0) {
				player.createPerk(PerkLib.HistoryScholar, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Scholar!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryScout) < 0 && player.findPerk(PerkLib.PastLifeScout) < 0) {
				player.createPerk(PerkLib.HistoryScout, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Scout!)</b>");
			}
			if (player.findPerk(PerkLib.HistorySlacker) < 0 && player.findPerk(PerkLib.PastLifeSlacker) < 0) {
				player.createPerk(PerkLib.HistorySlacker, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Slacker!)</b>");
			}
			if (player.findPerk(PerkLib.HistorySlut) < 0 && player.findPerk(PerkLib.PastLifeSlut) < 0) {
				player.createPerk(PerkLib.HistorySlut, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Slut!)</b>");
			}
			if (player.findPerk(PerkLib.HistorySmith) < 0 && player.findPerk(PerkLib.PastLifeSmith) < 0) {
				player.createPerk(PerkLib.HistorySmith, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Smith!)</b>");
			}
			if (player.findPerk(PerkLib.HistoryWhore) < 0 && player.findPerk(PerkLib.PastLifeWhore) < 0) {
				player.createPerk(PerkLib.HistoryWhore, 0, 0, 0, 0);
				outputText("\n\n<b>(Gained Perk: History: Whore!)</b>");
			}
			doNext(SoulforceCheats);
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
			addButton(10, "Tone/Thicc/Fem", StatsMenuToneThicknessFeminity).hint("Adj Tone/Thickness/Feminity.");
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
			addButton(4, "Str Up 5", AddStr5).hint("Add 1000 to Str.");
			addButton(9, "Str Down 5", SubStr5).hint("Substract 1000 from Str.");
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
			addButton(4, "Tou Up 5", AddTou5).hint("Add 1000 to Tou.");
			addButton(9, "Tou Down 5", SubTou5).hint("Substract 1000 from Tou.");
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
			addButton(4, "Spe Up 5", AddSpe5).hint("Add 1000 to Spe.");
			addButton(9, "Spe Down 5", SubSpe5).hint("Substract 1000 from Spe.");
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
			addButton(4, "Inte Up 5", AddInte5).hint("Add 1000 to Inte.");
			addButton(9, "Inte Down 5", SubInte5).hint("Substract 1000 from Inte.");
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
			addButton(4, "Wis Up 5", AddWis5).hint("Add 1000 to Wis.");
			addButton(9, "Wis Down 5", SubWis5).hint("Substract 1000 from Wis.");
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
			addButton(4, "Lib Up 5", AddLib5).hint("Add 1000 to Lib.");
			addButton(9, "Lib Down 5", SubLib5).hint("Substract 1000 from Lib.");
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
			addButton(4, "Sens Up 5", AddSens5).hint("Add 1000 to Sens.");
			addButton(9, "Sens Down 5", SubSens5).hint("Substract 1000 from Sens.");
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
		public function StatsMenuToneThicknessFeminity():void {
			menu();
			addButton(0, "Tone Up 1", AddTone1).hint("Add 1 to Tone.");
			addButton(2, "Tone Down 1", SubTone1).hint("Substract 1 from Tone.");
			addButton(1, "Tone Up 2", AddTone2).hint("Add 10 to Tone.");
			addButton(3, "Tone Down 2", SubTone2).hint("Substract 10 from Tone.");
			addButton(5, "Thickness Up 1", AddThickness1).hint("Add 1 to Thickness.");
			addButton(7, "Thickness Down 1", SubThickness1).hint("Substract 1 from Thickness.");
			addButton(6, "Thickness Up 2", AddThickness2).hint("Add 10 to Thickness.");
			addButton(8, "Thickness Down 2", SubThickness2).hint("Substract 10 from Thickness.");
			addButton(10, "Feminity Up 1", AddFeminity1).hint("Add 1 to Feminity.");
			addButton(12, "Feminity Down 1", SubFeminity1).hint("Substract 1 from Feminity.");
			addButton(11, "Feminity Up 2", AddFeminity2).hint("Add 10 to Feminity.");
			addButton(13, "Feminity Down 2", SubFeminity2).hint("Substract 10 from Feminity.");
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
			if (player.level < CoC.instance.levelCap) addButton(12, "Add 1 LvL", AddLvL1).hint("Add 1 Level (with stat and perk points).");
			if (player.level < CoC.instance.levelCap - 9) addButton(13, "Add 10 LvL's", AddLvL2).hint("Add 10 Levels (with stat and perk points).");
			addButton(14, "Back", SoulforceCheats);
		}
		public function BodyStateMenu():void {
			menu();
			addButton(0, "Height U1", AddTallness1).hint("Add 2 to Height.");
			addButton(2, "Height D1", SubTallness1).hint("Substract 2 from Height.");
			addButton(1, "Height U2", AddTallness2).hint("Add 12 to Height.");
			addButton(3, "Height D2", SubTallness2).hint("Substract 12 from Height.");
			addButton(4, "Hair L. Up", AddHairLength).hint("Add 2 to Hair Length.");
			addButton(9, "Hair L. Down", SubHairLength).hint("Substract 2 from Hair Length.");
			addButton(5, "Cup Up", AddCupSize).hint("Add 1 to Cup Size.");
			addButton(6, "Cup Down", SubCupSize).hint("Substract 1 from Cup Size.");
			addButton(7, "Cock Up", AddCockLength).hint("Add 1 to Cock Length.");
			addButton(8, "Cock Down", SubCockLength).hint("Substract 1 from Cock Length.");
			addButton(10, "Add Pussy", AddPussy).hint("Add Vagina.");
			addButton(11, "Rem Pussy", RemovePussy).hint("Remove Vagina.");
			addButton(12, "Add C+B", AddCockBalls).hint("Add Cock+Balls.");
			addButton(13, "Rem C+B", RemoveCockBalls).hint("Remove Cock+Balls.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function AddTallness1():void {
			player.tallness += 2;
			if (player.tallness >= 132) player.tallness = 132;
			BodyStateMenu();
		}
		public function AddTallness2():void {
			player.tallness += 12;
			if (player.tallness >= 132) player.tallness = 132;
			BodyStateMenu();
		}
		public function AddHairLength():void {
			player.hairLength += 2;
			BodyStateMenu();
		}
		public function AddCupSize():void {
			var growth:int = 1;
			if (player.breastRows[0].breastRating < 2) growth++;
			player.growTits(growth, player.breastRows.length, true, 3);
			BodyStateMenu();
		}
		public function AddCockLength():void {
			player.lengthChange(1, 1);
			BodyStateMenu();
		}
		public function AddPussy():void {
			player.createVagina();
			player.vaginas[0].vaginalLooseness = VaginaClass.LOOSENESS_TIGHT;
			player.vaginas[0].vaginalWetness = VaginaClass.WETNESS_NORMAL;
			player.vaginas[0].virgin = true;
			player.clitLength = .25;
			if (player.fertility <= 5) player.fertility = 6;
			BodyStateMenu();
		}
		public function AddCockBalls():void {
			player.createCock();
			player.cocks[0].cockLength = 4;
			player.cocks[0].cockThickness = 1;
			player.cocks[0].cockType = CockTypesEnum.HUMAN;
			player.clitLength = .25;
			if (player.balls <= 1) {
				player.balls = 2;
				player.ballSize = 1;
			}
			BodyStateMenu();
		}
		public function SubTallness1():void {
			player.tallness -= 2;
			if (player.tallness < 42) player.tallness = 42;
			BodyStateMenu();
		}
		public function SubTallness2():void {
			player.tallness -= 12;
			if (player.tallness < 42) player.tallness = 42;
			BodyStateMenu();
		}
		public function SubHairLength():void {
			player.hairLength -= 2;
			if (player.hairLength < 0) player.hairLength = 0;
			BodyStateMenu();
		}
		public function SubCupSize():void {
			if (player.breastRows[0].breastRating >= 1) player.breastRows[0].breastRating--;
			BodyStateMenu();
		}
		public function SubCockLength():void {
			var index:int = 0;
			player.lengthChange(-1, 1);
			if (player.cocks[index].cockLength < 2) {
				outputText("  ");
				player.killCocks(1);
			}
			BodyStateMenu();
		}
		public function RemovePussy():void {
			player.removeVagina(0, 1);
			player.clitLength = .25;
			BodyStateMenu();
		}
		public function RemoveCockBalls():void {
			player.killCocks(1);
			if (player.balls > 1) {
				player.balls = 0;
				player.ballSize = 0;
			}
			BodyStateMenu();
		}
		
				/*if (player.breastRows.length == 0) {
					outputText("A perfect pair of B cup breasts, complete with tiny nipples, form on your chest.");
					player.createBreastRow();
					player.breastRows[0].breasts = 2;
					//player.breastRows[0].breastsPerRow = 2;
					player.breastRows[0].nipplesPerBreast = 1;
					player.breastRows[0].breastRating = 2;
					outputText("\n");
				}
			}*/
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
			addButton(2, "Ascensus", AddTheStaffs).hint("Add set of items for Ascensus.");
			addButton(3, "Evelyn", AddTheEvelyn).hint("Add 1 Evelyn Crossbow.");
			addButton(4, "DualLAxes", AddDualMinoAxes).hint("Add 1 pair of Large Axes.");
			addButton(5, "NineTailWhip", AddNineTailWhip).hint("Add 1 Nine Tail Whip.");
			addButton(6, "CatONIneTWhip", AddCatONineTailWhip).hint("Add 1 Bastet Whip.");
			addButton(7, "L Ayo Arm", AddLightAyoArmor).hint("Add 1 Light Ayo Armor for testing purposes.");
			addButton(8, "HBA Armor", AddHBAArmor).hint("Add 1 HBA Armor for testing purposes.");
			addButton(9, "YODrops", AddYukiOnnaStuff).hint("Add both Yuki Onna equipment drops for testing purposes.");
			addButton(11, "GobMechPrime", AddGoblinMechPrime).hint("Add 1 Goblin Mech Prime for testing purposes.");
			addButton(12, "MatrixArmory1", AddTheSeerHairpinAndCo).hint("Adds: 1 Eldritch Staff, 1 master Gloves, 1 Gnoll Throwing Axes, 1 Hodr's Bow, 1 Truestrike Sword, 1 Sceptre of Command, 1 Demonic Scythe, 1 Seer's Hairpin, Sakura Petal Kimono, Oni bead necklace");
			addButton(13, "InqTome", AddTheInquisitorsTome).hint("Add 1 Inquisitor's Tome.");
			addButton(14, "Back", SoulforceCheats);
		}
		public function NonEquipmentMenu(page:int = 1):void {
			menu();
			if (page == 1) {
				addButton(0, "Fox Jewel", AddFoxJewel).hint("Add 1 Fox Jewel.");
				//addButton(1, "", ).hint("Add 1 .");
				//addButton(2, "", ).hint("Add 1 .");
				//addButton(3, "", ).hint("Add 1 .");
				//addButton(4, "AbyssalInk", "Not yet ready for test and just for future use put here already ^^ (Add 1 Abyssal Ink.)");
				addButton(5, "D.Fruit", AddDisplacerFruit).hint("Add 1 Displacer Fruit.");
				addButton(6, "SBMan", AddSoulBlastManual).hint("Add 1 Soul Blast manual.");
				addButton(7, "V.D.ARC", AddVeryDilutedArcaneRegenConcotion).hint("Add 1 very diluted Arcane Regen Concotion.");
				addButton(8, "D.ARC", AddDilutedArcaneRegenConcotion).hint("Add 1 diluted Arcane Regen Concotion.");
				addButton(9, "A.R.CON", AddArcaneRegenConcotion).hint("Add 1 Arcane Regen Concotion.");
				addButton(10, "White B.", AddWhiteBook).hint("Add 1 White Book.");
				addButton(11, "Black B.", AddBlackBook).hint("Add 1 Black Book.");
				addButton(12, "Grey B.", AddGreyBook).hint("Add 1 Grey Book.");
				addButton(13, "-2-", NonEquipmentMenu, page + 1);
				addButton(14, "Back", SoulforceCheats);
			}
			if (page == 2) {
				addButton(0, "SkybornSeed", AddSkybornSeed).hint("Add 1 Skyborn Seed.");
				addButton(1, "F.Fish", AddFreshFish).hint("Add 1 Fresh Fish.");
				addButton(2, "BehemothCum", AddBehemothCum).hint("Add 1 bottle of Behemoth Cum.");
				//addButton(3, "", ).hint("Add 1 .");
				addButton(4, "WhiteIceS.", AddWhiteIceShard).hint("White Ice Shard");
				addButton(5, "Enigmanium", AddEnigmanium).hint("Add 1 vial of Enigmanium.");
				addButton(6, "Skelp", AddSkelp).hint("Add 1 Skelp (WIP Melkie TF).");
				addButton(7, "Naga Oils", AddGorgonOil).hint("Add 1 vial of Gorgon, Vouivre and Couatl Oil.");
				addButton(8, "VT RV WF", AddVoltageTopaz).hint("Add 1 Voltage Topaz, 1 vial of Red Blood (Bat TF) and 1 Wonder Fruit.");
				addButton(9, "DSJ HS FSS", AddDarkSlimeJelly).hint("Add 1 Dark Slime Jelly, 1 Hydra Scale and 1 Fire Snail Saliva.");
				//addButton(10, "", ).hint("Add 1 .");
				//addButton(11, "", ).hint("Add 1 .");
				if (player.findPerk(PerkLib.ElementalConjurerMindAndBodySacrifice) < 0) addButton(12, "E.Pearls", AddThePearls).hint("Add all three Elemental Pearls.");
				addButton(13, "-1-", NonEquipmentMenu, page - 1);
				addButton(14, "Back", SoulforceCheats);
			}
		}
		public function MaterialMenu(page:int = 1):void {
			menu();
			if (page == 1) {
				addButton(0, "Wood", AddWood).hint("Add 100 Wood (game not check for limits so not go overboard with using this cheat).");
				addButton(1, "Nails", AddNail).hint("Add 50 Nails (game not check for limits so not go overboard with using this cheat).");
				addButton(2, "Stone", AddStone).hint("Add 100 Stone (game not check for limits so not go overboard with using this cheat).");
				addButton(3, "MetalPieces", AddMetalPieces).hint("Add 50 Metal Pieces (game not check for limits so not go overboard with using this cheat).");
				addButton(4, "SpiderSilk", AddSpiderSilk).hint("Add 1 Spider Silk.");
				addButton(5, "Ebonbloom", AddEbonbloom).hint("Add 1 Ebonbloom.");
				addButton(6, "WorldTreeB.", AddWorldTreeBranch).hint("Add 1 World Tree Branch.");
				addButton(7, "ChitinShard", AddBeeChitin).hint("Add 1 Chitin shard.");
				addButton(8, "GreenGel", AddGreenGel).hint("Add 1 Green Gel.");
				addButton(9, "DragonScale", AddDragonscale).hint("Add 1 Dragonscale.");
				//addButton(10, "", ).hint("Add 1 .");
				//addButton(11, "", ).hint("Add 1 .");
				//addButton(12, "", ).hint("Add 1 .");
				addButton(13, "-2-", MaterialMenu, page + 1);
				addButton(14, "Back", SoulforceCheats);
			}
			if (page == 2) {
				//addButton(0, "", ).hint("Add 1 .");
				//addButton(1, "", ).hint("Add 1 .");
				//addButton(2, "", ).hint("Add 1 .");
				//addButton(3, "", ).hint("Add 1 .");
				//addButton(4, "", ).hint("Add 1 .");
				addButton(5, "Mechanism", AddMechanism).hint("Add 1 Mechanism.");
				//addButton(6, "", ).hint("Add 1 .");
				//addButton(7, "", ).hint("Add 1 .");
				//addButton(8, "", ).hint("Add 1 .");
				addButton(9, "F.Imp S.", AddFeralImpSkull).hint("Add 1 Feral Imp Skull.");
				addButton(10, "EnergyCore", AddEnergyCore).hint("Add 1 Energy Core.");
				addButton(11, "MetShoTom", AddMeteorShowerTome).hint("Add 1 Meteor Shower tome.");
				addButton(12, "PolMidScr", AddPolarMidnightScroll).hint("Add 1 Polar Midnight scroll.");
				addButton(13, "-1-", MaterialMenu, page - 1);
				addButton(14, "Back", SoulforceCheats);
			}
		}
		public function EnemiesMenu(page:int = 1):void {
			menu();
			if (page == 1) {
				addButton(0, "FightForPearl", FightForPearl).hint("Test fight to get Sky Poison Pearl legally (aside we cheat to start fight)");
				addButton(1, "Marae", FightMarae).hint("Test fight with Marae (depending on game stage she can be buffed or unbuffed).");
				addButton(2, "Pierce", FightPierce).hint("Test fight with Pierce.");
				//addButton(3, "", ).hint("Test fight with .");
				//addButton(4, "", ).hint("Test fight with .");
				//addButton(5, "", ).hint("Test fight with .");
				//addButton(6, "", ).hint("Test fight with .");
				//addButton(7, "", ).hint("Test fight with .");
				addButton(8, "Sonya", FightSonya).hint("Test fight with Sonya.");
				addButton(9, "RyuBi", FightRyuBi).hint("Test fight with RyuBi.");
				addButton(10, "LvLUP Eva", LvLUPEva).hint("LvL UP forcefully Evangeline for testing purpose up to the limit.");
				addButton(11, "DELvL Eva", DELvLEva).hint("DE LvL forcefully Evangeline for testing purpose down toward the lvl 12.");
				addButton(12, "FeralT.Beast", FightFeralBeast).hint("Test fight with feral tentacle beast.");
				addButton(13, "-2-", EnemiesMenu, page + 1);
				addButton(14, "Back", SoulforceCheats);
			}
			if (page == 2)  {
				addButton(0, "DarkSlimeEmpress", FightDarkSlimeEmpress).hint("Test fight with Dark Slime Empress.");
				addButton(1, "Hydra", FightHydra).hint("Test fight with Hydra.");
				addButton(2, "HellfireSnail", FightHellfireSnail).hint("Test fight with Hellfire Snail.");
				addButton(3, "ChaosChimera", FightChaosChimera).hint("Test fight with Chaos Chimera.");
				//addButton(4, "", ).hint("Test fight with .");
				//addButton(5, "", ).hint("Test fight with .");
				addButton(6, "Aria", FightAria).hint("Test fight with melkie huntress Aria.");
				addButton(7, "Neisa", FightNeisa).hint("Test fight with Neisa.");
				addButton(8, "SomeMalikore", FightRandomnMalikore).hint("Test fight with some malikore.");
				addButton(9, "Lethice", FightLethice).hint("Test fight with Lethice.");
				addButton(10, "LvLUP Aurora", LvLUPAurora).hint("LvL UP forcefully Aurora for testing purpose up to the limit.");
				addButton(11, "DELvL Aurora", DELvLAurora).hint("DE LvL forcefully Aurora for testing purpose down toward the lvl 1.");
				addButton(12, "Alvina", FightAlvina).hint("Test fight with Alvina.");
				addButton(13, "-1-", EnemiesMenu, page - 1);
				addButton(14, "Back", SoulforceCheats);
			}
		}
		
		public function AddEnergyCore():void {
			outputText("\n\n<b>(Gained 1 Energy Core!)</b>\n\n");
			inventory.takeItem(useables.ENECORE, curry(MaterialMenu, 2));
		}
		public function AddMechanism():void {
			outputText("\n\n<b>(Gained 1 Mechanism!)</b>\n\n");
			inventory.takeItem(useables.MECHANI, curry(MaterialMenu, 2));
		}
		public function AddMetalPieces():void {
			outputText("\n\n<b>(Gained 50 Metal Pieces!)</b>\n\n");
			flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] += 50;
			statScreenRefresh();
			curry(MaterialMenu, 1);
		}
		public function AddPolarMidnightScroll():void {
			outputText("\n\n<b>(Gained 1 Polar Midnight scroll!)</b>\n\n");
			inventory.takeItem(consumables.POL_MID, curry(MaterialMenu, 2));
		}
		public function AddMeteorShowerTome():void {
			outputText("\n\n<b>(Gained 1 Meteor Shower tome!)</b>\n\n");
			inventory.takeItem(consumables.MET_SHO, curry(MaterialMenu, 2));
		}
		public function AddFeralImpSkull():void {
			outputText("\n\n<b>(Gained 1 Feral Imp Skull!)</b>\n\n");
			inventory.takeItem(useables.FIMPSKL, curry(MaterialMenu, 2));
		}
		public function AddSpiderSilk():void {
			outputText("\n\n<b>(Gained 1 Spider Silk!)</b>\n\n");
			inventory.takeItem(useables.T_SSILK, curry(MaterialMenu, 1));
		}
		public function AddBeeChitin():void {
			outputText("\n\n<b>(Gained 1 Chitin Shard!)</b>\n\n");
			inventory.takeItem(useables.B_CHITN, curry(MaterialMenu, 1));
		}
		public function AddGreenGel():void {
			outputText("\n\n<b>(Gained 1 Green Gel!)</b>\n\n");
			inventory.takeItem(useables.GREENGL, curry(MaterialMenu, 1));
		}
		public function AddDragonscale():void {
			outputText("\n\n<b>(Gained 1 Dragonscale!)</b>\n\n");
			inventory.takeItem(useables.D_SCALE, curry(MaterialMenu, 1));
		}
		public function AddFreshFish():void {
			outputText("\n\n<b>(Gained 1 Fresh Fish!)</b>\n\n");
			inventory.takeItem(consumables.FREFISH, curry(NonEquipmentMenu, 2));
		}
		public function AddFoxJewel():void {
			outputText("\n\n<b>(Gained 1 Fox Jewel!)</b>\n\n");
			inventory.takeItem(consumables.FOXJEWL, curry(NonEquipmentMenu, 1));
		}
		public function AddVoltageTopaz():void {
			outputText("\n\n<b>(Gained 1 Voltage Topaz!)</b>\n\n");
			inventory.takeItem(consumables.VOLTTOP, AddRedBlood);
		}
		public function AddRedBlood():void {
			outputText("\n\n<b>(Gained 1 vial of red blood!)</b>\n\n");
			inventory.takeItem(consumables.REDVIAL, AddWonderFruit);
		}
		public function AddWonderFruit():void {
			outputText("\n\n<b>(Gained 1 Wonder Fruit!)</b>\n\n");
			inventory.takeItem(consumables.WOFRUIT, curry(NonEquipmentMenu, 2));
		}
		public function AddDarkSlimeJelly():void {
			outputText("\n\n<b>(Gained 1 Dark Slime Jelly!)</b>\n\n");
			inventory.takeItem(consumables.DSLIMEJ, AddHydraScale);
		}
		public function AddHydraScale():void {
			outputText("\n\n<b>(Gained 1 Hydra Scale!)</b>\n\n");
			inventory.takeItem(consumables.HYDRASC, AddFireSnailSaliva);
		}
		public function AddFireSnailSaliva():void {
			outputText("\n\n<b>(Gained 1 Fire Snail Saliva!)</b>\n\n");
			inventory.takeItem(consumables.FSNAILS, curry(NonEquipmentMenu, 2));
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
			inventory.takeItem(consumables.COUAOIL, curry(NonEquipmentMenu, 2));
		}
		public function AddEnigmanium():void {
			outputText("\n\n<b>(Gained 1 vial of Enigmanium!)</b>\n\n");
			inventory.takeItem(consumables.ENIGMANIUM, curry(NonEquipmentMenu, 2));
		}
		public function AddSkelp():void {
			outputText("\n\n<b>(Gained 1 Skelp!)</b>\n\n");
			inventory.takeItem(consumables.SKELP__, curry(NonEquipmentMenu, 2));
		}
		public function AddWhiteIceShard():void {
			outputText("\n\n<b>(Gained 1 White Ice Shard!)</b>\n\n");
			inventory.takeItem(consumables.WHITEIS, SoulforceCheats);
		}
		public function AddVeryDilutedArcaneRegenConcotion():void {
			outputText("\n\n<b>(Gained 1 very diluted Arcane Regen Concotion!)</b>\n\n");
			inventory.takeItem(consumables.VDARCON, curry(NonEquipmentMenu, 1));
		}
		public function AddDilutedArcaneRegenConcotion():void {
			outputText("\n\n<b>(Gained 1 diluted Arcane Regen Concotion!)</b>\n\n");
			inventory.takeItem(consumables.D_ARCON, curry(NonEquipmentMenu, 1));
		}
		public function AddArcaneRegenConcotion():void {
			outputText("\n\n<b>(Gained 1 Arcane Regen Concotion!)</b>\n\n");
			inventory.takeItem(consumables.AREGCON, curry(NonEquipmentMenu, 1));
		}
		public function AddSoulBlastManual():void {
			outputText("\n\n<b>(Gained 1 Soul Blast Manual!)</b>\n\n");
			inventory.takeItem(consumables.SOBLMAN, curry(NonEquipmentMenu, 1));
		}
		public function AddDisplacerFruit():void {
			outputText("\n\n<b>(Gained 1 Displacer Fruit!)</b>\n\n");
			inventory.takeItem(consumables.D_FRUIT, curry(NonEquipmentMenu, 1));
		}
		public function AddSkybornSeed():void {
			outputText("\n\n<b>(Gained 1 Skyborn Seed!)</b>\n\n");
			inventory.takeItem(consumables.SKYSEED, curry(NonEquipmentMenu, 2));
		}
		public function AddBehemothCum():void {
			outputText("\n\n<b>(Gained 1 vial of Behemoth Cum!)</b>\n\n");
			inventory.takeItem(consumables.BHMTCUM, curry(NonEquipmentMenu, 2));
		}
		public function AddEbonbloom():void {
			outputText("\n\n<b>(Gained 1 Ebonbloom!)</b>\n\n");
			inventory.takeItem(useables.EBONBLO, curry(MaterialMenu, 1));
		}
		public function AddWorldTreeBranch():void {
			outputText("\n\n<b>(Gained 1 Wold Tree branch!)</b>\n\n");
			inventory.takeItem(useables.WT_BRAN, curry(MaterialMenu, 1));
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
		public function AddTheSeerHairpinAndCo():void {
			outputText("\n\n<b>(Gained 1 Eldritch Staff!)</b>\n\n");
			inventory.takeItem(weapons.E_STAFF, AddTheSeerHairpinAndCo1);
		}
		public function AddTheSeerHairpinAndCo1():void {
			outputText("\n\n<b>(Gained 1 Master Gloves!)</b>\n\n");
			inventory.takeItem(weapons.MASTGLO, AddTheSeerHairpinAndCo2);
		}
		public function AddTheSeerHairpinAndCo2():void {
			outputText("\n\n<b>(Gained 1 Gnoll Throwing Axes!)</b>\n\n");
			inventory.takeItem(weaponsrange.GTHRAXE, AddTheSeerHairpinAndCo3);
		}
		public function AddTheSeerHairpinAndCo3():void {
			outputText("\n\n<b>(Gained 1 Hodr's Bow!)</b>\n\n");
			inventory.takeItem(weaponsrange.BOWHODR, AddTheSeerHairpinAndCo4);
		}
		public function AddTheSeerHairpinAndCo4():void {
			outputText("\n\n<b>(Gained 1 Sceptre of Command!)</b>\n\n");
			inventory.takeItem(weapons.SCECOMM, AddTheSeerHairpinAndCo5);
		}
		public function AddTheSeerHairpinAndCo5():void {
			outputText("\n\n<b>(Gained 1 Truestrike Sword!)</b>\n\n");
			inventory.takeItem(weapons.TRSTSWO, AddTheSeerHairpinAndCo6);
		}
		public function AddTheSeerHairpinAndCo6():void {
			outputText("\n\n<b>(Gained 1 Demonic Scythe!)</b>\n\n");
			inventory.takeItem(weapons.DEMSCYT, AddTheSeerHairpinAndCo7);
		}
		public function AddTheSeerHairpinAndCo7():void {
			outputText("\n\n<b>(Gained 1 Seer's Hairpin!)</b>\n\n");
			inventory.takeItem(headjewelries.SEERPIN, AddTheSeerHairpinAndCo8);
		}
		public function AddTheSeerHairpinAndCo8():void {
			outputText("\n\n<b>(Gained 1 Sakura Petal Kimono!)</b>\n\n");
			inventory.takeItem(armors.SPKIMO, AddTheSeerHairpinAndCo9);
		}
		public function AddTheSeerHairpinAndCo9():void {
			outputText("\n\n<b>(Gained 1 Oni bead necklace!)</b>\n\n");
			inventory.takeItem(necklaces.OBNECK, EquipmentMenu);
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
		public function AddStr5():void {
			player.str = player.str + 1000;
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
		public function AddTou5():void {
			player.tou = player.tou + 1000;
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
		public function AddSpe5():void {
			player.spe = player.spe + 1000;
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
		public function AddInte5():void {
			player.inte = player.inte + 1000;
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
		public function AddWis5():void {
			player.wis = player.wis + 1000;
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
		public function AddLib5():void {
			player.lib = player.lib + 1000;
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
		public function AddSens5():void {
			player.sens = player.sens + 1000;
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
			StatsMenuToneThicknessFeminity();
		}
		public function AddTone2():void {
			player.tone = player.tone + 10;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function AddThickness1():void {
			player.thickness = player.thickness + 1;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function AddThickness2():void {
			player.thickness = player.thickness + 10;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function AddFeminity1():void {
			player.femininity = player.femininity + 1;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function AddFeminity2():void {
			player.femininity = player.femininity + 10;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
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
		public function SubStr5():void {
			player.str = player.str - 1000;
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
		public function SubTou5():void {
			player.tou = player.tou - 1000;
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
		public function SubSpe5():void {
			player.spe = player.spe - 1000;
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
		public function SubInte5():void {
			player.inte = player.inte - 1000;
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
		public function SubWis5():void {
			player.wis = player.wis - 1000;
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
		public function SubLib5():void {
			player.lib = player.lib - 1000;
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
		public function SubSens5():void {
			player.sens = player.sens - 1000;
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
			StatsMenuToneThicknessFeminity();
		}
		public function SubTone2():void {
			player.tone = player.tone - 10;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function SubThickness1():void {
			player.thickness = player.thickness - 1;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function SubThickness2():void {
			player.thickness = player.thickness - 10;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function SubFeminity1():void {
			player.femininity = player.femininity - 1;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
		}
		public function SubFeminity2():void {
			player.femininity = player.femininity - 10;
			statScreenRefresh();
			StatsMenuToneThicknessFeminity();
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
		public function AddHBAArmor():void {
			outputText("\n\n<b>(Gained 1 HBA Armor!)</b>\n\n");
			inventory.takeItem(armors.HBA_ARM, EquipmentMenu);
		}
		public function AddYukiOnnaStuff():void {
			outputText("\n\n<b>(Gained 1st Yuki Onna item!)</b>\n\n");
			inventory.takeItem(armors.BLIZZ_K, AddYukiOnnaStuff2);
		}
		public function AddYukiOnnaStuff2():void {
			outputText("\n\n<b>(Gained 2nd Yuki Onna item!)</b>\n\n");
			inventory.takeItem(headjewelries.SNOWFH, EquipmentMenu);
		}
		public function AddGoblinMechPrime():void {
			outputText("\n\n<b>(Gained 1 Goblin Mech Prime!)</b>\n\n");
			inventory.takeItem(vehicles.GOBMPRI, EquipmentMenu);
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
			inventory.takeItem(consumables.W__BOOK, curry(NonEquipmentMenu, 1));
		}
		public function AddBlackBook():void {
			outputText("\n\n<b>(Gained 1 Black Book!)</b>\n\n");
			inventory.takeItem(consumables.B__BOOK, curry(NonEquipmentMenu, 1));
		}
		public function AddGreyBook():void {
			outputText("\n\n<b>(Gained 1 Grey Book!)</b>\n\n");
			inventory.takeItem(consumables.G__BOOK, curry(NonEquipmentMenu, 1));
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
			inventory.takeItem(consumables.E7PEARL, curry(NonEquipmentMenu, 2));
		}
		public function AddWood():void {
			outputText("\n\n<b>(Gained 100 Wood!)</b>");
			flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] += 100;
			statScreenRefresh();
			curry(MaterialMenu, 1);
		}
		public function AddNail():void {
			outputText("\n\n<b>(Gained 50 Nails!)</b>");
			flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] += 50;
			statScreenRefresh();
			curry(MaterialMenu, 1);
		}
		public function AddStone():void {
			outputText("\n\n<b>(Gained 100 Stones!)</b>");
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 100;
			statScreenRefresh();
			curry(MaterialMenu, 1);
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
		public function FightPierce():void {
			clearOutput();
			outputText("Entering battle with Pierce! Enjoy ^^");
			startCombat(new Pierce());
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
		public function FightRandomnMalikore():void {
			clearOutput();
			outputText("Entering battle with some malikore! Enjoy ^^");
			startCombat(new Malikore());
		}
		public function LvLUPAurora():void {
			outputText("\n\n<b>Aurora get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 73))</b>");
			if (flags[kFLAGS.AURORA_LVL] < 13) flags[kFLAGS.AURORA_LVL]++;
			EnemiesMenu(2);
		}
		public function DELvLAurora():void {
			outputText("\n\n<b>Aurora get weaker! (cheat stop working when she reach lvl 1)</b>");
			if (flags[kFLAGS.AURORA_LVL] > 1) flags[kFLAGS.AURORA_LVL]--;
			EnemiesMenu(2);;
		}
		public function LvLUPEva():void {
			outputText("\n\n<b>Evangeline get stronger! (cheat stop working when she reach max possible lvl for now (atm it's lvl 42))</b>");
			if (flags[kFLAGS.EVANGELINE_LVL_UP] < 17) flags[kFLAGS.EVANGELINE_LVL_UP]++;
			EnemiesMenu(1);
		}
		public function DELvLEva():void {
			outputText("\n\n<b>Evangeline get weaker! (cheat stop working when she reach lvl 12)</b>");
			if (flags[kFLAGS.EVANGELINE_LVL_UP] > 6) flags[kFLAGS.EVANGELINE_LVL_UP]--;
			EnemiesMenu(1);
		}
		public function FightFeralBeast():void {
			clearOutput();
			outputText("Entering battle with feral tentacle beast! Enjoy ^^");
			startCombat(new TentacleBeastRaging());
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
			if (flags[kFLAGS.SOUL_SENSE_TAMANI] >= 3) addButton(0, "Tamani", TamaniEnc).hint("Req. 80+ soulforce");
			else addButtonDisabled(0, "Tamani", "");
			if (flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] >= 3) addButton(1, "Tamani D.", TamaniDaughtersEnc).hint("Req. at least 80+ soulforce (more daughters will increase needed SF)");
			else addButtonDisabled(1, "Tamani D.", "");
			if (flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] >= 3) addButton(2, "KitsuMansion", KitsuneMansion).hint("Req. 90+ soulforce");
			else addButtonDisabled(2, "KitsuMansion", "");
			if (flags[kFLAGS.SOUL_SENSE_IZUMI] >= 3) addButton(3, "Izumi", IzumiEnc).hint("Req. 300+ soulforce");
			else addButtonDisabled(3, "Izumi", "");
			if (flags[kFLAGS.SOUL_SENSE_PRISCILLA] >= 3) addButton(5, "Priscilla", PriscillaEnc).hint("Req. 320+ soulforce");
			else addButtonDisabled(5, "Priscilla", "");
			if (flags[kFLAGS.SOUL_SENSE_WORLD_TREE] >= 1) addButton(10, "WorldTree", findWorldTree).hint("Req. 100+ soulforce");
			else addButtonDisabled(10, "WorldTree", "");
			if (flags[kFLAGS.SOUL_SENSE_GIACOMO] >= 3) addButton(13, "Giacomo", findGiacomo).hint("Req. 100+ soulforce");
			else addButtonDisabled(13, "Giacomo", "");
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
		public function PriscillaEnc():void {
			if (player.soulforce >= 320) {
				player.soulforce -= 320;
				statScreenRefresh();
				SceneLib.goblinElderScene.goblinElderEncounter();
				spriteSelect(122);
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
}