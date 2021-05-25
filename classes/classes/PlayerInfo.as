package classes {

import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.GlobalFlags.*;
import classes.Scenes.NPCs.IsabellaScene;
import classes.Scenes.NPCs.ZenjiScenes;
import classes.Scenes.SceneLib;
import classes.Stats.StatUtils;
import classes.StatusEffects.VampireThirstEffect;

import coc.view.MainView;

import flash.events.TextEvent;

/**
 * The new home of Stats and Perks
 * @author Kitteh6660
 */
public class PlayerInfo extends BaseContent {
	public function PlayerInfo() {}

	//------------
	// STATS
	//------------
	public function displayStats():void {
		spriteSelect(-1);
		clearOutput();
		displayHeader("General Stats");

		// Begin Body Stats
		var bodyStats:String = "";

		if (flags[kFLAGS.HUNGER_ENABLED] > 0 || flags[kFLAGS.IN_PRISON] > 0) {
			bodyStats += "<b>Satiety:</b> " + Math.floor(player.hunger) + " / " + player.maxHunger() + " (";
			if (player.hunger <= 0) bodyStats += "<font color=\"#ff0000\">Dying</font>";
			if (player.hunger > 0 && player.hunger < 10) bodyStats += "<font color=\"#C00000\">Starving</font>";
			if (player.hunger >= 10 && player.hunger < 25) bodyStats += "<font color=\"#800000\">Very hungry</font>";
			if (player.hunger >= 25 && player.hunger < 50) bodyStats += "Hungry";
			if (player.hunger >= 50 && player.hunger < 75) bodyStats += "Not hungry";
			if (player.hunger >= 75 && player.hunger < 90) bodyStats += "<font color=\"#008000\">Satiated</font>";
			if (player.hunger >= 90 && player.hunger < 100) bodyStats += "<font color=\"#00C000\">Full</font>";
			if (player.hunger >= 100) bodyStats += "<font color=\"#0000ff\">Very full</font>";
			bodyStats += ")\n";
		}
		bodyStats += "<b>Times Transformed:</b> " + flags[kFLAGS.TIMES_TRANSFORMED] + "\n";
		if (player.tailType == Tail.BEE_ABDOMEN || player.tailType == Tail.SCORPION || player.tailType == Tail.MANTICORE_PUSSYTAIL || player.tailType == Tail.SPIDER_ADBOMEN || player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SPIDER_FANGS) {
			if (player.tailType == Tail.SPIDER_ADBOMEN && player.faceType != Face.SNAKE_FANGS && player.faceType != Face.SPIDER_FANGS)
				bodyStats += "<b>Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
			else if (player.tailType == Tail.SPIDER_ADBOMEN && (player.faceType == Face.SNAKE_FANGS || player.faceType == Face.SPIDER_FANGS))
				bodyStats += "<b>Venom/Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
			else if (player.tailType != Tail.SPIDER_ADBOMEN)
				bodyStats += "<b>Venom:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
		}
		bodyStats += "<b>Tone:</b> " + player.tone + " / " + player.maxToneCap() + "\n";
		bodyStats += "<b>Thickness:</b> " + player.thickness + " / " + player.maxThicknessCap() + "\n";
		bodyStats += "<b>Feminity:</b> " + player.femininity + " / 100\n";
		
		bodyStats += "<b>Anal Capacity:</b> " + Math.round(player.analCapacity()) + "\n";
		bodyStats += "<b>Anal Looseness:</b> " + Math.round(player.ass.analLooseness) + "\n";
		
		bodyStats += "<b>Fertility (Base) Rating:</b> " + Math.round(player.fertility) + "\n";
		bodyStats += "<b>Fertility (With Bonuses) Rating:</b> " + Math.round(player.totalFertility()) + "\n";
		if (player.cumQ() > 0)
			bodyStats += "<b>Virility Rating:</b> " + Math.round(player.virilityQ() * 100) + "\n";
		if (flags[kFLAGS.HUNGER_ENABLED] >= 1) bodyStats += "<b>Cum Production:</b> " + addComma(Math.round(player.cumQ())) + " / " + addComma(Math.round(player.cumCapacity())) + "mL (" + Math.round((player.cumQ() / player.cumCapacity()) * 100) + "%) \n";
		else bodyStats += "<b>Cum Production:</b> " + addComma(Math.round(player.cumQ())) + "mL\n";
		if (player.lactationQ() > 0)
			bodyStats += "<b>Milk Production:</b> " + addComma(Math.round(player.lactationQ())) + "mL\n";

		if (player.hasStatusEffect(StatusEffects.Feeder)) {
			bodyStats += "<b>Hours Since Last Time Breastfed Someone:</b>  " + player.statusEffectv2(StatusEffects.Feeder);
			if (player.statusEffectv2(StatusEffects.Feeder) >= 72)
				bodyStats += " (Too long! Sensitivity Increasing!)";
			bodyStats += "\n";
		}

		bodyStats += "<b>Pregnancy Speed Multiplier:</b> ";
		var preg:Number = 1;
		if (player.hasPerk(PerkLib.Diapause))
			bodyStats += "? (Variable due to Diapause)\n";
		else {
			if (player.hasPerk(PerkLib.MaraesGiftFertility)) preg++;
			if (player.hasPerk(PerkLib.BroodMother)) preg++;
			if (player.hasPerk(PerkLib.FerasBoonBreedingBitch)) preg++;
			if (player.hasPerk(PerkLib.MagicalFertility)) preg++;
			if (player.hasPerk(PerkLib.FerasBoonWideOpen) || player.hasPerk(PerkLib.FerasBoonMilkingTwat)) preg++;
			bodyStats += preg + "\n";
		}

		if (player.cocks.length > 0) {
			bodyStats += "<b>Total Cocks:</b> " + player.cocks.length + "\n";

			var totalCockLength:Number = 0;
			var totalCockGirth:Number  = 0;

			for (var i:Number = 0; i < player.cocks.length; i++) {
				totalCockLength += player.cocks[i].cockLength;
				totalCockGirth += player.cocks[i].cockThickness
			}

			bodyStats += "<b>Total Cock Length:</b> " + Math.round(totalCockLength) + " inches\n";
			bodyStats += "<b>Total Cock Girth:</b> " + Math.round(totalCockGirth) + " inches\n";
			bodyStats += "<b>Hours since last cum:</b> " + player.hoursSinceCum + "\n";

		}

		if (player.vaginas.length > 0)
			bodyStats += "<b>Vaginal Capacity:</b> " + Math.round(player.vaginalCapacity()) + "\n" + "<b>Vaginal Looseness:</b> " + Math.round(player.looseness()) + "\n";

		if (player.hasPerk(PerkLib.SpiderOvipositor) || player.hasPerk(PerkLib.BeeOvipositor))
			bodyStats += "<b>Ovipositor Total Egg Count: " + player.eggs() + "\nOvipositor Fertilized Egg Count: " + player.fertilizedEggs() + "</b>\n";

		if (player.hasStatusEffect(StatusEffects.SlimeCraving)) {
			if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18)
				bodyStats += "<b>Slime Craving:</b> Active! You are currently losing strength and speed.  You should find fluids.\n";
			else {
				if (player.hasPerk(PerkLib.SlimeCore) || player.hasPerk(PerkLib.DarkSlimeCore))
					bodyStats += "<b>Slime Stored:</b> " + ((17 - player.statusEffectv1(StatusEffects.SlimeCraving)) * 2) + " hours until you start losing strength.\n";
				else
					bodyStats += "<b>Slime Stored:</b> " + (17 - player.statusEffectv1(StatusEffects.SlimeCraving)) + " hours until you start losing strength.\n";
			}
		}

		if (bodyStats != "")
			outputText("\n<b><u>Body Stats</u></b>\n" + bodyStats);
		// End Body Stats

		// Begin Misc Stats
		var miscStats:String = "";

		if (camp.getCampPopulation() > 0) {
			miscStats += "<b>Camp Population:</b> " + camp.getCampPopulation() + "\n";
		//if (camp.getCampUndergroundPopulation() > 0)
			miscStats += "<b>Camp Underground Population:</b> " + camp.getCampUndergroundPopulation() + "\n";
		}

		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 2)
				miscStats += "<b>Nails:</b> " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/600" + "\n";
			else
				miscStats += "<b>Nails:</b> " + flags[kFLAGS.CAMP_CABIN_NAILS_RESOURCES] + "/200" + "\n";
		}
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 3)
				miscStats += "<b>Wood:</b> " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/900" + "\n";
			else
				miscStats += "<b>Wood:</b> " + flags[kFLAGS.CAMP_CABIN_WOOD_RESOURCES] + "/300" + "\n";
		}
		if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 1) {
			if (flags[kFLAGS.MATERIALS_STORAGE_UPGRADES] >= 4)
				miscStats += "<b>Stone:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/900" + "\n";
			else
				miscStats += "<b>Stone:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "/300" + "\n";
		}
		if (player.hasStatusEffect(StatusEffects.LumiWorkshop)) {
			miscStats += "<b>Metal Pieces:</b> " + flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] + "/200" + "\n";
		}

		miscStats += "<b>Basic Jobs:</b> " + player.currentBasicJobs() + " / 9\n";
		miscStats += "<b>Advanced Jobs:</b> " + player.currentAdvancedJobs() + " / " + player.maxAdvancedJobs() + "\n";
		miscStats += "<b>Hidden Jobs:</b> " + player.currentHiddenJobs() + " / " + player.maxHiddenJobs() + "\n";
		miscStats += "<b>Prestige Jobs:</b> " + player.currentPrestigeJobs() + " / " + player.maxPrestigeJobs() + "\n";
		
		if (player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter1)) {
			miscStats += "<b>Imps Hunt Quests completed:</b> " + player.statusEffectv1(StatusEffects.AdventureGuildQuestsCounter1) + "\n";
			miscStats += "<b>Demons Hunt Quests completed:</b> " + player.statusEffectv2(StatusEffects.AdventureGuildQuestsCounter1) + "\n";
			miscStats += "<b>Minotaurs Hunt Quests completed:</b> " + player.statusEffectv3(StatusEffects.AdventureGuildQuestsCounter1) + "\n";
		}
		if (player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter2)) {
			miscStats += "<b>Feral Tentacle Beasts Hunt Quests completed:</b> " + player.statusEffectv1(StatusEffects.AdventureGuildQuestsCounter2) + "\n";
			miscStats += "<b>Feral Imps Hunt Quests completed:</b> " + player.statusEffectv2(StatusEffects.AdventureGuildQuestsCounter2) + "\n";
			//miscStats += "<b>Imps Hunt Quests completed:</b> " + player.statusEffectv3(StatusEffects.AdventureGuildQuestsCounter2) + "\n";
		}
		if (player.hasStatusEffect(StatusEffects.AdventureGuildQuestsCounter4)) {
			miscStats += "<b>Black Chitin Gathering Quests completed:</b> " + player.statusEffectv1(StatusEffects.AdventureGuildQuestsCounter4) + "\n";
			miscStats += "<b>Green Gel Gathering Quests completed:</b> " + player.statusEffectv2(StatusEffects.AdventureGuildQuestsCounter4) + "\n";
			//miscStats += "<b>Imps Hunt Quests completed:</b> " + player.statusEffectv3(StatusEffects.AdventureGuildQuestsCounter1) + "\n";
		}

		if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] > 0) {
			if (flags[kFLAGS.CORRUPTED_GLADES_DESTROYED] < 100)
				miscStats += "<b>Corrupted Glades Status:</b> " + (100 - flags[kFLAGS.CORRUPTED_GLADES_DESTROYED]) + "% remaining\n";
			else
				miscStats += "<b>Corrupted Glades Status:</b> Extinct\n";
		}

		if (flags[kFLAGS.EGGS_BOUGHT] > 0)
			miscStats += "<b>Eggs Traded For:</b> " + flags[kFLAGS.EGGS_BOUGHT] + "\n";

		if (flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] > 0)
			miscStats += "<b>Times Had Fun with Feline Flexibility:</b> " + flags[kFLAGS.TIMES_AUTOFELLATIO_DUE_TO_CAT_FLEXABILITY] + "\n";

		if (flags[kFLAGS.FAP_ARENA_SESSIONS] > 0)
			miscStats += "<b>Times Circle Jerked in the Arena:</b> " + flags[kFLAGS.FAP_ARENA_SESSIONS] + "\n<b>Victories in the Arena:</b> " + flags[kFLAGS.FAP_ARENA_VICTORIES] + "\n";

		if (flags[kFLAGS.SPELLS_CAST] > 0)
			miscStats += "<b>Spells Cast:</b> " + flags[kFLAGS.SPELLS_CAST] + "\n";

		if (flags[kFLAGS.ARROWS_SHOT] > 0)
			miscStats += "<b>Arrows Fired:</b> " + flags[kFLAGS.ARROWS_SHOT] + "\n";

		if (flags[kFLAGS.TIMES_BAD_ENDED] > 0)
			miscStats += "<b>Times Bad-Ended:</b> " + flags[kFLAGS.TIMES_BAD_ENDED] + "\n";

		if (flags[kFLAGS.TIMES_ORGASMED] > 0)
			miscStats += "<b>Times Orgasmed:</b> " + flags[kFLAGS.TIMES_ORGASMED] + "\n";

		if (flags[kFLAGS.LUNA_MOON_CYCLE] > 0) {
			if (flags[kFLAGS.LUNA_MOON_CYCLE] == 8) miscStats += "<font color=\"#C00000\"><b>Day of the Moon Cycle:</b> " + flags[kFLAGS.LUNA_MOON_CYCLE] + " (FULL MOON)</font>";
			else miscStats += "<b>Day of the Moon Cycle:</b> " + flags[kFLAGS.LUNA_MOON_CYCLE];
			miscStats += "\n";
		}
		miscStats += "<b>Ebon Labyrinth:</b> Explored up to " + flags[kFLAGS.EBON_LABYRINTH_RECORD] + " room\n";
		miscStats += "<b>Exp needed to lvl up:</b> ";
		if (player.level < CoC.instance.levelCap) miscStats += "" + player.requiredXP() + "\n";
		else miscStats += "N/A (You already at max lvl)\n";
		miscStats += "<b>Ascension points (curently possesed):</b> " + player.ascensionPerkPoints + "\n";
		miscStats += "<b>Ascension points (possible to gain during next ascension):</b> " + camp.possibleToGainAscensionPoints() + "\n";
		
		if (miscStats != "")
			outputText("\n<b><u>Miscellaneous Stats</u></b>\n" + miscStats);
		// End Misc Stats

		// Begin Addition Stats
		var addictStats:String = "";
		//Marble Milk Addition
		if (player.statusEffectv3(StatusEffects.Marble) > 0) {
			addictStats += "<b>Marble Milk:</b> ";
			if (!player.hasPerk(PerkLib.MarbleResistant) && !player.hasPerk(PerkLib.MarblesMilk))
				addictStats += Math.round(player.statusEffectv2(StatusEffects.Marble)) + "%\n";
			else if (player.hasPerk(PerkLib.MarbleResistant))
				addictStats += "0%\n";
			else
				addictStats += "100%\n";
		}

		// Corrupted Minerva's Cum Addiction
		if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10 && flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] > 0) {
			addictStats += "<b>Minerva's Cum:</b> " + (flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] * 20) + "%";
		}

		// Mino Cum Addiction
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340] > 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 0 || player.hasPerk(PerkLib.MinotaurCumAddict) || player.hasPerk(PerkLib.MinotaurCumResistance) || player.hasPerk(PerkLib.ManticoreCumAddict)) {
			if (!player.hasPerk(PerkLib.MinotaurCumAddict))
				addictStats += "<b>Minotaur Cum:</b> " + Math.round(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] * 10) / 10 + "%\n";
			else if (player.hasPerk(PerkLib.MinotaurCumResistance) || player.hasPerk(PerkLib.ManticoreCumAddict))
				addictStats += "<b>Minotaur Cum:</b> 0% (Immune)\n";
			else
				addictStats += "<b>Minotaur Cum:</b> 100+%\n";
		}

		if (player.tailType == 28)
			addictStats += "<b>Manticore Hunger:</b> " + flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] + "%\n";

		if (addictStats != "")
			outputText("\n<b><u>Addictions</u></b>\n" + addictStats);
		// End Addition Stats

		// Begin Ongoing Stat Effects
		var statEffects:String = "";

		if (player.inHeat)
			statEffects += "Heat - " + Math.round(player.statusEffectv3(StatusEffects.Heat)) + " hours remaining\n";

		if (player.inRut)
			statEffects += "Rut - " + Math.round(player.statusEffectv3(StatusEffects.Rut)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.BlessingOfDivineFera) > 0)
			statEffects += "Blessing of Divine Agency - Fera: " + player.statusEffectv1(StatusEffects.BlessingOfDivineFera) + " hours remaining (Your lust resistance and corruption gains are empowered by 15% and 100% under the guidance of Fera)\n";

		if (player.statusEffectv1(StatusEffects.BlessingOfDivineMarae) > 0)
			statEffects += "Blessing of Divine Agency - Marae: " + player.statusEffectv1(StatusEffects.BlessingOfDivineMarae) + " hours remaining (Your white magic is empowered by " + player.statusEffectv2(StatusEffects.BlessingOfDivineMarae)*100 + "% under the guidance of Marae)\n";

		if (player.statusEffectv1(StatusEffects.BlessingOfDivineTaoth) > 0)
			statEffects += "Blessing of Divine Agency - Taoth: " + player.statusEffectv1(StatusEffects.BlessingOfDivineTaoth) + " hours remaining (Your speed is empowered by ~10% under the guidance of Taoth)\n";

		if (player.statusEffectv1(StatusEffects.Luststick) > 0)
			statEffects += "Luststick - " + Math.round(player.statusEffectv1(StatusEffects.Luststick)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.LustStickApplied) > 0)
			statEffects += "Luststick Application - " + Math.round(player.statusEffectv1(StatusEffects.LustStickApplied)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.LustyTongue) > 0)
			statEffects += "Lusty Tongue - " + Math.round(player.statusEffectv1(StatusEffects.LustyTongue)) + " hours remaining\n";

		if (player.statusEffectv1(StatusEffects.BlackCatBeer) > 0)
			statEffects += "Black Cat Beer - " + player.statusEffectv1(StatusEffects.BlackCatBeer) + " hours remaining (Lust resistance 20% lower, physical resistance 25% higher.)\n";

		if (player.statusEffectv1(StatusEffects.AndysSmoke) > 0)
			statEffects += "Andy's Pipe Smoke - " + player.statusEffectv1(StatusEffects.AndysSmoke) + " hours remaining (Speed temporarily lowered, intelligence temporarily increased.)\n";

		if (player.statusEffectv1(StatusEffects.IzumisPipeSmoke) > 0)
			statEffects += "Izumi's Pipe Smoke - " + player.statusEffectv1(StatusEffects.IzumisPipeSmoke) + " hours remaining. (Speed temporarily lowered.)\n";

		if (player.statusEffectv1(StatusEffects.DrunkenPower) > 0)
			statEffects += "Drunken Power - " + player.statusEffectv1(StatusEffects.DrunkenPower) + " hours remaining (Strength/libido temporarily increased, speed/intelligence temporarily lowered.)\n";

		if (player.statusEffectv1(StatusEffects.UmasMassage) > 0)
			statEffects += "Uma's Massage - " + player.statusEffectv3(StatusEffects.UmasMassage) + " hours remaining.\n";

		if (player.statusEffectv1(StatusEffects.BathedInHotSpring) > 0)
			statEffects += "Bathed in Hot Spring - " + player.statusEffectv1(StatusEffects.BathedInHotSpring) + " hours remaining. (Fatigue recovery rate 20% higher)\n";

		if (player.statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff1) > 0)
			statEffects += "Eating in 'Shira of the east' restaurant effect - " + player.statusEffectv1(StatusEffects.ShiraOfTheEastFoodBuff1) + " hours remaining. (Increased stats and elemental resistance)\n";

		if (player.statusEffectv1(StatusEffects.RaijuLightningStatus) > 0)
			statEffects += "Raiju Lightning - " + player.statusEffectv1(StatusEffects.RaijuLightningStatus) + " hours remaining. (During masturbation: Increase lust rather than dropping and extends duration of this effect by a few hours. Can also cause uncontrolled transformations into a raiju.)\n";

		if (player.statusEffectv1(StatusEffects.KonstantinArmorPolishing) > 0)
			statEffects += "Armor Polishing - " + player.statusEffectv1(StatusEffects.KonstantinArmorPolishing) + " hours remaining. (+" + player.statusEffectv2(StatusEffects.KonstantinArmorPolishing) + "% to armor)\n";

		if (player.statusEffectv1(StatusEffects.KonstantinWeaponSharpening) > 0)
			statEffects += "Weapon Sharpening - " + player.statusEffectv1(StatusEffects.KonstantinWeaponSharpening) + " hours remaining. (+" + player.statusEffectv2(StatusEffects.KonstantinWeaponSharpening) + "% to melee weapon atk)\n";

		if (player.statusEffectv1(StatusEffects.Dysfunction) > 0)
			statEffects += "Dysfunction - " + player.statusEffectv1(StatusEffects.Dysfunction) + " hours remaining. (Disables masturbation)\n";

		if (player.statusEffectv1(StatusEffects.HinezumiCoat) > 0)
			statEffects += "Hinezumi Coat: Unarmed attacks minor deal fire damage and discharge lust (1 point per attack) when you are aroused above 50%.\n";

		if (player.statusEffectv1(StatusEffects.Airweed) > 0)
			statEffects += "Airweed: Water breathing for " + Math.round(player.statusEffectv1(StatusEffects.Airweed)) + " hours.\n";

		if (player.statusEffectv1(StatusEffects.WendigoPsychosis) > 0)
			statEffects += "Wendigo psychosis - " + player.statusEffectv1(StatusEffects.WendigoPsychosis) + " hours remaining.\n";

		var vthirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		if (vthirst != null) {
			statEffects += "Vampire Thirst: " + vthirst.value1 + "/" + vthirst.maxThirst() + " ";
			if (vthirst.currentBoost > 0) statEffects += "(+" + vthirst.currentBoost + " to str / spe / int / lib)";
			statEffects += "\n";
		}

		if (player.statusEffectv1(StatusEffects.Bammed1) > 0) {
			if (player.statusEffectv1(StatusEffects.Bammed1) == 3) statEffects += "Bammed <b>(Disables melee attacks permanently)</b>\n";
			else statEffects += "Bammed - " + player.statusEffectv3(StatusEffects.Bammed1) + " hours remaining. (Disables melee attacks)\n";
		}
		if (player.statusEffectv2(StatusEffects.Bammed1) > 0) {
			if (player.statusEffectv2(StatusEffects.Bammed1) == 3) statEffects += "Bammed <b>(Disables range attacks permanently)</b>\n";
			else statEffects += "Bammed - " + player.statusEffectv4(StatusEffects.Bammed1) + " hours remaining. (Disables range attacks)\n";
		}
		if (player.statusEffectv1(StatusEffects.Bammed2) > 0) {
			if (player.statusEffectv1(StatusEffects.Bammed2) == 3) statEffects += "Bammed <b>(Disables physical specials permanently)</b>\n";
			else statEffects += "Bammed - " + player.statusEffectv3(StatusEffects.Bammed2) + " hours remaining. (Disables physical specials)\n";
		}
		if (player.statusEffectv2(StatusEffects.Bammed2) > 0) {
			if (player.statusEffectv2(StatusEffects.Bammed2) == 3) statEffects += "Bammed <b>(Disables magic specials permanently)</b>\n";
			else statEffects += "Bammed - " + player.statusEffectv4(StatusEffects.Bammed2) + " hours remaining. (Disables magic specials)\n";
		}

		if (statEffects != "")
			outputText("\n<b><u>Ongoing Status Effects</u></b>\n" + statEffects);
		// End Ongoing Stat Effects
		menu();
		addButton(0, "Next", playerMenu);
		if (player.statPoints > 0) {
			outputText("\n\n<b>You have " + num2Text(player.statPoints) + " attribute point" + (player.statPoints == 1 ? "" : "s") + " to distribute.</b>");
			addButton(1, "Stat Up", attributeMenu);
		}
		addButtonDisabled(5, "General", "You are currently at this stats page.");
		addButton(6, "Combat", displayStatsCombat);
		addButton(7, "NPC's", displayStatsNpcs);
		addButton(8, "Children", displayStatsChildren);
		addButton(9, "Mastery", displayStatsmastery);
		}
	public function displayStatsCombat():void {
		spriteSelect(-1);
		clearOutput();
		displayHeader("Combat Stats");
		// Begin Combat Stats
		var combatStats:String = "";

		combatStats += "<b>Resistance (Physical):</b> " + (100 - Math.round(player.damagePercent())) + "%\n";
		combatStats += "<b>Resistance (Magic):</b> " + (100 - Math.round(player.damageMagicalPercent())) + "%\n";
		combatStats += "<i>Resistance (Fire):</i> " + (100 - Math.round(player.damageFirePercent())) + "%\n";
		combatStats += "<i>Resistance (Ice):</i> " + (100 - Math.round(player.damageIcePercent())) + "%\n";
		combatStats += "<i>Resistance (Lightning):</i> " + (100 - Math.round(player.damageLightningPercent())) + "%\n";
		combatStats += "<i>Resistance (Darkness):</i> " + (100 - Math.round(player.damageDarknessPercent())) + "%\n";
		combatStats += "<i>Resistance (Poison):</i> " + (100 - Math.round(player.damagePoisonPercent())) + "%\n";
		combatStats += "<b>Resistance (Lust):</b> " + (100 - Math.round(CoC.instance.player.lustPercent())) + "%\n";
		combatStats += "\n";
		combatStats += "<b>Spells Effect Multiplier:</b> " + Math.round(100 * combat.spellMod()) + "%\n";
		combatStats += "<b>Spells Cost:</b> " + combat.spellCost(100) + "%\n";
		combatStats += "<b>White Spells Effect Multiplier:</b> " + Math.round(100 * combat.spellModWhite()) + "%\n";
		combatStats += "<b>White Spells Cost:</b> " + combat.spellCostWhite(100) + "%\n";
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) combatStats += "<b>White Spells Cooldowns:</b> " + combat.spellWhiteCooldown() + " turns\n";
		combatStats += "<b>Black Spells Effect Multiplier:</b> " + Math.round(100 * combat.spellModBlack()) + "%\n";
		combatStats += "<b>Black Spells Cost:</b> " + combat.spellCostBlack(100) + "%\n";
		if (flags[kFLAGS.SPELLS_COOLDOWNS] == 0) combatStats += "<b>Black Spells Cooldowns:</b> " + combat.spellBlackCooldown() + " turns\n";
		combatStats += "<b>Blood Spells/Soulskills Effect Multiplier:</b> " + Math.round(100 * combat.spellModBlood()) + "%\n";
		combatStats += "<b>Blood Spells/Soulskills Cost:</b> " + combat.spellCostBlood(100) + "%\n";
		combatStats += "\n";
		combatStats += "<b>Heals Effect Multiplier:</b> " + Math.round(100 * combat.healMod()) + "%\n";
		combatStats += "<b>Heals Cost:</b> " + combat.healCost(100) + "%\n";
		combatStats += "<b>White Heals Effect Multiplier:</b> " + Math.round(100 * combat.healModWhite()) + "%\n";
		combatStats += "<b>White Heals Cost:</b> " + combat.healCostWhite(100) + "%\n";
		combatStats += "<b>Black Heals Effect Multiplier:</b> " + Math.round(100 * combat.healModBlack()) + "%\n";
		combatStats += "<b>Black Heals Cost:</b> " + combat.healCostBlack(100) + "%\n";
		combatStats += "\n";
		combatStats += "<b>Accuracy (1st melee attack):</b> " + (combat.meleeAccuracy() / 2) + "%\n";
		if (player.hasPerk(PerkLib.DoubleAttackSmall) || player.hasPerk(PerkLib.DoubleAttack) || player.hasPerk(PerkLib.DoubleAttackLarge)) combatStats += "<b>Accuracy (2nd melee attack):</b> " + ((combat.meleeAccuracy() / 2) - (combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty())) + "%\n";
		if (player.hasPerk(PerkLib.TripleAttackSmall) || player.hasPerk(PerkLib.TripleAttack) || player.hasPerk(PerkLib.TripleAttackLarge)) combatStats += "<b>Accuracy (3rd melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 2)) + "%\n";
		if (player.hasPerk(PerkLib.QuadrupleAttackSmall) || player.hasPerk(PerkLib.QuadrupleAttack)) combatStats += "<b>Accuracy (4th melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 3)) + "%\n";
		if (player.hasPerk(PerkLib.PentaAttackSmall) || player.hasPerk(PerkLib.PentaAttack)) combatStats += "<b>Accuracy (5th melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 4)) + "%\n";
		if (player.hasPerk(PerkLib.HexaAttackSmall) || player.hasPerk(PerkLib.HexaAttack)) combatStats += "<b>Accuracy (6th melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 5)) + "%\n";
		if (player.hasPerk(PerkLib.HectaAttackSmall)) combatStats += "<b>Accuracy (7th melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 6)) + "%\n";
		if (player.hasPerk(PerkLib.OctaAttackSmall)) combatStats += "<b>Accuracy (8th melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 7)) + "%\n";
		if (player.hasPerk(PerkLib.NonaAttackSmall)) combatStats += "<b>Accuracy (9th melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 8)) + "%\n";
		if (player.hasPerk(PerkLib.DecaAttackSmall)) combatStats += "<b>Accuracy (10th melee attack):</b> " + ((combat.meleeAccuracy() / 2) - ((combat.meleeAccuracyPenalty() + combat.meleeDualWieldAccuracyPenalty()) * 9)) + "%\n";
		combatStats += "<i>(All accuracy values above includes bonus to accuracy from Archery Mastery)</i>\n";
		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kindra) < 1)
				combatStats += "<b>Bow Skill:</b> " + Math.round(player.statusEffectv1(StatusEffects.Kelt)) + " / 100\n";
			if (player.statusEffectv1(StatusEffects.Kindra) > 0)
				combatStats += "<b>Bow Skill:</b> " + (Math.round(player.statusEffectv1(StatusEffects.Kelt)) + Math.round(player.statusEffectv1(StatusEffects.Kindra))) + " / 250\n";
		}
		else combatStats += "<b>Bow Skill:</b> 0 / 100\n";
		combatStats += "<b>Arrow/Bolt Cost:</b> " + combat.bowCost(100) + "%\n";
		combatStats += "<b>Arrow Cost (Fatigue): </b> " + combat.oneArrowTotalCost() + "\n";
		combatStats += "<b>Throw Cost (Fatigue): </b> " + combat.oneThrowTotalCost() + "\n";
		combatStats += "<b>One Bullet Reload Cost (Fatigue): </b> " + combat.oneBulletReloadCost() + "\n";
		combatStats += "<b>Bow/Crossbow Accuracy (1st range attack):</b> " + (combat.arrowsAccuracy() / 2) + "%\n";
		if (player.hasPerk(PerkLib.DoubleStrike)) combatStats += "<b>Bow/Crossbow Accuracy (2nd range attack):</b> " + ((combat.arrowsAccuracy() / 2) - combat.arrowsAccuracyPenalty()) + "%\n";
		if (player.hasPerk(PerkLib.TripleStrike)) combatStats += "<b>Bow/Crossbow Accuracy (3rd range attack):</b> " + ((combat.arrowsAccuracy() / 2) - (combat.arrowsAccuracyPenalty() * 2)) + "%\n";
		if (player.hasPerk(PerkLib.Manyshot)) combatStats += "<b>Bow/Crossbow Accuracy (4th range attack):</b> " + ((combat.arrowsAccuracy() / 2) - (combat.arrowsAccuracyPenalty() * 3)) + "%\n";
		if (player.hasPerk(PerkLib.WildQuiver)) combatStats += "<b>Bow/Crossbow Accuracy (5th range attack):</b> " + ((combat.arrowsAccuracy() / 2) - (combat.arrowsAccuracyPenalty() * 4)) + "%\n";
		if (player.hasPerk(PerkLib.Multishot)) combatStats += "<b>Bow/Crossbow Accuracy (6th range attack):</b> " + ((combat.arrowsAccuracy() / 2) - (combat.arrowsAccuracyPenalty() * 5)) + "%\n";
		combatStats += "<i>(All accuracy values above includes bonus to accuracy from Archery Mastery)</i>\n";
		combatStats += "<b>Throwed Weapon Accuracy (1st range attack):</b> " + (combat.throwingAccuracy() / 2) + "%\n";
		if (player.hasPerk(PerkLib.DoubleStrike)) combatStats += "<b>Throwed Weapon Accuracy (2nd range attack):</b> " + ((combat.throwingAccuracy() / 2) - 15) + "%\n";
		if (player.hasPerk(PerkLib.TripleStrike)) combatStats += "<b>Throwed Weapon Accuracy (3rd range attack):</b> " + ((combat.throwingAccuracy() / 2) - 30) + "%\n";
		combatStats += "<i>(All accuracy values above includes bonus to accuracy from Throwing Weapons Mastery)</i>\n";
		combatStats += "<b>Firearms Accuracy (1st range attack):</b> " + (combat.firearmsAccuracy() / 2) + "%\n";
		if (player.hasPerk(PerkLib.AmateurGunslinger)) combatStats += "<b>Firearms Accuracy (2nd range attack):</b> " + ((combat.firearmsAccuracy() / 2) - (combat.firearmsAccuracyPenalty() + combat.firearmsDualWieldAccuracyPenalty())) + "%\n";
		if (player.hasPerk(PerkLib.ExpertGunslinger)) combatStats += "<b>Firearms Accuracy (3rd range attack):</b> " + ((combat.firearmsAccuracy() / 2) - ((combat.firearmsAccuracyPenalty() + combat.firearmsDualWieldAccuracyPenalty()) * 2)) + "%\n";
		if (player.hasPerk(PerkLib.MasterGunslinger)) combatStats += "<b>Firearms Accuracy (4th range attack):</b> " + ((combat.firearmsAccuracy() / 2) - ((combat.firearmsAccuracyPenalty() + combat.firearmsDualWieldAccuracyPenalty()) * 3)) + "%\n";
		combatStats += "<i>(All accuracy values above includes bonus to accuracy from Firearms Mastery)</i>\n";
		combatStats += "\n";
		combatStats += "<b>Soulskill Effect Multiplier:</b> " + Math.round(100 * combat.soulskillMod()) + "%\n";
		combatStats += "<b>Physical Soulskill Effect Multiplier:</b> " + Math.round(100 * combat.soulskillPhysicalMod()) + "%\n";
		combatStats += "<b>Magical Soulskill Effect Multiplier:</b> " + Math.round(100 * combat.soulskillMagicalMod()) + "%\n";
		combatStats += "<b>Soulskill Cost:</b> " + Math.round(100 * combat.soulskillCost()) + "%\n";
		combatStats += "\n";
		combatStats += "<b>Unarmed:</b> +" + combat.unarmedAttack() + "\n";
		combatStats += "<b>Venom:</b> " + Math.floor(player.tailVenom) + " / " + player.maxVenom() + "\n";
		combatStats += "<b>Venom Recharge:</b> +" + player.tailRecharge + " / hour\n";
		combatStats += "\n";
		var mins:Object = player.getAllMinStats();
		combatStats += "<b>Strength Cap:</b> " + Math.floor(player.strStat.max) + "\n";
		combatStats += "<i>Ghost Strength:</i> +" + Math.floor(combat.ghostStrength()) + "\n";
		combatStats += "<b>Toughness Cap:</b> " + Math.floor(player.touStat.max) + "\n";
		combatStats += "<i>Ghost Toughness:</i> +" + Math.floor(combat.ghostToughness()) + "\n";
		combatStats += "<b>Speed Cap:</b> " + Math.floor(player.speStat.max) + "\n";
		combatStats += "<i>Ghost Speed:</i> +" + Math.floor(combat.ghostSpeed()) + "\n";
		combatStats += "<b>Intelligence Cap:</b> " + Math.floor(player.intStat.max) + "\n";
		combatStats += "<b>Wisdom Cap:</b> " + Math.floor(player.wisStat.max) + "\n";
		combatStats += "<b>Libido Cap:</b> " + Math.floor(player.libStat.max) + "\n";
		combatStats += "<i>Effective Libido:</i> " + Math.floor(player.effectiveLibido()) + "\n";
		combatStats += "<i>Libido Minimum:</i> " + mins.lib + "\n";
		combatStats += "<b>Sensitivity Cap:</b> " + Math.floor(player.sensStat.max) + "\n";
		combatStats += "<i>Effective Sensitivity:</i> " + Math.floor(player.effectiveSensitivity()) + "\n";
		combatStats += "<i>Sensitivity Minimum:</i> " + mins.sens + "\n";
		combatStats += "<i>Corruption Minimum:</i> " + mins.cor + "\n";
		combatStats += "\n";
		combatStats += "<b>HP Regeneration (%):</b> ~ " + combat.PercentBasedRegeneration() + " % / " + combat.maximumRegeneration() + " % (turn), ~ " + combat.PercentBasedRegeneration() * 2 + " % / " + combat.maximumRegeneration() * 2 + " % (hour)\n";
		combatStats += "<b>HP Regeneration (Total):</b> ~ " + Math.round((player.maxHP() * combat.PercentBasedRegeneration() / 100) + combat.nonPercentBasedRegeneration()) + " HP /  turn, ~ " + Math.round((player.maxHP() * combat.PercentBasedRegeneration() / 100) + combat.nonPercentBasedRegeneration()) * 2 + " HP /  hour\n";
		combatStats += "<b>Fatigue Recovery:</b> " + combat.fatigueRecovery2() + " / turn\n";
		combatStats += "<b>Wrath Generation:</b> " + combat.wrathregeneration2() * 2 + " / turn, "+(player.hasPerk(PerkLib.AbsoluteStrength) ? ""+combat.wrathregeneration2()+"":"-60%")+" / hour\n";
		combatStats += "<b>Mana Regeneration:</b> " + Math.round(combat.manaregeneration2() * combat.manaRecoveryMultiplier()) + " / turn, " + Math.round(combat.manaregeneration2() * combat.manaRecoveryMultiplier()) * 2 + " / hour\n";
		combatStats += "<b>Soulforce Regeneration:</b> " + Math.round(combat.soulforceregeneration2() * combat.soulforceRecoveryMultiplier()) + " / turn, " + Math.round(combat.soulforceregeneration2() * combat.soulforceRecoveryMultiplier()) * 2 + " / hour\n";
		combatStats += "\n";
		combatStats += "<b>Minimum HP (reaching it mean HP based defeat):</b> " + player.minHP() + "\n";
		combatStats += "<b>Over HP (HP amount that can be reached beyond default 100% of Health bar):</b> " + (player.maxOverHP() - player.maxHP()) + "\n";
		combatStats += "<b>Maximum Safe Wrath I (treshold after which spells are unaccesable):</b> " + player.maxSafeWrathSpellcasting() + "\n";
		combatStats += "<b>Maximum Safe Wrath II (treshold after which magic soulskills are unaccesable):</b> " + player.maxSafeWrathMagicalAbilities() + "\n";
		combatStats += "<b>Over Wrath (Wrath amount that can be reached beyond default 100% of Wrath bar):</b> " + (player.maxOverWrath() - player.maxWrath()) + "\n";
		combatStats += "\n";
		combatStats += "<b>Base evasion:</b> " + player.getEvasionChance() + " %\n";
		combatStats += "<b>Base block chance:</b> " + combat.combatBlock2() + " %\n";
		combatStats += "<b>Base parry chance:</b> " + combat.combatParry2() + " %\n";
		combatStats += "<b>Base physical attacks critical chance:</b> " + combat.combatPhysicalCritical() + " %\n";
		combatStats += "<b>Base magical attacks critical chance:</b> " + combat.combatMagicalCritical() + " %\n";
		var vthirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
		if (vthirst != null) {
			combatStats += "<b>Vampire Thirst:</b> " + vthirst.value1 + "/" + vthirst.maxThirst() + " ";
			if (vthirst.currentBoost > 0) combatStats += "(+" + vthirst.currentBoost + " to str / spe / int / lib)";
			combatStats += "\n";
		}

		if (combatStats != "")
			outputText("\n<b><u>Combat Stats</u></b>\n" + combatStats);
		// End Combat Stats
		
		// Begin Kill Counters Stats
		var killCountStats:String = "";

		killCountStats += "<b>Goblins:</b> " + flags[kFLAGS.GOBLINS_KILLED] + "\n";
		killCountStats += "<b>Hellhounds:</b> " + flags[kFLAGS.HELLHOUNDS_KILLED] + "\n";
		killCountStats += "<b>Imps:</b> " + flags[kFLAGS.IMPS_KILLED] + "\n";
		killCountStats += "<b>Minotaurs:</b> " + flags[kFLAGS.MINOTAURS_KILLED] + "\n";

		if (killCountStats != "")
			outputText("\n<b><u>Kill Counters</u></b>\n" + killCountStats);
		// End Kill Counters Stats
		
		if (prison.inPrison || flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) prison.displayPrisonStats();
		
		menu();
		addButton(0, "Next", playerMenu);
		addButton(5, "General", displayStats);
		addButtonDisabled(6, "Combat", "You are currently at this stats page.");
		addButton(7, "NPC's", displayStatsNpcs);
		addButton(8, "Children", displayStatsChildren);
		addButton(9, "Mastery", displayStatsmastery);
	}
	public function displayStatsNpcs():void {
		spriteSelect(-1);
		clearOutput();
		displayHeader("NPC's Stats");

		// Begin Interpersonal Stats
		var interpersonStats:String = "";
			
		if (flags[kFLAGS.AIKO_TIMES_MET] > 0) {
			interpersonStats  += "<b>Aiko Affection:</b> "+flags[kFLAGS.AIKO_AFFECTION]+"\n";
			if (flags[kFLAGS.AIKO_CORRUPTION_ACTIVE] > 0)
				interpersonStats  += "<b>Aiko Corruption:</b> "+flags[kFLAGS.AIKO_CORRUPTION]+"\n";
		}

		if (flags[kFLAGS.ALVINA_FOLLOWER] > 12) {
			interpersonStats  += "<b>Alvina's Relationship Level:</b> " + (flags[kFLAGS.ALVINA_FOLLOWER] >= 20 ? "Lover" : "Follower") + "\n";
		}

		if (SceneLib.anzu.anzuRelationshipLevel() > 0) {
			interpersonStats += "<b>Anzu's Affection:</b> " + flags[kFLAGS.ANZU_AFFECTION] + "%\n";
			interpersonStats += "<b>Anzu's Relationship Level:</b> " + (flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 1 ? "Acquaintances" : flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 2 ? "Friend" : flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 3 ? "Close Friend" : flags[kFLAGS.ANZU_RELATIONSHIP_LEVEL] == 4 ? "Lover" : "Undefined") + "\n";
		}
			
		if (flags[kFLAGS.ARIAN_PARK] > 0)
            interpersonStats += "<b>Arian's Health:</b> " + Math.round(SceneLib.arianScene.arianHealth()) + "\n";
        if (flags[kFLAGS.ARIAN_VIRGIN] > 0)
			interpersonStats += "<b>Arian Sex Counter:</b> " + Math.round(flags[kFLAGS.ARIAN_VIRGIN]) + "\n";

		if (flags[kFLAGS.AURORA_LVL] >= 1) {
			//interpersonStats += "<b>Aurora:</b> " + Math.round(flags[kFLAGS.GALIA_AFFECTION]) + "%\n";
			/*if (flags[kFLAGS.AURORA_LVL] == 14) interpersonStats += "<b>Aurora lvl:</b> 79\n";
			if (flags[kFLAGS.AURORA_LVL] == 13) interpersonStats += "<b>Aurora lvl:</b> 73\n";
			if (flags[kFLAGS.AURORA_LVL] == 12) interpersonStats += "<b>Aurora lvl:</b> 67\n";
			if (flags[kFLAGS.AURORA_LVL] == 11) interpersonStats += "<b>Aurora lvl:</b> 61\n";
			if (flags[kFLAGS.AURORA_LVL] == 10) interpersonStats += "<b>Aurora lvl:</b> 55\n";
			if (flags[kFLAGS.AURORA_LVL] == 9) interpersonStats += "<b>Aurora lvl:</b> 49\n";
			if (flags[kFLAGS.AURORA_LVL] == 8) interpersonStats += "<b>Aurora lvl:</b> 43\n";
			if (flags[kFLAGS.AURORA_LVL] == 7) interpersonStats += "<b>Aurora lvl:</b> 37\n";
			if (flags[kFLAGS.AURORA_LVL] == 6) interpersonStats += "<b>Aurora lvl:</b> 31\n";
			if (flags[kFLAGS.AURORA_LVL] == 5) interpersonStats += "<b>Aurora lvl:</b> 25\n";*/
			if (flags[kFLAGS.AURORA_LVL] == 4) interpersonStats += "<b>Aurora lvl:</b> 19\n";
			if (flags[kFLAGS.AURORA_LVL] == 3) interpersonStats += "<b>Aurora lvl:</b> 13\n";
			if (flags[kFLAGS.AURORA_LVL] == 2) interpersonStats += "<b>Aurora lvl:</b> 7\n";
			if (flags[kFLAGS.AURORA_LVL] == 1) interpersonStats += "<b>Aurora lvl:</b> 1\n";
		}
			
		if (SceneLib.bazaar.benoit.benoitAffection() > 0)
            interpersonStats += "<b>" + SceneLib.bazaar.benoit.benoitMF("Benoit", "Benoite") + " Affection:</b> " + Math.round(SceneLib.bazaar.benoit.benoitAffection()) + "%\n";
        if (flags[kFLAGS.BROOKE_MET] > 0)
            interpersonStats += "<b>Brooke Affection:</b> " + Math.round(SceneLib.telAdre.brooke.brookeAffection()) + "\n";
        if (flags[kFLAGS.CEANI_AFFECTION] > 0)
			interpersonStats += "<b>Ceani Affection:</b> " + Math.round(flags[kFLAGS.CEANI_AFFECTION]) + "%\n";
			if (flags[kFLAGS.CEANI_FOLLOWER] == 1) {
				if (flags[kFLAGS.CEANI_LVL_UP] == 9) interpersonStats += "<b>Ceani lvl:</b> 98\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 8) interpersonStats += "<b>Ceani lvl:</b> 92\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 7) interpersonStats += "<b>Ceani lvl:</b> 86\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 6) interpersonStats += "<b>Ceani lvl:</b> 80\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 5) interpersonStats += "<b>Ceani lvl:</b> 74\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 4) interpersonStats += "<b>Ceani lvl:</b> 68\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 3) interpersonStats += "<b>Ceani lvl:</b> 60\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 2) interpersonStats += "<b>Ceani lvl:</b> 54\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 1) interpersonStats += "<b>Ceani lvl:</b> 46\n";
				if (flags[kFLAGS.CEANI_LVL_UP] == 0) interpersonStats += "<b>Ceani lvl:</b> 38\n";
			}

		if (flags[kFLAGS.CHI_CHI_AFFECTION] > 0) {
			interpersonStats += "<b>Chi Chi Affection:</b> " + Math.round(flags[kFLAGS.CHI_CHI_AFFECTION]) + "%\n";
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 6) interpersonStats += "<b>Chi Chi status:</b> Wife\n";
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 5) interpersonStats += "<b>Chi Chi status:</b> <font color=\"#800000\">Taken Away by Chon Lao</font>\n";
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 3) interpersonStats += "<b>Chi Chi status:</b> Lover\n";
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] == 2) interpersonStats += "<b>Chi Chi status:</b> <font color=\"#800000\">Dead</font>\n";
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] < 2) interpersonStats += "<b>Chi Chi status:</b> Apprentice\n";
			if (flags[kFLAGS.CHI_CHI_FOLLOWER] >= 3) {
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 8) interpersonStats += "<b>Chi Chi lvl:</b> 76\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 7) interpersonStats += "<b>Chi Chi lvl:</b> 70\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 6) interpersonStats += "<b>Chi Chi lvl:</b> 64\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 5) interpersonStats += "<b>Chi Chi lvl:</b> 58\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 4) interpersonStats += "<b>Chi Chi lvl:</b> 49\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 3) interpersonStats += "<b>Chi Chi lvl:</b> 40\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] == 2) interpersonStats += "<b>Chi Chi lvl:</b> 31\n";
				if (flags[kFLAGS.CHI_CHI_LVL_UP] < 2) interpersonStats += "<b>Chi Chi lvl:</b> 22\n";
			}
		}

		if (flags[kFLAGS.CERAPH_OWNED_DICKS] + flags[kFLAGS.CERAPH_OWNED_PUSSIES] + flags[kFLAGS.CERAPH_OWNED_TITS] > 0)
			interpersonStats += "<b>Body Parts Taken By Ceraph:</b> " + (flags[kFLAGS.CERAPH_OWNED_DICKS] + flags[kFLAGS.CERAPH_OWNED_PUSSIES] + flags[kFLAGS.CERAPH_OWNED_TITS]) + "\n";

		if (flags[kFLAGS.DIANA_AFFECTION] > 0) {
			interpersonStats += "<b>Diana Affection:</b> " + Math.round(flags[kFLAGS.DIANA_AFFECTION]) + "%\n";
			interpersonStats += "<b>Spells Casted:</b> " + flags[kFLAGS.DIANA_SPELLS_CASTED] + "\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 16) interpersonStats += "<b>Diana lvl:</b> 75\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 15) interpersonStats += "<b>Diana lvl:</b> 69\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 14) interpersonStats += "<b>Diana lvl:</b> 63\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 13) interpersonStats += "<b>Diana lvl:</b> 57\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 12) interpersonStats += "<b>Diana lvl:</b> 51\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 11) interpersonStats += "<b>Diana lvl:</b> 45\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 10) interpersonStats += "<b>Diana lvl:</b> 39\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 9) interpersonStats += "<b>Diana lvl:</b> 33\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 8) interpersonStats += "<b>Diana lvl:</b> 27\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 7) interpersonStats += "<b>Diana lvl:</b> 24\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 6) interpersonStats += "<b>Diana lvl:</b> 21\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 5) interpersonStats += "<b>Diana lvl:</b> 18\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 4) interpersonStats += "<b>Diana lvl:</b> 15\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 3) interpersonStats += "<b>Diana lvl:</b> 12\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 2) interpersonStats += "<b>Diana lvl:</b> 9\n";
			if (flags[kFLAGS.DIANA_LVL_UP] == 1) interpersonStats += "<b>Diana lvl:</b> 6\n";
			if (flags[kFLAGS.DIANA_LVL_UP] < 1) interpersonStats += "<b>Diana lvl:</b> 3\n";
		}

		if (flags[kFLAGS.DINAH_LVL_UP] > 0.5) {
			interpersonStats += "<b>Dinah Affection:</b> " + Math.round(flags[kFLAGS.DINAH_AFFECTION]) + "%\n";
			interpersonStats += "<b>Spells Casted:</b> " + flags[kFLAGS.DINAH_SPELLS_CASTED] + "\n";
			if (flags[kFLAGS.DINAH_LVL_UP] == 7) interpersonStats += "<b>Dinah lvl:</b> 44\n";
			if (flags[kFLAGS.DINAH_LVL_UP] == 6) interpersonStats += "<b>Dinah lvl:</b> 38\n";
			if (flags[kFLAGS.DINAH_LVL_UP] == 5) interpersonStats += "<b>Dinah lvl:</b> 32\n";
			if (flags[kFLAGS.DINAH_LVL_UP] == 4) interpersonStats += "<b>Dinah lvl:</b> 26\n";
			if (flags[kFLAGS.DINAH_LVL_UP] == 3) interpersonStats += "<b>Dinah lvl:</b> 20\n";
			if (flags[kFLAGS.DINAH_LVL_UP] == 2) interpersonStats += "<b>Dinah lvl:</b> 14\n";
			if (flags[kFLAGS.DINAH_LVL_UP] == 1) interpersonStats += "<b>Dinah lvl:</b> 8\n";
		}

		if (flags[kFLAGS.ETNA_AFFECTION] > 0) {
			interpersonStats += "<b>Etna Affection:</b> " + Math.round(flags[kFLAGS.ETNA_AFFECTION]) + "%\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 11) interpersonStats += "<b>Etna lvl:</b> 96\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 10) interpersonStats += "<b>Etna lvl:</b> 90\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 9) interpersonStats += "<b>Etna lvl:</b> 84\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 8) interpersonStats += "<b>Etna lvl:</b> 78\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 7) interpersonStats += "<b>Etna lvl:</b> 72\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 6) interpersonStats += "<b>Etna lvl:</b> 66\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 5) interpersonStats += "<b>Etna lvl:</b> 60\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 4) interpersonStats += "<b>Etna lvl:</b> 54\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 3) interpersonStats += "<b>Etna lvl:</b> 48\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 2) interpersonStats += "<b>Etna lvl:</b> 42\n";
			if (flags[kFLAGS.ETNA_LVL_UP] == 1) interpersonStats += "<b>Etna lvl:</b> 36\n";
			if (flags[kFLAGS.ETNA_LVL_UP] < 1) interpersonStats += "<b>Etna lvl:</b> 30\n";
		}

		if (flags[kFLAGS.ELECTRA_AFFECTION] > 0) {
			interpersonStats += "<b>Electra Affection:</b> " + Math.round(flags[kFLAGS.ELECTRA_AFFECTION]) + "%\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 12) interpersonStats += "<b>Electra lvl:</b> 96\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 11) interpersonStats += "<b>Electra lvl:</b> 90\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 10) interpersonStats += "<b>Electra lvl:</b> 84\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 9) interpersonStats += "<b>Electra lvl:</b> 78\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 8) interpersonStats += "<b>Electra lvl:</b> 72\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 7) interpersonStats += "<b>Electra lvl:</b> 66\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 6) interpersonStats += "<b>Electra lvl:</b> 60\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 5) interpersonStats += "<b>Electra lvl:</b> 54\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 4) interpersonStats += "<b>Electra lvl:</b> 48\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 3) interpersonStats += "<b>Electra lvl:</b> 42\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] == 2) interpersonStats += "<b>Electra lvl:</b> 36\n";
			if (flags[kFLAGS.ELECTRA_LVL_UP] < 2) interpersonStats += "<b>Electra lvl:</b> 30\n";
		}

		if (SceneLib.emberScene.emberAffection() > 0) {
            interpersonStats += "<b>Ember Affection:</b> " + Math.round(SceneLib.emberScene.emberAffection()) + "%\n";
            if (flags[kFLAGS.EMBER_LVL_UP] == 13) interpersonStats += "<b>Ember lvl:</b> 98\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 12) interpersonStats += "<b>Ember lvl:</b> 92\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 11) interpersonStats += "<b>Ember lvl:</b> 86\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 10) interpersonStats += "<b>Ember lvl:</b> 80\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 9) interpersonStats += "<b>Ember lvl:</b> 74\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 8) interpersonStats += "<b>Ember lvl:</b> 68\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 7) interpersonStats += "<b>Ember lvl:</b> 62\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 6) interpersonStats += "<b>Ember lvl:</b> 56\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 5) interpersonStats += "<b>Ember lvl:</b> 50\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 4) interpersonStats += "<b>Ember lvl:</b> 44\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 3) interpersonStats += "<b>Ember lvl:</b> 38\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 2) interpersonStats += "<b>Ember lvl:</b> 32\n";
			if (flags[kFLAGS.EMBER_LVL_UP] == 1) interpersonStats += "<b>Ember lvl:</b> 26\n";
			if (flags[kFLAGS.EMBER_LVL_UP] < 1) interpersonStats += "<b>Ember lvl:</b> 20\n";
		}/*

		if (flags[kFLAGS.GALIA_LVL_UP] > 0.5) {
			interpersonStats += "<b>Galia Affection:</b> " + Math.round(flags[kFLAGS.GALIA_AFFECTION]) + "%\n";
			if (flags[kFLAGS.GALIA_LVL_UP] == 5) interpersonStats += "<b>Galia lvl:</b> 25\n";
			if (flags[kFLAGS.GALIA_LVL_UP] == 4) interpersonStats += "<b>Galia lvl:</b> 19\n";
			if (flags[kFLAGS.GALIA_LVL_UP] == 3) interpersonStats += "<b>Galia lvl:</b> 13\n";
			if (flags[kFLAGS.GALIA_LVL_UP] == 2) interpersonStats += "<b>Galia lvl:</b> 7\n";
			if (flags[kFLAGS.GALIA_LVL_UP] == 1) interpersonStats += "<b>Galia lvl:</b> 1\n";
		}*/

		if (SceneLib.helFollower.helAffection() > 0)
            interpersonStats += "<b>Helia Affection:</b> " + Math.round(SceneLib.helFollower.helAffection()) + "%\n";
        if (SceneLib.helFollower.helAffection() >= 100)
            interpersonStats += "<b>Helia Bonus Points:</b> " + Math.round(flags[kFLAGS.HEL_BONUS_POINTS]) + "\n";

		if (flags[kFLAGS.ISABELLA_AFFECTION] > 0) {
			interpersonStats += "<b>Isabella Affection:</b> ";
            if (!SceneLib.isabellaFollowerScene.isabellaFollower())
                interpersonStats += Math.round(flags[kFLAGS.ISABELLA_AFFECTION]) + "%\n";
			else
				interpersonStats += "100%\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 13) interpersonStats += "<b>Isabella lvl:</b> 98\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 12) interpersonStats += "<b>Isabella lvl:</b> 92\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 11) interpersonStats += "<b>Isabella lvl:</b> 86\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 10) interpersonStats += "<b>Isabella lvl:</b> 80\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 9) interpersonStats += "<b>Isabella lvl:</b> 74\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 8) interpersonStats += "<b>Isabella lvl:</b> 68\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 7) interpersonStats += "<b>Isabella lvl:</b> 62\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 6) interpersonStats += "<b>Isabella lvl:</b> 56\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 5) interpersonStats += "<b>Isabella lvl:</b> 50\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 4) interpersonStats += "<b>Isabella lvl:</b> 44\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 3) interpersonStats += "<b>Isabella lvl:</b> 38\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 2) interpersonStats += "<b>Isabella lvl:</b> 32\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] == 1) interpersonStats += "<b>Isabella lvl:</b> 26\n";
			if (flags[kFLAGS.ISABELLA_LVL_UP] < 1) interpersonStats += "<b>Isabella lvl:</b> 20\n";
		}

		if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) {
			interpersonStats += "<b>Joy's Intelligence:</b> " + flags[kFLAGS.JOY_INTELLIGENCE];
			if (flags[kFLAGS.JOY_INTELLIGENCE] >= 50) interpersonStats += " (MAX)";
			interpersonStats += "\n";
		}

		if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4) {
            interpersonStats += "<b>Katherine Submissiveness:</b> " + SceneLib.telAdre.katherine.submissiveness() + "\n";
        }

		if (player.hasStatusEffect(StatusEffects.Kelt) && flags[kFLAGS.KELT_BREAK_LEVEL] == 0 && flags[kFLAGS.KELT_KILLED] == 0) {
			if (player.statusEffectv2(StatusEffects.Kelt) >= 130)
				interpersonStats += "<b>Submissiveness To Kelt:</b> " + 100 + "%\n";
			else
				interpersonStats += "<b>Submissiveness To Kelt:</b> " + Math.round(player.statusEffectv2(StatusEffects.Kelt) / 130 * 100) + "%\n";

		}

		if (flags[kFLAGS.ANEMONE_KID] > 0)
            interpersonStats += "<b>Kid A's Confidence:</b> " + SceneLib.anemoneScene.kidAXP() + "%\n";
        if (flags[kFLAGS.KIHA_AFFECTION_LEVEL] == 2) {
            if (SceneLib.kihaFollower.followerKiha())
                interpersonStats += "<b>Kiha Affection:</b> " + 100 + "%\n";
			else
				interpersonStats += "<b>Kiha Affection:</b> " + Math.round(flags[kFLAGS.KIHA_AFFECTION]) + "%\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 13) interpersonStats += "<b>Kiha lvl:</b> 99\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 12) interpersonStats += "<b>Kiha lvl:</b> 93\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 11) interpersonStats += "<b>Kiha lvl:</b> 87\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 10) interpersonStats += "<b>Kiha lvl:</b> 81\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 9) interpersonStats += "<b>Kiha lvl:</b> 75\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 8) interpersonStats += "<b>Kiha lvl:</b> 69\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 7) interpersonStats += "<b>Kiha lvl:</b> 63\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 6) interpersonStats += "<b>Kiha lvl:</b> 57\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 5) interpersonStats += "<b>Kiha lvl:</b> 51\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 4) interpersonStats += "<b>Kiha lvl:</b> 45\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 3) interpersonStats += "<b>Kiha lvl:</b> 39\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 2) interpersonStats += "<b>Kiha lvl:</b> 33\n";
			if (flags[kFLAGS.KIHA_LVL_UP] == 1) interpersonStats += "<b>Kiha lvl:</b> 27\n";
			if (flags[kFLAGS.KIHA_LVL_UP] < 1) interpersonStats += "<b>Kiha lvl:</b> 21\n";
		}

		if (flags[kFLAGS.KINDRA_FOLLOWER] > 0)
			interpersonStats += "<b>Kindra Affection:</b> " + Math.round(flags[kFLAGS.KINDRA_AFFECTION]) + "%\n";
			if (flags[kFLAGS.KINDRA_AFFECTION] >= 5) {
				if (flags[kFLAGS.KINDRA_LVL_UP] == 15) interpersonStats += "<b>Kindra lvl:</b> 99\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 14) interpersonStats += "<b>Kindra lvl:</b> 93\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 13) interpersonStats += "<b>Kindra lvl:</b> 87\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 12) interpersonStats += "<b>Kindra lvl:</b> 81\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 11) interpersonStats += "<b>Kindra lvl:</b> 75\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 10) interpersonStats += "<b>Kindra lvl:</b> 69\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 9) interpersonStats += "<b>Kindra lvl:</b> 63\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 8) interpersonStats += "<b>Kindra lvl:</b> 57\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] == 7) interpersonStats += "<b>Kindra lvl:</b> 51\n";
				if (flags[kFLAGS.KINDRA_LVL_UP] < 7) interpersonStats += "<b>Kindra lvl:</b> 45\n";
			}

		//Lottie stuff
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0)
            interpersonStats += "<b>Lottie's Encouragement:</b> " + SceneLib.telAdre.lottie.lottieMorale() + " (higher is better)\n" + "<b>Lottie's Figure:</b> " + SceneLib.telAdre.lottie.lottieTone() + " (higher is better)\n";
        if (SceneLib.mountain.salon.lynnetteApproval() != 0)
            interpersonStats += "<b>Lynnette's Approval:</b> " + SceneLib.mountain.salon.lynnetteApproval() + "\n";
        if (flags[kFLAGS.LUNA_FOLLOWER] > 3) {
			interpersonStats += "<b>Luna Affection:</b> " + Math.round(flags[kFLAGS.LUNA_AFFECTION]) + "%\n";
			interpersonStats += "<b>Luna Jealousy:</b> " + Math.round(flags[kFLAGS.LUNA_JEALOUSY]) + "%\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 15) interpersonStats += "<b>Luna lvl:</b> 99\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 14) interpersonStats += "<b>Luna lvl:</b> 93\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 13) interpersonStats += "<b>Luna lvl:</b> 87\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 12) interpersonStats += "<b>Luna lvl:</b> 81\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 11) interpersonStats += "<b>Luna lvl:</b> 75\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 10) interpersonStats += "<b>Luna lvl:</b> 69\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 9) interpersonStats += "<b>Luna lvl:</b> 63\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 8) interpersonStats += "<b>Luna lvl:</b> 57\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 7) interpersonStats += "<b>Luna lvl:</b> 51\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 6) interpersonStats += "<b>Luna lvl:</b> 45\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 5) interpersonStats += "<b>Luna lvl:</b> 39\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 4) interpersonStats += "<b>Luna lvl:</b> 33\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 3) interpersonStats += "<b>Luna lvl:</b> 27\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 2) interpersonStats += "<b>Luna lvl:</b> 21\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 1) interpersonStats += "<b>Luna lvl:</b> 15\n";
			if (flags[kFLAGS.LUNA_LVL_UP] == 0) interpersonStats += "<b>Luna lvl:</b> 9\n";
		}
		
		if (flags[kFLAGS.NEISA_FOLLOWER] >= 7)  {
			if (flags[kFLAGS.NEISA_AFFECTION] < 50) interpersonStats += "<b>Neisa Loyalty:</b> " + Math.round(flags[kFLAGS.NEISA_AFFECTION]) * 2 + "%\n";
			else interpersonStats += "<b>Neisa Loyalty:</b> 100%\n";
			if (flags[kFLAGS.NEISA_FOLLOWER] >= 14)  interpersonStats += "<b>Days that passed since last paycheck for Neisa:</b> " + (Math.round(flags[kFLAGS.NEISA_AFFECTION]) - 7) + " days (If you npot pay before 10th day she would leave)\n";
			else interpersonStats += "<b>Days that passed since last paycheck for Neisa:</b> " + (Math.round(flags[kFLAGS.NEISA_AFFECTION]) - 7) + " days\n";
			//interpersonStats += "<b>Luna Affection:</b> " + Math.round(flags[kFLAGS.LUNA_AFFECTION]) + "%\n";
			if (flags[kFLAGS.NEISA_LVL_UP] == 4) interpersonStats += "<b>Neisa lvl:</b> 21\n";
			if (flags[kFLAGS.NEISA_LVL_UP] == 3) interpersonStats += "<b>Neisa lvl:</b> 15\n";
			if (flags[kFLAGS.NEISA_LVL_UP] == 2) interpersonStats += "<b>Neisa lvl:</b> 9\n";
			if (flags[kFLAGS.NEISA_LVL_UP] == 1) interpersonStats += "<b>Neisa lvl:</b> 3\n";
		}
		if (flags[kFLAGS.OWCAS_ATTITUDE] > 0)
			interpersonStats += "<b>Owca's Attitude:</b> " + flags[kFLAGS.OWCAS_ATTITUDE] + "\n";

		if (SceneLib.telAdre.rubi.rubiAffection() > 0)
            interpersonStats += "<b>Rubi's Affection:</b> " + Math.round(SceneLib.telAdre.rubi.rubiAffection()) + "%\n" + "<b>Rubi's Orifice Capacity:</b> " + Math.round(SceneLib.telAdre.rubi.rubiCapacity()) + "%\n";
        
		if (flags[kFLAGS.SAMIRAH_AFFECTION] > 0)
			interpersonStats += "<b>Samirah Affection:</b> " + Math.round(flags[kFLAGS.SAMIRAH_AFFECTION]) + "%\n";
		
		if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 0)
			interpersonStats += "<b>Sapphire Affection:</b> " + Math.round(flags[kFLAGS.SAPPHIRE_AFFECTION]) + "%\n";
		
		if (flags[kFLAGS.SHEILA_XP] != 0) {
            interpersonStats += "<b>Sheila's Corruption:</b> " + SceneLib.sheilaScene.sheilaCorruption();
            if (SceneLib.sheilaScene.sheilaCorruption() > 100)
                interpersonStats += " (Yes, it can go above 100)";
			interpersonStats += "\n";
		}

		if (flags[kFLAGS.TED_WRATH] > 5) {
			if (flags[kFLAGS.TED_LVL_UP] >= 3) interpersonStats += "<b>Ted Wrath:</b> " + Math.round(flags[kFLAGS.TED_WRATH]) + "%\n";
			else interpersonStats += "<b>Dragon-boy Wrath:</b> " + Math.round(flags[kFLAGS.TED_WRATH]) + "%\n";
			if (flags[kFLAGS.TED_LVL_UP] == 6) interpersonStats += "<b>Ted lvl:</b> 45\n";
			if (flags[kFLAGS.TED_LVL_UP] == 5) interpersonStats += "<b>Ted lvl:</b> 39\n";
			if (flags[kFLAGS.TED_LVL_UP] == 4) interpersonStats += "<b>Ted lvl:</b> 33\n";
			if (flags[kFLAGS.TED_LVL_UP] == 3) interpersonStats += "<b>Ted lvl:</b> 27\n";
			if (flags[kFLAGS.TED_LVL_UP] == 2) interpersonStats += "<b>Dragon-boy lvl:</b> 21\n";
			if (flags[kFLAGS.TED_LVL_UP] == 1) interpersonStats += "<b>Dragon-boy lvl:</b> 15\n";
		}

		if (SceneLib.valeria.valeriaFluidsEnabled()) {
            interpersonStats += "<b>Valeria's Fluid:</b> " + flags[kFLAGS.VALERIA_FLUIDS] + "%\n"
		}

		if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] != 0) {
            if (SceneLib.urta.urtaLove()) {
                if (flags[kFLAGS.URTA_QUEST_STATUS] == -1) interpersonStats += "<b>Urta Status:</b> <font color=\"#800000\">Gone</font>\n";
				if (flags[kFLAGS.URTA_QUEST_STATUS] == 0) interpersonStats += "<b>Urta Status:</b> Lover\n";
				if (flags[kFLAGS.URTA_QUEST_STATUS] == 1) interpersonStats += "<b>Urta Status:</b> <font color=\"#008000\">Lover+</font>\n";
			}
			else if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] == -1)
				interpersonStats += "<b>Urta Status:</b> Ashamed\n";
			else if (flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] < 30)
				interpersonStats += "<b>Urta's Affection:</b> " + Math.round(flags[kFLAGS.URTA_PC_AFFECTION_COUNTER] * 3.3333) + "%\n";
			else
				interpersonStats += "<b>Urta Status:</b> Ready To Confess Love\n";
		}

		if (flags[kFLAGS.ZENJI_PROGRESS] > 0) {
			interpersonStats += "<b>Zenji's perspective on player:</b> " + Math.round(flags[kFLAGS.ZENJI_PERSPECTIVE_ON_PLAYER]) + "%\n";
			if (flags[kFLAGS.ZENJI_PROGRESS] == 8 || flags[kFLAGS.ZENJI_PROGRESS] == 9) {
				interpersonStats += "<b>Zenji status:</b> Follower\n";
				interpersonStats += "<b>Zenji lvl:</b> ";
				if (player.level > 24) interpersonStats += ""+player.level+"";
				else interpersonStats += "25";
				interpersonStats += "\n";
			}
			if (flags[kFLAGS.ZENJI_PROGRESS] == 11) {
				interpersonStats += "<b>Zenji status:</b> Lover\n";
				interpersonStats += "<b>Zenji Cum Production:</b> " + addComma(Math.round(1300 + player.statusEffectv2(StatusEffects.ZenjiModificationsList))) + "mL\n";
				if (ZenjiScenes.Z1stKid != "") interpersonStats += "<b>Zenji Firstborn (Male) Name:</b> "+ZenjiScenes.Z1stKid+"\n";
				if (ZenjiScenes.Z2ndKid != "") interpersonStats += "<b>Zenji Secondborn (Female) Name:</b> " + ZenjiScenes.Z2ndKid + "\n";
			}
		}

		if (interpersonStats != "")
			outputText("\n<b><u>Interpersonal Stats</u></b>\n" + interpersonStats);
		// End Interpersonal Stats

		// Begin Evangeline Stats
		var evangelineStats:String = "";
		if (flags[kFLAGS.EVANGELINE_AFFECTION] > 2) {
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 17) evangelineStats += "<b>Evangeline lvl:</b> 42\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 16) evangelineStats += "<b>Evangeline lvl:</b> 40\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 15) evangelineStats += "<b>Evangeline lvl:</b> 36\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 14) evangelineStats += "<b>Evangeline lvl:</b> 34\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 13) evangelineStats += "<b>Evangeline lvl:</b> 30\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 12) evangelineStats += "<b>Evangeline lvl:</b> 28\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 11) evangelineStats += "<b>Evangeline lvl:</b> 24\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 10) evangelineStats += "<b>Evangeline lvl:</b> 22\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 9) evangelineStats += "<b>Evangeline lvl:</b> 18\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 8) evangelineStats += "<b>Evangeline lvl:</b> 16\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 7) evangelineStats += "<b>Evangeline lvl:</b> 14\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 6) evangelineStats += "<b>Evangeline lvl:</b> 12\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 5) evangelineStats += "<b>Evangeline lvl:</b> 10\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 4) evangelineStats += "<b>Evangeline lvl:</b> 8\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 3) evangelineStats += "<b>Evangeline lvl:</b> 6\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] == 2) evangelineStats += "<b>Evangeline lvl:</b> 4\n";
			if (flags[kFLAGS.EVANGELINE_LVL_UP] < 2) evangelineStats += "<b>Evangeline lvl:</b> 2\n";
			evangelineStats += "<b>Evangeline Affection:</b> " + Math.round(flags[kFLAGS.EVANGELINE_AFFECTION]) + "%\n";
		}
		if (flags[kFLAGS.EVANGELINE_AFFECTION] >= 5) {
			evangelineStats += "<b>Gems Purse:</b> " + flags[kFLAGS.EVANGELINE_GEMS_PURSE] + " gems\n";
			evangelineStats += "<b>Spells Casted:</b> " + flags[kFLAGS.EVANGELINE_SPELLS_CASTED] + "\n";
			if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 0) {
				if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 10) evangelineStats += "<b>Spells Cost:</b> 100%\n";
				if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 10 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 30) evangelineStats += "<b>Spells Cost:</b> 90%\n";
				if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 30 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 70) evangelineStats += "<b>Spells Cost:</b> 80%\n";
				if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 70 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 150) evangelineStats += "<b>Spells Cost:</b> 70%\n";
				if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 150 && flags[kFLAGS.EVANGELINE_SPELLS_CASTED] < 310) evangelineStats += "<b>Spells Cost:</b> 60%\n";
				if (flags[kFLAGS.EVANGELINE_SPELLS_CASTED] >= 310) evangelineStats += "<b>Spells Cost:</b> 50%\n";
			}
		}
		if (evangelineStats != "")
			outputText("\n<b><u>Evangeline Stats</u></b>\n" + evangelineStats);
		// End Evangeline Stats
		
		// Begin RyuBi Stats
		var ryubiStats:String = "";
		if (ryubiStats != "")
			outputText("\n<b><u>RyuBi Stats</u></b>\n" + ryubiStats);
		// End RyuBi Stats
		
		// Begin Galia Stats
		var galiaStats:String = "";
		if (galiaStats != "")
			outputText("\n<b><u>Galia Stats</u></b>\n" + galiaStats);
		// End Galia Stats

		// Begin Outside camp NPC's Stats
		var outsideCampNpcsStats:String = "";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 13) outsideCampNpcsStats += "<b>Akbal lvl:</b> 98 (current max lvl he can reach)\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 12) outsideCampNpcsStats += "<b>Akbal lvl:</b> 92\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 11) outsideCampNpcsStats += "<b>Akbal lvl:</b> 86\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 10) outsideCampNpcsStats += "<b>Akbal lvl:</b> 80\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 9) outsideCampNpcsStats += "<b>Akbal lvl:</b> 74\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 8) outsideCampNpcsStats += "<b>Akbal lvl:</b> 68\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 7) outsideCampNpcsStats += "<b>Akbal lvl:</b> 62\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 6) outsideCampNpcsStats += "<b>Akbal lvl:</b> 56\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 5) outsideCampNpcsStats += "<b>Akbal lvl:</b> 50\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 4) outsideCampNpcsStats += "<b>Akbal lvl:</b> 44\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 3) outsideCampNpcsStats += "<b>Akbal lvl:</b> 38\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 2) outsideCampNpcsStats += "<b>Akbal lvl:</b> 32\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] == 1) outsideCampNpcsStats += "<b>Akbal lvl:</b> 26\n";
		if (flags[kFLAGS.AKBAL_LVL_UP] < 1) outsideCampNpcsStats += "<b>Akbal lvl:</b> 20\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 11) outsideCampNpcsStats += "<b>Izumi lvl:</b> 96 (current max lvl she can reach)\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 10) outsideCampNpcsStats += "<b>Izumi lvl:</b> 90\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 9) outsideCampNpcsStats += "<b>Izumi lvl:</b> 84\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 8) outsideCampNpcsStats += "<b>Izumi lvl:</b> 78\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 7) outsideCampNpcsStats += "<b>Izumi lvl:</b> 72\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 6) outsideCampNpcsStats += "<b>Izumi lvl:</b> 66\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 5) outsideCampNpcsStats += "<b>Izumi lvl:</b> 60\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 4) outsideCampNpcsStats += "<b>Izumi lvl:</b> 54\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 3) outsideCampNpcsStats += "<b>Izumi lvl:</b> 48\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 2) outsideCampNpcsStats += "<b>Izumi lvl:</b> 42\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] == 1) outsideCampNpcsStats += "<b>Izumi lvl:</b> 36\n";
		if (flags[kFLAGS.IZUMI_LVL_UP] < 1) outsideCampNpcsStats += "<b>Izumi lvl:</b> 30\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 12) outsideCampNpcsStats += "<b>Minerva lvl:</b> 95 (current max lvl she can reach)\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 11) outsideCampNpcsStats += "<b>Minerva lvl:</b> 89\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 10) outsideCampNpcsStats += "<b>Minerva lvl:</b> 83\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 9) outsideCampNpcsStats += "<b>Minerva lvl:</b> 77\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 8) outsideCampNpcsStats += "<b>Minerva lvl:</b> 71\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 7) outsideCampNpcsStats += "<b>Minerva lvl:</b> 65\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 6) outsideCampNpcsStats += "<b>Minerva lvl:</b> 59\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 5) outsideCampNpcsStats += "<b>Minerva lvl:</b> 53\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 4) outsideCampNpcsStats += "<b>Minerva lvl:</b> 47\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 3) outsideCampNpcsStats += "<b>Minerva lvl:</b> 41\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 2) outsideCampNpcsStats += "<b>Minerva lvl:</b> 35\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] == 1) outsideCampNpcsStats += "<b>Minerva lvl:</b> 29\n";
		if (flags[kFLAGS.MINERVA_LVL_UP] < 1) outsideCampNpcsStats += "<b>Minerva lvl:</b> 23\n";
		if (flags[kFLAGS.GOBLIN_ELDER_TALK_COUNTER] >= 1) {
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 11) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 98 (current max lvl she can reach)\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 10) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 92\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 9) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 86\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 8) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 80\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 7) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 74\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 6) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 68\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 5) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 62\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 4) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 56\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 3) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 50\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 2) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 44\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] == 1) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 38\n";
			if (flags[kFLAGS.PRISCILLA_LVL_UP] < 1) outsideCampNpcsStats += "<b>Priscilla lvl:</b> 32\n";
		}
		if (outsideCampNpcsStats != "")
			outputText("\n<b><u>Outside camp NPC's Stats</u></b>\n" + outsideCampNpcsStats);
		// End Outside camp NPC's Stats
		menu();
		addButton(0, "Next", playerMenu);
		addButton(5, "General", displayStats);
		addButton(6, "Combat", displayStatsCombat);
		addButtonDisabled(7, "NPC's", "You are currently at this stats page.");
		addButton(8, "Children", displayStatsChildren);
		addButton(9, "Mastery", displayStatsmastery);
	}
	public function displayStatsChildren():void {
		spriteSelect(-1);
		clearOutput();
		displayHeader("Children Stats");
		// Begin Children Stats
		var childStats:String = "";

		if (player.statusEffectv1(StatusEffects.Birthed) > 0)
			childStats += "<b>Times Given Birth:</b> " + player.statusEffectv1(StatusEffects.Birthed) + "\n";

		if (flags[kFLAGS.PC_GOBLIN_DAUGHTERS] > 0)
			childStats += "<b>[name] goblin daughters:</b> " + flags[kFLAGS.PC_GOBLIN_DAUGHTERS] + "\n";

		if (flags[kFLAGS.AMILY_MET] > 0)
			childStats += "<b>Litters With Amily:</b> " + (flags[kFLAGS.AMILY_BIRTH_TOTAL] + flags[kFLAGS.PC_TIMES_BIRTHED_AMILYKIDS]) + "\n";

		if (flags[kFLAGS.BEHEMOTH_CHILDREN] > 0)
			childStats += "<b>Children With Behemoth:</b> " + flags[kFLAGS.BEHEMOTH_CHILDREN] + "\n";

		if (flags[kFLAGS.BENOIT_EGGS] > 0)
			childStats += "<b>Benoit Eggs Laid:</b> " + flags[kFLAGS.BENOIT_EGGS] + "\n";
		if (flags[kFLAGS.FEMOIT_EGGS_LAID] > 0)
			childStats += "<b>Benoite Eggs Produced:</b> " + flags[kFLAGS.FEMOIT_EGGS_LAID] + "\n";

		if (flags[kFLAGS.COTTON_KID_COUNT] > 0)
			childStats += "<b>Children With Cotton:</b> " + flags[kFLAGS.COTTON_KID_COUNT] + "\n";

		if (flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] > 0)
			childStats += "<b>Children With Edryn:</b> " + flags[kFLAGS.EDRYN_NUMBER_OF_KIDS] + "\n";

		if (flags[kFLAGS.EMBER_CHILDREN_MALES] > 0)
			childStats += "<b>Ember Offspring (Males):</b> " + flags[kFLAGS.EMBER_CHILDREN_MALES] + "\n";
		if (flags[kFLAGS.EMBER_CHILDREN_FEMALES] > 0)
			childStats += "<b>Ember Offspring (Females):</b> " + flags[kFLAGS.EMBER_CHILDREN_FEMALES] + "\n";
		if (flags[kFLAGS.EMBER_CHILDREN_HERMS] > 0)
			childStats += "<b>Ember Offspring (Herms):</b> " + flags[kFLAGS.EMBER_CHILDREN_HERMS] + "\n";
        if (SceneLib.emberScene.emberChildren() > 0)
            childStats += "<b>Total Children With Ember:</b> " + (SceneLib.emberScene.emberChildren()) + "\n";
        if (flags[kFLAGS.EMBER_EGGS] > 0)
			childStats += "<b>Ember Eggs Produced:</b> " + flags[kFLAGS.EMBER_EGGS] + "\n";
			
        if (flags[kFLAGS.EXCELLIA_MALE_KIDS] > 0)
			childStats += "<b>Excellia Offspring (Human Males):</b> " + flags[kFLAGS.EXCELLIA_MALE_KIDS] + "\n";
		if (flags[kFLAGS.EXCELLIA_FEMALE_KIDS] > 0)
			childStats += "<b>Excellia Offspring (Human Females):</b> " + flags[kFLAGS.EXCELLIA_FEMALE_KIDS] + "\n";
        if (flags[kFLAGS.EXCELLIA_MALE_COW_KIDS] > 0)
			childStats += "<b>Excellia Offspring (Cow-morph Males):</b> " + flags[kFLAGS.EXCELLIA_MALE_COW_KIDS] + "\n";
		if (flags[kFLAGS.EXCELLIA_FEMALE_COW_KIDS] > 0)
			childStats += "<b>Excellia Offspring (Cow-morph Females):</b> " + flags[kFLAGS.EXCELLIA_FEMALE_COW_KIDS] + "\n";
        if (SceneLib.excelliaFollower.totalExcelliaChildren() > 0)
            childStats += "<b>Total Children With Excellia:</b> " + SceneLib.excelliaFollower.totalExcelliaChildren() + "\n";

        if (SceneLib.isabellaScene.totalIsabellaChildren() > 0) {
            if (SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) > 0)
                childStats += "<b>Children With Isabella (Human, Males):</b> " + SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) + "\n";
            if (SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) > 0)
                childStats += "<b>Children With Isabella (Human, Females):</b> " + SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) + "\n";
            if (SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) > 0)
                childStats += "<b>Children With Isabella (Human, Herms):</b> " + SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) + "\n";
            if (SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) > 0)
                childStats += "<b>Children With Isabella (Cowgirl, Females):</b> " + SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) + "\n";
            if (SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) > 0)
                childStats += "<b>Children With Isabella (Cowgirl, Herms):</b> " + SceneLib.isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) + "\n";
            childStats += "<b>Total Children With Isabella:</b> " + SceneLib.isabellaScene.totalIsabellaChildren() + "\n"
        }

		if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0)
			childStats += "<b>Children With Izma (Sharkgirls):</b> " + flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + "\n";
		if (flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
			childStats += "<b>Children With Izma (Tigersharks):</b> " + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] + "\n";
		if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0 && flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
			childStats += "<b>Total Children with Izma:</b> " + (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS]) + "\n";

        if (SceneLib.joyScene.getTotalLitters() > 0)
            childStats += "<b>Litters With " + (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 ? "Joy" : "Jojo") + ":</b> " + SceneLib.joyScene.getTotalLitters() + "\n";
        if (flags[kFLAGS.KELLY_KIDS_MALE] > 0)
			childStats += "<b>Children With Kelly (Males):</b> " + flags[kFLAGS.KELLY_KIDS_MALE] + "\n";
		if (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE] > 0)
			childStats += "<b>Children With Kelly (Females):</b> " + (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE]) + "\n";
		if (flags[kFLAGS.KELLY_KIDS] > 0)
			childStats += "<b>Total Children With Kelly:</b> " + flags[kFLAGS.KELLY_KIDS] + "\n";
        if (SceneLib.kihaFollower.pregnancy.isPregnant)
            childStats += "<b>Kiha's Pregnancy:</b> " + SceneLib.kihaFollower.pregnancy.incubation + "\n";
        if (flags[kFLAGS.KIHA_CHILDREN_BOYS] > 0)
			childStats += "<b>Kiha Offspring (Males):</b> " + flags[kFLAGS.KIHA_CHILDREN_BOYS] + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_GIRLS] > 0)
			childStats += "<b>Kiha Offspring (Females):</b> " + flags[kFLAGS.KIHA_CHILDREN_GIRLS] + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_HERMS] > 0)
			childStats += "<b>Kiha Offspring (Herms):</b> " + flags[kFLAGS.KIHA_CHILDREN_HERMS] + "\n";
        if (SceneLib.kihaFollower.totalKihaChildren() > 0)
            childStats += "<b>Total Children With Kiha:</b> " + SceneLib.kihaFollower.totalKihaChildren() + "\n";
        if (SceneLib.mountain.salon.lynnetteApproval() != 0)
            childStats += "<b>Lynnette Children:</b> " + flags[kFLAGS.LYNNETTE_BABY_COUNT] + "\n";

		if (flags[kFLAGS.MARBLE_KIDS] > 0)
			childStats += "<b>Children With Marble:</b> " + flags[kFLAGS.MARBLE_KIDS] + "\n";

		if (flags[kFLAGS.MINERVA_CHILDREN] > 0)
			childStats += "<b>Children With Minerva:</b> " + flags[kFLAGS.MINERVA_CHILDREN] + "\n";

		if (flags[kFLAGS.MITZI_DAUGHTERS] > 0)
			childStats += "<b>Mitzi Children:</b> " + flags[kFLAGS.MITZI_DAUGHTERS] + "\n";

		if (flags[kFLAGS.ANT_KIDS] > 0)
			childStats += "<b>Ant Children With Phylla:</b> " + flags[kFLAGS.ANT_KIDS] + "\n";
		if (flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)
			childStats += "<b>Drider Children With Phylla:</b> " + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] + "\n";
		if (flags[kFLAGS.ANT_KIDS] > 0 && flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT] > 0)
			childStats += "<b>Total Children With Phylla:</b> " + (flags[kFLAGS.ANT_KIDS] + flags[kFLAGS.PHYLLA_DRIDER_BABIES_COUNT]) + "\n";

		if (flags[kFLAGS.SHEILA_JOEYS] > 0)
			childStats += "<b>Children With Sheila (Joeys):</b> " + flags[kFLAGS.SHEILA_JOEYS] + "\n";
		if (flags[kFLAGS.SHEILA_IMPS] > 0)
			childStats += "<b>Children With Sheila (Imps):</b> " + flags[kFLAGS.SHEILA_IMPS] + "\n";
		if (flags[kFLAGS.SHEILA_JOEYS] > 0 && flags[kFLAGS.SHEILA_IMPS] > 0)
			childStats += "<b>Total Children With Sheila:</b> " + (flags[kFLAGS.SHEILA_JOEYS] + flags[kFLAGS.SHEILA_IMPS]) + "\n";

		if (flags[kFLAGS.SOPHIE_ADULT_KID_COUNT] > 0 || flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) {
			childStats += "<b>Children With Sophie:</b> ";
			var sophie:int = 0;
			if (flags[kFLAGS.SOPHIE_DAUGHTER_MATURITY_COUNTER] > 0) sophie++;
			sophie += flags[kFLAGS.SOPHIE_ADULT_KID_COUNT];
			if (flags[kFLAGS.SOPHIE_CAMP_EGG_COUNTDOWN] > 0) sophie++;
			childStats += sophie + "\n";
		}

		if (flags[kFLAGS.SOPHIE_EGGS_LAID] > 0)
			childStats += "<b>Eggs Fertilized For Sophie:</b> " + (flags[kFLAGS.SOPHIE_EGGS_LAID] + sophie) + "\n";

		if (flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] > 0)
			childStats += "<b>Children With Tamani:</b> " + flags[kFLAGS.TAMANI_NUMBER_OF_DAUGHTERS] + " (after all forms of natural selection)\n";

        if (SceneLib.urtaPregs.urtaKids() > 0)
            childStats += "<b>Children With Urta:</b> " + SceneLib.urtaPregs.urtaKids() + "\n";

		if (flags[kFLAGS.ZENJI_KIDS] > 0)
            childStats += "<b>Kids with Zenji:</b> " + flags[kFLAGS.ZENJI_KIDS] + "\n";
        //Mino sons
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] > 0)
			childStats += "<b>Number of Adult Minotaur Offspring:</b> " + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] + "\n";

		//Alraune daughters
		if (flags[kFLAGS.ALRAUNE_SEEDS] > 0)
			childStats += "<b>Alraune daughters:</b> " + flags[kFLAGS.ALRAUNE_SEEDS] + " <b>(Oldest ones: " + (flags[kFLAGS.ALRAUNE_GROWING] - 1) + " days)</b>\n";

		if (childStats != "")
			outputText("\n<b><u>Children</u></b>\n" + childStats);
		// End Children Stats
		menu();
		addButton(0, "Next", playerMenu);
		addButton(5, "General", displayStats);
		addButton(6, "Combat", displayStatsCombat);
		addButton(7, "NPC's", displayStatsNpcs);
		addButtonDisabled(8, "Children", "You are currently at this stats page.");
		addButton(9, "Mastery", displayStatsmastery);
	}
	public function displayStatsmastery():void {
		spriteSelect(-1);
		clearOutput();
		displayHeader("Mastery Stats");
		// Begin Mastery Stats
		var masteryStats:String = "";
		if (player.masteryGauntletLevel < combat.maxGauntletLevel())
			masteryStats += "<b>Gauntlets Mastery / Dao of Gauntlet:</b>  " + player.masteryGauntletLevel + " / " + combat.maxGauntletLevel() + " (Exp: " + player.masteryGauntletXP + " / " + combat.GauntletExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryGauntletLevel + "% damage, +" + (0.5 * Math.round((player.masteryGauntletLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Gauntlets Mastery / Dao of Gauntlet:</b>  " + player.masteryGauntletLevel + " / " + combat.maxGauntletLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryGauntletLevel + "% damage, +" + (0.5 * Math.round((player.masteryGauntletLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryDaggerLevel < combat.maxDaggerLevel())
			masteryStats += "<b>Daggers Mastery / Dao of Dagger:</b>  " + player.masteryDaggerLevel + " / " + combat.maxDaggerLevel() + " (Exp: " + player.masteryDaggerXP + " / " + combat.DaggerExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryDaggerLevel + "% damage, +" + (0.5 * Math.round((player.masteryDaggerLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Daggers Mastery / Dao of Dagger:</b>  " + player.masteryDaggerLevel + " / " + combat.maxDaggerLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryDaggerLevel + "% damage, +" + (0.5 * Math.round((player.masteryDaggerLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masterySwordLevel < combat.maxSwordLevel())
			masteryStats += "<b>Swords Mastery / Dao of Sword:</b>  " + player.masterySwordLevel + " / " + combat.maxSwordLevel() + " (Exp: " + player.masterySwordXP + " / " + combat.SwordExpToLevelUp() + ")\n<i>(Effects: +" + player.masterySwordLevel + "% damage, +" + (0.5 * Math.round((player.masterySwordLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Swords Mastery / Dao of Sword:</b>  " + player.masterySwordLevel + " / " + combat.maxSwordLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masterySwordLevel + "% damage, +" + (0.5 * Math.round((player.masterySwordLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryAxeLevel < combat.maxAxeLevel())
			masteryStats += "<b>Axes Mastery / Dao of Axe:</b>  " + player.masteryAxeLevel + " / " + combat.maxAxeLevel() + " (Exp: " + player.masteryAxeXP + " / " + combat.AxeExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryAxeLevel + "% damage, +" + (0.5 * Math.round((player.masteryAxeLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Axes Mastery / Dao of Axe:</b>  " + player.masteryAxeLevel + " / " + combat.maxAxeLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryAxeLevel + "% damage, +" + (0.5 * Math.round((player.masteryAxeLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryMaceHammerLevel < combat.maxMaceHammerLevel())
			masteryStats += "<b>Maces/Hammers Mastery / Dao of Mace/Hammer:</b>  " + player.masteryMaceHammerLevel + " / " + combat.maxMaceHammerLevel() + " (Exp: " + player.masteryMaceHammerXP + " / " + combat.MaceHammerExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryMaceHammerLevel + "% damage, +" + (0.5 * Math.round((player.masteryMaceHammerLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Maces/Hammers Mastery / Dao of Mace/Hammer:</b>  " + player.masteryMaceHammerLevel + " / " + combat.maxMaceHammerLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryMaceHammerLevel + "% damage, +" + (0.5 * Math.round((player.masteryMaceHammerLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryDuelingSwordLevel < combat.maxDuelingSwordLevel())
			masteryStats += "<b>Dueling Swords Mastery / Dao of Dueling Sword:</b>  " + player.masteryDuelingSwordLevel + " / " + combat.maxDuelingSwordLevel() + " (Exp: " + player.masteryDuelingSwordXP + " / " + combat.DuelingSwordExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryDuelingSwordLevel + "% damage, +" + (0.5 * Math.round((player.masteryDuelingSwordLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Dueling Swords Mastery / Dao of Dueling Sword:</b>  " + player.masteryDuelingSwordLevel + " / " + combat.maxDuelingSwordLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryDuelingSwordLevel + "% damage, +" + (0.5 * Math.round((player.masteryDuelingSwordLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] > 0) masteryStats += "<b>Rapier Skill:</b> " + flags[kFLAGS.RAPHAEL_RAPIER_TRANING] + " / 4\n";
		if (player.masterySpearLevel < combat.maxSpearLevel())
			masteryStats += "<b>Spears Mastery / Dao of Spear:</b>  " + player.masterySpearLevel + " / " + combat.maxSpearLevel() + " (Exp: " + player.masterySpearXP + " / " + combat.SpearExpToLevelUp() + ")\n<i>(Effects: +" + player.masterySpearLevel + "% damage, +" + (0.5 * Math.round((player.masterySpearLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Spears Mastery / Dao of Spear:</b>  " + player.masterySpearLevel + " / " + combat.maxSpearLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masterySpearLevel + "% damage, +" + (0.5 * Math.round((player.masterySpearLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryWhipLevel < combat.maxWhipLevel())
			masteryStats += "<b>Whip Mastery / Dao of Whip:</b>  " + player.masteryWhipLevel + " / " + combat.maxWhipLevel() + " (Exp: " + player.masteryWhipXP + " / " + combat.WhipExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryWhipLevel + "% damage, +" + (0.5 * Math.round((player.masteryWhipLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Whip Mastery / Dao of Whip:</b>  " + player.masteryWhipLevel + " / " + combat.maxWhipLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryWhipLevel + "% damage, +" + (0.5 * Math.round((player.masteryWhipLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryExoticLevel < combat.maxExoticLevel())
			masteryStats += "<b>Exotic Weapons Mastery / Dao of Exotic Weapons:</b>  " + player.masteryExoticLevel + " / " + combat.maxExoticLevel() + " (Exp: " + player.masteryExoticXP + " / " + combat.ExoticExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryExoticLevel + "% damage, +" + (0.5 * Math.round((player.masteryExoticLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Exotic Weapons Mastery / Dao of Exotic Weapons:</b>  " + player.masteryExoticLevel + " / " + combat.maxExoticLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryExoticLevel + "% damage, +" + (0.5 * Math.round((player.masteryExoticLevel - 1) / 2)) + "% accuracy)</i>\n";
		masteryStats += "\n";
		if (player.masteryArcheryLevel < combat.maxArcheryLevel())
			masteryStats += "<b>Archery Mastery / Dao of Archery:</b>  " + player.masteryArcheryLevel + " / " + combat.maxArcheryLevel() + " (Exp: " + player.masteryArcheryXP + " / " + combat.ArcheryExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryArcheryLevel + "% damage, +" + (0.5 * Math.round((player.masteryArcheryLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Archery Mastery / Dao of Archery:</b>  " + player.masteryArcheryLevel + " / " + combat.maxArcheryLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryArcheryLevel + "% damage, +" + (0.5 * Math.round((player.masteryArcheryLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryThrowingLevel < combat.maxThrowingLevel())
			masteryStats += "<b>Throwing Weapons Mastery / Dao of Throwing Weapons:</b>  " + player.masteryThrowingLevel + " / " + combat.maxThrowingLevel() + " (Exp: " + player.masteryThrowingXP + " / " + combat.ThrowingExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryThrowingLevel + "% damage, +" + (0.5 * Math.round((player.masteryThrowingLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Throwing Weapons Mastery / Dao of Throwing Weapons:</b>  " + player.masteryThrowingLevel + " / " + combat.maxThrowingLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryThrowingLevel + "% damage, +" + (0.5 * Math.round((player.masteryThrowingLevel - 1) / 2)) + "% accuracy)</i>\n";
		if (player.masteryFirearmsLevel < combat.maxFirearmsLevel())
			masteryStats += "<b>Firearms Mastery / Dao of Firearms:</b>  " + player.masteryFirearmsLevel + " / " + combat.maxFirearmsLevel() + " (Exp: " + player.masteryFirearmsXP + " / " + combat.FirearmsExpToLevelUp() + ")\n<i>(Effects: +" + player.masteryFirearmsLevel + "% damage, +" + (0.5 * Math.round((player.masteryFirearmsLevel - 1) / 2)) + "% accuracy)</i>\n";
		else
			masteryStats += "<b>Firearms Mastery / Dao of Firearms:</b>  " + player.masteryFirearmsLevel + " / " + combat.maxFirearmsLevel() + " (Exp: MAX)\n<i>(Effects: +" + player.masteryFirearmsLevel + "% damage, +" + (0.5 * Math.round((player.masteryFirearmsLevel - 1) / 2)) + "% accuracy)</i>\n";
		masteryStats += "\n";
		if (player.hasPerk(PerkLib.DualWield)) {
			if (player.dualWSLevel < combat.maxDualWieldSmallLevel())
				masteryStats += "<b>Dual Wield (Small) Skill:</b>  " + player.dualWSLevel + " / " + combat.maxDualWieldSmallLevel() + " (Exp: " + player.dualWSXP + " / " + combat.DualWieldSmallExpToLevelUp() + ")\n<i>(Effects: +" + player.dualWSLevel + "% damage, +" + (0.5 * Math.round((player.dualWSLevel - 1) / 2)) + "% accuracy)</i>\n";
			else
				masteryStats += "<b>Dual Wield (Small) Skill:</b>  " + player.dualWSLevel + " / " + combat.maxDualWieldSmallLevel() + "(Exp: MAX)\n<i>(Effects: +" + player.dualWSLevel + "% damage, +" + (0.5 * Math.round((player.dualWSLevel - 1) / 2)) + "% accuracy)</i>\n";
			if (player.dualWNLevel < combat.maxDualWieldNormalLevel())
				masteryStats += "<b>Dual Wield (Normal) Skill:</b>  " + player.dualWNLevel + " / " + combat.maxDualWieldNormalLevel() + " (Exp: " + player.dualWNXP + " / " + combat.DualWieldNormalExpToLevelUp() + ")\n<i>(Effects: +" + player.dualWNLevel + "% damage, +" + (0.5 * Math.round((player.dualWNLevel - 1) / 2)) + "% accuracy)</i>\n";
			else
				masteryStats += "<b>Dual Wield (Normal) Skill:</b>  " + player.dualWNLevel + " / " + combat.maxDualWieldNormalLevel() + "(Exp: MAX)\n<i>(Effects: +" + player.dualWNLevel + "% damage, +" + (0.5 * Math.round((player.dualWNLevel - 1) / 2)) + "% accuracy)</i>\n";
			if (player.dualWLLevel < combat.maxDualWieldLargeLevel())
				masteryStats += "<b>Dual Wield (Large) Skill:</b>  " + player.dualWLLevel + " / " + combat.maxDualWieldLargeLevel() + " (Exp: " + player.dualWLXP + " / " + combat.DualWieldLargeExpToLevelUp() + ")\n<i>(Effects: +" + player.dualWLLevel + "% damage, +" + (0.5 * Math.round((player.dualWLLevel - 1) / 2)) + "% accuracy)</i>\n";
			else
				masteryStats += "<b>Dual Wield (Large) Skill:</b>  " + player.dualWLLevel + " / " + combat.maxDualWieldLargeLevel() + "(Exp: MAX)\n<i>(Effects: +" + player.dualWLLevel + "% damage, +" + (0.5 * Math.round((player.dualWLLevel - 1) / 2)) + "% accuracy)</i>\n";
			if (player.dualWFLevel < combat.maxDualWieldFirearmsLevel())
				masteryStats += "<b>Dual Wield (Firearms) Skill:</b>  " + player.dualWFLevel + " / " + combat.maxDualWieldFirearmsLevel() + " (Exp: " + player.dualWFXP + " / " + combat.DualWieldFirearmsExpToLevelUp() + ")\n<i>(Effects: +" + player.dualWFLevel + "% damage, +" + (0.5 * Math.round((player.dualWFLevel - 1) / 2)) + "% accuracy)</i>\n";
			else
				masteryStats += "<b>Dual Wield (Firearms) Skill:</b>  " + player.dualWFLevel + " / " + combat.maxDualWieldFirearmsLevel() + "(Exp: MAX)\n<i>(Effects: +" + player.dualWFLevel + "% damage, +" + (0.5 * Math.round((player.dualWFLevel - 1) / 2)) + "% accuracy)</i>\n";
			masteryStats += "\n";
		}
		if (player.teaseLevel < combat.maxTeaseLevel())
			masteryStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / " + combat.maxTeaseLevel() + " (Exp: " + player.teaseXP + " / " + combat.teaseExpToLevelUp() + ")\n";
		else
			masteryStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / " + combat.maxTeaseLevel() + " (Exp: MAX)\n";
		masteryStats += "\n";
		if (player.herbalismLevel < player.maxHerbalismLevel())
			masteryStats += "<b>Herbalism Skill:</b>  " + player.herbalismLevel + " / " + player.maxHerbalismLevel() + " (Exp: " + player.herbalismXP + " / " + player.HerbExpToLevelUp() + ")\n";
		else
			masteryStats += "<b>Herbalism Skill:</b>  " + player.herbalismLevel + " / " + player.maxHerbalismLevel() + " (Exp: MAX)\n";
		if (masteryStats != "")
			outputText("\n<b><u>Mastery</u></b>\n" + masteryStats);
		// End Mastery Stats
		menu();
		addButton(0, "Next", playerMenu);
		addButton(5, "General", displayStats);
		addButton(6, "Combat", displayStatsCombat);
		addButton(7, "NPC's", displayStatsNpcs);
		addButton(8, "Children", displayStatsChildren);
		addButtonDisabled(9, "Mastery", "You are currently at this stats page.");
	}

	//------------
	// LEVEL UP
	//------------
	public function levelUpGo():void {
		clearOutput();
		hideMenus();
		mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
		if (player.XP >= player.requiredXP() && player.level < CoC.instance.levelCap){
			if (flags[kFLAGS.LVL_UP_FAST] == 1){
				lvlUpFastSubMenu();
				return;	//Not sure if this is what's stopping the thing from moving on, not bothered to check.
			}
			else if (flags[kFLAGS.LVL_UP_FAST] == 2){
				lUFSMM(999);
			}
			else {
				player.XP -= player.requiredXP();
				player.level++;
				player.perkPoints++;
				if (player.level <= 6) player.perkPoints++;
				//if (player.level % 2 == 0) player.ascensionPerkPoints++;
				//przerobić aby z asc perk co ?6/3/1? lvl dostawać another perk point?
				//może też dodać ascension perk aby móc dostawać 6 lub nawet wiecej stat points na lvl up?
				clearOutput();
				outputText("<b>You are now level " + num2Text(player.level) + "!</b>");
				if (player.level > 6) {
					player.statPoints += 5;
					outputText("\n\nYou have gained five attribute points and one perk point!");
				}
				else {
					player.statPoints += 10;
					outputText("\n\nYou have gained ten attribute points and two perk points!");
				}
				//What is this one for? V
				if (player.level > 6) outputText("\n\nYou have gained one perk point!");
				else outputText("\n\nYou have gained two perk points!");
			}
			if (player.statPoints>0) {
				doNext(attributeMenu);
			} else if (player.perkPoints > 0) {
				doNext(perkBuyMenu);
			} else {
				doNext(playerMenu);
			}
		}
		//Spend attribute points
		else if (player.statPoints > 0) {
			attributeMenu();
		}
		//Spend perk points
		else if (player.perkPoints > 0) {
			perkBuyMenu();
		}
		else {
			outputText("<b>ERROR. LEVEL UP PUSHED WHEN PC CANNOT LEVEL OR GAIN PERKS.  PLEASE REPORT THE STEPS TO REPRODUCE THIS BUG TO ORMAEL@GMAIL.COM OR THE FENOXO.COM XIANXIA MOD THREAD.</b>");
			doNext(playerMenu);
		}
	}

	//Sub-menus for limited levelling.
	public function lvlUpFastSubMenu():void{
		spriteSelect(-1);
		outputText("Fast levelling, just keep clicking on the button to level up by that number. Or press LvlMax to just get all the levels.");
		outputText("\n\nPressing \"Done\" will bring you to stat/perk allocation.");
		menu();
		addButton(0,"Lvl +1", lUFSM1);
		addButton(1,"Lvl +2", lUFSM2);
		addButton(2,"Lvl +5", lUFSM5);
		addButton(3,"Lvl +10", lUFSM10);
		addButton(4,"LvlMax", lUFSMX);
		addButton(14, "Done", lUFSMAP);
	}

	public function lUFSM1():void{
		lUFSMM(1);
	}
	public function lUFSM2():void{
		lUFSMM(2);
	}
	public function lUFSM5():void{
		lUFSMM(5);
	}
	public function lUFSM10():void{
		lUFSMM(10);
	}
	public function lUFSMX():void{
		lUFSMM(999);
	}

	public function lUFSMM(incmax:int = 999):void{
		var lvlinc:int = 0;		//Level increment tracking
		var perkLvl:int = player.perkPoints;	//Cheating by keeping track of changes by subtraction.
		var statLvl:int = player.statPoints;
		clearOutput();
		if (player.XP < player.requiredXP()){
			outputText("Max level reached. Unable to increase further.\n\n");
		}
		else {
			while (player.XP >= player.requiredXP() && player.level < CoC.instance.levelCap && lvlinc < incmax) {
				player.XP -= player.requiredXP();
				player.level++;
				lvlinc++;
				if (player.level <= 6) {
					player.perkPoints += 2;
					player.statPoints += 10;
				}
				else {
					player.perkPoints++;
					player.statPoints += 5;
				}
			}
			outputText("<b>You have gained " +lvlinc.toString() + " levels, and are now level " + num2Text(player.level)+"!</b>");
			var perkRes:int = player.perkPoints - perkLvl;
			var statRes:int = player.statPoints - statLvl;
			outputText("\n\nYou have gained " + statRes.toString() + " attribute points and " + perkRes.toString() + " perk points!\n\n");
			statScreenRefresh();
		}
		lvlUpFastSubMenu();
	}

	public function lUFSMAP():void {
		if (player.statPoints > 0) {
			attributeMenu();
		} else if (player.perkPoints > 0) {
			perkBuyMenu();
		} else {
			playerMenu();
		}
	}


//Attribute menu
	private function attributeMenu():void {
		clearOutput();
		outputText("You have <b>" + (player.statPoints) + "</b> left to spend.\n\n");

		outputText("Strength: ");
		if (player.strStat.core.value < player.strStat.core.max) outputText("" + Math.floor(player.strStat.core.value) + " + <b>" + player.tempStr + "</b> → " + Math.floor(player.strStat.core.value + player.tempStr) + " Total "+Math.floor((player.strStat.core.value + player.tempStr + player.strStat.bonus.value) * player.strStat.mult.value)+"\n");
		else outputText("" + Math.floor(player.strStat.core.value) + " (Maximum)\n");

		outputText("Toughness: ");
		if (player.touStat.core.value < player.touStat.core.max) outputText("" + Math.floor(player.touStat.core.value) + " + <b>" + player.tempTou + "</b> → " + Math.floor(player.touStat.core.value + player.tempTou) + " Total "+Math.floor((player.touStat.core.value + player.tempTou + player.touStat.bonus.value) * player.touStat.mult.value)+"\n");
		else outputText("" + Math.floor(player.touStat.core.value) + " (Maximum)\n");

		outputText("Speed: ");
		if (player.speStat.core.value < player.speStat.core.max) outputText("" + Math.floor(player.speStat.core.value) + " + <b>" + player.tempSpe + "</b> → " + Math.floor(player.speStat.core.value + player.tempSpe) + " Total "+Math.floor((player.speStat.core.value + player.tempSpe + player.speStat.bonus.value) * player.speStat.mult.value)+"\n");
		else outputText("" + Math.floor(player.speStat.core.value) + " (Maximum)\n");

		outputText("Intelligence: ");
		if (player.intStat.core.value < player.intStat.core.max) outputText("" + Math.floor(player.intStat.core.value) + " + <b>" + player.tempInt + "</b> → " + Math.floor(player.intStat.core.value + player.tempInt) + " Total "+Math.floor((player.intStat.core.value + player.tempInt + player.intStat.bonus.value) * player.intStat.mult.value)+"\n");
		else outputText("" + Math.floor(player.intStat.core.value) + " (Maximum)\n");

		outputText("Wisdom: ");
		if (player.wisStat.core.value < player.wisStat.core.max) outputText("" + Math.floor(player.wisStat.core.value) + " + <b>" + player.tempWis + "</b> → " + Math.floor(player.wisStat.core.value + player.tempWis) + " Total "+Math.floor((player.wisStat.core.value + player.tempWis + player.wisStat.bonus.value) * player.wisStat.mult.value)+"\n");
		else outputText("" + Math.floor(player.wisStat.core.value) + " (Maximum)\n");

		outputText("Libido: ");
		if (player.libStat.core.value < player.libStat.core.max) outputText("" + Math.floor(player.libStat.core.value) + " + <b>" + player.tempLib + "</b> → " + Math.floor(player.libStat.core.value + player.tempLib) + " Total "+Math.floor((player.libStat.core.value + player.tempLib + player.libStat.bonus.value) * player.libStat.mult.value)+"\n");
		else outputText("" + Math.floor(player.libStat.core.value) + " (Maximum)\n");

		menu();
		//Add
		if (player.statPoints > 0) {
			if ((player.strStat.core.value + player.tempStr) < player.strStat.core.max) addButton(0, "Add STR", addAttribute, "str", null, null, "Add 1 point (5 points with Shift) to Strength.", "Add Strength");
			if ((player.touStat.core.value + player.tempTou) < player.touStat.core.max) addButton(1, "Add TOU", addAttribute, "tou", null, null, "Add 1 point (5 points with Shift) to Toughness.", "Add Toughness");
			if ((player.speStat.core.value + player.tempSpe) < player.speStat.core.max) addButton(2, "Add SPE", addAttribute, "spe", null, null, "Add 1 point (5 points with Shift) to Speed.", "Add Speed");
			if ((player.intStat.core.value + player.tempInt) < player.intStat.core.max) addButton(3, "Add INT", addAttribute, "int", null, null, "Add 1 point (5 points with Shift) to Intelligence.", "Add Intelligence");
			if ((player.wisStat.core.value + player.tempWis) < player.wisStat.core.max) addButton(4, "Add WIS", addAttribute, "wis", null, null, "Add 1 point (5 points with Shift) to Wisdom.", "Add Wisdom");
			if ((player.libStat.core.value + player.tempLib) < player.libStat.core.max) addButton(10, "Add LIB", addAttribute, "lib", null, null, "Add 1 point (5 points with Shift) to Libido.", "Add Libido");
		}
		//Subtract
		if (player.tempStr > 0) addButton(5, "Sub STR", subtractAttribute, "str", null, null, "Subtract 1 point (5 points with Shift) from Strength.", "Subtract Strength");
		if (player.tempTou > 0) addButton(6, "Sub TOU", subtractAttribute, "tou", null, null, "Subtract 1 point (5 points with Shift) from Toughness.", "Subtract Toughness");
		if (player.tempSpe > 0) addButton(7, "Sub SPE", subtractAttribute, "spe", null, null, "Subtract 1 point (5 points with Shift) from Speed.", "Subtract Speed");
		if (player.tempInt > 0) addButton(8, "Sub INT", subtractAttribute, "int", null, null, "Subtract 1 point (5 points with Shift) from Intelligence.", "Subtract Intelligence");
		if (player.tempWis > 0) addButton(9, "Sub WIS", subtractAttribute, "wis", null, null, "Subtract 1 point (5 points with Shift) from Wisdom.", "Subtract Wisdom");
		if (player.tempLib > 0) addButton(11, "Sub LIB", subtractAttribute, "lib", null, null, "Subtract 1 point (5 points with Shift) from Libido.", "Subtract Libido");

		hideStats();
		hideUpDown();
		mainView.hideAllMenuButtons()
		mainView.hideComboBox();
		addButton(13, "Reset", resetAttributes);
		addButton(14, "Done", finishAttributes);
	}

	private function addAttribute(attribute:String):void {
		var n:int=1;
		var m:int;
		if (flags[kFLAGS.SHIFT_KEY_DOWN]) n = 5;
		if (n > player.statPoints) n = player.statPoints;
		switch (attribute) {
			case "str":
				m = player.strStat.core.max - int(player.strStat.core.value + player.tempStr);
				if (m < n) n = m;
				player.tempStr+=n;
				break;
			case "tou":
				m = player.touStat.core.max - int(player.touStat.core.value + player.tempTou);
				if (m < n) n = m;
				player.tempTou+=n;
				break;
			case "spe":
				m = player.speStat.core.max - int(player.speStat.core.value + player.tempSpe);
				if (m < n) n = m;
				player.tempSpe+=n;
				break;
			case "int":
				m = player.intStat.core.max - int(player.intStat.core.value + player.tempInt);
				if (m < n) n = m;
				player.tempInt+=n;
				break;
			case "wis":
				m = player.wisStat.core.max - int(player.wisStat.core.value + player.tempWis);
				if (m < n) n = m;
				player.tempWis+=n;
				break;
			case "lib":
				m = player.libStat.core.max - int(player.libStat.core.value + player.tempLib);
				if (m < n) n = m;
				player.tempLib+=n;
				break;
		//	case "sen":
		//		m = maxes.sens - int(player.sens + player.tempSens);
		//		if (m < n) n = m;
		//		player.tempSens+=n;
		//		break;
			default:
				n=0; //Failsafe
		}
		player.statPoints-=n;
		attributeMenu();
	}
	private function subtractAttribute(attribute:String):void {
		var n:int=1;
		if (flags[kFLAGS.SHIFT_KEY_DOWN]) n = 5;
		switch (attribute) {
			case "str":
				if (player.tempStr < n) n = player.tempStr;
				player.tempStr-=n;
				break;
			case "tou":
				if (player.tempTou < n) n = player.tempTou;
				player.tempTou-=n;
				break;
			case "spe":
				if (player.tempSpe < n) n = player.tempSpe;
				player.tempSpe-=n;
				break;
			case "int":
				if (player.tempInt < n) n = player.tempInt;
				player.tempInt-=n;
				break;
			case "wis":
				if (player.tempWis < n) n = player.tempWis;
				player.tempWis-=n;
				break;
			case "lib":
				if (player.tempLib < n) n = player.tempLib;
				player.tempLib-=n;
				break;
			default:
				n=0; //Failsafe
		}
		player.statPoints+=n;
		attributeMenu();
	}
	private function resetAttributes():void {
		//Increment unspent attribute points.
		player.statPoints += player.tempStr;
		player.statPoints += player.tempTou;
		player.statPoints += player.tempSpe;
		player.statPoints += player.tempInt;
		player.statPoints += player.tempWis;
		player.statPoints += player.tempLib;
		//Reset temporary attributes to 0.
		player.tempStr = 0;
		player.tempTou = 0;
		player.tempSpe = 0;
		player.tempInt = 0;
		player.tempWis = 0;
		player.tempLib = 0;
		//DONE!
		attributeMenu();
	}
	private function finishAttributes():void {
		clearOutput();
		if (player.tempStr > 0) {
			if (player.tempStr >= 3) outputText("Your muscles feel significantly stronger from your time adventuring.\n");
			else outputText("Your muscles feel slightly stronger from your time adventuring.\n");
		}
		if (player.tempTou > 0) {
			if (player.tempTou >= 3) outputText("You feel tougher from all the fights you have endured.\n");
			else outputText("You feel slightly tougher from all the fights you have endured.\n");
		}
		if (player.tempSpe > 0) {
			if (player.tempSpe >= 3) outputText("Your time in combat has driven you to move faster.\n");
			else outputText("Your time in combat has driven you to move slightly faster.\n");
		}
		if (player.tempInt > 0) {
			if (player.tempInt >= 3) outputText("Your time spent fighting the creatures of this realm has sharpened your wit.\n");
			else outputText("Your time spent fighting the creatures of this realm has sharpened your wit slightly.\n");
		}
		if (player.tempWis > 0) {
			if (player.tempWis >= 3) outputText("Your time spent fighting the creatures of this realm has improved your insight.\n");
			else outputText("Your time spent fighting the creatures of this realm has improved your insight slightly.\n");
		}
		if (player.tempLib > 0) {
			if (player.tempLib >= 3) outputText("Your time spent in this realm has made you more lustful.\n");
			else outputText("Your time spent in this realm has made you slightly more lustful.\n");
		}
		if (player.tempStr + player.tempTou + player.tempSpe + player.tempInt + player.tempWis + player.tempLib <= 0 || player.statPoints > 0) {
			outputText("\nYou may allocate your remaining stat points later.");
		}
		player.strStat.core.value += player.tempStr;
		player.touStat.core.value += player.tempTou;
		player.speStat.core.value += player.tempSpe;
		player.intStat.core.value += player.tempInt;
		player.wisStat.core.value += player.tempWis;
		player.libStat.core.value += player.tempLib;
		player.tempStr = 0;
		player.tempTou = 0;
		player.tempSpe = 0;
		player.tempInt = 0;
		player.tempWis = 0;
		player.tempLib = 0;
		statScreenRefresh();
		if (player.perkPoints > 0) doNext(perkBuyMenu);
		else doNext(playerMenu);
	}

	public function perkBuyMenu():void {
		clearOutput();
		var perks:/*PerkType*/Array    = PerkTree.availablePerks(player);
		hideMenus();
		mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
		if (perks.length == 0) {
			outputText("<b>You do not qualify for any perks at present.  </b>In case you qualify for any in the future, you will keep your " + num2Text(player.perkPoints) + " perk point");
			if (player.perkPoints > 1) outputText("s");
			outputText(".");
			doNext(playerMenu);
			return;
		}
        if (CoC.instance.testingBlockExiting) {
            menu();
			addButton(0, "Next", perkSelect, perks[rand(perks.length)]);
		} else {
			outputText("Please select a perk from the drop-down list, then click 'Okay'.  You can press 'Skip' to save your perk point for later.\n");
            //CoC.instance.showComboBox(perkList, "Choose a perk", perkCbChangeHandler);
            if (player.perkPoints>1) outputText("You have "+numberOfThings(player.perkPoints,"perk point","perk points")+".\n\n");
	        mainView.mainText.addEventListener(TextEvent.LINK, linkhandler);
	        perkList = [];
	        for each(var perk:PerkType in perks) {
		        var p:PerkClass = new PerkClass(perk,
				        perk.defaultValue1, perk.defaultValue2, perk.defaultValue3, perk.defaultValue4);
		        var lab:* = {label: p.perkName, perk: p};
		        perkList.push(lab);
		        outputText("<u><a href=\"event:"+perkList.indexOf(lab)+"\">"+p.perkName+"</a></u>\n");
	        }
			mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
			menu();
			addButton(1, "Skip", perkSkip);
		}
	}
	private var perkList:Array = [];
	private function linkhandler(e:TextEvent):void{
		trace(e.text);
		perkCbChangeHandler(perkList[e.text]);
	}
	private function perkSelect(selected:PerkClass):void {
		mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
		mainView.hideComboBox();
		applyPerk(selected);
	}

	private function perkSkip():void {
		mainView.mainText.removeEventListener(TextEvent.LINK, linkhandler);
		mainView.hideComboBox();
		playerMenu();
	}

	public function perkCbChangeHandler(selectedItem:*):void {
		//Store perk name for later addition
		clearOutput();
		var selected:PerkClass = selectedItem.perk;
		outputText("You have selected the following perk:\n");
		outputText("<b>" + selected.perkName + ":</b> " + selected.perkLongDesc);
        CoC.instance.placeComboBoxAfterText();
        var unlocks:Array = CoC.instance.perkTree.listUnlocks(selected.ptype);
        if (unlocks.length > 0) {
			outputText("<b>Unlocks:</b> <ul>");
			for each (var pt:PerkType in unlocks) outputText("<li>" + pt.name + " (" + pt.longDesc + ")</li>");
			outputText("</ul>");
		}
		outputText("If you would like to select this perk, click <b>Okay</b>.  Otherwise, select a new perk, or press <b>Skip</b> to make a decision later.\n");
		if (player.perkPoints > 1) outputText("\n\nYou have "+numberOfThings(player.perkPoints,"perk point","perk points")+".\n\n");
		for each(var p:* in perkList){
			outputText("<u><a href=\"event:"+perkList.indexOf(p)+"\">"+p.perk.perkName+"</a></u>\n");
		}
		menu();
		addButton(0, "Okay", perkSelect, selected);
		addButton(1, "Skip", perkSkip);
	}

	public function applyPerk(perk:PerkClass):void {
		clearOutput();
		player.perkPoints--;
		//Apply perk here.
		outputText("<b>" + perk.perkName + "</b> gained!");
		player.createPerk(perk.ptype, perk.value1, perk.value2, perk.value3, perk.value4);
		if (perk.ptype == PerkLib.StrongBack3) player.itemSlot8.unlocked = true;
		if (perk.ptype == PerkLib.StrongBack2) player.itemSlot7.unlocked = true;
		if (perk.ptype == PerkLib.StrongBack) player.itemSlot6.unlocked = true;
		if (perk.ptype == PerkLib.TankI || perk.ptype == PerkLib.TankII || perk.ptype == PerkLib.TankIII || perk.ptype == PerkLib.TankIV || perk.ptype == PerkLib.TankV || perk.ptype == PerkLib.TankVI) {
			HPChange(player.tou, false);
			statScreenRefresh();
		}
		if (perk.ptype == PerkLib.GoliathI || perk.ptype == PerkLib.GoliathII || perk.ptype == PerkLib.GoliathIII || perk.ptype == PerkLib.GoliathIV || perk.ptype == PerkLib.GoliathV || perk.ptype == PerkLib.GoliathVI) {
			HPChange(player.str, false);
			statScreenRefresh();
		}
		if (perk.ptype == PerkLib.CheetahI || perk.ptype == PerkLib.CheetahII || perk.ptype == PerkLib.CheetahIII || perk.ptype == PerkLib.CheetahIV || perk.ptype == PerkLib.CheetahV || perk.ptype == PerkLib.CheetahVI) {
			HPChange(player.spe, false);
			statScreenRefresh();
		}
		if (player.perkPoints > 0) {
			doNext(perkBuyMenu);
		} else {
			doNext(playerMenu);
		}
	}
			/*	DeityJobMunchkin.requirePerk(JobWarlord)
                                .requirePerk(JobMonk)
                                .requirePerk(JobKnight)
                                .requirePerk(JobGolemancer)
                                .requirePerk(JobHunter)
                                .requirePerk(JobEromancer)
                                .requirePerk(JobEnchanter)
                                .requirePerk(JobElementalConjurer)
                                .requirePerk(JobCourtesan)
                                .requirePerk(JobDervish)
                                .requirePerk(JobDefender)
                                .requirePerk(JobBrawler)
                                .requirePerk(JobBeastWarrior)
                                .requirePerk(JobSwordsman)
                                .requirePerk(JobAllRounder)
                                .requireStr(150)
                                .requireTou(150)
                                .requireSpe(150)
                                .requireInt(150)
                                .requireWis(150)
                                .requireLib(90)
								.requireSen(90)
                                .requireLevel(30); //requirePerk(JobEromancer)
			*/	//(Still need some other related stuff added to make PC true Munchkin
	
	public function superPerkBuyMenu(page:int = 1):void {
		clearOutput();
		outputText("If you meet requirements and have enough points you can pick one or more super perks.\n");
		if (player.superPerkPoints > 0) outputText("You have "+numberOfThings(player.superPerkPoints,"super perk point","super perk points")+".\n\n");
		hideMenus();
		mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
		menu();
		if (page == 1) {
			if (player.superPerkPoints > 0) {
				if (player.hasPerk(PerkLib.DeityJobMunchkin)) addButtonDisabled(0, "DJ:M", "You already have this perk.");
				else {
					if (player.str >= 150 && player.tou >= 150 && player.spe >= 150 && player.inte >= 150 && player.wis >= 150 && player.lib >= 150 && player.sens >= 100 && player.level >= 90 && player.currentBasicJobs() >= 9 && player.currentAdvancedJobs() >= 6 && player.currentPrestigeJobs() >= 2 && player.currentHiddenJobs() >= 1) {
						addButton(0, "DJ:M", perkDeityJobMunchkin).hint("Choose the 'Deity Job: Munchkin' super munchkin perk. You're Munchkin, an ultimate being that possess a god-like body and powers. (+20% max HP/Lust/Wrath, +10% max SF/Mana/Fatigue, increase limit of negative HP equal to all stats (aside of corruption) added up)");
					}
					else addButtonDisabled(0, "DJ:M", "You do not have one/all of them yet: enough super perk points to obtain this perk, level 90+, 150+ in str/tou/spe/inte/wis/lib, 100+ in sens, 9 basic jobs, 6 advanced jobs, 2 prestige jobs, 1 hidden job.");
				}
				addButtonDisabled(1, "M(at)G", "Soon");
				addButtonDisabled(2, "M(at)W", "Soon");
			}
			else {
				if (player.hasPerk(PerkLib.DeityJobMunchkin)) addButtonDisabled(0, "DJ:M", "You already have this perk.");
				else addButtonDisabled(0, "DJ:M", "You do not have enough super perk points to obtain this perk.");
				addButtonDisabled(1, "M(at)G", "Soon");
				addButtonDisabled(2, "M(at)W", "Soon");
			}
			addButton(12, "Next", superPerkBuyMenu, page + 1);
			if (player.perkPoints > 2) addButton(13, "Convert", superPerkConvertMenu);
			else addButtonDisabled(13, "Convert", "You need at least 3 perk points to convert them.");
			addButton(14, "Back", playerMenu);
		}
		if (page == 2) {
			if (player.superPerkPoints > 0) {
				if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) addButtonDisabled(0, "HJ:BD", "You already have this super perk.");
				else {
					if (player.freeHiddenJobsSlots() > 0) addButton(0, "HJ:BD", perkHiddenJobBloodDemon).hint("Choose the 'Hidden Job: Blood Demon' super perk. You've trained in arts of blood demons. Beings that reached mastery of using their own or others blood to great effect. (+10x Tou of OverMax HP, -10% blood spells cost, +20% blood spells power, can learn Blood Spells form Red Manuscripts)");
					else addButtonDisabled(0, "HJ:BD", "You do not have a free slot for this hidden job.");
				}
				if (player.hasPerk(PerkLib.WayOfTheBlood)) addButtonDisabled(1, "WOTB", "You already have this super perk.");
				else {
					if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) addButton(1, "WOTB", perkWayOfTheBlood).hint("Choose the 'Way of the Blood' super perk. Allowing to use health to substitude using soulforce in almost all soulskills. (+10x Tou of OverMax HP, -10% blood spells cost, +20% blood spells power, can learn Blood Soulskills form Crimson Jades)");
					else addButtonDisabled(1, "WOTB", "You need to first have the 'Hidden Job: Blood Demon' super perk.");
				}
				if (player.hasPerk(PerkLib.YourPainMyPower)) addButtonDisabled(2, "YPMP", "You already have this super perk.");
				else {
					if (player.hasPerk(PerkLib.WayOfTheBlood)) addButton(2, "YPMP", perkYourPainMyPower).hint("Choose the 'Your Pain My Power' super perk. You can absorb all of blood spilled and wrath generated by enemy under Bleed effects into yourself. (+10x Tou of OverMax HP, -10% blood spells cost, +20% blood spells power)");
					else addButtonDisabled(2, "YPMP", "You need to first have the 'Way of the Blood' super perk.");
				}
				if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) addButtonDisabled(3, "MBFBP", "You already have this super perk.");
				else {
					if (player.hasPerk(PerkLib.YourPainMyPower)) addButton(3, "MBFBP", perkMyBloodForBloodPuppies).hint("Choose the 'My Blood for Blood Puppies' super perk. During fight small part of your blood from into blood puppies that can attack on your behalf with blood magic/soulskills. When you grow in mastery of blood they would grow stronger with you. (+10x Tou of OverMax HP, -10% blood spells cost, +20% blood spells power)");
					else addButtonDisabled(3, "MBFBP", "You need to first have the 'Your Pain My Power' super perk.");
				}
				if (player.level >= 30) {
					if (player.hasPerk(PerkLib.BloodDemonToughness)) addButtonDisabled(4, "BDT", "You already have this super perk.");
					else {
						if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) addButton(4, "BDT", perkBloodDemonToughness).hint("Choose the 'Blood Demon Toughness' super perk. When below 0 HP it would negate any negative effect of other perks that would cause negative HP regen. (+10x Tou of OverMax HP, -5% blood spells/soulskills cost, +10% blood spells/soulskills power/Base TOU Cap, +0,5% HP regen)");
						else addButtonDisabled(4, "BDT", "You need to first have the 'My Blood for Blood Puppies' super perk.");
					}
				}
				else {
					addButtonDisabled(4, "BDT", "You need to reach level 30 first.");
				}
			}
			else {
				if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) addButtonDisabled(0, "HJ:BD", "You already have this perk.");
				else addButtonDisabled(0, "HJ:BD", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.WayOfTheBlood)) addButtonDisabled(1, "WOTB", "You already have this perk.");
				else addButtonDisabled(1, "WOTB", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.YourPainMyPower)) addButtonDisabled(2, "YPMP", "You already have this perk.");
				else addButtonDisabled(2, "YPMP", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) addButtonDisabled(3, "MBFBP", "You already have this perk.");
				else addButtonDisabled(3, "MBFBP", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.BloodDemonToughness)) addButtonDisabled(4, "BDT", "You already have this perk.");
				else addButtonDisabled(4, "BDT", "You do not have enough super perk points to obtain this perk.");
			}
			addButton(12, "Next", superPerkBuyMenu, page + 1);
			addButton(13, "Previous", superPerkBuyMenu, page - 1);
			addButton(14, "Back", playerMenu);
		}
		if (page == 3) {
			if (player.superPerkPoints > 0) {
				if (player.hasPerk(PerkLib.HiddenJobAsura)) addButtonDisabled(0, "HJ:A", "You already have this super perk.");
				else {
					if (player.freeHiddenJobsSlots() > 0) addButton(0, "HJ:A", perkHiddenJobAsura).hint("Choose the 'Hidden Job: Asura' super perk. You've trained in way of asuras. Beings that reached mastery of unleashing wrath to great effect. (+10% of OverMax Wrath, access to Asura Form: 3x more melee attacks per turn, +40%/30%/20% of core str/spe/tou stat value)");
					else addButtonDisabled(0, "HJ:A", "You do not have a free slot for this hidden job.");
				}
				if (player.hasPerk(PerkLib.AbsoluteStrength)) addButtonDisabled(1, "AS", "You already have this super perk.");
				else {
					if (player.hasPerk(PerkLib.HiddenJobAsura)) addButton(1, "AS", perkAbsoluteStrength).hint("Choose the 'Absolute Strength' super perk. Increase strength based on current amount of wrath. Also wrath outside of combat will not decay and even with correct perks can slowly rise. (+10% of OverMax Wrath, % based multi bonus to str stat equal to 50% of wrath (updated once a day))");
					else addButtonDisabled(1, "AS", "You need to first have the 'Hidden Job: Asura' super perk.");
				}
				if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) addButtonDisabled(2, "LAB", "You already have this super perk.");
				else {
					if (player.hasPerk(PerkLib.AbsoluteStrength)) addButton(2, "LAB", perkLikeAnAsuraBoss).hint("Choose the 'Like A-sura Boss' super perk. Adds to toggle starting in Asura Form at combat start, increase to physical might rise to 80%/60%/40% of core str/tou/spe. (+10% of OverMax Wrath)");
					else addButtonDisabled(2, "LAB", "You need to first have the 'Absolute Strength' super perk.");
				}
				if (player.hasPerk(PerkLib.ICastAsuraFist)) addButtonDisabled(3, "ICAF", "You already have this super perk.");
				else {
					if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) addButton(3, "ICAF", perkICastAsuraFist).hint("Choose the 'I Cast (Asura) Fist' super perk. Safe treshold for magic/m.specials is magic/m.specials is calculated based on overmax wrath not max wrath, +100% of base max wrath. (+10% of OverMax Wrath)");
					else addButtonDisabled(3, "ICAF", "You need to first have the 'Like A-sura Boss' super perk.");
				}
				if (player.level >= 30) {
					if (player.hasPerk(PerkLib.AsuraStrength)) addButtonDisabled(4, "ASTR", "You already have this super perk.");
					else {
						if (player.hasPerk(PerkLib.ICastAsuraFist)) addButton(4, "ASTR", perkAsuraStrength).hint("Choose the 'Asura Strength' super perk. Gain Asura Strength, Asura Form increase to physical might rise to 180%/90%/60% of core str/tou/spe and generate one additional pair of semi-transparent arms. (+10% of OverMax Wrath/Base STR Cap)");
						else addButtonDisabled(4, "ASTR", "You need to first have the 'I Cast (Asura) Fist' super perk.");
					}
				}
				else {
					addButtonDisabled(4, "ASTR", "You need to reach level 30 first.");
				}
			}
			else {
				if (player.hasPerk(PerkLib.HiddenJobAsura)) addButtonDisabled(0, "HJ:A", "You already have this perk.");
				else addButtonDisabled(0, "HJ:A", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.AbsoluteStrength)) addButtonDisabled(1, "AS", "You already have this perk.");
				else addButtonDisabled(1, "AS", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) addButtonDisabled(2, "LAB", "You already have this perk.");
				else addButtonDisabled(2, "LAB", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.ICastAsuraFist)) addButtonDisabled(3, "ICAF", "You already have this perk.");
				else addButtonDisabled(3, "ICAF", "You do not have enough super perk points to obtain this perk.");
				if (player.hasPerk(PerkLib.AsuraStrength)) addButtonDisabled(4, "ASTR", "You already have this perk.");
				else addButtonDisabled(4, "ASTR", "You do not have enough super perk points to obtain this perk.");
			}
			//12 -> page + 1 button
			addButton(13, "Previous", superPerkBuyMenu, page - 1);
			addButton(14, "Back", playerMenu);
		}
		if (page == 3) {
			if (player.superPerkPoints > 0) {
				
			}
			else {
				
			}
			//12 -> page + 1 button
			//13 -> page - 1 button
			addButton(14, "Back", playerMenu);
		}
	}
	private function superPerkConvertMenu():void {
		clearOutput();
		outputText("You sacrifice three perk points and recieve one super perk point.");
		player.perkPoints -= 3;
		player.superPerkPoints++;
		doNext(superPerkBuyMenu);
	}
	private function perkDeityJobMunchkin():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.DeityJobMunchkin,0,0,0,0);
		clearOutput();
		outputText("You gained 'Deity Job: Munchkin' super munchkin perk. (Because it too cool to be merely super perk, right?)");
		doNext(curry(superPerkBuyMenu, 1));
	}
	private function perkMunchkinAtGym():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.MunchkinAtGym,0,0,0,0);
		clearOutput();
		outputText("You gained 'Munchkin @ Gym' super munchkin perk. (Because it too cool to be merely super perk, right?)");
		doNext(curry(superPerkBuyMenu, 1));
	}
	private function perkMunchkinAtWork():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.MunchkinAtWork,0,0,0,0);
		clearOutput();
		outputText("You gained 'Munchkin @ Work' super munchkin perk. (Because it too cool to be merely super perk, right?)");
		doNext(curry(superPerkBuyMenu, 1));
	}
	private function perkHiddenJobBloodDemon():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.HiddenJobBloodDemon,0,0,0,0);
		clearOutput();
		outputText("You gained 'Hidden Job: Blood Demon' super perk.");
		doNext(curry(superPerkBuyMenu, 2));
	}
	private function perkWayOfTheBlood():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.WayOfTheBlood,0,0,0,0);
		clearOutput();
		outputText("You gained 'Way of the Blood' super perk.");
		doNext(curry(superPerkBuyMenu, 2));
	}
	private function perkYourPainMyPower():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.YourPainMyPower,0,0,0,0);
		clearOutput();
		outputText("You gained 'Your Pain My Power' super perk.");
		doNext(curry(superPerkBuyMenu, 2));
	}
	private function perkMyBloodForBloodPuppies():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.MyBloodForBloodPuppies,0,0,0,0);
		clearOutput();
		outputText("You gained 'My Blood for Blood Puppies' super perk.");
		doNext(curry(superPerkBuyMenu, 2));
	}
	private function perkBloodDemonToughness():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.BloodDemonToughness,0,0,0,0);
		clearOutput();
		outputText("You gained 'Blood Demon Toughness' super perk.");
		doNext(curry(superPerkBuyMenu, 2));
	}
	private function perkHiddenJobAsura():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.HiddenJobAsura,0,0,0,0);
		clearOutput();
		outputText("You gained 'Hidden Job: Asura' super perk.");
		doNext(curry(superPerkBuyMenu, 3));
	}
	private function perkAbsoluteStrength():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.AbsoluteStrength,0,0,0,0);
		clearOutput();
		outputText("You gained 'Absolute Strength' super perk.");
		doNext(curry(superPerkBuyMenu, 3));
	}
	private function perkLikeAnAsuraBoss():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.LikeAnAsuraBoss,0,0,0,0);
		clearOutput();
		outputText("You gained 'Like A-sura Boss' super perk.");
		doNext(curry(superPerkBuyMenu, 3));
	}
	private function perkICastAsuraFist():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.ICastAsuraFist,0,0,0,0);
		clearOutput();
		outputText("You gained 'I Cast (Asura) Fist' super perk.");
		doNext(curry(superPerkBuyMenu, 3));
	}
	private function perkAsuraStrength():void {
		player.superPerkPoints--;
		player.createPerk(PerkLib.AsuraStrength,0,0,0,0);
		clearOutput();
		outputText("You gained 'Asura Strength' super perk.");
		doNext(curry(superPerkBuyMenu, 3));
	}
}
}