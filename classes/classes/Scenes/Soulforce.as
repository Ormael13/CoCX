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
	
	use namespace kGAMECLASS;
	
	public class Soulforce extends BaseContent
	{
		public var tamaniDaughtersScene:TamainsDaughtersScene = new TamainsDaughtersScene();
		public var tamaniScene:TamaniScene = new TamaniScene();
		
		
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
			outputText("<b>Cultivation stage: </b>");
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
			outputText("<b>Cultivation level: </b>" + flags[kFLAGS.SOUL_CULTIVATION] + "\n");
			outputText("<b>Spirit Stones: </b>" + flags[kFLAGS.SPIRIT_STONES] + "\n");
			outputText("<b>Additional Soulforce from training: </b>" + flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] + " / 310\n");
		/*	outputText("<b>Progress toward clearing next meridian: </b>");
			if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 2)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 1)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
		*/	outputText("\nCurrent soulpower: " + player.soulforce + " / " + player.maxSoulforce() + " \n");
			var dailySoulforceUsesLimit:Number = 0;
			if (player.findPerk(PerkLib.JobSoulCultivator) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) dailySoulforceUsesLimit++;
			if (player.findPerk(PerkLib.SoulOverlord) >= 0) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
			menu();
			addButton(0, "Cultivate", SoulforceRegeneration, null, null, null, "Spend some time on restoring some of the used soulforce.");
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(1, "Self-sustain", SelfSustain, null, null, null, "Spend some soulforce on suppresing hunger for a while."); //zamiana soulforce na satiety w stosunku 1:5
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(2, "Repres. Lust", RepresLust, null, null, null, "Spend some soulforce on calming your sexual urges."); //używanie soulforce do zmniejszania lust w stosunku 1:2
			//if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(3, "", , null, null, null, "."); //używanie soulforce do zmniejszania fatigue w stosunku 1:1 a może jednak 1:2 i fat w soul i soul w fat używalne nawet w walce też ale z wiekszym kosztem przeliczania może 1:3/3:1 lub nawet 1:4/4:1 lub 1:5/5:1
			//if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(4, "Purif. Corr.", , null, null, null, "."); //używanie soulforce do zmniejszania corruption w stosunku 1:100
			//addButton(5, "Upgrade", UpgradeItems, null, null, null, "."); //ulepszanie itemów
			if (player.findPerk(PerkLib.Metamorph) >= 0) addButton(6, "Metamorf", kGAMECLASS.metamorph.accessMetamorphMenu, null, null, null, "Use your soulforce to mold freely your body.")//używanie metamorfowania z użyciem soulforce
			if (player.findPerk(PerkLib.SoulSense) >= 0) addButton(7, "Soul Sense", SoulSense, null, null, null, "Use your soul sense to trigger specific encounter."); //używanie divine sense aby znaleść określone event encounters: Tamani (lvl 6+), Tamani daugthers (lvl 6+), Kitsune mansion (lvl 12+), Izumi (lvl 18/24+), itp.
			addButton(14, "Back", playerMenu);
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
			var soulforceamountrestored:int = 10;
			if (player.alicornScore() >= 6) soulforceamountrestored += 10;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 10;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailVenom == 9) soulforceamountrestored += 40;
			if (player.unicornScore() >= 5) soulforceamountrestored += 5;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 10;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 10;
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
			var soulforceamountrestored:int = 30;
			if (player.alicornScore() >= 6) soulforceamountrestored += 30;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 30;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailVenom == 9) soulforceamountrestored += 120;
			if (player.unicornScore() >= 5) soulforceamountrestored += 15;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 30;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 30;
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
			var soulforceamountrestored:int = 70;
			if (player.alicornScore() >= 6) soulforceamountrestored += 70;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 70;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailVenom == 9) soulforceamountrestored += 280;
			if (player.unicornScore() >= 5) soulforceamountrestored += 35;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 70;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 70;
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
			var soulforceamountrestored:int = 110;
			if (player.alicornScore() >= 6) soulforceamountrestored += 110;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 110;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailVenom == 9) soulforceamountrestored += 440;
			if (player.unicornScore() >= 5) soulforceamountrestored += 55;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 110;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 110;
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
			var soulforceamountrestored:int = 150;
			if (player.alicornScore() >= 6) soulforceamountrestored += 150;
			if (player.kitsuneScore() >= 6) soulforceamountrestored += 150;
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailVenom == 9) soulforceamountrestored += 600;
			if (player.unicornScore() >= 5) soulforceamountrestored += 75;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) soulforceamountrestored += 150;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) soulforceamountrestored += 150;
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
			if (player.kitsuneScore() >= 12 && player.tailType == 13 && player.tailVenom == 9) costPercent += 400;
			if (player.unicornScore() >= 5) costPercent += 50;
			if (player.findPerk(PerkLib.SoulApprentice) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulPersonage) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulWarrior) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulSprite) >= 0) costPercent += 100;
			if (player.findPerk(PerkLib.SoulExalt) >= 0) costPercent += 100;
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
				outputText("Consuming some of your soulforce you medicore amount of lust are gone.");
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
				outputText("Consuming not a small amount of your soulforce you most of your lust is gone.");
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
		public function SoulSense():void {
			clearOutput();
			outputText("Using a tiny amount of soulforce you could try to use soul sense to locate some of people you meet of location you found before without wasting hours for that. Especialy if those people are usualy roaming around or places that constantly changing their location.");
			outputText("\n\nAmount of soulforce used to locate them using soul sense depening of relative power of searched person or location.");
			menu();
			if (flags[kFLAGS.SOUL_SENSE_TAMANI] == 5) addButton(0, "Tamani", TamaniEnc);
			if (flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] == 5) addButton(1, "Tamani D.", TamaniDaughtersEnc);
			if (flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] == 5) addButton(2, "KitsuMansion", KitsuneMansion);
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
	}
}