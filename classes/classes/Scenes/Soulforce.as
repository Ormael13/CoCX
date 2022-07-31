/**
 * ...
 * @author Ormael
 */
package classes.Scenes
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.Areas.Desert.NagaScene;
import classes.Scenes.Areas.Forest.TamainsDaughtersScene;
import classes.Scenes.Areas.Forest.TamaniScene;
import classes.Scenes.Areas.Forest.WorldTree;
import classes.Scenes.Areas.HighMountains.IzumiScene;
import classes.Scenes.Areas.HighMountains.MinotaurMobScene;
import classes.Scenes.Monsters.Oozaru;
import classes.Scenes.NPCs.BelisaFollower;
import classes.Scenes.NPCs.LilyFollower;
import classes.Scenes.NPCs.TyrantiaFollower;

use namespace CoC;

public class Soulforce extends BaseContent
{
	public var tamaniDaughtersScene:TamainsDaughtersScene = new TamainsDaughtersScene();
	public var tamaniScene:TamaniScene = new TamaniScene();
	public var izumiScenes:IzumiScene = new IzumiScene();
	public var nagaScene:NagaScene = new NagaScene();
	public var worldtreeScene:WorldTree = new WorldTree();
	public var minotaurSonsScene:MinotaurMobScene = new MinotaurMobScene();

	public function accessSoulforceMenu():void {
		clearOutput();
		SoulCultivationLvL();
		var dailySoulforceUsesLimit:Number = 0;
		if (player.hasPerk(PerkLib.JobSoulCultivator)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulWarrior)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulGrandmaster)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulOverlord)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulEmperor)) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
		outputText("<b>Cultivation level:</b> " + flags[kFLAGS.SOUL_CULTIVATION] + "\n");
		outputText("<b>Additional Soulforce from training:</b> " + flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] + " % / 2230 %\n");
		if (player.hasPerk(PerkLib.Dantain)) {
			if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor) && player.perkv1(PerkLib.Dantain) == 0) player.addPerkValue(PerkLib.Dantain, 1, 1);
			if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor) && player.perkv1(PerkLib.Dantain) == 1) player.addPerkValue(PerkLib.Dantain, 1, 1);
			if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor) && player.perkv1(PerkLib.Dantain) == 2) player.addPerkValue(PerkLib.Dantain, 1, 1);
			outputText("<b>Dantain:</b> ");
			if (player.perkv1(PerkLib.Dantain) == 3) outputText("Nascent Soul");
			else if (player.perkv1(PerkLib.Dantain) == 2) outputText("Core Formation");
			else if (player.perkv1(PerkLib.Dantain) == 1) outputText("Foundation Establishment");
			else outputText("Qi Condensation");
			outputText("\n");
		}
		/*	outputText("<b>Progress toward clearing next meridian: </b>");
			if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 2)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else if (flags[kFLAGS.UNLOCKED_MERIDIANS] == 1)
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
			else
				outputText(flags[kFLAGS.SOULFORCE_USED_FOR_BREAKTHROUGH] + " / wartość liczbowa\n");
		*/	outputText("<b>Uses of soulforce per day (for 4 first option beside cultivate):</b> " + flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] + " / " + dailySoulforceUsesLimit + "\n");
		menu();
		if (player.hasPerk(PerkLib.EnergyDependent)) addButtonDisabled(0, "Meditations", "You're unable to recover soulforce by meditating.");
		else addButton(0, "Meditations", SoulforceRegeneration).hint("Spend some time on restoring some of the used soulforce.");
		if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButton(1, "Contemplate", DaoContemplations).hint("Dao Contemplations");
		else addButtonDisabled(1, "???", "Req.  successfully surviving 1st Tribulation.");
		if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) {
			addButton(2, "Self-sustain", SelfSustain).hint("Spend some soulforce on suppresing hunger for a while."); //zamiana soulforce na satiety w stosunku 1:5
			addButton(3, "Repres. Lust", RepresLust).hint("Spend some soulforce on calming your sexual urges."); //używanie soulforce do zmniejszania lust w stosunku 1:2
			addButton(4, "Adj. Corr.", CorruptionAndSoulforce).hint("Spend some soulforce on affecting your current corruption."); //używanie soulforce do zmniejszania corruption w stosunku 1:100 a zdobywanie corruption w stosunku 1:50
		}
		else {
			addButtonDisabled(2, "Self-sustain", "Wait till new day arrive to use this option again.");
			addButtonDisabled(3, "Repres. Lust", "Wait till new day arrive to use this option again.");
			addButtonDisabled(4, "Adj. Corr.", "Wait till new day arrive to use this option again.");
		}
		//addButton(5, "Upgrade", UpgradeItems).hint("."); //ulepszanie itemów
		if (player.hasPerk(PerkLib.SoulSense)) addButton(7, "Soul Sense", SoulSense).hint("Use your soul sense to trigger specific encounters."); //używanie divine sense aby znaleść określone event encounters: Tamani (lvl 6+), Tamani daugthers (lvl 6+), Kitsune mansion (lvl 12+), Izumi (lvl 18/24+), itp.
		else addButtonDisabled(7, "???", "Req. Soul Sense.");
		if (player.hasPerk(PerkLib.SoulApprentice)) {
			if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) addButton(9, "Mana", ManaAndSoulforce).hint("Convert some soulforce into mana or vice versa."); //używanie soulforce do zamiany na mane w stosunku 1:1 a many do soulforce 1:2, używalne nawet w walce też ale z wiekszym kosztem przeliczania czyli 1:2 i 1:4
			else addButtonDisabled(9, "Mana", "Wait till new day arrive to use this option again.");
		}
		else addButtonDisabled(9, "???", "Req. Soul Apprentice stage.");
		if (player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") >= 0 || player.hasKeyItem("Cultivation Manual: Body like a Coke Fiend") >= 0 || player.hasKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil") >= 0) addButton(12, "Sub-paths", SubPaths).hint("Contemplate mysteries on your choosen sub-path(s).");
		if (player.hasPerk(PerkLib.Metamorph)) {
			if (player.blockingBodyTransformations()) addButtonDisabled(10, "Metamorph", "Your current body state prevents you from using Metamorph. (Either cure it or ascend to gain access to metamorph menu again)");
			else addButton(10, "Metamorph", SceneLib.metamorph.openMetamorph).hint("Use your soulforce to mold your body.");//używanie metamorfowania z użyciem soulforce
		}
		else addButtonDisabled(10, "???", "Req. Metamorph.");
		addButton(13, "Cultivation", Contemplations).hint("Contemplate mysteries of the world to try progress your soul cultivation path. Maybe even attain cultivation base breakthrou. (Req. 100% or 30% of max Soulforce + high enough wisdom / level + sometimes some additional req.)");
		addButton(14, "Back", playerMenu);
	}

	public function SoulCultivationLvL():void {	//Converted Soul Cultivation level check to a function, easier to update, and much nicer on the eyes than the old block of ifs!
		//Actually.... Since the tier and lvl have to sync for the soul cult lvl, and is checked for the output tier... I can hijack this and use it to output the tiers as well!
		/*var cultTier:Array = [PerkLib.SoulApprentice, PerkLib.SoulPersonage, PerkLib.SoulWarrior, PerkLib.SoulSprite, PerkLib.SoulScholar, PerkLib.SoulElder, PerkLib.SoulExalt, PerkLib.SoulOverlord, PerkLib.SoulTyrant, PerkLib.SoulKing, PerkLib.SoulEmperor, PerkLib.SoulAncestor];
			var pLvlMax:int = 122;	//Should only need to change this and above array for future expansion.
			var cultRankTier:Array = ["Late ", "Early ", "Middle "];
			var cultStanding:String = "Mortal";
			var lNeed:Boolean = true;
			var pLvl:int = 6;
			var cLvlTier:int = 0;
			var perkTier:PerkType;*/
		/*var cultTier:Array = [PerkLib.JobSoulCultivator, PerkLib.SoulApprentice, PerkLib.SoulPersonage, PerkLib.SoulWarrior, PerkLib.SoulSprite, PerkLib.SoulScholar, PerkLib.SoulElder, PerkLib.SoulExalt, PerkLib.SoulOverlord, PerkLib.SoulTyrant, PerkLib.SoulKing, PerkLib.SoulEmperor, PerkLib.SoulAncestor];
		var pLvlMax:int = 76;	//Should only need to change this and above array for future expansion.
		var cultRankTier:Array = ["Late ", "Early ", "Middle "];
		var lNeed:Boolean = true;
		var pLvl:int = 6;
		var cLvlTier:int = 0;
		var cultStanding:String = "Mortal";
		flags[kFLAGS.SOUL_CULTIVATION] = 0;*/
		/*for (var i:int = 0; i < cultTier.length(); i++){	//This *should* work?
				if (!player.hasPerk(cultTier[i])){
					if (i == 0) break;
					perkTier = cultTier[i - 1];
					if (player.level < 76) pLvlMax = player.level
					if (i - 1 < 6){
						cultStanding = cultRankTier[pLvlMax % 3] + perkTier.name();
					}
					else{
						cultStanding = cultRankTier[pLvlMax % 4] + perkTier.name();
					}
					break;
				}
			}*/
		/*if (player.level >= 4 && player.hasPerk(cultTier[0])){	//Deprecating.
			flags[kFLAGS.SOUL_CULTIVATION] +=3;
		}
		else if (player.level >= 2 && player.hasPerk(cultTier[0])){	//Actually.... I can also get rid of the checks for the cultTier here, since you have to have that perk beforehand to get to this menu in the first place...
			flags[kFLAGS.SOUL_CULTIVATION] +=2;
			lNeed = false;
		}
		else if (player.level >= 1 && player.hasPerk(cultTier[0])){
			flags[kFLAGS.SOUL_CULTIVATION] +=1;
			lNeed = false;
		}
		while (lNeed) {
			if (player.level >= pLvl && pLvl <= pLvlMax && player.hasPerk(cultTier[floor(pLvl /6)])){
				flags[kFLAGS.SOUL_CULTIVATION] +=1;
			}
			else {
				lNeed = false;
			}
			if (cLvlTier == 3) cLvlTier = 0;
			if (!lNeed){
				if (flags[kFLAGS.SOUL_CULTIVATION] >=4){
					cultStanding = cultRankTier[cLvlTier] + cultTier[floor(int((pLvl-2)/6))].name();
				}
			}
			pLvl += 2;
			cLvlTier += 1;
		}*/
		var cultStanding:String = "";
		if (flags[kFLAGS.SOUL_CULTIVATION] >= 1) {
			var prefix:String = "";
			switch(player.perkv1(PerkLib.JobSoulCultivator)){
				case 1:
					prefix = "Early ";
					break;
				case 2:
					prefix = "Middle ";
					break;
				case 3:
					prefix = "Late ";
					break;
				case 4:
					prefix = "Peak ";
					break;
				case 5:
					prefix = "Half Step to ";
					break;
			}
			var suffix:String = "";
			switch(player.perkv2(PerkLib.JobSoulCultivator)){
				case 1:
					suffix = " Apprentice";
					break;
				case 2:
					suffix = " Personage";
					break;
				case 3:
					suffix = " Warrior";
					break;
				case 4:
					suffix = " Sprite";
					break;
				case 5:
					suffix = " Scholar";
					break;
				case 6:
					suffix = " Grandmaster";
					break;
				case 7:
					suffix = " Elder";
					break;
				case 8:
					suffix = " Exalt";
					break;
				case 9:
					suffix = " Overlord";
					break;
				case 10:
					suffix = " Tyrant";
					break;
				case 11:
					suffix = " King";
					break;
				case 12:
					suffix = " Emperor";
					break;
				case 13:
					suffix = " Ancestor";
					break;
				case 14:
					suffix = " Sage";
					break;
			}
			cultStanding += prefix;
			cultStanding += "Soul";
			cultStanding += suffix;
		}
		else cultStanding = "Mortal";
		outputText("<b>Cultivation stage:</b> " + cultStanding + "\n");
	}


	public function SoulforceRegeneration():void {
		menu();
		addButton(0, "1 hour", SoulforceRegeneration1).hint("Cultivate for 1 hour (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(20) + " soulforce).");//x1
		addButton(1, "2 hours", SoulforceRegeneration2).hint("Cultivate for 2 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(60) + " soulforce).");//x3
		addButton(2, "4 hours", SoulforceRegeneration3).hint("Cultivate for 4 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(140) + " soulforce).");//x7
		addButton(3, "6 hours", SoulforceRegeneration4).hint("Cultivate for 6 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(220) + " soulforce).");//x11
		addButton(4, "8 hours", SoulforceRegeneration5).hint("Cultivate for 8 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(300) + " soulforce).");//x15
		addButton(5, "10 hours", SoulforceRegeneration6).hint("Cultivate for 10 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(380) + " soulforce).");//x19
		addButton(6, "12 hours", SoulforceRegeneration7).hint("Cultivate for 12 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(460) + " soulforce).");//x23
		addButton(7, "14 hours", SoulforceRegeneration8).hint("Cultivate for 14 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(540) + " soulforce).");//x27
		addButton(8, "16 hours", SoulforceRegeneration9).hint("Cultivate for 16 hours (Allow to recover ~" + AmountOfSoulforceRecoveredDuringCultivation(620) + " soulforce).");//x31
		addButton(14, "Back", accessSoulforceMenu);
	}
	private function SoulforceRegeneration00():Number {
		var SFR00:Number = 0;
		var tier:int;

		tier = player.racialTier(Races.KITSUNE);
		if (tier >= 4) SFR00 += 200;
		else if (tier == 3) SFR00 += 150;
		else if (tier == 2) SFR00 += 80;
		else if (tier == 1) SFR00 += 40;

		tier = player.racialTier(Races.NEKOMATA);
		if (tier >= 2) SFR00 += 40;
		else if (tier == 1) SFR00 += 20;

		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistElderStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) SFR00 += 20;
		if (player.hasPerk(PerkLib.DaoistTyrantStage)) SFR00 += 20;
		return SFR00;
	}
	private function SoulforceRegenerationCompatibileTrainingItems():Boolean {
		return player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring"
				|| player.weaponFlyingSwordsName == "training soul flying sword";
	}
	public function Contemplations(page:int = 1):void {
		menu();
		if (page == 1) {
			if (flags[kFLAGS.SOUL_CULTIVATION] == 0 && player.wis >= 20 && player.soulforce >= player.maxSoulforce()) addButton(0, "E.S.A.", Contemplations1, 1).hint("Attempt breakthrou to Early Soul Apprentice stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 1) addButtonDisabled(0, "E.S.A.", "You already reached Early Soul Apprentice.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 1 && player.level >= 3 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(1, "M.S.A.", Contemplations2, 1).hint("Attempt breakthrou to Middle Soul Apprentice stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) addButtonDisabled(1, "M.S.A.", "You already reached Middle Soul Apprentice.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 2 && player.level >= 6 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(2, "L.S.A.", Contemplations2, 2).hint("Attempt breakthrou to Late Soul Apprentice stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 3) addButtonDisabled(2, "L.S.A.", "You already reached Late Soul Apprentice.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 3 && player.wis >= 40 && player.level >= 9 && player.soulforce >= player.maxSoulforce() && player.hasPerk(PerkLib.Dantain)) addButton(3, "E.S.A.", Contemplations1, 2).hint("Attempt breakthrou to Early Soul Personage stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 4) addButtonDisabled(3, "E.S.P.", "You already reached Early Soul Personage.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 4 && player.level >= 12 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(4, "M.S.P.", Contemplations2, 3).hint("Attempt breakthrou to Middle Soul Personage stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 5) addButtonDisabled(4, "M.S.P.", "You already reached Middle Soul Personage.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 5 && player.level >= 15 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(5, "L.S.P.", Contemplations2, 4).hint("Attempt breakthrou to Late Soul Personage stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 6) addButtonDisabled(5, "L.S.P.", "You already reached Late Soul Personage.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 6 && player.wis >= 60 && player.level >= 18 && player.soulforce >= player.maxSoulforce() && player.hasPerk(PerkLib.SoulSense)) addButton(6, "E.S.W.", Contemplations1, 3).hint("Attempt breakthrou to Early Soul Warrior stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 7) addButtonDisabled(6, "E.S.W.", "You already reached Early Soul Warrior.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 7 && player.level >= 21 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(7, "M.S.W.", Contemplations2, 5).hint("Attempt breakthrou to Middle Soul Warrior stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 8) addButtonDisabled(7, "M.S.W.", "You already reached Middle Soul Warrior.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 8 && player.level >= 24 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(8, "L.S.W.", Contemplations2, 6).hint("Attempt breakthrou to Late Soul Warrior stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 9) addButtonDisabled(8, "L.S.W.", "You already reached Late Soul Warrior.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 9 && player.level >= 27 && player.wis >= 80 && player.hasKeyItem("Heavenly Tribulation: Myths and Facts") >= 0 && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButton(9, "Tribulation", tribulationsPrompt).hint("H class Heaven Tribulation - To face it or not? That's the question.");
			else if (player.hasPerk(PerkLib.HclassHeavenTribulationSurvivor)) addButtonDisabled(9, "Tribulation", "You already survived H class Heaven Tribulation.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 10 && player.level >= 30 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(10, "M.S.S.", Contemplations2, 7).hint("Attempt breakthrou to Middle Soul Sprite stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 11) addButtonDisabled(10, "M.S.W.", "You already reached Middle Soul Sprite.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 11 && player.level >= 33 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(11, "L.S.S.", Contemplations2, 8).hint("Attempt breakthrou to Late Soul Sprite stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 12) addButtonDisabled(11, "L.S.W.", "You already reached Late Soul Sprite.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 12 && player.wis >= 100 && player.level >= 36 && player.soulforce >= player.maxSoulforce()) addButton(12, "E.S.S.", Contemplations1, 4).hint("Attempt breakthrou to Early Soul Scholar stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 13) addButtonDisabled(12, "E.S.W.", "You already reached Early Soul Scholar.");
			addButton(13, "-2-", Contemplations, page + 1);
		}
		if (page == 2)  {
			if (flags[kFLAGS.SOUL_CULTIVATION] == 13 && player.level >= 39 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(0, "M.S.S.", Contemplations2, 9).hint("Attempt breakthrou to Middle Soul Scholar stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 14) addButtonDisabled(0, "M.S.S.", "You already reached Middle Soul Scholar.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 14 && player.level >= 42 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(1, "L.S.S.", Contemplations2, 10).hint("Attempt breakthrou to Late Soul Scholar stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 15) addButtonDisabled(1, "L.S.S.", "You already reached Late Soul Scholar.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 15 && player.wis >= 120 && player.level >= 45 && player.soulforce >= player.maxSoulforce()) addButton(2, "E.S.GM.", Contemplations1, 5).hint("Attempt breakthrou to Early Soul Grandmaster stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 16) addButtonDisabled(2, "E.S.GM.", "You already reached Early Soul Grandmaster.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 16 && player.level >= 48 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(3, "M.S.GM.", Contemplations2, 11).hint("Attempt breakthrou to Middle Soul Grandmaster stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 17) addButtonDisabled(3, "M.S.GM.", "You already reached Middle Soul Grandmaster.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 17 && player.level >= 51 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(4, "L.S.GM.", Contemplations2, 12).hint("Attempt breakthrou to Late Soul Grandmaster stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 18) addButtonDisabled(4, "L.S.GM.", "You already reached Late Soul Grandmaster.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 18 && player.level >= 54 && player.wis >= 140 && player.hasPerk(PerkLib.SoulGrandmaster) && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) addButton(5, "Tribulation", tribulationsPrompt).hint("G class Heaven Tribulation - To face it or not? That's the question.");
			else if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor)) addButtonDisabled(5, "Tribulation", "You already survived G class Heaven Tribulation.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 19 && player.level >= 57 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(6, "M.S.E.", Contemplations2, 13).hint("Attempt breakthrou to Middle Soul Elder stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 20) addButtonDisabled(6, "M.S.E.", "You already reached Middle Soul Elder.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 20 && player.level >= 60 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(7, "L.S.E.", Contemplations2, 14).hint("Attempt breakthrou to Late Soul Elder stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 21) addButtonDisabled(7, "L.S.E.", "You already reached Late Soul Elder.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 21 && player.level >= 63 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(8, "P.S.E.", Contemplations2, 15).hint("Attempt breakthrou to Peak Soul Elder stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 22) addButtonDisabled(8, "P.S.E.", "You already reached Peak Soul Elder.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 22 && player.wis >= 170 && player.level >= 66 && player.soulforce >= player.maxSoulforce()) addButton(9, "E.S.O.", Contemplations1, 6).hint("Attempt breakthrou to Early Soul Exalt stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 23) addButtonDisabled(9, "E.S.O.", "You already reached Early Soul Exalt.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 23 && player.level >= 69 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(10, "M.S.E.", Contemplations2, 16).hint("Attempt breakthrou to Middle Soul Exalt stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 24) addButtonDisabled(10, "M.S.E.", "You already reached Middle Soul Exalt.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 24 && player.level >= 72 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(11, "L.S.E.", Contemplations2, 17).hint("Attempt breakthrou to Late Soul Exalt stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 25) addButtonDisabled(11, "L.S.E.", "You already reached Late Soul Exalt.");
			addButton(12, "-1-", Contemplations, page - 1);
			addButton(13, "-3-", Contemplations, page + 1);
		}
		if (page == 3) {
			if (flags[kFLAGS.SOUL_CULTIVATION] == 25 && player.level >= 75 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(0, "P.S.E.", Contemplations2, 18).hint("Attempt breakthrou to Peak Soul Exalt stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 26) addButtonDisabled(0, "P.S.E.", "You already reached Peak Soul Exalt.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 26 && player.level >= 78 && player.wis >= 200 && player.hasPerk(PerkLib.SoulExalt) && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) addButton(1, "Tribulation", tribulationsPrompt).hint("F class Heaven Tribulation - To face it or not? That's the question.");
			else if (player.hasPerk(PerkLib.FclassHeavenTribulationSurvivor)) addButtonDisabled(1, "Tribulation", "You already survived F class Heaven Tribulation.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 27 && player.level >= 81 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(2, "M.S.O.", Contemplations2, 19).hint("Attempt breakthrou to Middle Soul Overlord stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 28) addButtonDisabled(2, "M.S.O.", "You already reached Middle Soul Overlord.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 28 && player.level >= 84 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(3, "L.S.O.", Contemplations2, 20).hint("Attempt breakthrou to Late Soul Overlord stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 29) addButtonDisabled(3, "L.S.O.", "You already reached Late Soul Overlord.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 29 && player.level >= 87 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(4, "P.S.O.", Contemplations2, 21).hint("Attempt breakthrou to Peak Soul Overlord stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 30) addButtonDisabled(4, "P.S.O.", "You already reached Peak Soul Overlord.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 30 && player.level >= 90 && player.wis >= 230 && player.soulforce >= player.maxSoulforce()) addButton(5, "E.S.T.", Contemplations1, 7).hint("Attempt breakthrou to Early Soul Tyrant stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 31) addButtonDisabled(5, "E.S.T.", "You already reached Early Soul Tyrant.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 31 && player.level >= 93 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(6, "M.S.T.", Contemplations2, 22).hint("Attempt breakthrou to Middle Soul Tyrant stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 32) addButtonDisabled(6, "M.S.T.", "You already reached Middle Soul Tyrant.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 32 && player.level >= 96 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(7, "L.S.T.", Contemplations2, 23).hint("Attempt breakthrou to Late Soul Tyrant stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 33) addButtonDisabled(7, "L.S.T.", "You already reached Late Soul Tyrant.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 33 && player.level >= 99 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(8, "P.S.T.", Contemplations2, 24).hint("Attempt breakthrou to Peak Soul Tyrant stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 34) addButtonDisabled(8, "P.S.T.", "You already reached Peak Soul Tyrant.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 34 && player.level >= 102 && player.wis >= 260 && player.hasPerk(PerkLib.SoulTyrant) && !player.hasStatusEffect(StatusEffects.TribulationCountdown) && !player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) addButton(9, "Tribulation", tribulationsPrompt).hint("FF class Heaven Tribulation - To face it or not? That's the question.");
			else if (player.hasPerk(PerkLib.FFclassHeavenTribulationSurvivor)) addButtonDisabled(9, "Tribulation", "You already survived FF class Heaven Tribulation.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 35 && player.level >= 105 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(10, "M.S.K.", Contemplations2, 25).hint("Attempt breakthrou to Middle Soul King stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 36) addButtonDisabled(10, "M.S.K.", "You already reached Middle Soul King.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 36 && player.level >= 108 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(11, "L.S.K.", Contemplations2, 26).hint("Attempt breakthrou to Late Soul King stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 37) addButtonDisabled(11, "L.S.K.", "You already reached Late Soul King.");
			addButton(12, "-2-", Contemplations, page - 1);
			addButton(13, "-4-", Contemplations, page + 1);
		}
		if (page == 4) {
			if (flags[kFLAGS.SOUL_CULTIVATION] == 37 && player.level >= 111 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(0, "P.S.K.", Contemplations2, 27).hint("Attempt breakthrou to Peak Soul King stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 38) addButtonDisabled(0, "P.S.K.", "You already reached Peak Soul King.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 38 && player.level >= 114 && player.wis >= 230 && player.soulforce >= player.maxSoulforce()) addButton(1, "E.S.E.", Contemplations1, 8).hint("Attempt breakthrou to Early Soul Emperor stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 39) addButtonDisabled(1, "E.S.E.", "You already reached Early Soul Emperor.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 39 && player.level >= 117 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(2, "M.S.E.", Contemplations2, 28).hint("Attempt breakthrou to Middle Soul Emperor stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 40) addButtonDisabled(2, "M.S.E.", "You already reached Middle Soul Emperor.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 40 && player.level >= 120 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(3, "L.S.E.", Contemplations2, 29).hint("Attempt breakthrou to Late Soul Emperor stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 41) addButtonDisabled(3, "L.S.E.", "You already reached Late Soul Emperor.");
			if (flags[kFLAGS.SOUL_CULTIVATION] == 41 && player.level >= 123 && player.soulforce >= Math.round(player.maxSoulforce() * 0.3)) addButton(4, "P.S.E.", Contemplations2, 30).hint("Attempt breakthrou to Peak Soul Emperor stage.");
			else if (flags[kFLAGS.SOUL_CULTIVATION] >= 42) addButtonDisabled(4, "P.S.E.", "You already reached Peak Soul Emperor.");
			//else if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) addButtonDisabled(10, "E.S.E.", "You already reached Early Soul Exalt.");
			//else if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) addButtonDisabled(11, "M.S.E.", "You already reached Middle Soul Exalt.");
			//else if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) addButtonDisabled(12, "L.S.E.", "You already reached Late Soul Exalt.");
			//else if (flags[kFLAGS.SOUL_CULTIVATION] >= 2) addButtonDisabled(13, "P.S.E.", "You already reached Peak Soul Exalt.");
			addButton(12, "-3-", Contemplations, page - 1);
		}
		addButton(14, "Back", accessSoulforceMenu);
		//outputText("You find a flat, comfortable rock to sit down on and begin to cultivated according to the manual.  Minute after minute you feel immersed into world that surrounds you.  How they flow around you, how they change on their own and how they interact with each other.  All this while trying to understand, despite being insignificant while the great dao manifests around you.\n\n");
	}
	public function Contemplations1(breakthrou:Number):void {
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and begin to cultivated according to the manual.  Minute after minute you feel your inner soulforce slowly starting to circle inside your body.  It's very slowly circling within yourself.\n\n");
		outputText("Near the end you feel silent 'pop' inside your body and your cultivation base made breakthrou.\n\n");
		EngineCore.SoulforceChange(-player.maxSoulforce(), true);
		player.addPerkValue(PerkLib.JobSoulCultivator, 2, 1);
		flags[kFLAGS.SOUL_CULTIVATION] += 1;
		var print:String = "";
		switch(breakthrou){
			case 1:
				player.createPerk(PerkLib.SoulApprentice, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, 1);
				print = "Early Soul Apprentice";
				break;
			case 2:
				player.createPerk(PerkLib.SoulPersonage, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, -2);
				print = "Early Soul Personage";
				break;
			case 3:
				player.createPerk(PerkLib.SoulWarrior, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, -2);
				print = "Early Soul Warrior";
				break;
			case 4:
				player.createPerk(PerkLib.SoulScholar, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, -2);
				print = "Early Soul Scholar";
				break;
			case 5:
				player.createPerk(PerkLib.SoulGrandmaster, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, -2);
				print = "Early Soul Grandmaster";
				break;
			case 6:
				player.createPerk(PerkLib.SoulExalt, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, -3);
				print = "Early Soul Exalt";
				break;
			case 7:
				player.createPerk(PerkLib.SoulTyrant, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, -3);
				print = "Early Soul Tyrant";
				break;
			case 8:
				player.createPerk(PerkLib.SoulEmperor, 0, 0, 0, 0);
				player.addPerkValue(PerkLib.JobSoulCultivator, 1, -3);
				print = "Early Soul Emperor";
				break;
		}
		outputText("<b>You're now "+print+".</b>\n\n");
		doNext(camp.returnToCampUseTwoHours);
	}
	public function Contemplations2(breakthrou:Number):void {
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and begin to cultivated according to the manual.  Minute after minute you feel your inner soulforce slowly starting to circle inside your body.  It's very slowly circling within yourself.\n\n");
		outputText("Near the end you feel silent 'pop' inside your body and your cultivation base made breakthrou.\n\n");
		EngineCore.SoulforceChange( -Math.round(player.maxSoulforce() * 0.3), true);
		player.addPerkValue(PerkLib.JobSoulCultivator, 1, 1);
		flags[kFLAGS.SOUL_CULTIVATION] += 1;
		var print:String = "";
		switch(breakthrou){
			case 1:
				print = "Middle Soul Apprentice";
				break;
			case 2:
				print = "Late Soul Apprentice";
				break;
			case 3:
				print = "Middle Soul Personage";
				break;
			case 4:
				print = "Late Soul Personage";
				break;
			case 5:
				print = "Middle Soul Warrior";
				break;
			case 6:
				print = "Late Soul Warrior";
				break;
			case 7:
				print = "Middle Soul Sprite";
				break;
			case 8:
				print = "Late Soul Sprite";
				break;
			case 9:
				print = "Middle Soul Scholar";
				break;
			case 10:
				print = "Late Soul Scholar";
				break;
			case 11:
				print = "Middle Soul Grandmaster";
				break;
			case 12:
				print = "Late Soul Grandmaster";
				break;
			case 13:
				print = "Middle Soul Elder";
				break;
			case 14:
				print = "Late Soul Elder";
				break;
			case 15:
				print = "Peak Soul Elder";
				break;
			case 16:
				print = "Middle Soul Exalt";
				break;
			case 17:
				print = "Late Soul Exalt";
				break;
			case 18:
				print = "Peak Soul Exalt";
				break;
			case 19:
				print = "Middle Soul Overlord";
				break;
			case 20:
				print = "Late Soul Overlord";
				break;
			case 21:
				print = "Peak Soul Overlord";
				break;
			case 22:
				print = "Middle Soul Tyrant";
				break;
			case 23:
				print = "Late Soul Tyrant";
				break;
			case 24:
				print = "Peak Soul Tyrant";
				break;
			case 25:
				print = "Middle Soul King";
				break;
			case 26:
				print = "Late Soul King";
				break;
			case 27:
				print = "Peak Soul King";
				break;
			case 28:
				print = "Middle Soul Emperor";
				break;
			case 29:
				print = "Late Soul Emperor";
				break;
			case 30:
				print = "Peak Soul Emperor";
				break;
		}
		outputText("<b>You're now "+print+".</b>\n\n");
		doNext(camp.returnToCampUseTwoHours);
	}
	public function SubPaths():void {
		menu();
		if (player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") >= 0) addButton(0, "Daoist", daoistSubPath).hint("Contemplate mysteries from 'My Dao Sticks are better than Yours' daoist cultivation manual.");
		if (player.hasKeyItem("Cultivation Manual: Body like a Coke Fiend") >= 0) addButton(5, "BodyCult", bodycultivationSubPath).hint("Contemplate mysteries from 'Body like a Coke Fiend' body cultivation manual.");
		//if (player.hasKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil") >= 0) addButton(10, "HeartCult", );
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function daoistSubPath():void {
		menu();
		addButtonIfTrue(0, "Apprentice", daoistSubPath1, "You already reached this stage.", !player.hasPerk(PerkLib.DaoistApprenticeStage));
		addButtonIfTrue(1, "Warrior", daoistSubPath2, "You already reached this stage.", !player.hasPerk(PerkLib.DaoistWarriorStage));
		addButtonIfTrue(2, "Elder", daoistSubPath3, "You already reached this stage.", !player.hasPerk(PerkLib.DaoistElderStage));
		addButtonIfTrue(3, "Overlord", daoistSubPath4, "You already reached this stage.", !player.hasPerk(PerkLib.DaoistOverlordStage));
		addButton(14, "Back", SubPaths);
	}
	public function daoistSubPath1():void {
		clearOutput();
		if (player.hasItem(consumables.LGSFRPB, 1) || player.hasItem(consumables.LG_SFRP, 10)) {
			if (player.hasItem(consumables.LGSFRPB, 1)) player.destroyItems(consumables.LGSFRPB, 1);
			else player.destroyItems(consumables.LG_SFRP, 10);
			//outputText("\n\n");
			outputText("<b>Gained perk: Daoist: Apprentice Stage</b>\n\n");
			player.createPerk(PerkLib.DaoistApprenticeStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			outputText("Lacking bottle of low-grade Soulforce Recover Pills OR 10 low-grade Soulforce Recover Pills.");
			doNext(daoistSubPath);
		}
	}
	public function daoistSubPath2():void {
		clearOutput();
		if (player.hasItem(consumables.MGSFRPB, 1) || player.hasItem(consumables.MG_SFRP, 10)) {
			if (player.hasItem(consumables.MGSFRPB, 1)) player.destroyItems(consumables.MGSFRPB, 1);
			else player.destroyItems(consumables.MG_SFRP, 10);
			//outputText("\n\n");
			outputText("<b>Gained perk: Daoist: Warrior Stage</b>\n\n");
			player.createPerk(PerkLib.DaoistWarriorStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			if (!player.hasPerk(PerkLib.SoulSprite)) outputText("Lacking high enough cultivation base. Try again after becoming Soul Sprite.");
			else outputText("Lacking bottle of mid-grade Soulforce Recover Pills OR 10 mid-grade Soulforce Recover Pills.");
			doNext(daoistSubPath);
		}
	}
	public function daoistSubPath3():void {
		clearOutput();
		if (player.hasItem(consumables.HGSFRPB, 1) || player.hasItem(consumables.HG_SFRP, 10)) {
			if (player.hasItem(consumables.HGSFRPB, 1)) player.destroyItems(consumables.HGSFRPB, 1);
			else player.destroyItems(consumables.HG_SFRP, 10);
			//outputText("\n\n");
			outputText("<b>Gained perk: Daoist: Elder Stage</b>\n\n");
			player.createPerk(PerkLib.DaoistElderStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			if (!player.hasPerk(PerkLib.SoulExalt)) outputText("Lacking high enough cultivation base. Try again after becoming Soul Exalt.");
			else outputText("Lacking bottle of high-grade Soulforce Recover Pills OR 10 high-grade Soulforce Recover Pills.");
			doNext(daoistSubPath);
		}
	}
	public function daoistSubPath4():void {
		clearOutput();
		if (player.hasItem(consumables.SGSFRPB, 1) || player.hasItem(consumables.SG_SFRP, 10)) {
			if (player.hasItem(consumables.SGSFRPB, 1)) player.destroyItems(consumables.SGSFRPB, 1);
			else player.destroyItems(consumables.SG_SFRP, 10);
			//outputText("\n\n");
			outputText("<b>Gained perk: Daoist: Overlord Stage</b>\n\n");
			player.createPerk(PerkLib.DaoistOverlordStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			if (!player.hasPerk(PerkLib.SoulKing)) outputText("Lacking high enough cultivation base. Try again after becoming Soul King.");
			else outputText("Lacking bottle of superior-grade Soulforce Recover Pills OR 10 superior-grade Soulforce Recover Pills.");
			doNext(daoistSubPath);
		}
	}
	public function bodycultivationSubPath():void {
		menu();
		addButtonIfTrue(0, "Apprentice", bodycultivationSubPath1, "You already reached this stage.", !player.hasPerk(PerkLib.FleshBodyApprenticeStage));
		addButtonIfTrue(1, "Warrior", bodycultivationSubPath2, "You already reached this stage.", !player.hasPerk(PerkLib.FleshBodyWarriorStage));
		addButtonIfTrue(2, "Elder", bodycultivationSubPath3, "You already reached this stage.", !player.hasPerk(PerkLib.FleshBodyElderStage));
		addButtonIfTrue(3, "Overlord", bodycultivationSubPath4, "You already reached this stage.", !player.hasPerk(PerkLib.FleshBodyOverlordStage));
		addButton(14, "Back", SubPaths);
	}
	public function bodycultivationSubPath1():void {
		clearOutput();
		if (player.hasItem(consumables.LGSFRPB, 2) && player.hasItem(useables.BTSOLUTION, 2)) {
			player.destroyItems(consumables.LGSFRPB, 2);
			player.destroyItems(useables.BTSOLUTION, 2);
			//outputText("\n\n");
			outputText("<b>Gained perk: Flesh Body: Apprentice Stage</b>\n\n");
			player.createPerk(PerkLib.FleshBodyApprenticeStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			outputText("Lacking 2 bottles of low-grade Soulforce Recover Pills and 2 vials of Body Tempering solution.");
			doNext(bodycultivationSubPath);
		}
	}
	public function bodycultivationSubPath2():void {
		clearOutput();
		if (player.hasItem(consumables.MGSFRPB, 2) && player.hasItem(useables.BTSOLUTION, 4)) {
			player.destroyItems(consumables.MGSFRPB, 2);
			player.destroyItems(useables.BTSOLUTION, 4);
			//outputText("\n\n");
			outputText("<b>Gained perk: Flesh Body: Warrior Stage</b>\n\n");
			player.createPerk(PerkLib.FleshBodyWarriorStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			if (!player.hasPerk(PerkLib.SoulSprite)) outputText("Lacking high enough cultivation base. Try again after becoming Soul Sprite.");
			else outputText("Lacking 2 bottles of mid-grade Soulforce Recover Pills and 4 vials of Body Tempering solution.");
			doNext(bodycultivationSubPath);
		}
	}
	public function bodycultivationSubPath3():void {
		clearOutput();
		if (player.hasItem(consumables.HGSFRPB, 2) && player.hasItem(useables.BTSOLUTION, 6)) {
			player.destroyItems(consumables.HGSFRPB, 2);
			player.destroyItems(useables.BTSOLUTION, 6);
			//outputText("\n\n");
			outputText("<b>Gained perk: Flesh Body: Elder Stage</b>\n\n");
			player.createPerk(PerkLib.FleshBodyElderStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			if (!player.hasPerk(PerkLib.SoulExalt)) outputText("Lacking high enough cultivation base. Try again after becoming Soul Exalt.");
			else outputText("Lacking 2 bottles of high-grade Soulforce Recover Pills and 6 vials of Body Tempering solution.");
			doNext(bodycultivationSubPath);
		}
	}
	public function bodycultivationSubPath4():void {
		clearOutput();
		if (player.hasItem(consumables.SGSFRPB, 2) && player.hasItem(useables.BTSOLUTION, 8)) {
			player.destroyItems(consumables.SGSFRPB, 2);
			player.destroyItems(useables.BTSOLUTION, 8);
			//outputText("\n\n");
			outputText("<b>Gained perk: Flesh Body: Overlord Stage</b>\n\n");
			player.createPerk(PerkLib.FleshBodyOverlordStage, 0, 0, 0, 0);
			doNext(camp.returnToCampUseFourHours);
		}
		else {
			if (!player.hasPerk(PerkLib.SoulKing)) outputText("Lacking high enough cultivation base. Try again after becoming Soul King.");
			else outputText("Lacking 2 bottles of superior-grade Soulforce Recover Pills and 8 vials of Body Tempering solution.");
			doNext(bodycultivationSubPath);
		}
	}/*
	public function Contemplations0():void {
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and begin to cultivated according to the manual.  Minute after minute you feel your inner soulforce slowly starting to circle inside your body.  It's very slowly circling within yourself.\n\n");
		outputText("After two hours you not felt any change. A bit of shame but maybe next time you will gain some enlightenment.\n\n");
		doNext(camp.returnToCampUseTwoHours);
	}
	*/

	public function tribulationsPrompt():void {
		clearOutput();
		outputText("Something within you speaks. You can sense that you’ve nearly reached the pinnacle of cultivation as a Soul ");
		if (player.level >= 126 && !player.hasPerk(PerkLib.SoulAncestor)) outputText("Emperor");
		else if (player.level >= 102 && !player.hasPerk(PerkLib.SoulKing)) outputText("Tyrant");
		else if (player.level >= 78 && !player.hasPerk(PerkLib.SoulOverlord)) outputText("Exalt");
		else if (player.level >= 54 && !player.hasPerk(PerkLib.SoulElder)) outputText("Grandmaster");
		else outputText("Warrior");
		outputText(". Now, only a tiny step is needed to advance further.");
		outputText("\n\nThough, you pause. It’s a feeling so close, yet so far. Do you progress your skills naturally, or push for the goal that you’ve worked so hard to achieve.");
		menu();
		addButton(1, "No", tribulationsPromptNo);
		addButton(3, "Yes", tribulationsPromptYes);
	}
	public function tribulationsPromptYes():void {
		clearOutput();
		outputText("There’s no use in delaying the inevitable. You do not fear the tribulation, you know you’re ready.");
		outputText("\n\nYou know it’s time to give it your all. With determination and force of will, you cannot fail.");
		player.createStatusEffect(StatusEffects.TribulationCountdown, (2 + rand(4)), 0, 0, 0);
		doNext(playerMenu);
	}
	public function tribulationsPromptNo():void {
		clearOutput();
		outputText("As you pause, you know it’s not time yet. You can suppress your soulforce until it’s time for the tribulation to descend. Hopefully, then you’ll be ready.");
		doNext(accessSoulforceMenu);
	}

	public function DaoContemplations():void {
		clearOutput();
		outputText("Which Dao would you try to comprehend?\n\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfFire)) outputText("Fire: "+player.statusEffectv1(StatusEffects.DaoOfFire)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfIce)) outputText("Ice: "+player.statusEffectv1(StatusEffects.DaoOfIce)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfLightning)) outputText("Lightning: "+player.statusEffectv1(StatusEffects.DaoOfLightning)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfDarkness)) outputText("Darkness: "+player.statusEffectv1(StatusEffects.DaoOfDarkness)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfPoison)) outputText("Poison: "+player.statusEffectv1(StatusEffects.DaoOfPoison)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfWind)) outputText("Wind: "+player.statusEffectv1(StatusEffects.DaoOfWind)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfBlood)) outputText("Blood: "+player.statusEffectv1(StatusEffects.DaoOfBlood)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfWater)) outputText("Water: "+player.statusEffectv1(StatusEffects.DaoOfWater)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfEarth)) outputText("Earth: "+player.statusEffectv1(StatusEffects.DaoOfEarth)+"\n");
		if (player.hasStatusEffect(StatusEffects.DaoOfAcid)) outputText("Acid: "+player.statusEffectv1(StatusEffects.DaoOfAcid)+"\n");
		menu();
		if (player.statusEffectv2(StatusEffects.DaoOfFire) == highestLayerOfDaoComprehension()) addButtonDisabled(0, "Fire", "You reached limit of comprehending this Dao.");
		else addButton(0, "Fire", DaoContemplationsEffect, StatusEffects.DaoOfFire, "Fire");
		if (player.statusEffectv2(StatusEffects.DaoOfIce) == highestLayerOfDaoComprehension()) addButtonDisabled(1, "Ice", "You reached limit of comprehending this Dao.");
		else addButton(1, "Ice", DaoContemplationsEffect, StatusEffects.DaoOfIce, "Ice");
		if (player.statusEffectv2(StatusEffects.DaoOfLightning) == highestLayerOfDaoComprehension()) addButtonDisabled(2, "Lightning", "You reached limit of comprehending this Dao.");
		else addButton(2, "Lightning", DaoContemplationsEffect, StatusEffects.DaoOfLightning, "Lightning");
		if (player.statusEffectv2(StatusEffects.DaoOfDarkness) == highestLayerOfDaoComprehension()) addButtonDisabled(3, "Darkness", "You reached limit of comprehending this Dao.");
		else addButton(3, "Darkness", DaoContemplationsEffect, StatusEffects.DaoOfDarkness, "Darkness");
		if (player.statusEffectv2(StatusEffects.DaoOfPoison) == highestLayerOfDaoComprehension()) addButtonDisabled(4, "Poison", "You reached limit of comprehending this Dao.");
		else addButton(4, "Poison", DaoContemplationsEffect, StatusEffects.DaoOfPoison, "Poison");
		if (player.statusEffectv2(StatusEffects.DaoOfWind) == highestLayerOfDaoComprehension()) addButtonDisabled(5, "Wind", "You reached limit of comprehending this Dao.");
		else addButton(5, "Wind", DaoContemplationsEffect, StatusEffects.DaoOfWind, "Wind");
		if (player.statusEffectv2(StatusEffects.DaoOfBlood) == highestLayerOfDaoComprehension()) addButtonDisabled(6, "Blood", "You reached limit of comprehending this Dao.");
		else addButton(6, "Blood", DaoContemplationsEffect, StatusEffects.DaoOfBlood, "Blood");
		if (player.statusEffectv2(StatusEffects.DaoOfWater) == highestLayerOfDaoComprehension()) addButtonDisabled(7, "Water", "You reached limit of comprehending this Dao.");
		else addButton(7, "Water", DaoContemplationsEffect, StatusEffects.DaoOfWater, "Water");
		if (player.statusEffectv2(StatusEffects.DaoOfEarth) == highestLayerOfDaoComprehension()) addButtonDisabled(8, "Earth", "You reached limit of comprehending this Dao.");
		else addButton(8, "Earth", DaoContemplationsEffect, StatusEffects.DaoOfEarth, "Earth");
		if (player.statusEffectv2(StatusEffects.DaoOfAcid) == highestLayerOfDaoComprehension()) addButtonDisabled(9, "Acid", "You reached limit of comprehending this Dao.");
		else addButton(9, "Acid", DaoContemplationsEffect, StatusEffects.DaoOfAcid, "Acid");
		addButton(14, "Back", accessSoulforceMenu);
	}
	private function DaoContemplationsEffect(statusEffect:StatusEffectType, daoname:String):void {
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and contemplate.  Minute after minute you feel immersed into elements that surrounds you.  How they flow around you, how they change on their own and how they interact with each other.  All this while trying to understand, despite being insignificant while the great dao manifests around you.\n\n");
		var dao:Number = rand(6);
		switch(daoname){
			case "Fire":
				if (player.hasPerk(PerkLib.FireAffinity)) dao += 1 + rand(3);
				break;
			case "Ice":
				if (player.hasPerk(PerkLib.ColdAffinity)) dao += 1 + rand(3);
				break;
			case "Lightning":
				if (player.hasPerk(PerkLib.LightningAffinity)) dao += 1 + rand(3);
				break;
			case "Darkness":
				if (player.hasPerk(PerkLib.DarknessAffinity)) dao += 1 + rand(3);
				break;
		}
		//uzycie w kontemplacji niebianskich skarbow zwiazanych z danym zywiolem daje bonusowe punkty
		if (dao > 0) {
			outputText("After the session ends you managed to progress in Dao of "+daoname+".");
			if (player.hasStatusEffect(statusEffect)) {
				player.addStatusValue(statusEffect, 1, dao);
				if (player.statusEffectv1(statusEffect) > 300 && player.statusEffectv2(statusEffect) == 8) {
					player.addStatusValue(statusEffect, 1, -300);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 9th layer. (To reach 10th layer you need to be at least Early Soul Ancestor)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 260 && player.statusEffectv2(statusEffect) == 7) {
					player.addStatusValue(statusEffect, 1, -260);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 8th layer. (To reach 9th layer you need to be at least Early Soul Emperor)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 220 && player.statusEffectv2(statusEffect) == 6) {
					player.addStatusValue(statusEffect, 1, -220);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 7th layer. (To reach 8th layer you need to be at least Early Soul King)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 180 && player.statusEffectv2(statusEffect) == 5) {
					player.addStatusValue(statusEffect, 1, -180);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 6th layer. (To reach 7th layer you need to be at least Early Soul Tyrant)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 140 && player.statusEffectv2(statusEffect) == 4) {
					player.addStatusValue(statusEffect, 1, -140);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 5th layer. (To reach 6th layer you need to be at least Early Soul Overlord)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 100 && player.statusEffectv2(statusEffect) == 3) {
					player.addStatusValue(statusEffect, 1, -100);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 4th layer. (To reach 5th layer you need to be at least Early Soul Exalt)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 60 && player.statusEffectv2(statusEffect) == 2) {
					player.addStatusValue(statusEffect, 1, -60);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 3rd layer. (To reach 4th layer you need to be at least Early Soul Elder)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 40 && player.statusEffectv2(statusEffect) == 1) {
					player.addStatusValue(statusEffect, 1, -40);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 2nd layer. (To reach 3rd layer you need to be at least Early Soul Grandmaster)</b>");
				}
				if (player.statusEffectv1(statusEffect) > 20 && player.statusEffectv2(statusEffect) == 0) {
					player.addStatusValue(statusEffect, 1, -20);
					player.addStatusValue(statusEffect, 2, 1);
					outputText("\n\n<b>Your comprehension reached 1st layer. (To reach 2nd layer you need to be at least Early Soul Scholar)</b>");
				}
			}
			else player.createStatusEffect(statusEffect, dao, 0, 0, 0);
		}
		else outputText("After the session ends, you did not manage to progress in your comprehension.");
		outputText("\n\n");
		doNext(camp.returnToCampUseEightHours);
	}
	public function DaoContemplationsEffectClone(statusEffect:StatusEffectType, daoname:String):void {
		player.addStatusValue(statusEffect, 1, 1);
		if (player.statusEffectv1(statusEffect) > 300 && player.statusEffectv2(statusEffect) == 8) {
			player.addStatusValue(statusEffect, 1, -300);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 9th layer. (To reach 10th layer you need to be at least Early Soul Ancestor)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 260 && player.statusEffectv2(statusEffect) == 7) {
			player.addStatusValue(statusEffect, 1, -260);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 8th layer. (To reach 9th layer you need to be at least Early Soul Emperor)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 220 && player.statusEffectv2(statusEffect) == 6) {
			player.addStatusValue(statusEffect, 1, -220);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 7th layer. (To reach 8th layer you need to be at least Early Soul King)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 180 && player.statusEffectv2(statusEffect) == 5) {
			player.addStatusValue(statusEffect, 1, -180);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 6th layer. (To reach 7th layer you need to be at least Early Soul Tyrant)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 140 && player.statusEffectv2(statusEffect) == 4) {
			player.addStatusValue(statusEffect, 1, -140);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 5th layer. (To reach 6th layer you need to be at least Early Soul Overlord)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 100 && player.statusEffectv2(statusEffect) == 3) {
			player.addStatusValue(statusEffect, 1, -100);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 4th layer. (To reach 5th layer you need to be at least Early Soul Exalt)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 60 && player.statusEffectv2(statusEffect) == 2) {
			player.addStatusValue(statusEffect, 1, -60);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 3rd layer. (To reach 4th layer you need to be at least Early Soul Elder)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 40 && player.statusEffectv2(statusEffect) == 1) {
			player.addStatusValue(statusEffect, 1, -40);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 2nd layer. (To reach 3rd layer you need to be at least Early Soul Grandmaster)</b>");
		}
		if (player.statusEffectv1(statusEffect) > 20 && player.statusEffectv2(statusEffect) == 0) {
			player.addStatusValue(statusEffect, 1, -20);
			player.addStatusValue(statusEffect, 2, 1);
			outputText("\n<b>Due to your clone contemplations your comprehension in Dao of "+daoname+" reached 1st layer. (To reach 2nd layer you need to be at least Early Soul Scholar)</b>");
		}
	}
	public function highestLayerOfDaoComprehension():Number {
		var hLrODC:Number = 1;
		hLrODC += (player.perkv2(PerkLib.JobSoulCultivator) - 4);
		return hLrODC;
	}
	public function SoulforceRegeneration1():void {
		clearOutput();
		var soulforceamountrestored:int = 16;
		soulforceamountrestored += SoulforceRegeneration00();
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 16;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 16;
		player.soulforce += soulforceamountrestored;
		if (SoulforceRegenerationCompatibileTrainingItems()) {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1();
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(20);
		doNext(camp.returnToCampUseOneHour);
	}
	public function SoulforceRegeneration2():void {
		clearOutput();
		var soulforceamountrestored:int = 52;
		soulforceamountrestored += (SoulforceRegeneration00() * 3);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 52;//48(4)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 52;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 52;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 2;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(40);
		doNext(camp.returnToCampUseTwoHours);
	}
	public function SoulforceRegeneration3():void {
		clearOutput();
		var soulforceamountrestored:int = 124;
		soulforceamountrestored += (SoulforceRegeneration00() * 7);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 124;//112(12)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 124;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 124;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 4;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(80);
		doNext(camp.returnToCampUseFourHours);
	}
	public function SoulforceRegeneration4():void {
		clearOutput();
		var soulforceamountrestored:int = 196;
		soulforceamountrestored += (SoulforceRegeneration00() * 11);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 196;//176(20)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 196;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 196;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 6;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(120);
		doNext(camp.returnToCampUseSixHours);
	}
	public function SoulforceRegeneration5():void {
		clearOutput();
		var soulforceamountrestored:int = 268;
		soulforceamountrestored += (SoulforceRegeneration00() * 15);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 268;//240(28)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 268;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 268;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 8;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(160);
		doNext(camp.returnToCampUseEightHours);
	}
	public function SoulforceRegeneration6():void {
		clearOutput();
		var soulforceamountrestored:int = 340;
		soulforceamountrestored += (SoulforceRegeneration00() * 19);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 340;//304(36)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 340;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 340;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 10;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(200);
		doNext(camp.returnToCampUseTenHours);
	}
	public function SoulforceRegeneration7():void {
		clearOutput();
		var soulforceamountrestored:int = 412;
		soulforceamountrestored += (SoulforceRegeneration00() * 23);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 412;//368(44)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 412;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 412;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 12;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(240);
		doNext(camp.returnToCampUseTwelveHours);
	}
	public function SoulforceRegeneration8():void {
		clearOutput();
		var soulforceamountrestored:int = 484;
		soulforceamountrestored += (SoulforceRegeneration00() * 27);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 484;//432(52)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 484;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 484;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 14;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(280);
		doNext(camp.returnToCampUseFourteenHours);
	}
	public function SoulforceRegeneration9():void {
		clearOutput();
		var soulforceamountrestored:int = 556;
		soulforceamountrestored += (SoulforceRegeneration00() * 31);
		if (player.hasPerk(PerkLib.DaoistCultivator)) soulforceamountrestored += 556;//496(60)
		if (player.hasPerk(PerkLib.SoulApprentice)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulPersonage)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulWarrior)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulSprite)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulScholar)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulElder)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulExalt)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulOverlord)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulTyrant)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulKing)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulEmperor)) soulforceamountrestored += 556;
		if (player.hasPerk(PerkLib.SoulAncestor)) soulforceamountrestored += 556;
		player.soulforce += soulforceamountrestored;
		if (player.weaponName == "training soul axe" || player.weaponRangeName == "training soul crossbow" || player.shieldName == "training soul buckler" || player.armorName == "training soul armor" || player.upperGarmentName == "soul training shirt" || player.lowerGarmentName == "soul training panties"
				|| player.headjewelryName == "training soul hairpin" || player.necklaceName == "training soul necklace" || player.jewelryName == "training soul ring" || player.jewelryName2 == "training soul ring" || player.jewelryName3 == "training soul ring" || player.jewelryName4 == "training soul ring") {
			var bonussoulforce:Number = 0;
			bonussoulforce += SoulforceGainedFromCultivation1() * 16;
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2] = bonussoulforce;
			SoulforceGainedFromCultivation2();
		}
		if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
		outputText("You find a flat, comfortable rock to sit down on and meditate.  Minute after minute you feel how lost earlier soulforce starting to be slowly replenished.\n\n");
		outputText("Spent time allowed you to restore " + soulforceamountrestored + " soulforce.\n\n");
		outputText("Current soulpower: " + player.soulforce + " / " + player.maxSoulforce());
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(320);
		doNext(camp.returnToCampUseSixteenHours);
	}
	public function SoulforceGainedFromCultivation1():Number {
		var cumulativegains:Number = 0;
		if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor" && player.upperGarmentName == "soul training shirt" && player.lowerGarmentName == "soul training panties"
				&& player.headjewelryName == "training soul hairpin" && player.necklaceName == "training soul necklace" && player.jewelryName == "training soul ring" && player.jewelryName2 == "training soul ring" && player.jewelryName3 == "training soul ring" && player.jewelryName4 == "training soul ring"
				&& player.weaponFlyingSwordsName == "training soul flying sword") {
			cumulativegains += 28;//+130% jak wszystkie 13 slotów - każdy kolejny dodany slot dodaje kolejne 10%
		}
		else if (player.weaponName == "training soul axe" && player.weaponRangeName == "training soul crossbow" && player.shieldName == "training soul buckler" && player.armorName == "training soul armor" && player.upperGarmentName == "soul training shirt" && player.lowerGarmentName == "soul training panties"
				&& player.headjewelryName == "training soul hairpin" && player.necklaceName == "training soul necklace" && player.jewelryName == "training soul ring") {
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
			if (player.jewelryName2 == "training soul ring") cumulativegains += 1;
			if (player.jewelryName3 == "training soul ring") cumulativegains += 1;
			if (player.jewelryName4 == "training soul ring") cumulativegains += 1;
			if (player.weaponFlyingSwordsName == "training soul flying sword") cumulativegains += 1;
		}
		return cumulativegains;
	}
	public function SoulforceGainedFromCultivation2():void {
		var bonussoulforce2:Number = 0;//razem może mieć max 2330
		if (player.weaponName == "training soul axe") bonussoulforce2 += 80;
		if (player.weaponRangeName == "training soul crossbow") bonussoulforce2 += 50;
		if (player.shieldName == "training soul buckler") bonussoulforce2 += 60;
		if (player.armorName == "training soul armor") bonussoulforce2 += 240;
		if (player.upperGarmentName == "soul training shirt") bonussoulforce2 += 200;
		if (player.lowerGarmentName == "soul training panties") bonussoulforce2 += 200;
		if (player.headjewelryName == "training soul hairpin") bonussoulforce2 += 200;
		if (player.necklaceName == "training soul necklace") bonussoulforce2 += 300;
		if (player.jewelryName == "training soul ring") bonussoulforce2 += 100;
		if (player.jewelryName2 == "training soul ring") bonussoulforce2 += 100;
		if (player.jewelryName3 == "training soul ring") bonussoulforce2 += 100;
		if (player.jewelryName4 == "training soul ring") bonussoulforce2 += 100;
		if (player.weaponFlyingSwordsName == "training soul flying sword") bonussoulforce2 += 500;
		if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > 0) {
			if ((bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]) > flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2]) flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING_2];
			else flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += (bonussoulforce2 - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]);
		}
	}
	public function AmountOfSoulforceRecoveredDuringCultivation(mod:Number):Number {
		var costPercent:Number = 100;
		var tier:int;

		tier = player.racialTier(Races.KITSUNE);
		if (tier >= 4) costPercent += 1000;
		else if (tier == 3) costPercent += 650;
		else if (tier == 2) costPercent += 400;
		else if (tier == 1) costPercent += 200;

		tier = player.racialTier(Races.NEKOMATA);
		if (tier >= 2) costPercent += 200;
		else if (tier == 1) costPercent += 100;

		if (player.hasPerk(PerkLib.DaoistCultivator)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistWarriorStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistElderStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistOverlordStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.DaoistTyrantStage)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulApprentice)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulPersonage)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulWarrior)) costPercent += 100;
		if (player.hasPerk(PerkLib.SoulSprite)) costPercent += 150;
		if (player.hasPerk(PerkLib.SoulScholar)) costPercent += 150;
		if (player.hasPerk(PerkLib.SoulElder)) costPercent += 150;
		if (player.hasPerk(PerkLib.SoulExalt)) costPercent += 200;
		if (player.hasPerk(PerkLib.SoulOverlord)) costPercent += 200;
		if (player.hasPerk(PerkLib.SoulTyrant)) costPercent += 200;
		if (player.hasPerk(PerkLib.SoulKing)) costPercent += 250;
		if (player.hasPerk(PerkLib.SoulEmperor)) costPercent += 250;
		if (player.hasPerk(PerkLib.SoulAncestor)) costPercent += 250;
		mod *= costPercent/100;
		return mod;
	}
	public function SelfSustain():void {
		clearOutput();
		outputText("Use some of your soulforce to partialy sate your hunger. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		menu();
		addButton(0, "V. Low", SelfSustain1).hint("Spend 50 soulforce for 10 hunger.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "Low", SelfSustain2).hint("Spend 100 soulforce for 20 hunger.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "Low-Med", SelfSustain3).hint("Spend 200 soulforce for 40 hunger.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "Medium", SelfSustain4).hint("Spend 400 soulforce for 80 hunger.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(4, "High-Med", SelfSustain5).hint("Spend 800 soulforce for 160 hunger.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(5, "High", SelfSustain6).hint("Spend 1600 soulforce for 320 hunger.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(6, "V. High", SelfSustain7).hint("Spend 3200 soulforce for 640 hunger.");
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
	public function SelfSustain6():void {
		clearOutput();
		if (player.soulforce >= 1600) {
			outputText("Consuming below averange amount of your soulforce you feel your hungry decreasing very noticable.");
			player.soulforce -= 1600;
			player.refillHunger(320);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(320);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(SelfSustain);
		}
	}
	public function SelfSustain7():void {
		clearOutput();
		if (player.soulforce >= 3200) {
			outputText("Consuming a bit below averange amount of your soulforce you feel your hungry decreasing by large margin.");
			player.soulforce -= 3200;
			player.refillHunger(640);
			if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(640);
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
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "Low", RepresLust2).hint("Spend 80 soulforce for 40 lust.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "Low-med", RepresLust3).hint("Spend 200 soulforce for 100 lust.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "Medium", RepresLust4).hint("Spend 400 soulforce for 200 lust.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(4, "High-Med", RepresLust5).hint("Spend 800 soulforce for 400 lust.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(5, "High", RepresLust6).hint("Spend 1600 soulforce for 800 lust.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(6, "V. High", RepresLust7).hint("Spend 3200 soulforce for 1600 lust.");
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
			outputText("Consuming not a small amount of your soulforce bit above averange amount of your lust is gone.");
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
	public function RepresLust6():void {
		clearOutput();
		if (player.soulforce >= 1600) {
			outputText("Consuming below averange amount of your soulforce high amount of your lust is gone.");
			player.soulforce -= 1600;
			player.lust -= 800;
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
	public function RepresLust7():void {
		clearOutput();
		if (player.soulforce >= 3200) {
			outputText("Consuming a bit below averange amount of your soulforce most of your lust is gone.");
			player.soulforce -= 3200;
			player.lust -= 1600;
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
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(1, "200", Covert200Soulforce).hint("Convert 200 soulforce to 200 mana.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(2, "500", Covert500Soulforce).hint("Convert 500 soulforce to 500 mana.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(3, "1000", Covert1000Soulforce).hint("Convert 1000 soulforce to 1000 mana.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(4, "2000", Covert2000Soulforce).hint("Convert 2000 soulforce to 2000 mana.");
		addButton(5, "100", Covert100Mana).hint("Convert 100 mana to 50 soulforce.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(6, "200", Covert200Mana).hint("Convert 200 mana to 100 soulforce.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(7, "500", Covert500Mana).hint("Convert 500 mana to 250 soulforce.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(8, "1000", Covert1000Mana).hint("Convert 1000 mana to 500 soulforce.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(9, "2000", Covert2000Mana).hint("Convert 2000 mana to 1000 soulforce.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(10, "5000", Covert5000Soulforce).hint("Convert 5000 soulforce to 5000 mana.");
		if (player.hasPerk(PerkLib.SoulExalt)) addButton(11, "10000", Covert10000Soulforce).hint("Convert 10000 soulforce to 10000 mana.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(12, "5000", Covert5000Mana).hint("Convert 5000 mana to 2500 soulforce.");
		if (player.hasPerk(PerkLib.SoulExalt)) addButton(13, "10000", Covert10000Mana).hint("Convert 10000 mana to 5000 soulforce.");
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
	public function Covert5000Soulforce():void {
		clearOutput();
		if (player.soulforce >= 5000) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 5000;
			player.mana += 5000;
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
	public function Covert10000Soulforce():void {
		clearOutput();
		if (player.soulforce >= 10000) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			player.soulforce -= 10000;
			player.mana += 10000;
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
	public function Covert5000Mana():void {
		clearOutput();
		if (player.mana < 5000) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 5000;
			player.soulforce += 2500;
			if (player.soulforce > player.maxSoulforce()) player.soulforce = player.maxSoulforce();
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
	}
	public function Covert10000Mana():void {
		clearOutput();
		if (player.mana < 10000) {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
		else {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			player.mana -= 10000;
			player.soulforce += 5000;
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
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "Low", CorrDrop2).hint("Spend 200 soulforce for lowering corruption by 2.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "Medium", CorrDrop3).hint("Spend 500 soulforce for lowering corruption by 5.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "High", CorrDrop4).hint("Spend 1000 soulforce for lowering corruption by 10.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(4, "V. High", CorrDrop5).hint("Spend 2000 soulforce for lowering corruption by 20.");
		addButton(5, "V. Low", CorrRise1).hint("Spend 50 soulforce for rising corruption by 1.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(6, "Low", CorrRise2).hint("Spend 100 soulforce for rising corruption by 2.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(7, "Medium", CorrRise3).hint("Spend 250 soulforce for rising corruption by 5.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(8, "High", CorrRise4).hint("Spend 500 soulforce for rising corruption by 10.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(9, "V. High", CorrRise5).hint("Spend 1000 soulforce for rising corruption by 20.");
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
		if (flags[kFLAGS.SOUL_SENSE_TAMANI] >= 3 && player.hasCock() || !player.hasKeyItem("Deluxe Dildo")) addButton(0, "Tamani", TamaniEnc).hint("Req. 80+ soulforce");
		else addButtonDisabled(0, "Tamani", "");
		if (flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] >= 3) {
			if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] >= 16) {
				if (player.hasCock()) addButton(1, "Tamani D.", TamaniDaughtersEnc).hint("Req. at least 80+ soulforce (more daughters will increase needed SF)");
				else addButtonDisabled(1, "Tamani D.", "Req. to have cock of any type.");
			}
			else addButtonDisabled(1, "Tamani D.", "Req. to have 16+ (still alive) daughters with Tamani.");
		}
		else addButtonDisabled(1, "Tamani D.", "");
		if (flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] >= 3) addButton(2, "KitsuMansion", KitsuneMansion).hint("Req. 90+ soulforce");
		else addButtonDisabled(2, "KitsuMansion", "");
		if (flags[kFLAGS.SOUL_SENSE_IZUMI] >= 3) addButton(3, "Izumi", IzumiEnc).hint("Req. 300+ soulforce");
		else addButtonDisabled(3, "Izumi", "");
		//next page button?
		if (flags[kFLAGS.SOUL_SENSE_PRISCILLA] >= 3) addButton(5, "Priscilla", PriscillaEnc).hint("Req. 320+ soulforce");
		else addButtonDisabled(5, "Priscilla", "");
		if (flags[kFLAGS.SOUL_SENSE_MINOTAUR_SONS] >= 3) {
			if (flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] >= 3) {
				if (player.hasVagina()) addButton(6, "Mino Sons", MinotaurSonsEnc).hint("Req. at least 260+ soulforce (more sons will increase needed SF)");
				else addButtonDisabled(6, "Mino Sons", "Req. to have vagina.");
			}
			else addButtonDisabled(6, "Mino Sons", "Req. to have 3+ (still alive) minotaur sons.");
		}
		else addButtonDisabled(6, "Mino Sons", "");
		//button 7 - Sheila (non demon ver) find
		//button 8 - ?Behemoth find?
		//previous page button?
		if (flags[kFLAGS.SOUL_SENSE_WORLD_TREE] >= 1) addButton(10, "WorldTree", findWorldTree).hint("Req. 100+ soulforce");
		else addButtonDisabled(10, "WorldTree", "");
		//button 11
		if (flags[kFLAGS.SOUL_SENSE_GIACOMO] >= 3) addButton(12, "Giacomo", findGiacomo).hint("Req. 100+ soulforce");
		else addButtonDisabled(12, "Giacomo", "");
		addButton(13, "???", theUnknown).hint("Draw into your soulforce for soulsensing.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function TamaniEnc():void {
		if (player.soulforce >= 80) {
			player.soulforce -= 80;
			statScreenRefresh();
			tamaniScene.encounterTamani();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
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
			outputText("\n\nYour current soulforce is too low.");
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
			outputText("\n\nYour current soulforce is too low.");
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
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function PriscillaEnc():void {
		if (player.soulforce >= 320) {
			player.soulforce -= 320;
			statScreenRefresh();
			SceneLib.priscillaScene.goblinElderEncounter();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function MinotaurSonsEnc():void {
		if (player.soulforce >= 10 * (26 + Math.round((flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] - 3)/2))) {
			player.soulforce -= 10 * (26 + Math.round((flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] - 3)/2));
			statScreenRefresh();
			minotaurSonsScene.meetMinotaurSons();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	//button 7
	//button 8
	public function findWorldTree():void {
		if (player.soulforce >= 100) {
			player.soulforce -= 100;
			statScreenRefresh();
			worldtreeScene.YggdrasilDiscovery();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	//button 11
	public function findGiacomo():void {
		if (player.soulforce >= 100) {
			player.soulforce -= 100;
			statScreenRefresh();
			SceneLib.giacomoShop.giacomoEncounter();
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function theUnknown():void {
		if (player.soulforce >= 100) {
			player.soulforce -= 100;
			menu();
			statScreenRefresh();
			if (BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3 && BelisaFollower.BelisaEncounternum >= 1 && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(0, "???", belisatest).hint("Shy Spooder");
			if (!LilyFollower.LilyFollowerState && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(1, "???", lilytest).hint("Lewd Spooder");
			if (player.level >= 45 && TyrantiaFollower.TyrantiaFollowerStage < 4 && !TyrantiaFollower.TyraniaIsRemovedFromThewGame && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(2, "???", FightTyrantia).hint("Scary Spooder");
			if (player.level >= 3 && flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] > 0 && (flags[kFLAGS.IZMA_WORMS_SCARED] == 0 || !player.hasStatusEffect(StatusEffects.Infested)) && flags[kFLAGS.IZMA_FOLLOWER_STATUS] <= 0) addButton(3, "???", tigerSharkGal).hint("Tigershark Gal?");
			if (player.level >= 3 && flags[kFLAGS.DIANA_FOLLOWER] < 6 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.DianaOff)) addButton(4, "???", shyHealer).hint("Shy Healer");
			if (flags[kFLAGS.ISABELLA_PLAINS_DISABLED] == 0) addButton(5, "???", germanCow).hint("German Cow");
			if (player.level >= 3 && flags[kFLAGS.SAMIRAH_FOLLOWER] <= 9) addButton(6, "???", sneakOnThePlane).hint("F**king ??? on the Plane.");
			addButton(10, "???", returnToMonke);
			addButton(11, "???", dragON);
			addButton(14, "Back", SoulSense);
		}
		else {
			outputText("\n\nYour current soulforce is too low.");
			doNext(SoulSense);
		}
	}
	public function returnToMonke():void {
		clearOutput();
		outputText("A gigantic monkey and you. (placeholder text for now so not mind it and just kick the monkey ass)");
		flags[kFLAGS.SAIYAN_ENEMY_NUMBER_COUNTER] = 1;
		startCombat(new Oozaru());
	}
	public function dragON():void {
		SceneLib.ryubi.RyuBiEnterTheDragon();
	}
	public function lilytest():void {
		SceneLib.lily.lilyEncounter();
	}
	public function belisatest():void {
		SceneLib.belisa.subsequentEncounters();
	}
	public function FightTyrantia():void {
		clearOutput();
		if (TyrantiaFollower.TyrantiaFollowerStage > 2) SceneLib.tyrania.repeatEncounterBattlefield();
		else if (TyrantiaFollower.TyrantiaAffectionMeter > 40 && TyrantiaFollower.TyrantiaFollowerStage > 1) SceneLib.tyrania.encounterBattlefieldAfter40Affection();
		else if (TyrantiaFollower.TyrantiaFollowerStage > 0) SceneLib.tyrania.repeatEncounterBattlefield();
		else SceneLib.tyrania.firstEncounter();
	}
	public function tigerSharkGal():void {
		player.createStatusEffect(StatusEffects.NearWater,0,0,0,0);
		SceneLib.izmaScene.meetIzmaAtLake();
	}
	public function shyHealer():void {
		if ((flags[kFLAGS.DIANA_FOLLOWER] < 3 || flags[kFLAGS.DIANA_FOLLOWER] == 5) && flags[kFLAGS.DIANA_LVL_UP] >= 8) SceneLib.dianaScene.postNameEnc();
		else SceneLib.dianaScene.repeatEnc();
	}
	public function germanCow():void {
		SceneLib.isabellaScene.isabellaGreeting();
	}
	public function sneakOnThePlane():void {
		nagaScene.nagaEncounter();
	}
}
}