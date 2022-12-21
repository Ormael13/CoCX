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
		if (player.hasPerk(PerkLib.JobSoulCultivator)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulWarrior)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulGrandmaster)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulOverlord)) dailySoulforceUsesLimit++;
		if (player.hasPerk(PerkLib.SoulEmperor)) dailySoulforceUsesLimit++;//dodawać kolejne co 3 level-e
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
			/*15*/[0, "Early Soul Scholar", "E.S.Gm.", 120, PerkLib.SoulGrandmaster],
			[1, "Middle Soul Scholar", "M.S.Gm."],
			[1, "Late Soul Scholar", "L.S.Gm."],
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
				.disableIf(player.hasPerk(stages[i][1]), "You have already reached this stage.");
		addButton(14, "Back", SubPaths);
	}

	private function daoistSubPathChosen(perk:PerkType, bottle:ItemType):void {
		player.destroyItems(bottle, 1);
		player.createPerk(perk, 0, 0, 0, 0);
		outputText("\n\n<b>Gained perk - " + perk.name() + "</b>");
		doNext(camp.returnToCampUseFourHours);
	}

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

	public function daoContemplationsEffect(statusEffect:StatusEffectType, daoname:String, clone:Boolean = false):void {
		clearOutput();
		outputText("You find a flat, comfortable rock to sit down on and contemplate.  Minute after minute you feel immersed into elements that surrounds you.  How they flow around you, how they change on their own and how they interact with each other.  All this while trying to understand, despite being insignificant while the great dao manifests around you.\n\n");
		var dao:int;
		if (clone) dao = 1;
		else {
			dao = rand(6);
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
		}
		//uzycie w kontemplacji niebianskich skarbow zwiazanych z danym zywiolem daje bonusowe punkty
		if (dao > 0) {
			outputText("After the session ends you managed to progress in Dao of "+daoname+".");
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
						outputText(" comprehension in Dao of "+daoname+" has reached the " + NUMBER_WORDS_POSITIONAL[curLevel+1] + " layer.</b>");
					}
				}
			} else player.createStatusEffect(statusEffect, dao, 0, 0, 0);
		}
		else outputText("After the session ends, you did not manage to progress in your comprehension.");
		outputText("\n\n");
		doNext(camp.returnToCampUseEightHours);
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
	public static var cultivationBonusMaxSF_maxPossible:int = 2330;

	//Calculates the limit from your items
	public function cultivationBonusMaxSF_limit():int {
		var maxForItems:Number = 0;//razem może mieć max 2330
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
		addButton(0, "100", convertSoulforce, 100).hint("Convert 100 soulforce to 100 mana.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(1, "200", convertSoulforce, 200).hint("Convert 200 soulforce to 200 mana.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(2, "500", convertSoulforce, 500).hint("Convert 500 soulforce to 500 mana.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(3, "1000", convertSoulforce, 1000).hint("Convert 1000 soulforce to 1000 mana.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(4, "2000", convertSoulforce, 2000).hint("Convert 2000 soulforce to 2000 mana.");
		//
		addButton(5, "100", convertMana, 100).hint("Convert 100 mana to 50 soulforce.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(6, "200", convertMana, 200).hint("Convert 200 mana to 100 soulforce.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(7, "500", convertMana, 500).hint("Convert 500 mana to 250 soulforce.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(8, "1000", convertMana, 1000).hint("Convert 1000 mana to 500 soulforce.");
		if (player.hasPerk(PerkLib.SoulScholar)) addButton(9, "2000", convertMana, 2000).hint("Convert 2000 mana to 1000 soulforce.");
		//
		if (player.hasPerk(PerkLib.SoulElder)) addButton(10, "5000", convertSoulforce, 5000).hint("Convert 5000 soulforce to 5000 mana.");
		if (player.hasPerk(PerkLib.SoulExalt)) addButton(11, "10000", convertSoulforce, 10000).hint("Convert 10000 soulforce to 10000 mana.");
		if (player.hasPerk(PerkLib.SoulElder)) addButton(12, "5000", convertMana, 5000).hint("Convert 5000 mana to 2500 soulforce.");
		if (player.hasPerk(PerkLib.SoulExalt)) addButton(13, "10000", convertMana, 10000).hint("Convert 10000 mana to 5000 soulforce.");
		addButton(14, "Back", accessSoulforceMenu);
	}

	public function convertSoulforce(amount:int):void {
		clearOutput();
		if (player.soulforce >= amount) {
			outputText("You sit down and focus your spiritual power to recover some of your mana, within moments, you feel rested and refreshed.");
			EngineCore.SoulforceChange(-amount);
			EngineCore.ManaChange(amount);
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		} else {
			outputText("Your current soulforce is too low.");
			doNext(ManaAndSoulforce);
		}
	}

	public function convertMana(amount:int):void {
		clearOutput();
		if (player.mana >= amount) {
			outputText("You sit down and focus in recovering your spiritual power, draining your mana to replenish your soul force.");
			EngineCore.ManaChange(-amount);
			EngineCore.SoulforceChange(amount / 2);
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		} else {
			outputText("Your current mana is too low.");
			doNext(ManaAndSoulforce);
		}
	}

	public function CorruptionAndSoulforce():void {
		clearOutput();
		outputText("Use some of your soulforce to slowly purify or...corrupt yourself. The higher your cultivation is the more of the soulforce you could drawn without hurting yourself.\n\n");
		outputText("So what amount of your soulforce do you want to use?");
		menu();
		addButton(0, "V. Low -", corChange, -1).hint("Spend 100 soulforce for lowering corruption by 1.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(1, "Low -", corChange, -2).hint("Spend 200 soulforce for lowering corruption by 2.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(2, "Medium -", corChange, -5).hint("Spend 500 soulforce for lowering corruption by 5.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(3, "High -", corChange, -10).hint("Spend 1000 soulforce for lowering corruption by 10.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(4, "V. High -", corChange, -20).hint("Spend 2000 soulforce for lowering corruption by 20.");
		addButton(5, "V. Low +", corChange, 1).hint("Spend 50 soulforce for rising corruption by 1.");
		if (player.hasPerk(PerkLib.SoulApprentice)) addButton(6, "Low +", corChange, 2).hint("Spend 100 soulforce for rising corruption by 2.");
		if (player.hasPerk(PerkLib.SoulPersonage)) addButton(7, "Medium +", corChange, 5).hint("Spend 250 soulforce for rising corruption by 5.");
		if (player.hasPerk(PerkLib.SoulWarrior)) addButton(8, "High +", corChange, 10).hint("Spend 500 soulforce for rising corruption by 10.");
		if (player.hasPerk(PerkLib.SoulSprite)) addButton(9, "V. High +", corChange, 20).hint("Spend 1000 soulforce for rising corruption by 20.");
		addButton(14, "Back", accessSoulforceMenu);
	}

	public function corChange(change:int):void {
		var cost:int = Math.abs(change) * 100;
		clearOutput();
		if (player.soulforce >= cost) {
			outputText("Consuming a little of soulforce, you adjust your corruption.");
			player.soulforce -= cost;
			player.dynStats("cor", change);
			statScreenRefresh();
			flags[kFLAGS.DAILY_SOULFORCE_USE_LIMIT]++;
			doNext(playerMenu);
		}
		else {
			outputText("Your current soulforce is too low.");
			doNext(CorruptionAndSoulforce);
		}
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
		if (flags[kFLAGS.SOUL_SENSE_GIACOMO] >= 3)
			addSSButton(btn++, "Giacomo", SceneLib.giacomoShop.giacomoEncounter, 100);
		if (flags[kFLAGS.SOUL_SENSE_TAMANI] >= 3 && player.hasCock() || !player.hasKeyItem("Deluxe Dildo"))
			addSSButton(btn++, "Tamani", tamaniScene.encounterTamani, 80);
		if (flags[kFLAGS.SOUL_SENSE_TAMANI_DAUGHTERS] >= 3)
			addSSButton(btn++, "Tamani D.", tamaniDaughtersScene.encounterTamanisDaughters, soulforceForDaughters())
				.disableIf(flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] < 16, "Req. to have 16+ daughters with Tamani.")
				.disableIf(!player.hasCock(), "Req. to have a cock.");
		if (flags[kFLAGS.SOUL_SENSE_PRISCILLA] >= 3)
			addSSButton(btn++, "Priscilla", SceneLib.priscillaScene.goblinElderEncounter, 320);
		if (flags[kFLAGS.SOUL_SENSE_KITSUNE_MANSION] >= 3)
			addSSButton(btn++, "KitsuMansion", SceneLib.kitsuneScene.enterTheTrickster, 90);
		if (flags[kFLAGS.SOUL_SENSE_IZUMI] >= 3)
			addSSButton(btn++, "Izumi", izumiScenes.encounter, 300);
		if (flags[kFLAGS.SOUL_SENSE_MINOTAUR_SONS] >= 3)
			addSSButton(btn++, "Mino Sons", minotaurSonsScene.meetMinotaurSons, soulforceForSons())
				.disableIf(flags[kFLAGS.MINOTAUR_SONS_TRIBE_SIZE] < 3, "Req. to have 3+ minotaur sons.")
				.disableIf(!player.hasVagina(), "Req. to have a vagina.");
		if (flags[kFLAGS.SOUL_SENSE_WORLD_TREE] >= 1)
			addSSButton(btn++, "WorldTree", worldtreeScene.YggdrasilDiscovery, 100);
		if (flags[kFLAGS.SOUL_SENSE_ANTHILL] >= 1 && !flags[kFLAGS.ANT_WAIFU])
			addSSButton(btn++, "Ant Colony", SceneLib.desert.antsScene.antColonyChallenge, 200);
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
		if (TyrantiaFollower.TyrantiaFollowerStage > 2) SceneLib.tyrantia.repeatEncounterBattlefield();
		else if (TyrantiaFollower.TyrantiaAffectionMeter > 40 && TyrantiaFollower.TyrantiaFollowerStage > 1) SceneLib.tyrantia.encounterBattlefieldAfter40Affection();
		else if (TyrantiaFollower.TyrantiaFollowerStage > 0) SceneLib.tyrantia.repeatEncounterBattlefield();
		else SceneLib.tyrantia.firstEncounter();
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