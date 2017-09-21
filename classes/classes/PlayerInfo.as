package classes {

import coc.view.MainView;

import flash.events.Event;

import fl.controls.ComboBox;
import fl.data.DataProvider;

import classes.Scenes.NPCs.IsabellaScene;
import classes.GlobalFlags.*;

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
		displayHeader("Stats");
		// Begin Combat Stats
		var combatStats:String = "";

		combatStats += "<b>Damage Resistance:</b> " + (100 - Math.round(player.damagePercent(true))) + "-" + (100 - Math.round(player.damagePercent(true) - player.damageToughnessModifier(true))) + "% (Higher is better.)\n";

		combatStats += "<b>Lust Resistance:</b> " + (100 - Math.round(getGame().lustPercent())) + "% (Higher is better.)\n";

		combatStats += "<b>Spell Effect Multiplier:</b> " + Math.round(100 * combat.spellMod()) + "%\n";

		combatStats += "<b>Spell Cost:</b> " + combat.spellCost(100) + "%\n";

		combatStats += "<b>White Spell Effect Multiplier:</b> " + Math.round(100 * combat.spellModWhite()) + "%\n";

		combatStats += "<b>White Spell Cost:</b> " + combat.spellCostWhite(100) + "%\n";

		combatStats += "<b>Black Spell Effect Multiplier:</b> " + Math.round(100 * combat.spellModBlack()) + "%\n";

		combatStats += "<b>Black Spell Cost:</b> " + combat.spellCostBlack(100) + "%\n";

		combatStats += "<b>Unarmed:</b> +" + combat.unarmedAttack() + "\n";

		if (player.statusEffectv1(StatusEffects.Kelt) > 0) {
			if (player.statusEffectv1(StatusEffects.Kindra) < 1)
				combatStats += "<b>Bow Skill:</b> " + Math.round(player.statusEffectv1(StatusEffects.Kelt)) + " / 100\n";
			if (player.statusEffectv1(StatusEffects.Kindra) > 0)
				combatStats += "<b>Bow Skill:</b> " + (Math.round(player.statusEffectv1(StatusEffects.Kelt)) + Math.round(player.statusEffectv1(StatusEffects.Kindra))) + " / 250\n";
		}

		combatStats += "<b>Arrow/Bolt Cost:</b> " + combat.bowCost(100) + "%\n";

		combatStats += "<b>Accuracy (1st range attack):</b> " + (combat.arrowsAccuracy() / 2) + "%\n";

		if (player.findPerk(PerkLib.DoubleStrike) >= 0) combatStats += "<b>Accuracy (2nd range attack):</b> " + ((combat.arrowsAccuracy() / 2) - 15) + "%\n";

		if (player.findPerk(PerkLib.Manyshot) >= 0) combatStats += "<b>Accuracy (3rd range attack):</b> " + ((combat.arrowsAccuracy() / 2) - 30) + "%\n";

		if (player.findPerk(PerkLib.TripleStrike) >= 0) combatStats += "<b>Accuracy (4th range attack):</b> " + ((combat.arrowsAccuracy() / 2) - 45) + "%\n";

		if (player.findPerk(PerkLib.WildQuiver) >= 0) combatStats += "<b>Accuracy (5th range attack):</b> " + ((combat.arrowsAccuracy() / 2) - 60) + "%\n";

		if (player.findPerk(PerkLib.Multishot) >= 0) combatStats += "<b>Accuracy (6th range attack):</b> " + ((combat.arrowsAccuracy() / 2) - 75) + "%\n";

		combatStats += "<b>Soulskill Effect Multiplier:</b> " + Math.round(100 * combat.soulskillMod()) + "%\n";

		combatStats += "<b>Soulskill Cost:</b> " + Math.round(100 * combat.soulskillCost()) + "%\n";

		if (flags[kFLAGS.RAPHAEL_RAPIER_TRANING] > 0)
			combatStats += "<b>Rapier Skill:</b> " + flags[kFLAGS.RAPHAEL_RAPIER_TRANING] + " / 4\n";

		if (player.teaseLevel < 5)
			combatStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / 5 (Exp: " + player.teaseXP + " / " + (10 + (player.teaseLevel + 1) * 5 * (player.teaseLevel + 1)) + ")\n";
		else
			combatStats += "<b>Tease Skill:</b>  " + player.teaseLevel + " / 5 (Exp: MAX)\n";

		var maxes:Object = player.getAllMaxStats();
		combatStats += "<b>Strength Cap:</b> " + maxes.str + "\n";
		combatStats += "<b>Toughness Cap:</b> " + maxes.tou + "\n";
		combatStats += "<b>Speed Cap:</b> " + maxes.spe + "\n";
		combatStats += "<b>Intelligence Cap:</b> " + maxes.inte + "\n";
		combatStats += "<b>Wisdom Cap:</b> " + maxes.wis + "\n";
		combatStats += "<b>Libido Cap:</b> " + maxes.lib + "\n";
		combatStats += "<b>Sensitivity Cap:</b> " + maxes.sens + "\n";

		var mins:Object = player.getAllMinStats();
		combatStats += "<b>Libido Minimum:</b> " + mins.lib + "\n";
		combatStats += "<b>Sensitivity Minimum:</b> " + mins.sens + "\n";
		combatStats += "<b>Corruption Minimum:</b> " + mins.cor + "\n";

		if (combatStats != "")
			outputText("<b><u>Combat Stats</u></b>\n" + combatStats);
		// End Combat Stats

		if (prison.inPrison || flags[kFLAGS.PRISON_CAPTURE_COUNTER] > 0) prison.displayPrisonStats();

		// Begin Children Stats
		var childStats:String = "";

		if (player.statusEffectv1(StatusEffects.Birthed) > 0)
			childStats += "<b>Times Given Birth:</b> " + player.statusEffectv1(StatusEffects.Birthed) + "\n";

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
		if (getGame().emberScene.emberChildren() > 0)
			childStats += "<b>Total Children With Ember:</b> " + (getGame().emberScene.emberChildren()) + "\n";

		if (flags[kFLAGS.EMBER_EGGS] > 0)
			childStats += "<b>Ember Eggs Produced:</b> " + flags[kFLAGS.EMBER_EGGS] + "\n";

		if (getGame().isabellaScene.totalIsabellaChildren() > 0) {
			if (getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) > 0)
				childStats += "<b>Children With Isabella (Human, Males):</b> " + getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_BOYS) + "\n";
			if (getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) > 0)
				childStats += "<b>Children With Isabella (Human, Females):</b> " + getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_GIRLS) + "\n";
			if (getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) > 0)
				childStats += "<b>Children With Isabella (Human, Herms):</b> " + getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_HUMAN_HERMS) + "\n";
			if (getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) > 0)
				childStats += "<b>Children With Isabella (Cowgirl, Females):</b> " + getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWGIRLS) + "\n";
			if (getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) > 0)
				childStats += "<b>Children With Isabella (Cowgirl, Herms):</b> " + getGame().isabellaScene.getIsabellaChildType(IsabellaScene.OFFSPRING_COWFUTAS) + "\n";
			childStats += "<b>Total Children With Isabella:</b> " + getGame().isabellaScene.totalIsabellaChildren() + "\n"
		}


		if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0)
			childStats += "<b>Children With Izma (Sharkgirls):</b> " + flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + "\n";
		if (flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
			childStats += "<b>Children With Izma (Tigersharks):</b> " + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] + "\n";
		if (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] > 0 && flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS] > 0)
			childStats += "<b>Total Children with Izma:</b> " + (flags[kFLAGS.IZMA_CHILDREN_SHARKGIRLS] + flags[kFLAGS.IZMA_CHILDREN_TIGERSHARKS]) + "\n";

		if (getGame().joyScene.getTotalLitters() > 0)
			childStats += "<b>Litters With " + (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3 ? "Joy" : "Jojo") + ":</b> " + getGame().joyScene.getTotalLitters() + "\n";

		if (flags[kFLAGS.KELLY_KIDS_MALE] > 0)
			childStats += "<b>Children With Kelly (Males):</b> " + flags[kFLAGS.KELLY_KIDS_MALE] + "\n";
		if (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE] > 0)
			childStats += "<b>Children With Kelly (Females):</b> " + (flags[kFLAGS.KELLY_KIDS] - flags[kFLAGS.KELLY_KIDS_MALE]) + "\n";
		if (flags[kFLAGS.KELLY_KIDS] > 0)
			childStats += "<b>Total Children With Kelly:</b> " + flags[kFLAGS.KELLY_KIDS] + "\n";
		if (getGame().kihaFollower.pregnancy.isPregnant)
			childStats += "<b>Kiha's Pregnancy:</b> " + getGame().kihaFollower.pregnancy.incubation + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_BOYS] > 0)
			childStats += "<b>Kiha Offspring (Males):</b> " + flags[kFLAGS.KIHA_CHILDREN_BOYS] + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_GIRLS] > 0)
			childStats += "<b>Kiha Offspring (Females):</b> " + flags[kFLAGS.KIHA_CHILDREN_GIRLS] + "\n";
		if (flags[kFLAGS.KIHA_CHILDREN_HERMS] > 0)
			childStats += "<b>Kiha Offspring (Herms):</b> " + flags[kFLAGS.KIHA_CHILDREN_HERMS] + "\n";
		if (getGame().kihaFollower.totalKihaChildren() > 0)
			childStats += "<b>Total Children With Kiha:</b> " + getGame().kihaFollower.totalKihaChildren() + "\n";

		if (getGame().mountain.salon.lynnetteApproval() != 0)
			childStats += "<b>Lynnette Children:</b> " + flags[kFLAGS.LYNNETTE_BABY_COUNT] + "\n";

		if (flags[kFLAGS.MARBLE_KIDS] > 0)
			childStats += "<b>Children With Marble:</b> " + flags[kFLAGS.MARBLE_KIDS] + "\n";

		if (flags[kFLAGS.MINERVA_CHILDREN] > 0)
			childStats += "<b>Children With Minerva:</b> " + flags[kFLAGS.MINERVA_CHILDREN] + "\n";

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

		if (getGame().urtaPregs.urtaKids() > 0)
			childStats += "<b>Children With Urta:</b> " + getGame().urtaPregs.urtaKids() + "\n";

		//Mino sons
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] > 0)
			childStats += "<b>Number of Adult Minotaur Offspring:</b> " + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00326] + "\n";

		//Alraune daughters
		if (flags[kFLAGS.ALRAUNE_SEEDS] > 0)
			childStats += "<b>Alraune daughters:</b> " + flags[kFLAGS.ALRAUNE_SEEDS] + " <b>(Oldest ones: " + (flags[kFLAGS.ALRAUNE_GROWING] - 1) + " days)</b>\n";

		if (childStats != "")
			outputText("\n<b><u>Children</u></b>\n" + childStats);
		// End Children Stats

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
		if (player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SCORPION || player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL || player.tailType == TAIL_TYPE_SPIDER_ADBOMEN || player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS) {
			if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && player.faceType != FACE_SNAKE_FANGS && player.faceType != FACE_SPIDER_FANGS)
				bodyStats += "<b>Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
			else if (player.tailType == TAIL_TYPE_SPIDER_ADBOMEN && (player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS))
				bodyStats += "<b>Venom/Web:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
			else if (player.tailType != TAIL_TYPE_SPIDER_ADBOMEN)
				bodyStats += "<b>Venom:</b> " + player.tailVenom + "/" + player.maxVenom() + "\n";
		}

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
		if (player.findPerk(PerkLib.Diapause) >= 0)
			bodyStats += "? (Variable due to Diapause)\n";
		else {
			if (player.findPerk(PerkLib.MaraesGiftFertility) >= 0) preg++;
			if (player.findPerk(PerkLib.BroodMother) >= 0) preg++;
			if (player.findPerk(PerkLib.FerasBoonBreedingBitch) >= 0) preg++;
			if (player.findPerk(PerkLib.MagicalFertility) >= 0) preg++;
			if (player.findPerk(PerkLib.FerasBoonWideOpen) >= 0 || player.findPerk(PerkLib.FerasBoonMilkingTwat) >= 0) preg++;
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

		}

		if (player.vaginas.length > 0)
			bodyStats += "<b>Vaginal Capacity:</b> " + Math.round(player.vaginalCapacity()) + "\n" + "<b>Vaginal Looseness:</b> " + Math.round(player.looseness()) + "\n";

		if (player.findPerk(PerkLib.SpiderOvipositor) >= 0 || player.findPerk(PerkLib.BeeOvipositor) >= 0)
			bodyStats += "<b>Ovipositor Total Egg Count: " + player.eggs() + "\nOvipositor Fertilized Egg Count: " + player.fertilizedEggs() + "</b>\n";

		if (player.hasStatusEffect(StatusEffects.SlimeCraving)) {
			if (player.statusEffectv1(StatusEffects.SlimeCraving) >= 18)
				bodyStats += "<b>Slime Craving:</b> Active! You are currently losing strength and speed.  You should find fluids.\n";
			else {
				if (player.findPerk(PerkLib.SlimeCore) >= 0)
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

		if (camp.getCampPopulation() > 0)
			miscStats += "<b>Camp Population:</b> " + camp.getCampPopulation() + "\n";

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

		if (miscStats != "")
			outputText("\n<b><u>Miscellaneous Stats</u></b>\n" + miscStats);
		// End Misc Stats

		// Begin Addition Stats
		var addictStats:String = "";
		//Marble Milk Addition
		if (player.statusEffectv3(StatusEffects.Marble) > 0) {
			addictStats += "<b>Marble Milk:</b> ";
			if (player.findPerk(PerkLib.MarbleResistant) < 0 && player.findPerk(PerkLib.MarblesMilk) < 0)
				addictStats += Math.round(player.statusEffectv2(StatusEffects.Marble)) + "%\n";
			else if (player.findPerk(PerkLib.MarbleResistant) >= 0)
				addictStats += "0%\n";
			else
				addictStats += "100%\n";
		}

		// Corrupted Minerva's Cum Addiction
		if (flags[kFLAGS.MINERVA_CORRUPTION_PROGRESS] >= 10 && flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] > 0) {
			addictStats += "<b>Minerva's Cum:</b> " + (flags[kFLAGS.MINERVA_CORRUPTED_CUM_ADDICTION] * 20) + "%";
		}

		// Mino Cum Addiction
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00340] > 0 || flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] > 0 || player.findPerk(PerkLib.MinotaurCumAddict) >= 0 || player.findPerk(PerkLib.MinotaurCumResistance) >= 0 || player.findPerk(PerkLib.ManticoreCumAddict) >= 0) {
			if (player.findPerk(PerkLib.MinotaurCumAddict) < 0)
				addictStats += "<b>Minotaur Cum:</b> " + Math.round(flags[kFLAGS.MINOTAUR_CUM_ADDICTION_TRACKER] * 10) / 10 + "%\n";
			else if (player.findPerk(PerkLib.MinotaurCumResistance) >= 0 || player.findPerk(PerkLib.ManticoreCumAddict) >= 0)
				addictStats += "<b>Minotaur Cum:</b> 0% (Immune)\n";
			else
				addictStats += "<b>Minotaur Cum:</b> 100+%\n";
		}

		if (player.tailType == 28)
			addictStats += "<b>Manticore Hunger:</b> " + flags[kFLAGS.SEXUAL_FLUIDS_LEVEL] + "%\n";

		if (addictStats != "")
			outputText("\n<b><u>Addictions</u></b>\n" + addictStats);
		// End Addition Stats

		// Begin Interpersonal Stats
		var interpersonStats:String = "";

		if (flags[kFLAGS.ARIAN_PARK] > 0)
			interpersonStats += "<b>Arian's Health:</b> " + Math.round(getGame().arianScene.arianHealth()) + "\n";

		if (flags[kFLAGS.ARIAN_VIRGIN] > 0)
			interpersonStats += "<b>Arian Sex Counter:</b> " + Math.round(flags[kFLAGS.ARIAN_VIRGIN]) + "\n";

		if (getGame().bazaar.benoit.benoitAffection() > 0)
			interpersonStats += "<b>" + getGame().bazaar.benoit.benoitMF("Benoit", "Benoite") + " Affection:</b> " + Math.round(getGame().bazaar.benoit.benoitAffection()) + "%\n";

		if (flags[kFLAGS.BROOKE_MET] > 0)
			interpersonStats += "<b>Brooke Affection:</b> " + Math.round(getGame().telAdre.brooke.brookeAffection()) + "\n";

		if (flags[kFLAGS.CEANI_AFFECTION] > 0)
			interpersonStats += "<b>Ceani Affection:</b> " + Math.round(flags[kFLAGS.CEANI_AFFECTION]) + "%\n";
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220] > 0)
			interpersonStats += "<b>Body Parts Taken By Ceraph:</b> " + (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00218] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00219] + flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00220]) + "\n";
		if (flags[kFLAGS.ETNA_AFFECTION] > 0)
			interpersonStats += "<b>Etna Affection:</b> " + Math.round(flags[kFLAGS.ETNA_AFFECTION]) + "%\n";
		if (getGame().emberScene.emberAffection() > 0)
			interpersonStats += "<b>Ember Affection:</b> " + Math.round(getGame().emberScene.emberAffection()) + "%\n";
		if (getGame().helFollower.helAffection() > 0)
			interpersonStats += "<b>Helia Affection:</b> " + Math.round(getGame().helFollower.helAffection()) + "%\n";
		if (getGame().helFollower.helAffection() >= 100)
			interpersonStats += "<b>Helia Bonus Points:</b> " + Math.round(flags[kFLAGS.HEL_BONUS_POINTS]) + "\n";

		if (flags[kFLAGS.ISABELLA_AFFECTION] > 0) {
			interpersonStats += "<b>Isabella Affection:</b> ";

			if (!getGame().isabellaFollowerScene.isabellaFollower())
				interpersonStats += Math.round(flags[kFLAGS.ISABELLA_AFFECTION]) + "%\n", false;
			else
				interpersonStats += "100%\n";
		}

		if (flags[kFLAGS.JOJO_BIMBO_STATE] >= 3) {
			interpersonStats += "<b>Joy's Intelligence:</b> " + flags[kFLAGS.JOY_INTELLIGENCE];
			if (flags[kFLAGS.JOY_INTELLIGENCE] >= 50) interpersonStats += " (MAX)"
			interpersonStats += "\n";
		}

		if (flags[kFLAGS.KATHERINE_UNLOCKED] >= 4) {
			interpersonStats += "<b>Katherine Submissiveness:</b> " + getGame().telAdre.katherine.submissiveness() + "\n";
		}

		if (player.hasStatusEffect(StatusEffects.Kelt) && flags[kFLAGS.KELT_BREAK_LEVEL] == 0 && flags[kFLAGS.KELT_KILLED] == 0) {
			if (player.statusEffectv2(StatusEffects.Kelt) >= 130)
				interpersonStats += "<b>Submissiveness To Kelt:</b> " + 100 + "%\n";
			else
				interpersonStats += "<b>Submissiveness To Kelt:</b> " + Math.round(player.statusEffectv2(StatusEffects.Kelt) / 130 * 100) + "%\n";

		}

		if (flags[kFLAGS.ANEMONE_KID] > 0)
			interpersonStats += "<b>Kid A's Confidence:</b> " + getGame().anemoneScene.kidAXP() + "%\n";

		if (flags[kFLAGS.KIHA_AFFECTION_LEVEL] == 2) {
			if (getGame().kihaFollower.followerKiha())
				interpersonStats += "<b>Kiha Affection:</b> " + 100 + "%\n";
			else
				interpersonStats += "<b>Kiha Affection:</b> " + Math.round(flags[kFLAGS.KIHA_AFFECTION]) + "%\n";
		}

		if (flags[kFLAGS.KINDRA_FOLLOWER] > 0)
			interpersonStats += "<b>Kindra Affection:</b> " + Math.round(flags[kFLAGS.KINDRA_AFFECTION]) + "%\n";

		//Lottie stuff
		if (flags[kFLAGS.UNKNOWN_FLAG_NUMBER_00281] > 0)
			interpersonStats += "<b>Lottie's Encouragement:</b> " + getGame().telAdre.lottie.lottieMorale() + " (higher is better)\n" + "<b>Lottie's Figure:</b> " + getGame().telAdre.lottie.lottieTone() + " (higher is better)\n";

		if (getGame().mountain.salon.lynnetteApproval() != 0)
			interpersonStats += "<b>Lynnette's Approval:</b> " + getGame().mountain.salon.lynnetteApproval() + "\n";

		if (flags[kFLAGS.OWCAS_ATTITUDE] > 0)
			interpersonStats += "<b>Owca's Attitude:</b> " + flags[kFLAGS.OWCAS_ATTITUDE] + "\n";

		if (getGame().telAdre.rubi.rubiAffection() > 0)
			interpersonStats += "<b>Rubi's Affection:</b> " + Math.round(getGame().telAdre.rubi.rubiAffection()) + "%\n" + "<b>Rubi's Orifice Capacity:</b> " + Math.round(getGame().telAdre.rubi.rubiCapacity()) + "%\n";

		if (flags[kFLAGS.SAPPHIRE_AFFECTION] > 0)
			interpersonStats += "<b>Sapphire Affection:</b> " + Math.round(flags[kFLAGS.SAPPHIRE_AFFECTION]) + "%\n";
		
		if (flags[kFLAGS.SHEILA_XP] != 0) {
			interpersonStats += "<b>Sheila's Corruption:</b> " + getGame().sheilaScene.sheilaCorruption();
			if (getGame().sheilaScene.sheilaCorruption() > 100)
				interpersonStats += " (Yes, it can go above 100)";
			interpersonStats += "\n";
		}

		if (getGame().valeria.valeriaFluidsEnabled()) {
			interpersonStats += "<b>Valeria's Fluid:</b> " + flags[kFLAGS.VALERIA_FLUIDS] + "%\n"
		}

		if (flags[kFLAGS.URTA_COMFORTABLE_WITH_OWN_BODY] != 0) {
			if (getGame().urta.urtaLove()) {
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

		// Begin Ongoing Stat Effects
		var statEffects:String = "";

		if (player.inHeat)
			statEffects += "Heat - " + Math.round(player.statusEffectv3(StatusEffects.Heat)) + " hours remaining\n";

		if (player.inRut)
			statEffects += "Rut - " + Math.round(player.statusEffectv3(StatusEffects.Rut)) + " hours remaining\n";

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

		if (player.statusEffectv1(StatusEffects.FeedingEuphoria) > 0)
			statEffects += "Feeding Euphoria - " + player.statusEffectv1(StatusEffects.FeedingEuphoria) + " hours remaining (Speed temporarily increased.)\n";

		if (player.statusEffectv1(StatusEffects.IzumisPipeSmoke) > 0)
			statEffects += "Izumi's Pipe Smoke - " + player.statusEffectv1(StatusEffects.IzumisPipeSmoke) + " hours remaining. (Speed temporarily lowered.)\n";

		if (player.statusEffectv1(StatusEffects.UmasMassage) > 0)
			statEffects += "Uma's Massage - " + player.statusEffectv3(StatusEffects.UmasMassage) + " hours remaining.\n";

		if (player.statusEffectv1(StatusEffects.BathedInHotSpring) > 0)
			statEffects += "Bathed in Hot Spring - " + player.statusEffectv1(StatusEffects.BathedInHotSpring) + " hours remaining. (Fatigue recovery rate 20% higher)\n";

		if (player.statusEffectv1(StatusEffects.Dysfunction) > 0)
			statEffects += "Dysfunction - " + player.statusEffectv1(StatusEffects.Dysfunction) + " hours remaining. (Disables masturbation)\n";

		if (statEffects != "")
			outputText("\n<b><u>Ongoing Status Effects</u></b>\n" + statEffects);
		// End Ongoing Stat Effects
		menu();
		if (player.statPoints > 0) {
			outputText("\n\n<b>You have " + num2Text(player.statPoints) + " attribute point" + (player.statPoints == 1 ? "" : "s") + " to distribute.</b>");
			addButton(1, "Stat Up", attributeMenu);
		}
		doNext(playerMenu);
	}

	//------------
	// LEVEL UP
	//------------
	public function levelUpGo():void {
		clearOutput();
		hideMenus();
		mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
		//Level up
		if (player.XP >= player.requiredXP() && player.level < getGame().levelCap) {
			player.XP -= player.requiredXP();
			player.level++;
			player.perkPoints++;
			//if (player.level % 2 == 0) player.ascensionPerkPoints++;
			//przerobić aby z asc perk co ?6/3/1? lvl dostawać another perk point?
			//może też dodać ascension perk aby móc dostawać 6 lub nawet wiecej stat points na lvl up?
			clearOutput();
			outputText("<b>You are now level " + num2Text(player.level) + "!</b>");
			if (flags[kFLAGS.STAT_GAIN_MODE] ==CoC.STAT_GAIN_CLASSIC) {
				player.statPoints += 5;
				outputText("\n\nYou have gained five attribute points and one perk point!");
			} else {
				outputText("\n\nYou have gained one perk point!");
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
			outputText("<b>ERROR.  LEVEL UP PUSHED WHEN PC CANNOT LEVEL OR GAIN PERKS.  PLEASE REPORT THE STEPS TO REPRODUCE THIS BUG TO FENOXO@GMAIL.COM OR THE FENOXO.COM BUG REPORT FORUM.</b>");
			doNext(playerMenu);
		}
	}

//Attribute menu
	private function attributeMenu():void {
		var maxes:Object = player.getAllMaxStats();
		clearOutput();
		outputText("You have <b>" + (player.statPoints) + "</b> left to spend.\n\n");

		outputText("Strength: ");
		if (player.str < maxes.str) outputText("" + Math.floor(player.str) + " + <b>" + player.tempStr + "</b> → " + Math.floor(player.str + player.tempStr) + "\n");
		else outputText("" + Math.floor(player.str) + " (Maximum)\n");

		outputText("Toughness: ");
		if (player.tou < maxes.tou) outputText("" + Math.floor(player.tou) + " + <b>" + player.tempTou + "</b> → " + Math.floor(player.tou + player.tempTou) + "\n");
		else outputText("" + Math.floor(player.tou) + " (Maximum)\n");

		outputText("Speed: ");
		if (player.spe < maxes.spe) outputText("" + Math.floor(player.spe) + " + <b>" + player.tempSpe + "</b> → " + Math.floor(player.spe + player.tempSpe) + "\n");
		else outputText("" + Math.floor(player.spe) + " (Maximum)\n");

		outputText("Intelligence: ");
		if (player.inte < maxes.inte) outputText("" + Math.floor(player.inte) + " + <b>" + player.tempInt + "</b> → " + Math.floor(player.inte + player.tempInt) + "\n");
		else outputText("" + Math.floor(player.inte) + " (Maximum)\n");

		outputText("Wisdom: ");
		if (player.wis < maxes.wis) outputText("" + Math.floor(player.wis) + " + <b>" + player.tempWis + "</b> → " + Math.floor(player.wis + player.tempWis) + "\n");
		else outputText("" + Math.floor(player.wis) + " (Maximum)\n");

		outputText("Libido: ");
		if (player.lib < maxes.lib) outputText("" + Math.floor(player.lib) + " + <b>" + player.tempLib + "</b> → " + Math.floor(player.lib + player.tempLib) + "\n");
		else outputText("" + Math.floor(player.lib) + " (Maximum)\n");

		menu();
		//Add
		if (player.statPoints > 0) {
			if ((player.str + player.tempStr) < maxes.str) addButton(0, "Add STR", addAttribute, "str", null, null, "Add 1 point (5 points with Shift) to Strength.", "Add Strength");
			if ((player.tou + player.tempTou) < maxes.tou) addButton(1, "Add TOU", addAttribute, "tou", null, null, "Add 1 point (5 points with Shift) to Toughness.", "Add Toughness");
			if ((player.spe + player.tempSpe) < maxes.spe) addButton(2, "Add SPE", addAttribute, "spe", null, null, "Add 1 point (5 points with Shift) to Speed.", "Add Speed");
			if ((player.inte + player.tempInt) < maxes.inte) addButton(3, "Add INT", addAttribute, "int", null, null, "Add 1 point (5 points with Shift) to Intelligence.", "Add Intelligence");
			if ((player.wis + player.tempWis) < maxes.wis) addButton(4, "Add WIS", addAttribute, "wis", null, null, "Add 1 point (5 points with Shift) to Wisdom.", "Add Wisdom");
			if ((player.lib + player.tempLib) < maxes.lib) addButton(10, "Add LIB", addAttribute, "lib", null, null, "Add 1 point (5 points with Shift) to Libido.", "Add Libido");
		}
		//Subtract
		if (player.tempStr > 0) addButton(5, "Sub STR", subtractAttribute, "str", null, null, "Subtract 1 point (5 points with Shift) from Strength.", "Subtract Strength");
		if (player.tempTou > 0) addButton(6, "Sub TOU", subtractAttribute, "tou", null, null, "Subtract 1 point (5 points with Shift) from Toughness.", "Subtract Toughness");
		if (player.tempSpe > 0) addButton(7, "Sub SPE", subtractAttribute, "spe", null, null, "Subtract 1 point (5 points with Shift) from Speed.", "Subtract Speed");
		if (player.tempInt > 0) addButton(8, "Sub INT", subtractAttribute, "int", null, null, "Subtract 1 point (5 points with Shift) from Intelligence.", "Subtract Intelligence");
		if (player.tempWis > 0) addButton(9, "Sub WIS", subtractAttribute, "wis", null, null, "Subtract 1 point (5 points with Shift) from Wisdom.", "Subtract Wisdom");
		if (player.tempLib > 0) addButton(11, "Sub LIB", subtractAttribute, "lib", null, null, "Subtract 1 point (5 points with Shift) from Libido.", "Subtract Libido");

		addButton(13, "Reset", resetAttributes);
		addButton(14, "Done", finishAttributes);
	}

	private function addAttribute(attribute:String):void {
		var maxes:Object = player.getAllMaxStats();
		var n:int=1;
		var m:int;
		if (flags[kFLAGS.SHIFT_KEY_DOWN]) n = 5;
		if (n > player.statPoints) n = player.statPoints;
		switch (attribute) {
			case "str":
				m = maxes.str - int(player.str + player.tempStr);
				if (m < n) n = m;
				player.tempStr+=n;
				break;
			case "tou":
				m = maxes.tou - int(player.tou + player.tempTou);
				if (m < n) n = m;
				player.tempTou+=n;
				break;
			case "spe":
				m = maxes.spe - int(player.spe + player.tempSpe);
				if (m < n) n = m;
				player.tempSpe+=n;
				break;
			case "int":
				m = maxes.inte - int(player.inte + player.tempInt);
				if (m < n) n = m;
				player.tempInt+=n;
				break;
			case "wis":
				m = maxes.wis - int(player.wis + player.tempWis);
				if (m < n) n = m;
				player.tempWis+=n;
				break;
			case "lib":
				m = maxes.lib - int(player.lib + player.tempLib);
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
				player.tempLib--;
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
		clearOutput()
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
		player.str += player.tempStr;
		player.tou += player.tempTou;
		player.spe += player.tempSpe;
		player.inte += player.tempInt;
		player.wis += player.tempWis;
		player.lib += player.tempLib;
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
		if (getGame().testingBlockExiting) {
			menu();
			addButton(0, "Next", perkSelect, perks[rand(perks.length)]);
		} else {
			outputText("Please select a perk from the drop-down list, then click 'Okay'.  You can press 'Skip' to save your perk point for later.\n");
			var perkList:Array = [];
			for each(var perk:PerkType in perks) {
				var p:PerkClass = new PerkClass(perk,
						perk.defaultValue1, perk.defaultValue2, perk.defaultValue3, perk.defaultValue4);
				perkList.push({label: p.perkName, perk: p});
			}
			getGame().showComboBox(perkList,"Choose a perk",perkCbChangeHandler);
			if (player.perkPoints>1) outputText("You have "+numberOfThings(player.perkPoints,"perk point","perk points")+".");
			mainView.hideMenuButton(MainView.MENU_NEW_MAIN);
			menu();
			addButton(1, "Skip", perkSkip);
		}
	}

	private function perkSelect(selected:PerkClass):void {
		mainView.hideComboBox();
		applyPerk(selected);
	}

	private function perkSkip():void {
		mainView.hideComboBox();
		playerMenu();
	}

	public function perkCbChangeHandler(selectedItem:*):void {
		//Store perk name for later addition
		clearOutput();
		var selected:PerkClass = selectedItem.perk;
		outputText("You have selected the following perk:\n");
		outputText("<b>" + selected.perkName + ":</b> " + selected.perkLongDesc);
		getGame().placeComboBoxAfterText();
		var unlocks:Array = getGame().perkTree.listUnlocks(selected.ptype);
		if (unlocks.length > 0) {
			outputText("<b>Unlocks:</b> <ul>");
			for each (var pt:PerkType in unlocks) outputText("<li>" + pt.name + " (" + pt.longDesc + ")</li>");
			outputText("</ul>");
		}
		outputText("If you would like to select this perk, click <b>Okay</b>.  Otherwise, select a new perk, or press <b>Skip</b> to make a decision later.");
		if (player.perkPoints>1) outputText("\n\nYou have "+numberOfThings(player.perkPoints,"perk point","perk points")+".");
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
		if (perk.ptype == PerkLib.StrongBack2) player.itemSlot5.unlocked = true;
		if (perk.ptype == PerkLib.StrongBack) player.itemSlot4.unlocked = true;
		if (perk.ptype == PerkLib.TankI || perk.ptype == PerkLib.TankII || perk.ptype == PerkLib.TankIII || perk.ptype == PerkLib.TankIV || perk.ptype == PerkLib.TankV || perk.ptype == PerkLib.TankVI) {
			HPChange(player.tou, false);
			statScreenRefresh();
		}
		if (player.perkPoints > 0) {
			doNext(perkBuyMenu);
		} else {
			doNext(playerMenu);
		}
	}
}

}
