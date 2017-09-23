/**
 * Created by aimozg on 22.05.2017.
 */
package classes.display {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;
import classes.GlobalFlags.kGAMECLASS;
import classes.PerkClass;
import classes.PerkLib;
import classes.PerkTree;
import classes.PerkType;
import classes.StatusEffects;

import flash.events.MouseEvent;

public class PerkMenu extends BaseContent {
	public function PerkMenu() {
	}
	public function displayPerks(e:MouseEvent = null):void {
		var temp:int = 0;
		clearOutput();
		displayHeader("Perks");
		while(temp < player.perks.length) {
			outputText("<b>" + player.perk(temp).perkName + "</b> - " + player.perk(temp).perkDesc + "\n");
			temp++;
		}
		menu();
		var button:int = 0;
		addButton(button++, "Next", playerMenu);
		if (player.perkPoints > 0) {
			outputText("\n<b>You have " + num2Text(player.perkPoints) + " perk point");
			if(player.perkPoints > 1) outputText("s");
			outputText(" to spend.</b>");
			addButton(button++, "Perk Up", kGAMECLASS.playerInfo.perkBuyMenu);
		}
		if (player.findPerk(PerkLib.DoubleAttack) >= 0 || player.findPerk(PerkLib.DoubleAttackLarge) >= 0 || player.findPerk(PerkLib.Combo) >= 0) {
			outputText("\n<b>You can adjust your melee attack settings.</b>");
			addButton(5, "Melee Opt",doubleAttackOptions);
		}
		if (player.findPerk(PerkLib.DoubleStrike) >= 0 || player.findPerk(PerkLib.ElementalArrows) >= 0 || player.findPerk(PerkLib.Cupid) >= 0 || player.findPerk(PerkLib.EnvenomedBolt) >= 0) {
			outputText("\n<b>You can adjust your range strike settings.</b>");
			addButton(6, "Range Opt",doubleStrikeOptions);
		}
		if (player.findPerk(PerkLib.Spellsword) >= 0 || player.findPerk(PerkLib.Spellarmor) >= 0 || player.findPerk(PerkLib.Battleflash) >= 0 || player.findPerk(PerkLib.Battlemage) >= 0 || player.findPerk(PerkLib.FortressOfIntellect) >= 0) {
			outputText("\n<b>You can adjust your spell autocast settings.</b>");
			addButton(7, "Spells Opt",spellautocastOptions);
		}
		if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
			outputText("\n<b>You can adjust your elemental summons behaviour during combat.</b>");
			addButton(8, "Elementals",summonsbehaviourOptions);
		}
		addButton(9, "Database", perkDatabase);
		addButton(10, "Number of", kGAMECLASS.doNothing);
		addButton(11, "perks: " + player.perks.length, kGAMECLASS.doNothing);
	}

	public function doubleAttackOptions():void {
		clearOutput();
		menu();
		outputText("You will always attack ");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) outputText("six times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) outputText("five times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) outputText("four times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) outputText("three times");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) outputText("twice");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] < 1) outputText("once");
		outputText(" in combat turn");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 5) outputText(" using 75% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 4) outputText(" using 80% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 3) outputText(" using 85% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 2) outputText(" using 90% of your current strength");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] == 1) outputText(" using 95% of your current strength");
		outputText(".");
		outputText("\n\nYou can change it to different amount of attacks.");
		if (flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 0) addButton(0, "All Single", singleAttack);
		var maxFistAttacks:int = combat.maxFistAttacks();
		var maxLargeAttacks:int = combat.maxLargeAttacks();
		var maxCommonAttacks:int = combat.maxCommonAttacks();
		var maxCurrentAttacks:int = combat.maxCurrentAttacks();
		var maxAttacks:int = Math.max(maxFistAttacks,maxLargeAttacks,maxCommonAttacks);

		if (maxAttacks >= 2 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 1) {
			if (maxCurrentAttacks < 2) addButtonDisabled(1, "All Double", "You current melee weapon not allow to use this option");
			else addButton(1, "All Double", doubleAttack);
		}
		if (maxAttacks >= 3 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 2) {
			if (maxCurrentAttacks < 3) addButtonDisabled(5, "All Triple", "You current melee weapon not allow to use this option");
			else addButton(5, "All Triple", tripleAttack);
		}
		if (maxAttacks >= 4 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 3) {
			if (maxCurrentAttacks < 4) addButtonDisabled(6, "All Quadruple", "You current melee weapon not allow to use this option");
			else addButton(6, "All Quadruple", quadrupleAttack);
		}
		if (maxAttacks >= 5 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 4) {
			if (maxCurrentAttacks < 5) addButtonDisabled(10, "All Penta", "You current melee weapon not allow to use this option");
			else addButton(10, "All Penta", pentaAttack);
		}
		if (maxAttacks >= 6 && flags[kFLAGS.DOUBLE_ATTACK_STYLE] != 5) {
			if (maxCurrentAttacks < 6) addButtonDisabled(11, "All Hexe", "You current melee weapon not allow to use this option");
			else addButton(11, "All Hexe", hexaAttack);
		}

		if (getGame().inCombat) addButton(14, "Back", combat.combatMenu);
		else addButton(14, "Back", displayPerks);
	}

	public function hexaAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 5;
		doubleAttackOptions();
	}
	public function pentaAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 4;
		doubleAttackOptions();
	}
	public function quadrupleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 3;
		doubleAttackOptions();
	}
	public function tripleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 2;
		doubleAttackOptions();
	}
	public function doubleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 1;
		doubleAttackOptions();
	}
	public function singleAttack():void {
		flags[kFLAGS.DOUBLE_ATTACK_STYLE] = 0;
		doubleAttackOptions();
	}

	public function doubleStrikeOptions():void {
		clearOutput();
		menu();
		outputText("You will always shoot ");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 5) outputText("six");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 4) outputText("five");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 3) outputText("four");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 2) outputText("three");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] == 1) outputText("two");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] < 1) outputText("single");
		outputText(" projectile");
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] > 0) outputText("s");
		outputText(" in combat.");
		outputText("\n\nYou can change it to different amount of projectiles.");
		if (player.findPerk(PerkLib.ElementalArrows) >= 0) {
			outputText("\n\nIf you learned specific techniques you could even add some magical effects to the projectiles. (Working only with bows and crosbows)");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 0) outputText("\n\nElemental effect added: <b>None</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 1) outputText("\n\nElemental effect added: <b>Fire</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 2) outputText("\n\nElemental effect added: <b>Ice</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 3) outputText("\n\nElemental effect added: <b>Lightning</b>");
			if (flags[kFLAGS.ELEMENTAL_ARROWS] == 4) outputText("\n\nElemental effect added: <b>Dakness</b>");
		}
		if (player.findPerk(PerkLib.Cupid) >= 0) {
			outputText("\n\nIf you learned specific black magical you could add it effects to the projectiles. (Working only with bows and crosbows)");
			if (flags[kFLAGS.CUPID_ARROWS] == 0) outputText("\n\nBlack Magic effect added: <b>None</b>");
			if (flags[kFLAGS.CUPID_ARROWS] == 1) outputText("\n\nBlack Magic effect added: <b>Arouse</b>");
		}
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0) {
			outputText("\n\nIf you can naturaly produce venom then you could add it effects to the projectiles. (Working only with bows and crosbows)");
			if (flags[kFLAGS.ENVENOMED_BOLTS] == 0) outputText("\n\nVenom effect added: <b>No</b>");
			if (flags[kFLAGS.ENVENOMED_BOLTS] == 1) outputText("\n\nVenom effect added: <b>Yes</b>");
		}
		if (flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 0) addButton(0, "All Single", singleStrike);
		var maxThrowingAttacks:int = combat.maxThrowingAttacks();
		var maxCrossbowAttacks:int = combat.maxCrossbowAttacks();
		var maxBowAttacks:int = combat.maxBowAttacks();
		var maxCurrentRangeAttacks:int = combat.maxCurrentRangeAttacks();
		var maxRangeAttacks:int = Math.max(maxThrowingAttacks, maxCrossbowAttacks, maxBowAttacks);
		
		if (maxRangeAttacks >= 2 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 1) {
			if (maxCurrentRangeAttacks < 2) addButtonDisabled(1, "All Double", "You current range weapon not allow to use this option");
			else addButton(1, "All Double", doubleStrike);
		}
		if (maxRangeAttacks >= 3 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 2) {
			if (maxCurrentRangeAttacks < 3) addButtonDisabled(2, "All Triple", "You current range weapon not allow to use this option");
			else addButton(2, "All Triple", tripleStrike);
		}
		if (maxRangeAttacks >= 4 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 3) {
			if (maxCurrentRangeAttacks < 4) addButtonDisabled(5, "All Quad", "You current range weapon not allow to use this option");
			else addButton(5, "All Quad", quadrupleStrike);
		}
		if (maxRangeAttacks >= 5 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 4) {
			if (maxCurrentRangeAttacks < 5) addButtonDisabled(6, "All Penta", "You current range weapon not allow to use this option");
			else addButton(6, "All Penta", pentaStrike);
		}
		if (maxRangeAttacks >= 6 && flags[kFLAGS.DOUBLE_STRIKE_STYLE] != 5) {
			if (maxCurrentRangeAttacks < 6) addButtonDisabled(7, "All Hexa", "You current range weapon not allow to use this option");
			else addButton(7, "All Hexa", hexaStrike);
		}
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && flags[kFLAGS.ELEMENTAL_ARROWS] != 0) addButton(3, "None", normalArrows);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && flags[kFLAGS.ELEMENTAL_ARROWS] != 1) addButton(8, "Fire", fireArrows);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && flags[kFLAGS.ELEMENTAL_ARROWS] != 2) addButton(9, "Ice", iceArrows);
		if (player.findPerk(PerkLib.Cupid) >= 0 && flags[kFLAGS.CUPID_ARROWS] != 0) addButton(10, "None", normalArrows2);
		if (player.findPerk(PerkLib.Cupid) >= 0 && player.hasStatusEffect(StatusEffects.KnowsArouse) && flags[kFLAGS.CUPID_ARROWS] != 1) addButton(11, "Arouse", arouseArrows);
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0 && flags[kFLAGS.ENVENOMED_BOLTS] != 0) addButton(12, "None", normalArrows3);
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0 && (player.tailType == TAIL_TYPE_BEE_ABDOMEN || player.tailType == TAIL_TYPE_SCORPION || player.tailType == TAIL_TYPE_MANTICORE_PUSSYTAIL || player.faceType == FACE_SNAKE_FANGS || player.faceType == FACE_SPIDER_FANGS) && flags[kFLAGS.ENVENOMED_BOLTS] != 1) addButton(13, "Venom", venomArrows);

		var e:MouseEvent;
		if (getGame().inCombat) addButton(14, "Back", combat.combatMenu);
		else addButton(14, "Back", displayPerks);
	}

	public function darknessArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 4;
		doubleStrikeOptions();
	}
	public function lightningArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 3;
		doubleStrikeOptions();
	}
	public function iceArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 2;
		doubleStrikeOptions();
	}
	public function fireArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 1;
		doubleStrikeOptions();
	}
	public function normalArrows():void {
		flags[kFLAGS.ELEMENTAL_ARROWS] = 0;
		doubleStrikeOptions();
	}
	public function arouseArrows():void {
		flags[kFLAGS.CUPID_ARROWS] = 1;
		doubleStrikeOptions();
	}
	public function normalArrows2():void {
		flags[kFLAGS.CUPID_ARROWS] = 0;
		doubleStrikeOptions();
	}
	public function venomArrows():void {
		flags[kFLAGS.ENVENOMED_BOLTS] = 1;
		doubleStrikeOptions();
	}
	public function normalArrows3():void {
		flags[kFLAGS.ENVENOMED_BOLTS] = 0;
		doubleStrikeOptions();
	}
	public function hexaStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 5;
		doubleStrikeOptions();
	}
	public function pentaStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 4;
		doubleStrikeOptions();
	}
	public function quadrupleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 3;
		doubleStrikeOptions();
	}
	public function tripleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 2;
		doubleStrikeOptions();
	}
	public function doubleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 1;
		doubleStrikeOptions();
	}
	public function singleStrike():void {
		flags[kFLAGS.DOUBLE_STRIKE_STYLE] = 0;
		doubleStrikeOptions();
	}

	public function spellautocastOptions():void {
		clearOutput();
		menu();
		outputText("You can choose to autocast or not specific buff spells at the start of each combat.\n");
		if (player.findPerk(PerkLib.Spellsword) >= 0) {
			outputText("\n<b>Charge Weapon:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.Spellarmor) >= 0) {
			outputText("\n<b>Charge Armor:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.Battlemage) >= 0) {
			outputText("\n<b>Might:</b> ");
			if (flags[kFLAGS.AUTO_CAST_MIGHT] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.Battleflash) >= 0) {
			outputText("\n<b>Blink:</b> ");
			if (flags[kFLAGS.AUTO_CAST_BLINK] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.FortressOfIntellect) >= 0) {
			outputText("\n<b>Fortress of Intellect:</b> ");
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) outputText("On");
			else outputText("Off");
		}
		if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 0) addButton(0, "Autocast", autoChargeWeapon);
		if (player.findPerk(PerkLib.Spellsword) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 1) addButton(5, "Manual", manualChargeWeapon);
		if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 0) addButton(1, "Autocast", autoChargeArmor);
		if (player.findPerk(PerkLib.Spellarmor) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 1) addButton(6, "Manual", manualChargeArmor);
		if (flags[kFLAGS.AUTO_CAST_MIGHT] != 0) addButton(2, "Autocast", autoMight);
		if (player.findPerk(PerkLib.Battlemage) >= 0 && flags[kFLAGS.AUTO_CAST_MIGHT] != 1) addButton(7, "Manual", manualMight);
		if (flags[kFLAGS.AUTO_CAST_BLINK] != 0) addButton(3, "Autocast", autoBlink);
		if (player.findPerk(PerkLib.Battleflash) >= 0 && flags[kFLAGS.AUTO_CAST_BLINK] != 1) addButton(8, "Manual", manualBlink);
		if (player.findPerk(PerkLib.FortressOfIntellect) >= 0 && !player.hasStatusEffect(StatusEffects.FortressOfIntellect)) addButton(12, "FoI On", toggleOnFortressOfIntelect);
		if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) addButton(13, "FoI Off", toggleOffFortressOfIntelect);

		var e:MouseEvent;
		addButton(14, "Back", displayPerks);
	}

	public function manualBlink():void {
		flags[kFLAGS.AUTO_CAST_BLINK] = 1;
		spellautocastOptions();
	}
	public function autoBlink():void {
		flags[kFLAGS.AUTO_CAST_BLINK] = 0;
		spellautocastOptions();
	}
	public function manualMight():void {
		flags[kFLAGS.AUTO_CAST_MIGHT] = 1;
		spellautocastOptions();
	}
	public function autoMight():void {
		flags[kFLAGS.AUTO_CAST_MIGHT] = 0;
		spellautocastOptions();
	}
	public function manualChargeArmor():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] = 1;
		spellautocastOptions();
	}
	public function autoChargeArmor():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] = 0;
		spellautocastOptions();
	}
	public function manualChargeWeapon():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] = 1;
		spellautocastOptions();
	}
	public function autoChargeWeapon():void {
		flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] = 0;
		spellautocastOptions();
	}
	public function toggleOnFortressOfIntelect():void {
		player.createStatusEffect(StatusEffects.FortressOfIntellect,0,0,0,0);
		spellautocastOptions();
	}
	public function toggleOffFortressOfIntelect():void {
		player.removeStatusEffect(StatusEffects.FortressOfIntellect);
		spellautocastOptions();
	}
	
	public function summonsbehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your summoned elementals will behave during each fight.\n\n");
		outputText("\n<b>Elementals behavious:</b>\n");
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 3) outputText("Elemental will attack enemy on it own alongside PC.");
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] == 2) outputText("Attacking instead of PC each time melee attack command is chosen.");
		else outputText("Not participating");
		outputText("\n\n<b>Elemental, which would attack in case option to them helping in attacks is enabled:</b>\n");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 1) outputText("Air");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 2) outputText("Earth");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 3) outputText("Fire");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 4) outputText("Water");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 10) outputText("Ether");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 8) outputText("Wood");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 9) outputText("Metal");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 5) outputText("Ice");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 6) outputText("Lightning");
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 7) outputText("Darkness");
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 1) addButton(0, "Air", attackingElementalAir);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 2) addButton(1, "Earth", attackingElementalEarth);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 3) addButton(2, "Fire", attackingElementalFire);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 4) addButton(3, "Water", attackingElementalWater);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 10) addButton(4, "Ether", attackingElementalEther);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 8) addButton(5, "Wood", attackingElementalWood);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 9) addButton(6, "Metal", attackingElementalMetal);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 5) addButton(7, "Ice", attackingElementalIce);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 6) addButton(8, "Lightning", attackingElementalLightning);
		if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness) && flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] != 7) addButton(9, "Darkness", attackingElementalDarkness);
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] > 1) addButton(10, "NotHelping", elementalNotAttacking);
		if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] != 2 && player.hasStatusEffect(StatusEffects.SummonedElementals)) addButton(11, "MeleeAtk", elementalAttackReplacingPCmeleeAttack);
	//	if (flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] != 3 && player.hasStatusEffect(StatusEffects.SummonedElementals)) addButton(12, "Helping", elementalAttackingAlongsidePC);//dodatkowy perk wymagano do tej opcji

		var e:MouseEvent;
		if (getGame().inCombat) addButton(14, "Back", combat.combatMenu);
		else addButton(14, "Back", displayPerks);
	}

	public function elementalNotAttacking():void {
		flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 1;
		summonsbehaviourOptions();
	}
	public function elementalAttackReplacingPCmeleeAttack():void {
		flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 2;
		if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 0) {
			menu();
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) addButton(0, "Air", attackingElementalAir);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) addButton(1, "Earth", attackingElementalEarth);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) addButton(2, "Fire", attackingElementalFire);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) addButton(3, "Water", attackingElementalWater);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) addButton(4, "Ether", attackingElementalEther);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) addButton(5, "Wood", attackingElementalWood);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) addButton(6, "Metal", attackingElementalMetal);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) addButton(7, "Ice", attackingElementalIce);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) addButton(8, "Lightning", attackingElementalLightning);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) addButton(9, "Darkness", attackingElementalDarkness);
		}
		summonsbehaviourOptions();
	}
	public function elementalAttackingAlongsidePC():void {
		flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 3;
		summonsbehaviourOptions();
	}
	public function attackingElementalAir():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 1;
		summonsbehaviourOptions();
	}
	public function attackingElementalEarth():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 2;
		summonsbehaviourOptions();
	}
	public function attackingElementalFire():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 3;
		summonsbehaviourOptions();
	}
	public function attackingElementalWater():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 4;
		summonsbehaviourOptions();
	}
	public function attackingElementalIce():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 5;
		summonsbehaviourOptions();
	}
	public function attackingElementalLightning():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 6;
		summonsbehaviourOptions();
	}
	public function attackingElementalDarkness():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 7;
		summonsbehaviourOptions();
	}
	public function attackingElementalWood():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 8;
		summonsbehaviourOptions();
	}
	public function attackingElementalMetal():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 9;
		summonsbehaviourOptions();
	}
	public function attackingElementalEther():void {
		flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] = 10;
		summonsbehaviourOptions();
	}

	public function perkDatabase(page:int=0, count:int=20):void {
		var allPerks:Array = PerkTree.obtainablePerks();
		clearOutput();
		var perks:Array = allPerks.slice(page*count,(page+1)*count);
		displayHeader("All Perks ("+(1+page*count)+"-"+(page*count+perks.length)+
					  "/"+allPerks.length+")");
		for each (var ptype:PerkType in perks) {
			var pclass:PerkClass = player.perk(player.findPerk(ptype));

			var color:String;
			if (pclass) color=(darkTheme()?'#ffffff':'#000000'); // has perk
			else if (ptype.available(player)) color=darkTheme()?'#44cc44':'#228822'; // can take on next lvl
			else color=darkTheme()?'#ffcc44':'#aa8822'; // requirements not met

			outputText("<font color='" +color +"'><b>"+ptype.name+"</b></font>: ");
			outputText(pclass?ptype.desc(pclass):ptype.longDesc);
			if (!pclass && ptype.requirements.length>0) {
				var reqs:Array = [];
				for each (var cond:Object in ptype.requirements) {
					if (cond.fn(player)) color=(darkTheme()?'#ffffff':'#000000');
					else color=darkTheme()?'#ff4444':'#aa2222';
					reqs.push("<font color='"+color+"'>"+cond.text+"</font>");
				}
				outputText("<ul><li><b>Requires:</b> " + reqs.join(", ")+".</li></ul>");
			} else {
				outputText("\n");
			}
		}
		if (page>0) addButton(0,"Prev",perkDatabase,page-1);
		else addButtonDisabled(0,"Prev");
		if (page*count<allPerks.length) addButton(1,"Next",perkDatabase,page+1);
		else addButtonDisabled(1,"Next");
		addButton(9, "Back", playerMenu);
	}
	/* [INTERMOD: revamp]
	 public function ascToleranceOption():void{
	 clearOutput();
	 menu();
	 if (player.perkv2(PerkLib.AscensionTolerance) == 0){
	 outputText("Corruption Tolerance is under effect, giving you " + player.corruptionTolerance() + " tolerance on most corruption events." +
	 "\n\nYou can disable this perk's effects at any time.<b>Some camp followers may leave you immediately after doing this. Save beforehand!</b>");
	 addButton(0, "Disable", disableTolerance);
	 }else addButtonDisabled(0, "Disable", "The perk is already disabled.");
	 if (player.perkv2(PerkLib.AscensionTolerance) == 1){
	 outputText("Ascension Tolerance is not under effect. You may enable it at any time.");
	 addButton(1, "Enable", enableTolerance);
	 }else addButtonDisabled(1, "Enable", "The perk is already enabled.");
	 addButton(4, "Back", displayPerks);
	 }

	 public function disableTolerance():void{
	 player.setPerkValue(PerkLib.AscensionTolerance, 2, 1);
	 ascToleranceOption();
	 }
	 public function enableTolerance():void{
	 player.setPerkValue(PerkLib.AscensionTolerance, 2, 0);
	 ascToleranceOption();
	 }
	 */

}
}
