/**
 * ...
 * @author Ormael
 */
package classes.Scenes
{
import classes.*;
import classes.GlobalFlags.kFLAGS;
import classes.Items.FlyingSwords;
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

import coc.view.CoCButton;

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
		if (player.hasPerk(PerkLib.JobSoulCultivator)) dailySoulforceUsesLimit += 6;
		if (player.hasPerk(PerkLib.DaoistApprenticeStage)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.FleshBodyApprenticeStage)) dailySoulforceUsesLimit++;
		//if (player.hasPerk(PerkLib.)) dailySoulforceUsesLimit++;//heart cultivator path
		//if (player.hasPerk(PerkLib.)) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
		outputText("<b>Cultivation level:</b> " + flags[kFLAGS.SOUL_CULTIVATION] + "\n");
		outputText("<b>Additional Soulforce from training:</b> " + flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] + " % / "+Soulforce.cultivationBonusMaxSF_maxPossible+" %\n");
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
		//button 2 - ?
		if (flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT] < dailySoulforceUsesLimit) {
			addButton(3, "Self-sustain", SelfSustain).hint("Spend some soulforce on suppresing hunger for a while."); //zamiana soulforce na satiety w stosunku 1:5
			addButton(4, "Repres. Lust", RepresLust).hint("Spend some soulforce on calming your sexual urges."); //używanie soulforce do zmniejszania lust w stosunku 1:2
			addButton(8, "Adj. Corr.", CorruptionAndSoulforce).hint("Spend some soulforce on affecting your current corruption."); //używanie soulforce do zmniejszania corruption w stosunku 1:100 a zdobywanie corruption w stosunku 1:50
			addButton(9, "Mana", ManaAndSoulforce).hint("Convert some soulforce into mana or vice versa."); //używanie soulforce do zamiany na mane w stosunku 1:1 a many do soulforce 1:2, używalne nawet w walce też ale z wiekszym kosztem przeliczania czyli 1:2 i 1:4
		}
		else {
			addButtonDisabled(3, "Self-sustain", "Wait till new day arrive to use this option again.");
			addButtonDisabled(4, "Repres. Lust", "Wait till new day arrive to use this option again.");
			addButtonDisabled(8, "Adj. Corr.", "Wait till new day arrive to use this option again.");
			addButtonDisabled(9, "Mana", "Wait till new day arrive to use this option again.");
		}
		//addButton(5, "Upgrade", UpgradeItems).hint("."); //ulepszanie itemów
		if (player.hasPerk(PerkLib.FlyingSwordPath)) addButton(6, "Imprinting", ImprintingSF).hint("Imprint your SF to combine or seperate sets of flying swords.");
		else addButtonDisabled(6, "???", "Req. Flying Sword Path.");
		if (player.hasPerk(PerkLib.SoulSense)) addButton(7, "Soul Sense", SoulSense).hint("Use your soul sense to trigger specific encounters."); //używanie divine sense aby znaleść określone event encounters: Tamani (lvl 6+), Tamani daugthers (lvl 6+), Kitsune mansion (lvl 12+), Izumi (lvl 18/24+), itp.
		else addButtonDisabled(7, "???", "Req. Soul Sense.");
		//button 8 - ?
		if (player.hasPerk(PerkLib.Metamorph)) {
			if (player.blockingBodyTransformations()) addButtonDisabled(10, "Metamorph", "Your current body state prevents you from using Metamorph. (Either cure it or ascend to gain access to metamorph menu again)");
			else addButton(10, "Metamorph", SceneLib.metamorph.openMetamorph).hint("Use your soulforce to mold your body.");//używanie metamorfowania z użyciem soulforce
		}
		else addButtonDisabled(10, "???", "Req. Metamorph.");
		//button 11 - ?
		if (player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") >= 0 || player.hasKeyItem("Cultivation Manual: Body like a Coke Fiend") >= 0 || player.hasKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil") >= 0) addButton(12, "Sub-paths", SubPaths).hint("Contemplate mysteries on your choosen sub-path(s).");
		addButton(13, "Cultivation", Contemplations).hint("Contemplate mysteries of the world in attempt to progress your soul cultivation path.");
		addButton(14, "Back", playerMenu);
	}

	public function SoulCultivationLvL():void {
		var cultStanding:String = "";
		if (flags[kFLAGS.SOUL_CULTIVATION] >= 1) {
			cultStanding += ["", "Early", "Middle", "Late", "Peak", "Half-Step to"][player.perkv1(PerkLib.JobSoulCultivator)];
			cultStanding += " Soul ";
			cultStanding += ["", "Apprentice", "Personage", "Warrior", "Sprite", "Scholar", "Grandmaster", "Elder",
				"Exalt", "Overlord", "Tyrant", "King", "Emperor", "Ancestor", "Sage"][player.perkv2(PerkLib.JobSoulCultivator)];
		}
		else cultStanding = "Mortal";
		outputText("<b>Cultivation stage:</b> " + cultStanding + "\n");
	}


	public function SoulforceRegeneration():void {
		var hoursOpt:/*int*/Array = [1, 2, 4, 6, 8, 10, 12, 14, 16];
		menu();
		var btn:int = 0;
		for each(var hours:int in hoursOpt) {
			var timeS:String = hours == 1 ? "1 hour" : "" + hours + " hours";
			addButton(btn++, timeS, meditate, hours)
				.hint("Meditate for "+timeS+" (Allow to recover " + meditationPredict(hours)  + " soulforce).");
		}
		addButton(14, "Back", accessSoulforceMenu);
	}
	private function sfTrainingItems():int {
		var itemConds:/*Boolean*/Array = [
			player.weaponName == "training soul axe",
			player.weaponRangeName == "training soul crossbow",
			player.shieldName == "training soul buckler",
			player.armorName == "training soul armor",
			player.upperGarmentName == "soul training shirt",
			player.lowerGarmentName == "soul training panties",
			player.headjewelryName == "training soul hairpin",
			player.necklaceName == "training soul necklace",
			player.jewelryName == "training soul ring",
			player.jewelryName2 == "training soul ring",
			player.jewelryName3 == "training soul ring",
			player.jewelryName4 == "training soul ring",
			player.weaponFlyingSwordsName == "training soul flying sword",
		];
		var cnt:int = 0;
		for each(var itemCond:Boolean in itemConds)
			if (itemCond)
				++cnt;
		return cnt;
	}

	public function Contemplations():void {
		//Types: 0 - primary, 1 - secondary, 2 - tribulation
		var stages:Array = [
			// name, short, level, wisdom, soulforce, additional req, type (primary = true), perk (for primary), wisdom (for primary)
			//level - 3*stage
			//soulforce - 1/3 for secondary, full for primary
			/*0*/[0, "Early Soul Apprentice", "E.S.A.", 20, PerkLib.SoulApprentice],
			[1, "Middle Soul Apprentice", "M.S.A."],
			[1, "Late Soul Apprentice", "L.S.A."],
			/*3*/[0, "Early Soul Personage", "E.S.P.", 40, PerkLib.SoulPersonage],
			[1, "Middle Soul Personage", "M.S.P."],
			[1, "Late Soul Personage", "L.S.P."],
			/*6*/[0, "Early Soul Warrior", "E.S.W.", 60, PerkLib.SoulWarrior],
			[1, "Middle Soul Warrior", "M.S.W."],
			[1, "Late Soul Warrior", "L.S.W."],
			/*9*/[2, "Tribulation (H)", "Trib. (H)", 80],
			[1, "Middle Soul Sprite", "M.S.Sp."],
			[1, "Late Soul Sprite", "L.S.Sp."],
			/*12*/[0, "Early Soul Scholar", "E.S.Sc.", 100, PerkLib.SoulScholar],
			[1, "Middle Soul Scholar", "M.S.Sc."],
			[1, "Late Soul Scholar", "L.S.Sc."],
			/*15*/[0, "Early Soul Grandmaster", "E.S.Gm.", 120, PerkLib.SoulGrandmaster],
			[1, "Middle Soul Grandmaster", "M.S.Gm."],
			[1, "Late Soul Grandmaster", "L.S.Gm."],
			/*18*/[2, "Tribulation (G)", "Trib. (G)", 140],
			[1, "Middle Soul Elder", "M.S.El."],
			[1, "Late Soul Elder", "L.S.El."],
			[1, "Peak Soul Elder", "P.S.El."],
			/*22*/[0, "Early Soul Exalt", "E.S.Ex.", 170, PerkLib.SoulExalt],
			[1, "Middle Soul Exalt", "M.S.Ex."],
			[1, "Late Soul Exalt", "L.S.Ex."],
			[1, "Peak Soul Exalt", "P.S.Ex."],
			/*26*/[2, "Tribulation (F)", "Trib. (F)", 200],
			[1, "Middle Soul Overlord", "M.S.O."],
			[1, "Late Soul Overlord", "L.S.O."],
			[1, "Peak Soul Overlord", "P.S.O."],
			/*30*/[0, "Early Soul Tyrant", "E.S.T.", 230, PerkLib.SoulTyrant],
			[1, "Middle Soul Tyrant", "M.S.T."],
			[1, "Late Soul Tyrant", "L.S.T."],
			[1, "Peak Soul Tyrant", "P.S.T."],
			/*34*/[2, "Tribulation (FF)", "Trib. (FF)", 260],
			[1, "Middle Soul King", "M.S.K."],
			[1, "Late Soul King", "L.S.K."],
			[1, "Peak Soul King", "P.S.K."],
			/*38*/[0, "Early Soul Emperor", "E.S.E.", 290, PerkLib.SoulEmperor],
			[1, "Middle Soul Emperor", "M.S.E."],
			[1, "Late Soul Emperor", "L.S.E."],
			[1, "Peak Soul Emperor", "P.S.E."],
		];
		clearOutput();
		if (flags[kFLAGS.SOUL_CULTIVATION] > 0)
			outputText("<b>Current stage: " + stages[flags[kFLAGS.SOUL_CULTIVATION] - 1][1] + "</b>\n\n");
		menu();
		if (flags[kFLAGS.SOUL_CULTIVATION] < stages.length) {
			var stage:Array = stages[flags[kFLAGS.SOUL_CULTIVATION]];
			var level:int = flags[kFLAGS.SOUL_CULTIVATION] * 3;
			outputText("<b>Next stage: " + stage[1] + "</b>\n");
			outputText("Requirements:\n"
				+ "Level: " + level + "\n");
			if (stage[0] != 1) outputText("Wisdom: " + stage[3]);
			//Primary
			if (stage[0] == 0) addButton(0, stage[2], contPrimary, stage[1], stage[4])
				.disableIf(player.soulforce < player.maxSoulforce(), "Not enough soulforce, required: full");
			//Secondary
			else if (stage[0] == 1) addButton(0, stage[2], contSecondary, stage[1])
				.disableIf(player.soulforce < Math.round(player.maxSoulforce() * 0.3), "Not enough soulforce, required: " + Math.round(player.maxSoulforce() * 0.3));
			//Tribulation
			else addButton(0, stage[2], tribulationsPrompt)
				.disableIf(player.hasStatusEffect(StatusEffects.TribulationCountdown), "It's already coming.");
			//Requirements
			if (stage[0] != 1) button(0)
				.disableIf(player.wis < stage[3], "Your wisdom is too low, required: " + stage[3]);
			button(0).disableIf(player.level < level, "Your level is too low, required: " + level);
			//unique cases
			if (button(0).enabled) switch (flags[kFLAGS.SOUL_CULTIVATION]) {
				case 3:
					button(0).disableIf(!player.hasPerk(PerkLib.Dantain), "You have to visit another lecture.");
					break;
				case 6:
					button(0).disableIf(!player.hasPerk(PerkLib.SoulSense), "You have to visit another lecture and walk around a little.");
					break;
				case 9:
					button(0).disableIf(!player.hasKeyItem("Heavenly Tribulation: Myths and Facts"), "You have to visit another lecture.");
					break;
			}
		} else outputText("<b>MAXIMUM STAGE REACHED</b>");
		addButton(14, "Back", accessSoulforceMenu);
	}

	private function contShared(name:String):void {
		flags[kFLAGS.SOUL_CULTIVATION] += 1;
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and begin to cultivated according to the manual.  Minute after minute you feel your inner soulforce slowly starting to circle inside your body. Near the end you feel silent 'pop' inside your body as your cultivation base has made a breakthrough.\n\n");
		outputText("<b>You're now a " + name + ".</b>");
		doNext(camp.returnToCampUseTwoHours);
	}

	private function contPrimary(name:String, perk:PerkType):void {
		EngineCore.SoulforceChange(-player.maxSoulforce());
		player.addPerkValue(PerkLib.JobSoulCultivator, 2, 1);
		player.createPerk(perk, 0, 0, 0, 0);
		player.setPerkValue(PerkLib.JobSoulCultivator, 1, 1);
		contShared(name);
	}

	private function contSecondary(name:String):void {
		EngineCore.SoulforceChange(-Math.round(player.maxSoulforce() * 0.3));
		player.addPerkValue(PerkLib.JobSoulCultivator, 1, 1);
		contShared(name);
	}

	public function SubPaths():void {
		menu();
		if (player.hasKeyItem("Cultivation Manual: My Dao Sticks are better than Yours") >= 0) addButton(0, "Daoist", daoistSubPath).hint("Contemplate mysteries from 'My Dao Sticks are better than Yours' daoist cultivation manual.");
		if (player.hasKeyItem("Cultivation Manual: Body like a Coke Fiend") >= 0) addButton(5, "BodyCult", bodycultivationSubPath).hint("Contemplate mysteries from 'Body like a Coke Fiend' body cultivation manual.");
		//if (player.hasKeyItem("Cultivation Manual: Heart-shaped Eyed She-Devil") >= 0) addButton(10, "HeartCult", );
		addButton(14, "Back", accessSoulforceMenu);
	}

	public function daoistSubPath():void {
		var stages:Array = [
			["Apprentice", PerkLib.DaoistApprenticeStage, consumables.LGSFRPB, PerkLib.SoulApprentice],
			["Warrior", PerkLib.DaoistWarriorStage, consumables.MGSFRPB, PerkLib.SoulSprite],
			["Elder", PerkLib.DaoistElderStage, consumables.HGSFRPB, PerkLib.SoulExalt],
			["Overlord", PerkLib.DaoistOverlordStage, consumables.SGSFRPB, PerkLib.SoulKing],
		];
		menu();
		var i:int;
		for (i = 0; i < stages.length; ++i)
			addButton(i, stages[i][0], daoistSubPathChosen, stages[i][1], stages[i][2])
				.disableIf(!player.hasItem(stages[i][2]), "Requires " + (stages[i][2] as ItemType).longName)
				.disableIf(!player.hasPerk(stages[i][3]), "Requires perk: " + (stages[i][3] as PerkType).name())
				.disableIf(i != 0 && !player.hasPerk(stages[i - 1][1]), "You need to have achieved the previous stage first.")
				.disableIf(player.hasPerk(stages[i][1]), "You have already reached this stage.");
		addButton(14, "Back", SubPaths);
	}

	private function daoistSubPathChosen(perk:PerkType, bottle:ItemType):void {
		player.destroyItems(bottle, 1);
		player.createPerk(perk, 0, 0, 0, 0);
		outputText("\n\n<b>Gained perk - " + perk.name() + "</b>");
		doNext(camp.returnToCampUseFourHours);
	}
/*
	public function bodycultivationSubPath():void {
		var stages:Array = [
			["Apprentice", PerkLib.FleshBodyApprenticeStage, consumables.LGSFRPB, PerkLib.SoulApprentice],
			["Warrior", PerkLib.FleshBodyWarriorStage, consumables.MGSFRPB, PerkLib.SoulSprite],
			["Elder", PerkLib.FleshBodyElderStage, consumables.HGSFRPB, PerkLib.SoulExalt],
			["Overlord", PerkLib.FleshBodyOverlordStage, consumables.SGSFRPB, PerkLib.SoulKing],
		];
		menu();
		var i:int;
		for (i = 0; i < stages.length; ++i)
			addButton(i, stages[i][0], bodycultivationSubPathChosen, stages[i][1], stages[i][2], (i + 1) * 2)
				.disableIf(!player.hasItem(stages[i][2], 2) || !player.hasItem(useables.BTSOLUTION, (i + 1) * 2),
					"Requires 2 bottles" + (stages[i][2] as ItemType).longName.substr(8)
					+ " and " + ((i + 1) * 2) + " vials" + useables.BTSOLUTION.longName.substr(6))
				.disableIf(!player.hasPerk(stages[i][3]), "Requires perk: " + (stages[i][3] as PerkType).name())
				.disableIf(player.hasPerk(stages[i][1]), "You have already reached this stage.");
		addButton(14, "Back", SubPaths);
	}

	private function bodycultivationSubPathChosen(perk:PerkType, bottle:ItemType, btcnt:int):void {
		player.destroyItems(bottle, 2);
		player.destroyItems(useables.BTSOLUTION, btcnt);
		player.createPerk(perk, 0, 0, 0, 0);
		outputText("\n\n<b>Gained perk - " + perk.name() + "</b>");
		doNext(camp.returnToCampUseFourHours);
	}
*/
	public function bodycultivationSubPath():void {
		var stages:Array = [
			["Apprentice", PerkLib.FleshBodyApprenticeStage, consumables.LGSFRPB, PerkLib.SoulApprentice],
			["Warrior", PerkLib.FleshBodyWarriorStage, consumables.MGSFRPB, PerkLib.SoulSprite],
			["Elder", PerkLib.FleshBodyElderStage, consumables.HGSFRPB, PerkLib.SoulExalt],
			["Overlord", PerkLib.FleshBodyOverlordStage, consumables.SGSFRPB, PerkLib.SoulKing],
		];
		menu();
		var i:int;
		for (i = 0; i < stages.length; ++i)
			addButton(i, stages[i][0], bodycultivationSubPathChosen, stages[i][1], stages[i][2])
				.disableIf(!player.hasItem(stages[i][2], 1) || !player.hasItem(useables.BTSOLUTION, 1),
					"Requires 1 bottle of " + (stages[i][2] as ItemType).longName
					+ " and 1 vial of " + useables.BTSOLUTION.longName)
				.disableIf(!player.hasPerk(stages[i][3]), "Requires perk: " + (stages[i][3] as PerkType).name())
				.disableIf(i != 0 && !player.hasPerk(stages[i - 1][1]), "You need to have achieved the previous stage first.")
				.disableIf(player.hasPerk(stages[i][1]), "You have already reached this stage.");
		addButton(14, "Back", SubPaths);
	}

	private function bodycultivationSubPathChosen(perk:PerkType, bottle:ItemType):void {
		player.destroyItems(bottle, 1);
		player.destroyItems(useables.BTSOLUTION, 1);
		player.createPerk(perk, 0, 0, 0, 0);
		outputText("\n\n<b>Gained perk - " + perk.name() + "</b>");
		doNext(camp.returnToCampUseFourHours);
	}

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

	//Name, status, clone ID
	public static var daos:/*Array*/Array = [
		["Fire", StatusEffects.DaoOfFire, 11],
		["Ice", StatusEffects.DaoOfIce, 12],
		["Lightning", StatusEffects.DaoOfLightning, 13],
		["Darkness", StatusEffects.DaoOfDarkness, 14],
		["Poison", StatusEffects.DaoOfPoison, 15],
		["Wind", StatusEffects.DaoOfWind, 16],
		["Blood", StatusEffects.DaoOfBlood, 17],
		["Water", StatusEffects.DaoOfWater, 18],
		["Earth", StatusEffects.DaoOfEarth, 19],
		["Acid", StatusEffects.DaoOfAcid, 20],
	];

	public static var clones:/*StatusEffectType*/Array = [
		StatusEffects.PCClone1st,
		StatusEffects.PCClone2nd,
		StatusEffects.PCClone3rd,
		StatusEffects.PCClone4th,
	];
	
	public static const clonelevelcost:int = 9;

	public function DaoContemplations():void {
		clearOutput();
		outputText("Which Dao would you try to comprehend?\n\n");
		for (var i:int = 0; i < daos.length; ++i) {
			var dao:Array = daos[i];
			if (player.hasStatusEffect(dao[1]))
				outputText(dao[0] + ": Level - " + player.statusEffectv2(dao[1]) + ", Progress - " + player.statusEffectv1(dao[1]) + "\n");
			addButton(i, dao[0], daoContemplationsEffect, dao[1], dao[0])
				.disableIf(player.statusEffectv2(dao[1]) == highestLayerOfDaoComprehension(),
					"You have reached your current limit of comprehending for this Dao."
					+ (player.hasPerk(PerkLib.SoulEmperor) ? "Try to improve your soulforce skills to get further."
						: "\n<b>MAXIMUM LEVEL REACHED</b>"));
		}
		addButton(14, "Back", accessSoulforceMenu);
	}

	public function daoContemplationsEffect(statusEffect:StatusEffectType, daoname:String, clone:Boolean = false, elementalBody:Boolean = false):void {
		if (!clone && !elementalBody) {
			clearOutput();
			outputText("You find a flat, comfortable rock to sit down on and contemplate.  Minute after minute you feel immersed into elements that surrounds you.  How they flow around you, how they change on their own and how they interact with each other.  All this while trying to understand, despite being insignificant while the great dao manifests around you.\n\n");
		}
		var dao:int;
		if (clone) dao = 1;
		else {
			dao = rand(6);
			switch(daoname){
				case "Fire":
					if (player.hasAnyPerk(PerkLib.FireAffinity, PerkLib.AffinityIgnis)) dao += 1 + rand(3);
					break;
				case "Ice":
					if (player.hasAnyPerk(PerkLib.ColdAffinity, PerkLib.ColdMastery)) dao += 1 + rand(3);
					break;
				case "Lightning":
					if (player.hasPerk(PerkLib.LightningAffinity)) dao += 1 + rand(3);
					break;
				case "Darkness":
					if (player.hasPerk(PerkLib.DarknessAffinity)) dao += 1 + rand(3);
					break;
				case "Poison":
					if (player.hasPerk(PerkLib.PoisonAffinity)) dao += 1 + rand(3);
					break;
				case "Wind":
					if (player.hasAnyPerk(PerkLib.WindAffinity, PerkLib.AffinitySylph)) dao += 1 + rand(3);
					break;
				case "Blood":
					if (player.hasAnyPerk(PerkLib.BloodAffinity, PerkLib.BloodMastery, PerkLib.WayOfTheBlood)) dao += 1 + rand(3);
					break;
				case "Water":
					if (player.hasAnyPerk(PerkLib.WaterAffinity, PerkLib.AffinityUndine)) dao += 1 + rand(3);
					break;
				case "Earth":
					if (player.hasAnyPerk(PerkLib.EarthAffinity, PerkLib.AffinityGnome)) dao += 1 + rand(3);
					break;
				case "Acid":
					if (player.hasPerk(PerkLib.AcidAffinity)) dao += 1 + rand(3);
					break;
				
			}
		}
		//uzycie w kontemplacji niebianskich skarbow zwiazanych z danym zywiolem daje bonusowe punkty
		if (dao > 0) {
			if (!clone && !elementalBody) outputText("After the session ends you managed to progress in Dao of "+daoname+".");
			if (player.hasStatusEffect(statusEffect)) {
				player.addStatusValue(statusEffect, 1, dao);
				var thres:Array = [20, 40, 60, 100, 140, 180, 220, 260, 300];
				var curLevel:int = player.statusEffectv2(statusEffect);
				if (curLevel < thres.length) {
					if (player.statusEffectv1(statusEffect) >= thres[curLevel]) {
						player.addStatusValue(statusEffect, 1, -thres[curLevel]);
						player.addStatusValue(statusEffect, 2, 1);
						outputText("\n\n<b>")
						if (clone) outputText("Due to your clone contemplations your");
						else outputText("Your");
						outputText(" comprehension in Dao of "+daoname+" has reached the " + NUMBER_WORDS_POSITIONAL[curLevel+1] + " layer.</b>\n\n");
					}
				}
			} else player.createStatusEffect(statusEffect, dao, 0, 0, 0);
		}
		else outputText("After the session ends, you did not manage to progress in your comprehension.\n\n");
		if (!clone && !elementalBody) doNext(camp.returnToCampUseEightHours);
	}

	public function highestLayerOfDaoComprehension():Number {
		var hLrODC:Number = 1;
		hLrODC += (player.perkv2(PerkLib.JobSoulCultivator) - 4);
		return hLrODC;
	}

	public function sfRegenRacialMult():Number {
		var kitsuneBonus:Array = [0.4, 0.8, 1.3, 2.0];
		var nekoBonus:Array = [0.2, 0.4];
		var kitshooBonus:Array = [0.3, 0.4, 0.5];
		var mult:Number = 1.0;
		if (player.isRace(Races.KITSUNE)) mult += kitsuneBonus[player.racialTier(Races.KITSUNE) - 1];
		if (player.isRace(Races.NEKOMATA)) mult += nekoBonus[player.racialTier(Races.NEKOMATA) - 1];
		if (player.isRace(Races.KITSHOO)) mult += kitshooBonus[player.racialTier(Races.KITSHOO) - 1];
		if (player.isRaceCached(Races.UNICORN, 2)) mult += 0.05;
		if (player.isRaceCached(Races.ALICORN, 2)) mult += 0.1;
		return mult;
	}

	//Returns the number of soulforce regenerated after the specified time (doesn't change anything)
	private function sfRegen(hours:int):int {
		var amount:int = 16;
		//Base amount
		var soulPerks:/*PerkType*/Array = [
			PerkLib.DaoistCultivator,
			PerkLib.SoulApprentice,
			PerkLib.SoulPersonage,
			PerkLib.SoulWarrior,
			PerkLib.SoulSprite,
			PerkLib.SoulScholar,
			PerkLib.SoulElder,
			PerkLib.SoulExalt,
			PerkLib.SoulOverlord,
			PerkLib.SoulTyrant,
			PerkLib.SoulKing,
			PerkLib.SoulEmperor,
			PerkLib.SoulAncestor,
		];
		var daoistPerks:/*PerkType*/Array = [
			PerkLib.DaoistApprenticeStage,
			PerkLib.DaoistWarriorStage,
			PerkLib.DaoistElderStage,
			PerkLib.DaoistOverlordStage,
			PerkLib.DaoistTyrantStage,
		];
		for each(var soulPerk:PerkType in soulPerks)
			if (player.hasPerk(soulPerk))
				amount += 16;
		for each(var daoistPerk:PerkType in daoistPerks)
			if (player.hasPerk(daoistPerk))
				amount += 20;
		amount *= (hours * 2 - 1); //time mult
		amount *= sfRegenRacialMult();
		return amount;
	}

	//Predict the soulforce change after the meditation
	public function meditationPredict(hours:int):int {
		var maxChange:int = sfRegen(hours) //regen from meditation itself
			+ Math.round(SceneLib.combat.soulforceregeneration2() * 2 * SceneLib.combat.soulforceRecoveryMultiplier() * hours); //from time spent
		return Math.min(maxChange, player.maxOverSoulforce() - player.soulforce);
	}

	//Regen SF and train max SF with items
	private function meditate(hours:int):void {
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and meditate. Minute after minute you feel how your lost soulforce is slowly replenished.\n\n");
		soulforceItemTraining(hours); //incremental bonus to MAX soulforce after each cultivation. Scales with hours
		//need to include the time.
		var predict:int = meditationPredict(hours);
		outputText("The spent time has allowed you to restore " + predict + " soulforce.\n\n");
		outputText("Current soulpower: " + (player.soulforce + predict) + " / " + player.maxSoulforce());
		EngineCore.SoulforceChange(sfRegen(hours)); //actual regen
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(20 * hours);
		doNext(camp.returnToCamp, hours);
	}

	//Max possible with ALL items
	public static var cultivationBonusMaxSF_maxPossible:int = 2230;

	//Calculates the limit from your items
	public function cultivationBonusMaxSF_limit():int {
		var maxForItems:Number = 0;//razem może mieć max 2330%
		if (player.weaponName == "training soul axe") maxForItems += 80;
		if (player.weaponRangeName == "training soul crossbow") maxForItems += 50;
		if (player.shieldName == "training soul buckler") maxForItems += 60;
		if (player.armorName == "training soul armor") maxForItems += 240;
		if (player.upperGarmentName == "soul training shirt") maxForItems += 200;
		if (player.lowerGarmentName == "soul training panties") maxForItems += 200;
		if (player.headjewelryName == "training soul hairpin") maxForItems += 200;
		if (player.necklaceName == "training soul necklace") maxForItems += 300;
		if (player.jewelryName == "training soul ring") maxForItems += 100;
		if (player.jewelryName2 == "training soul ring") maxForItems += 100;
		if (player.jewelryName3 == "training soul ring") maxForItems += 100;
		if (player.jewelryName4 == "training soul ring") maxForItems += 100;
		if (player.weaponFlyingSwordsName == "training soul flying sword") maxForItems += 500;
		return maxForItems;
	}

	public function soulforceItemTraining(hours:int):void {
		var itemCnt:Number = sfTrainingItems();
		if (itemCnt > 10) itemCnt *= (1.0 + itemCnt * 0.1);
		else if (itemCnt > 5) itemCnt *= (1.0 + itemCnt * 0.05);
		var limit:int = cultivationBonusMaxSF_limit();
		if (flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] < limit)
			flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING] += Math.min(int(itemCnt * hours), limit - flags[kFLAGS.SOULFORCE_GAINED_FROM_CULTIVATING]);
	}

	public function SelfSustain():void {
		clearOutput();
		outputText("Use some of your soulforce to partialy sate your hunger. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		var maxH:Number = player.maxHunger();
		menu();
		if (player.soulforce >= Math.round(maxH * 0.5)) addButton(0, "-10-", SelfSustain0, Math.round(maxH * 0.1)).hint("Spend soulforce to decrease hunger by 10%.");
		else addButtonDisabled(0, "-10-", "Your current soulforce is too low.");
		if (player.soulforce >= maxH) addButton(1, "-20-", SelfSustain0, Math.round(maxH * 0.2)).hint("Spend soulforce to decrease hunger by 20%.");
		else addButtonDisabled(1, "-20-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 1.5)) addButton(2, "-30-", SelfSustain0, Math.round(maxH * 0.3)).hint("Spend soulforce to decrease hunger by 30%.");
		else addButtonDisabled(2, "-30-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 2)) addButton(3, "-40-", SelfSustain0, Math.round(maxH * 0.4)).hint("Spend soulforce to decrease hunger by 40%.");
		else addButtonDisabled(3, "-40-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 2.5)) addButton(4, "-50-", SelfSustain0, Math.round(maxH * 0.5)).hint("Spend soulforce to decrease hunger by 50%.");
		else addButtonDisabled(4, "-50-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 3)) addButton(5, "-60-", SelfSustain0, Math.round(maxH * 0.6)).hint("Spend soulforce to decrease hunger by 60%.");
		else addButtonDisabled(5, "-60-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 3.5)) addButton(6, "-70-", SelfSustain0, Math.round(maxH * 0.7)).hint("Spend soulforce to decrease hunger by 70%.");
		else addButtonDisabled(6, "-70-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 4)) addButton(7, "-80-", SelfSustain0, Math.round(maxH * 0.8)).hint("Spend soulforce to decrease hunger by 80%.");
		else addButtonDisabled(7, "-80-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 4.5)) addButton(8, "-90-", SelfSustain0, Math.round(maxH * 0.93)).hint("Spend soulforce to decrease hunger by 90%.");
		else addButtonDisabled(8, "-90-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxH * 5)) addButton(9, "-100-", SelfSustain0, maxH).hint("Spend soulforce to decrease hunger by 00%.");
		else addButtonDisabled(9, "-100-", "Your current soulforce is too low.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function SelfSustain0(ratio:Number):void {
		clearOutput();
		outputText("Consuming some of your soulforce you feel your hungry decreasing.");
		player.soulforce -= Math.round(ratio * 5);
		player.refillHunger(ratio);
		if (player.isGargoyle() && player.hasPerk(PerkLib.GargoylePure)) player.refillGargoyleHunger(ratio);
		statScreenRefresh();
		flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
		doNext(SelfSustain);
	}
	public function RepresLust():void {
		clearOutput();
		outputText("Use some of your soulforce to partialy suppress your lust. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		var maxL:Number = player.maxLust();
		menu();
		if (player.soulforce >= Math.round(maxL * 0.2)) addButton(0, "-10-", RepresLust0, Math.round(maxL * 0.1)).hint("Spend soulforce to decrease lust by 10%.");
		else addButtonDisabled(0, "-10-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 0.4)) addButton(1, "-20-", RepresLust0, Math.round(maxL * 0.2)).hint("Spend soulforce to decrease lust by 20%.");
		else addButtonDisabled(1, "-20-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 0.6)) addButton(2, "-30-", RepresLust0, Math.round(maxL * 0.3)).hint("Spend soulforce to decrease lust by 30%.");
		else addButtonDisabled(2, "-30-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 0.8)) addButton(3, "-40-", RepresLust0, Math.round(maxL * 0.4)).hint("Spend soulforce to decrease lust by 40%.");
		else addButtonDisabled(3, "-40-", "Your current soulforce is too low.");
		if (player.soulforce >= maxL) addButton(4, "-50-", RepresLust0, Math.round(maxL * 0.5)).hint("Spend soulforce to decrease lust by 50%.");
		else addButtonDisabled(4, "-50-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 1.2)) addButton(5, "-60-", RepresLust0, Math.round(maxL * 0.6)).hint("Spend soulforce to decrease lust by 60%.");
		else addButtonDisabled(5, "-60-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 1.4)) addButton(6, "-70-", RepresLust0, Math.round(maxL * 0.7)).hint("Spend soulforce to decrease lust by 70%.");
		else addButtonDisabled(6, "-70-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 1.6)) addButton(7, "-80-", RepresLust0, Math.round(maxL * 0.8)).hint("Spend soulforce to decrease lust by 80%.");
		else addButtonDisabled(7, "-80-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 1.8)) addButton(8, "-90-", RepresLust0, Math.round(maxL * 0.9)).hint("Spend soulforce to decrease lust by 90%.");
		else addButtonDisabled(8, "-90-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxL * 2)) addButton(9, "-100-", RepresLust0, maxL).hint("Spend soulforce to decrease lust by 100%.");
		else addButtonDisabled(9, "-100-", "Your current soulforce is too low.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function RepresLust0(ratio:Number):void {
		clearOutput();
		outputText("Consuming some of your soulforce you lust lowered.");
		player.soulforce -= Math.round(ratio * 2);
		player.lust -= ratio;
		if (player.lust < 0) player.lust = 0;
		statScreenRefresh();
		flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
		doNext(RepresLust);
	}
	public function ManaAndSoulforce():void {
		clearOutput();
		outputText("Use some of your soulforce to slowly conver it into mana or some mana in soulforce. The higher your cultivation is the more you could convert without hurting yourself.\n\n");
		outputText("So what amount of your soulforce/mana do you want to convert?");
		var maxS:Number = player.maxSoulforce();
		var maxM:Number = player.maxMana();
		menu();
		if (player.soulforce >= 100) addButton(0, "100", convertSoulforce, 100).hint("Convert 100 soulforce to 100 mana.");
		else addButtonDisabled(0, "100", "Your current soulforce is too low.");
		if (player.soulforce >= 500) addButton(1, "500", convertSoulforce, 500).hint("Convert 500 soulforce to 500 mana.");
		else addButtonDisabled(1, "500", "Your current soulforce is too low.");
		if (player.soulforce >= 1000) addButton(2, "1000", convertSoulforce, 1000).hint("Convert 1,000 soulforce to 1,000 mana.");
		else addButtonDisabled(2, "1000", "Your current soulforce is too low.");
		if (player.soulforce >= 5000) addButton(3, "5000", convertSoulforce, 5000).hint("Convert 5,000 soulforce to 5,000 mana.");
		else addButtonDisabled(3, "5000", "Your current soulforce is too low.");
		if (player.soulforce >= 10000) addButton(4, "10000", convertSoulforce, 10000).hint("Convert 10,000 soulforce to 10,000 mana.");
		else addButtonDisabled(4, "10000", "Your current soulforce is too low.");
		if (player.mana >= 200) addButton(5, "200", convertMana, 200).hint("Convert 200 mana to 100 soulforce.");
		else addButtonDisabled(5, "200", "Your current mana is too low.");
		if (player.mana >= 1000) addButton(6, "1000", convertMana, 1000).hint("Convert 1,000 mana to 500 soulforce.");
		else addButtonDisabled(6, "1000", "Your current mana is too low.");
		if (player.mana >= 2000) addButton(7, "2000", convertMana, 2000).hint("Convert 2,000 mana to 1,000 soulforce.");
		else addButtonDisabled(7, "200", "Your current mana is too low.");
		if (player.mana >= 10000) addButton(8, "10000", convertMana, 10000).hint("Convert 10,000 mana to 5,000 soulforce.");
		else addButtonDisabled(8, "200", "Your current mana is too low.");
		if (player.mana >= 20000) addButton(9, "20000", convertMana, 20000).hint("Convert 20,000 mana to 10,000 soulforce.");
		else addButtonDisabled(9, "200", "Your current mana is too low.");
		if (player.soulforce >= Math.round(maxM * 0.25)) addButton(10, "-25-", convertSoulforce, Math.round(maxM * 0.25)).hint("Convert "+Math.round(maxM * 0.25)+" soulforce to "+Math.round(maxM * 0.25)+" mana.");
		else addButtonDisabled(10, "-25-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxM * 0.25)) addButton(11, "-100-", convertSoulforce, maxM).hint("Convert "+maxM+" soulforce to "+maxM+" mana.");
		else addButtonDisabled(11, "-100-", "Your current soulforce is too low.");
		if (player.soulforce >= Math.round(maxS * 0.5)) addButton(12, "-25-", convertMana, Math.round(maxS * 0.5)).hint("Convert "+Math.round(maxS * 0.5)+" mana to "+Math.round(maxS * 0.25)+" soulforce.");
		else addButtonDisabled(12, "-25-", "Your current mana is too low.");
		if (player.soulforce >= (maxS * 2)) addButton(13, "-100-", convertMana, (maxS * 2)).hint("Convert "+(maxS * 2)+" mana to "+maxS+" soulforce.");
		else addButtonDisabled(13, "-100-", "Your current mana is too low.");
		addButton(14, "Back", accessSoulforceMenu);
	}

	public function convertSoulforce(amount:int):void {
		clearOutput();
		outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
		EngineCore.SoulforceChange(-amount);
		EngineCore.ManaChange(amount);
		flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
		doNext(ManaAndSoulforce);
	}

	public function convertMana(amount:int):void {
		clearOutput();
		outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
		EngineCore.ManaChange(-amount);
		EngineCore.SoulforceChange(amount / 2);
		flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
		doNext(ManaAndSoulforce);
	}

	public function CorruptionAndSoulforce():void {
		clearOutput();
		outputText("Use some of your soulforce to slowly purify or...corrupt yourself. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		menu();
		addButton(0, "V. Low -", corChange, -1).hint("Spend 100 soulforce for lowering corruption by 1.");
		addButton(1, "Low -", corChange, -2).hint("Spend 200 soulforce for lowering corruption by 2.");
		addButton(2, "Medium -", corChange, -5).hint("Spend 500 soulforce for lowering corruption by 5.");
		addButton(3, "High -", corChange, -10).hint("Spend 1000 soulforce for lowering corruption by 10.");
		addButton(4, "V. High -", corChange, -20).hint("Spend 2000 soulforce for lowering corruption by 20.");
		addButton(5, "V. Low +", corChange, 1).hint("Spend 50 soulforce for rising corruption by 1.");
		addButton(6, "Low +", corChange, 2).hint("Spend 100 soulforce for rising corruption by 2.");
		addButton(7, "Medium +", corChange, 5).hint("Spend 250 soulforce for rising corruption by 5.");
		addButton(8, "High +", corChange, 10).hint("Spend 500 soulforce for rising corruption by 10.");
		addButton(9, "V. High +", corChange, 20).hint("Spend 1000 soulforce for rising corruption by 20.");
		addButton(14, "Back", accessSoulforceMenu);
	}

	public function corChange(change:int):void {
		var cost:int = Math.abs(change) * 100;
		if (change > 0) cost *= 0.5;
		clearOutput();
		if (player.soulforce >= cost) {
			outputText("Consuming a little of soulforce, you adjust your corruption.");
			player.soulforce -= cost;
			player.dynStats("cor", change);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
		}
		else outputText("Your current soulforce is too low.");
		doNext(CorruptionAndSoulforce);
	}
	
	public function ImprintingSF():void {
		clearOutput();
		outputText("");
		menu();
		var btn:int = 0;
		if (player.itemCount(weaponsflyingswords.W_HALFM) > 1) addButton(btn++, "W.HalfM2", ImprintingSFCombine, weaponsflyingswords.W_HALFM, weaponsflyingswords.W_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.W_HALFM2) > 0) addButton(btn++, "W.HalfM", ImprintingSFSeparate1, weaponsflyingswords.W_HALFM2, weaponsflyingswords.W_HALFM).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.B_HALFM) > 1) addButton(btn++, "B.HalfM2", ImprintingSFCombine, weaponsflyingswords.B_HALFM, weaponsflyingswords.B_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.B_HALFM2) > 0) addButton(btn++, "B.HalfM", ImprintingSFSeparate1, weaponsflyingswords.B_HALFM2, weaponsflyingswords.B_HALFM).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.S_HALFM) > 1) addButton(btn++, "S.HalfM2", ImprintingSFCombine, weaponsflyingswords.S_HALFM, weaponsflyingswords.S_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.S_HALFM2) > 0) addButton(btn++, "S.HalfM", ImprintingSFSeparate1, weaponsflyingswords.S_HALFM2, weaponsflyingswords.S_HALFM).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.E_HALFM) > 1) addButton(btn++, "E.HalfM2", ImprintingSFCombine, weaponsflyingswords.E_HALFM, weaponsflyingswords.E_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.E_HALFM2) > 0) addButton(btn++, "E.HalfM", ImprintingSFSeparate1, weaponsflyingswords.E_HALFM2, weaponsflyingswords.E_HALFM).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.W_HALFM2) > 1) addButton(btn++, "W.HalfM4", ImprintingSFCombine, weaponsflyingswords.W_HALFM2, weaponsflyingswords.W_HALFM3).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.W_HALFM3) > 0) addButton(btn++, "W.HalfM2", ImprintingSFSeparate1, weaponsflyingswords.W_HALFM3, weaponsflyingswords.W_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.B_HALFM2) > 1) addButton(btn++, "B.HalfM4", ImprintingSFCombine, weaponsflyingswords.B_HALFM2, weaponsflyingswords.B_HALFM3).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.B_HALFM3) > 0) addButton(btn++, "B.HalfM2", ImprintingSFSeparate1, weaponsflyingswords.B_HALFM3, weaponsflyingswords.B_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.S_HALFM2) > 1) addButton(btn++, "S.HalfM4", ImprintingSFCombine, weaponsflyingswords.S_HALFM2, weaponsflyingswords.S_HALFM3).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.S_HALFM3) > 0) addButton(btn++, "S.HalfM2", ImprintingSFSeparate1, weaponsflyingswords.S_HALFM3, weaponsflyingswords.S_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.E_HALFM2) > 1) addButton(btn++, "E.HalfM4", ImprintingSFCombine, weaponsflyingswords.E_HALFM2, weaponsflyingswords.E_HALFM3).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		if (player.itemCount(weaponsflyingswords.E_HALFM3) > 0) addButton(btn++, "E.HalfM2", ImprintingSFSeparate1, weaponsflyingswords.E_HALFM3, weaponsflyingswords.E_HALFM2).disableIf(player.soulforce < 100, "Req. 100 soulforce.");
		addButton(14, "Back", accessSoulforceMenu);
	}
	public function ImprintingSFCombine(flyingsword1: FlyingSwords, flyingsword2: FlyingSwords):void {
		clearOutput();
		outputText("Combining.\n\n");
		player.soulforce -= 100;
		player.destroyItems(flyingsword1, 2);
		inventory.takeItem(flyingsword2, ImprintingSF);
	}
	public function ImprintingSFSeparate1(flyingsword1: FlyingSwords, flyingsword2: FlyingSwords):void {
		clearOutput();
		outputText("Separating.\n\n");
		player.soulforce -= 100;
		player.destroyItems(flyingsword1, 1);
		inventory.takeItem(flyingsword2, curry(ImprintingSFSeparate1a, flyingsword2));
	}
	public function ImprintingSFSeparate1a(flyingsword2: FlyingSwords):void {
		outputText("\n\n");
		inventory.takeItem(flyingsword2, ImprintingSF);
	}

	private function addSSButton(btn:int, name:String, func:Function, sfCost:int):CoCButton {
		return addButton(btn, name, function ():void {
			player.soulforce -= sfCost;
			statScreenRefresh();
			func();
		}).disableIf(player.soulforce < sfCost, "Req. " + sfCost + " soulforce.");
	}

	public function SoulSense():void {
		clearOutput();
		outputText("Using a tiny amount of soulforce you could try to use soul sense to locate some of people you meet of location you found before without wasting hours for that. Especialy if those people are usualy roaming around or places that constantly changing their location.");
		outputText("\n\nAmount of soulforce used to locate them using soul sense depening of relative power of searched person or location.");
		menu();
		var btn:int = 0;
		if (flags[kFLAGS.SOUL_SENSE_WORLD_TREE] >= 1)
			addSSButton(btn++, "WorldTree", worldtreeScene.YggdrasilDiscovery, 100);
		//button 11
		addButton(13, "???", theUnknown).hint("Draw into your soulforce for soulsensing.");
		addButton(14, "Back", accessSoulforceMenu);
	}

	private function soulforceForDaughters():int {
		return 10 * (8 + (Math.floor(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] / 20)));
	}

	private function soulforceForSons():int {
		return 10 * (26 + Math.round((flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] - 3)/2));
	}

	public function theUnknown(page:int = 1):void {
		if (player.soulforce >= 100) {
			player.soulforce -= 100;
			menu();
			statScreenRefresh();
			if (page == 1) {
				if (BelisaFollower.BelisaInGame && BelisaFollower.BelisaFollowerStage < 3 && BelisaFollower.BelisaEncounternum >= 1 && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(0, "???", belisatest).hint("Shy Spooder");
				if (!LilyFollower.LilyFollowerState && flags[kFLAGS.LILY_LVL_UP] > 0 && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(1, "???", lilytest).hint("Lewd Spooder");
				if (TyrantiaFollower.TyrantiaFollowerStage > 0 && TyrantiaFollower.TyrantiaFollowerStage < 4 && !TyrantiaFollower.TyraniaIsRemovedFromThewGame && !player.hasStatusEffect(StatusEffects.SpoodersOff)) addButton(2, "???", FightTyrantia).hint("Scary Spooder");
				if (flags[kFLAGS.IZMA_ENCOUNTER_COUNTER] > 0 && (flags[kFLAGS.IZMA_WORMS_SCARED] == 0 || !player.hasStatusEffect(StatusEffects.Infested)) && flags[kFLAGS.IZMA_FOLLOWER_STATUS] <= 0) addButton(3, "???", tigerSharkGal).hint("Tigershark Gal?");
				if (flags[kFLAGS.NADIA_LVL_UP] > 0 && flags[kFLAGS.NADIA_FOLLOWER] < 6 && player.statusEffectv4(StatusEffects.CampSparingNpcsTimers2) < 1 && !player.hasStatusEffect(StatusEffects.NadiaOff)) addButton(4, "???", shyHealer).hint("Shy Healer");
				if (flags[kFLAGS.ISABELLA_AFFECTION] > 0 && flags[kFLAGS.ISABELLA_PLAINS_DISABLED] == 0) addButton(5, "???", germanCow).hint("German Cow");
				if (player.isNaga() && flags[kFLAGS.SAMIRAH_FOLLOWER] <= 9) addButton(6, "???", sneakOnThePlane).hint("F**king ??? on the Plane.");
				if (!SceneLib.kihaFollower.followerKiha() && flags[kFLAGS.KIHA_TALK_STAGE] > 0) addButton(7, "???", quasiDragoness).hint("Quasi-dragoness.");
				if (flags[kFLAGS.ZENJI_PROGRESS] != -1 && flags[kFLAGS.ZENJI_PROGRESS] > 0 && (flags[kFLAGS.ZENJI_PROGRESS] < 8 || flags[kFLAGS.ZENJI_PROGRESS] == 10)) addButton(8, "???", theySeeHimTrollinTheyHatin).hint("They see him trollin' They hatin'");
				addButton(13, "-2-", theUnknown, page + 1);
				addButton(14, "Back", SoulSense);
			}
			if (page == 2) {
				if (flags[kFLAGS.ETNA_AFFECTION] >= 2 && flags[kFLAGS.ETNA_FOLLOWER] < 1) addButton(0, "???", hornyCore).hint("Horny-core.");
				if (flags[kFLAGS.ELECTRA_AFFECTION] >= 2 && flags[kFLAGS.ELECTRA_FOLLOWER] < 2) addButton(1, "???", lightningRod).hint("Lightning Rod.");
				if (SceneLib.helScene.helSexualAmbushCondition()) addButton(9, "???", analLover).hint("Anal-lover.");
				addButton(10, "???", dragON);
				addButton(11, "???", returnToMonke);
				addButton(13, "-1-", theUnknown, page - 1);
				addButton(14, "Back", SoulSense);
			}
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
		if (TyrantiaFollower.TyrantiaFollowerStage > 2) SceneLib.tyrantia.repeatEncounterBattlefield();
		else if (TyrantiaFollower.TyrantiaAffectionMeter > 40 && TyrantiaFollower.TyrantiaFollowerStage > 1) SceneLib.tyrantia.encounterBattlefieldAfter40Affection();
		else if (TyrantiaFollower.TyrantiaFollowerStage > 0) SceneLib.tyrantia.repeatEncounterBattlefield();
		else SceneLib.tyrantia.firstEncounter();
	}
	public function tigerSharkGal():void {
		SceneLib.izmaScene.meetIzmaAtLake();
	}
	public function shyHealer():void {
		if ((flags[kFLAGS.NADIA_FOLLOWER] < 3 || flags[kFLAGS.NADIA_FOLLOWER] == 5) && flags[kFLAGS.NADIA_LVL_UP] >= 8) SceneLib.nadiaScene.postNameEnc();
		else SceneLib.nadiaScene.repeatEnc();
	}
	public function germanCow():void {
		SceneLib.isabellaScene.isabellaGreeting();
	}
	public function sneakOnThePlane():void {
		nagaScene.nagaEncounter();
	}
	public function quasiDragoness():void {
		SceneLib.kihaScene.encounterKiha();
	}
	public function hornyCore():void {
		SceneLib.etnaScene.repeatEnc();
	}
	public function lightningRod():void {
		SceneLib.electraScene.repeatMountainEnc();
	}
	public function theySeeHimTrollinTheyHatin():void {
		if (flags[kFLAGS.ZENJI_PROGRESS] >= 4) {
			if (flags[kFLAGS.ZENJI_PROGRESS] == 6) {
				if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] == 100) {
					if (flags[kFLAGS.ZENJI_PROGRESS] == 7) SceneLib.zenjiScene.followerZenjiRepeatOffer();
					else SceneLib.zenjiScene.followerZenjiFirstTimeOffer();
				} else if (flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER] == 0) {
					if (flags[kFLAGS.ZENJI_PROGRESS] == 10) SceneLib.zenjiScene.loverZenjiRepeatOffer();
					else SceneLib.zenjiScene.loverZenjiFirstTimeOffer();
				} else SceneLib.zenjiScene.part2TrollEncounterRepeat();
			} else SceneLib.zenjiScene.part2TrollEncounterFirst();
		} else if (flags[kFLAGS.ZENJI_PROGRESS] > 0 && flags[kFLAGS.ZENJI_PROGRESS] < 4) SceneLib.zenjiScene.part1TrollEncounterRepeat();
	}
	public function analLover():void {
		SceneLib.helScene.helSexualAmbush();
	}
}
}
