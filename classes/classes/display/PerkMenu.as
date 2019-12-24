/**
 * Created by aimozg on 22.05.2017.
 */
package classes.display {
import classes.BaseContent;
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.CoC;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.PerkClass;
import classes.PerkLib;
import classes.PerkTree;
import classes.PerkType;
import classes.Scenes.SceneLib;
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
			addButton(button++, "Perk Up", CoC.instance.playerInfo.perkBuyMenu);
		}
		addButton(4, "Database", perkDatabase);
		if (player.hasPerk(PerkLib.DoubleAttack) || player.hasPerk(PerkLib.DoubleAttackLarge) || player.hasPerk(PerkLib.DoubleAttackSmall) || player.hasPerk(PerkLib.Combo) || player.hasPerk(PerkLib.Poisoning) || (player.hasPerk(PerkLib.JobBeastWarrior) && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon()))) {
			outputText("\n<b>You can adjust your melee attack settings.</b>");
			addButton(5, "Melee Opt",doubleAttackOptions);
		}
		if (player.hasPerk(PerkLib.DoubleStrike) || player.hasPerk(PerkLib.ElementalArrows) || player.hasPerk(PerkLib.Cupid) || player.hasPerk(PerkLib.EnvenomedBolt) || player.hasPerk(PerkLib.AmateurGunslinger)) {
			outputText("\n<b>You can adjust your range strike settings.</b>");
			addButton(6, "Range Opt",doubleStrikeOptions);
		}
		if (player.hasPerk(PerkLib.Spellsword) || player.hasPerk(PerkLib.Spellarmor) || player.hasPerk(PerkLib.Battleflash) || player.hasPerk(PerkLib.Battlemage) || player.hasPerk(PerkLib.Battleshield) || player.hasPerk(PerkLib.FortressOfIntellect)) {
			outputText("\n<b>You can adjust your spell autocast settings.</b>");
			addButton(7, "Spells Opt",spellautocastOptions);
		}
		if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
			outputText("\n<b>You can adjust your elemental summons behaviour during combat.</b>");
			addButton(8, "Elementals",summonsbehaviourOptions);
		}
		if (flags[kFLAGS.PERNAMENT_GOLEMS_BAG] > 0 && player.hasPerk(PerkLib.FirstAttackGolems)) {
			outputText("\n<b>You can adjust your pernament golems behaviour during combat.</b>");
			addButton(9, "P.Golems",golemsbehaviourOptions);
		}
		addButton(10, "Number of", EngineCore.doNothing);
		addButton(11, "perks: " + player.perks.length, EngineCore.doNothing);
		if (player.hasPerk(PerkLib.JobLeader)) {
			outputText("\n<b>You can adjust your Will-o'-the-wisp behaviour during combat.</b>");
			addButton(14, "Will-o'-the-wisp",WOTWbehaviourOptions);
		}
	}

	public function doubleAttackOptions():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
        var elementalMelee:Function = curry(setFlag, doubleAttackOptions2, kFLAGS.ELEMENTAL_MELEE);
		var toggleflag:Function = curry(toggleFlag,doubleAttackOptions);
		clearOutput();
		menu();
		outputText("You will always attack ");
		var doubleAttackStyle:Function = curry(setFlag,doubleAttackOptions,kFLAGS.DOUBLE_ATTACK_STYLE);
        var doubleAttackVal:int = flags[kFLAGS.DOUBLE_ATTACK_STYLE];
        if (doubleAttackVal == 9) outputText("ten times");
		if (doubleAttackVal == 8) outputText("nine times");
		if (doubleAttackVal == 7) outputText("eight times");
		if (doubleAttackVal == 6) outputText("seven times");
		if (doubleAttackVal == 5) outputText("six times");
		if (doubleAttackVal == 4) outputText("five times");
		if (doubleAttackVal == 3) outputText("four times");
		if (doubleAttackVal == 2) outputText("three times");
		if (doubleAttackVal == 1) outputText("twice");
		if (doubleAttackVal < 1) outputText("once");
		outputText(" in combat turn.\n\nYou can change it to different amount of attacks.");
		if (player.findPerk(PerkLib.JobBeastWarrior) >= 0 || player.jiangshiScore() >= 20) {
			outputText("\n\nYou can choose between fighting feral or normaly with your fists. (Req. to have natural claws or gaunlet type weapon with claws to enable feral mode)");
			if (flags[kFLAGS.FERAL_COMBAT_MODE] == 0) outputText("\n\nFighting Style: <b>Normal</b>");
			if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1) outputText("\n\nFighting Style: <b>Feral</b>");
		}
		if ((player.hasPerk(PerkLib.Berzerker) || player.hasPerk(PerkLib.Lustzerker)) && player.hasPerk(PerkLib.SalamanderAdrenalGlandsFinalForm)) {
			outputText("\n\nYou can choose between starting fight with berserker, lustzerker, both or none.");
			outputText("\n\nBerzerker: <b>");
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] == 1 || flags[kFLAGS.ZERKER_COMBAT_MODE] == 3) outputText("Autocast");
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] == 0 || flags[kFLAGS.ZERKER_COMBAT_MODE] == 2) outputText("Manual");
			outputText("</b>");
			outputText("\n\nLustzerker: <b>");
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] == 2 || flags[kFLAGS.ZERKER_COMBAT_MODE] == 3) outputText("Autocast");
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] == 0 || flags[kFLAGS.ZERKER_COMBAT_MODE] == 1) outputText("Manual");
			outputText("</b>");
		}
		if (player.findPerk(PerkLib.Poisoning) >= 0) {
			outputText("\n\nIf you can naturaly produce venom then you could add it effects to weapon. (Working only with small weapons)");
			if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 0) outputText("\n\nVenom effect added: <b>No</b>");
			if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 1) outputText("\n\nVenom effect added: <b>Yes</b>");
		}
		if (player.findPerk(PerkLib.SwiftCasting) >= 0) {
			outputText("\n\nIf you learned specific spells you could cast them after doing melee attack. (Working only with one handed weapons and no shield)");
			outputText("\n\nSpell casted: <b>");
			switch(flags[kFLAGS.ELEMENTAL_MELEE]){
				case NONE: outputText("None");break;
				case FIRE: outputText("Whitefire");break;
				case ICE : outputText("Ice Spike") ;break;
				case LIGHTNING: outputText("Lightning Bolt");break;
				case DARKNESS: outputText("Darkness Shard");break;
			}
			outputText("</b>");
		}

        var maxCurrentAttacks:int = combat.maxCurrentAttacks();
		var maxAttacks:int = Math.max(combat.maxFistAttacks(),combat.maxClawsAttacks(),combat.maxSmallAttacks(),combat.maxLargeAttacks(),combat.maxCommonAttacks());

		if (doubleAttackVal != 0) addButton(0, "All Single", doubleAttackStyle,0);
		if (maxAttacks >= 2 && doubleAttackVal != 1) {
			if (maxCurrentAttacks < 2) addButtonDisabled(1, "All Double", "You current melee weapon not allow to use this option");
			else addButton(1, "All Double", doubleAttackStyle,1);
		}
		if (maxAttacks >= 3 && doubleAttackVal != 2) {
			if (maxCurrentAttacks < 3) addButtonDisabled(2, "All Triple", "You current melee weapon not allow to use this option");
			else addButton(2, "All Triple", doubleAttackStyle,2);
		}
		if (maxAttacks >= 4 && doubleAttackVal != 3) {
			if (maxCurrentAttacks < 4) addButtonDisabled(5, "All Quadruple", "You current melee weapon not allow to use this option");
			else addButton(5, "All Quadruple", doubleAttackStyle,3);
		}
		if (maxAttacks >= 5 && doubleAttackVal != 4) {
			if (maxCurrentAttacks < 5) addButtonDisabled(6, "All Penta", "You current melee weapon not allow to use this option");
			else addButton(6, "All Penta", doubleAttackStyle,4);
		}
		if (maxAttacks >= 6 && doubleAttackVal != 5) {
			if (maxCurrentAttacks < 6) addButtonDisabled(7, "All Hexe", "You current melee weapon not allow to use this option");
			else addButton(7, "All Hexa", doubleAttackStyle,5);
		}
		if (maxAttacks >= 7 && doubleAttackVal != 6) {
			if (maxCurrentAttacks < 7) addButtonDisabled(10, "All Hecta", "You current melee weapon not allow to use this option");
			else addButton(10, "All Hecta", doubleAttackStyle,6);
		}
		if (maxAttacks >= 8 && doubleAttackVal != 7) {
			if (maxCurrentAttacks < 8) addButtonDisabled(11, "All Octa", "You current melee weapon not allow to use this option");
			else addButton(11, "All Octa", doubleAttackStyle,7);
		}
		if (maxAttacks >= 9 && doubleAttackVal != 8) {
			if (maxCurrentAttacks < 9) addButtonDisabled(12, "All Nona", "You current melee weapon not allow to use this option");
			else addButton(12, "All Nona", doubleAttackStyle,8);
		}
		if (maxAttacks >= 10 && doubleAttackVal != 9) {
			if (maxCurrentAttacks < 10) addButtonDisabled(13, "All Deca", "You current melee weapon not allow to use this option");
			else addButton(13, "All Deca", doubleAttackStyle,9);
		}
		addButton(9, "Others", doubleAttackOptions2);

		if (CoC.instance.inCombat) addButton(14, "Back", combat.combatMenu);
        else addButton(14, "Back", displayPerks);
	}
	public function doubleAttackOptions2():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
		var toggleflag:Function = curry(toggleFlag, doubleAttackOptions2);
		var zerkingStyle:Function = curry(setFlag, doubleAttackOptions2, kFLAGS.ZERKER_COMBAT_MODE);
		var poisoningStyle:Function = curry(setFlag, doubleAttackOptions2, kFLAGS.ENVENOMED_MELEE_ATTACK);
        var elementalMelee:Function = curry(setFlag, doubleAttackOptions2, kFLAGS.ELEMENTAL_MELEE);
		menu();
		if (player.findPerk(PerkLib.SwiftCasting) >= 0 && flags[kFLAGS.ELEMENTAL_MELEE] != 0) addButton(0, "None", elementalMelee,NONE);
		if (player.findPerk(PerkLib.SwiftCasting) >= 0 && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && flags[kFLAGS.ELEMENTAL_MELEE] != 1) addButton(1, "Fire", elementalMelee,FIRE);
		if (player.findPerk(PerkLib.SwiftCasting) >= 0 && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && flags[kFLAGS.ELEMENTAL_MELEE] != 2) addButton(2, "Ice", elementalMelee,ICE);
		if (player.findPerk(PerkLib.SwiftCasting) >= 0 && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && flags[kFLAGS.ELEMENTAL_MELEE] != 3) addButton(6, "Lightning", elementalMelee,LIGHTNING);
		if (player.findPerk(PerkLib.SwiftCasting) >= 0 && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && flags[kFLAGS.ELEMENTAL_MELEE] != 4) addButton(7, "Darkness", elementalMelee,DARKNESS);
		if (player.findPerk(PerkLib.Poisoning) >= 0
			&& (player.tailType == Tail.BEE_ABDOMEN
			|| player.tailType == Tail.SCORPION
			|| player.tailType == Tail.MANTICORE_PUSSYTAIL
			|| player.faceType == Face.SNAKE_FANGS
			|| player.faceType == Face.SPIDER_FANGS)
			&& flags[kFLAGS.ENVENOMED_MELEE_ATTACK] != 1) {
            addButton(4, "Venom", toggleflag,kFLAGS.ENVENOMED_MELEE_ATTACK,true);
		}
		if (player.findPerk(PerkLib.JobBeastWarrior) >= 0 || player.jiangshiScore() >= 20) {
			if (flags[kFLAGS.FERAL_COMBAT_MODE] != 0) addButton(5, "Normal", toggleflag, kFLAGS.FERAL_COMBAT_MODE, false);
			if (((player.weaponName == "fists" && player.haveNaturalClaws()) || player.haveNaturalClawsTypeWeapon()) && flags[kFLAGS.FERAL_COMBAT_MODE] != 1) addButton(8, "Feral", toggleflag , kFLAGS.FERAL_COMBAT_MODE, true);
			else addButtonDisabled(8, "Feral", "You not meet all req. to use this. Need to not have any melee weapon equipped OR have equipped gaunlet with any type of artifical claws.");
		}
		if (player.findPerk(PerkLib.Poisoning) >= 0 && flags[kFLAGS.ENVENOMED_MELEE_ATTACK] != 0) addButton(9, "None", toggleflag,kFLAGS.ENVENOMED_MELEE_ATTACK,false);
		if ((player.hasPerk(PerkLib.Berzerker) || player.hasPerk(PerkLib.Lustzerker)) && player.hasPerk(PerkLib.SalamanderAdrenalGlandsFinalForm)) {
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 0) addButton(10, "None", zerkingStyle,0);
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 1) addButton(11, "Berserking", zerkingStyle,1);
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 2) addButton(12, "Lustzerking", zerkingStyle,2);
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 3) addButton(13, "Both", zerkingStyle,3);
		}
		addButton(14, "Back", doubleAttackOptions);
	}

	public function doubleStrikeOptions():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
		var toggleflag:Function = curry(toggleFlag,doubleStrikeOptions);
        var doubleStrikeStyle:Function = curry(setFlag,doubleStrikeOptions,kFLAGS.DOUBLE_STRIKE_STYLE);
        var elementalArrows:Function = curry(setFlag,doubleStrikeOptions,kFLAGS.ELEMENTAL_ARROWS);
		clearOutput();
		menu();
		outputText("You will always shoot ");
        var doubleStrikeVal:int = flags[kFLAGS.DOUBLE_STRIKE_STYLE];
        if (doubleStrikeVal == 5) outputText("six");
		if (doubleStrikeVal == 4) outputText("five");
		if (doubleStrikeVal == 3) outputText("four");
		if (doubleStrikeVal == 2) outputText("three");
		if (doubleStrikeVal == 1) outputText("two");
		if (doubleStrikeVal < 1) outputText("single");
		outputText(" projectile");
		if (doubleStrikeVal > 0) outputText("s");
		outputText(" in combat.");
		outputText("\n\nYou can change it to different amount of projectiles.");
		if (player.findPerk(PerkLib.ElementalArrows) >= 0) {
			outputText("\n\nIf you learned specific techniques you could even add some magical effects to the projectiles. (Working only with bows and crosbows)");
			outputText("\n\nElemental effect added: <b>");
			switch(flags[kFLAGS.ELEMENTAL_ARROWS]){
				case NONE: outputText("None");break;
				case FIRE: outputText("Fire");break;
				case ICE : outputText("Ice") ;break;
				case LIGHTNING: outputText("Lightning");break;
				case DARKNESS: outputText("Darkness");break;
			}
			outputText("</b>");
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

        var maxCurrentRangeAttacks:int = combat.maxCurrentRangeAttacks();
		var maxRangeAttacks:int = Math.max(combat.maxFirearmsAttacks(), combat.maxThrowingAttacks(), combat.maxCrossbowAttacks(), combat.maxBowAttacks());

		if (doubleStrikeVal != 0) addButton(0, "All Single", doubleStrikeStyle,0);
		if (maxRangeAttacks >= 2 && doubleStrikeVal != 1) {
			if (maxCurrentRangeAttacks < 2) addButtonDisabled(1, "All Double", "You current range weapon not allow to use this option");
			else addButton(1, "All Double", doubleStrikeStyle,1);
		}
		if (maxRangeAttacks >= 3 && doubleStrikeVal != 2) {
			if (maxCurrentRangeAttacks < 3) addButtonDisabled(2, "All Triple", "You current range weapon not allow to use this option");
			else addButton(2, "All Triple", doubleStrikeStyle,2);
		}
		if (maxRangeAttacks >= 4 && doubleStrikeVal != 3) {
			if (maxCurrentRangeAttacks < 4) addButtonDisabled(5, "All Quad", "You current range weapon not allow to use this option");
			else addButton(5, "All Quad", doubleStrikeStyle,3);
		}
		if (maxRangeAttacks >= 5 && doubleStrikeVal != 4) {
			if (maxCurrentRangeAttacks < 5) addButtonDisabled(6, "All Penta", "You current range weapon not allow to use this option");
			else addButton(6, "All Penta", doubleStrikeStyle,4);
		}
		if (maxRangeAttacks >= 6 && doubleStrikeVal != 5) {
			if (maxCurrentRangeAttacks < 6) addButtonDisabled(7, "All Hexa", "You current range weapon not allow to use this option");
			else addButton(7, "All Hexa", doubleStrikeStyle,5);
		}
		addButton(13, "Enchantments", doubleStrikeOptions2);
        if (CoC.instance.inCombat) addButton(14, "Back", combat.combatMenu);
        else addButton(14, "Back", displayPerks);
	}
	public function doubleStrikeOptions2():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
		var toggleflag:Function = curry(toggleFlag,doubleStrikeOptions2);
        var doubleStrikeStyle:Function = curry(setFlag,doubleStrikeOptions2,kFLAGS.DOUBLE_STRIKE_STYLE);
        var elementalArrows:Function = curry(setFlag,doubleStrikeOptions2,kFLAGS.ELEMENTAL_ARROWS);
		menu();
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && flags[kFLAGS.ELEMENTAL_ARROWS] != 0) addButton(0, "None", elementalArrows,NONE);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && flags[kFLAGS.ELEMENTAL_ARROWS] != 1) addButton(1, "Fire", elementalArrows,FIRE);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && flags[kFLAGS.ELEMENTAL_ARROWS] != 2) addButton(2, "Ice", elementalArrows,ICE);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && flags[kFLAGS.ELEMENTAL_ARROWS] != 3) addButton(6, "Lightning", elementalArrows,LIGHTNING);
		if (player.findPerk(PerkLib.ElementalArrows) >= 0 && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && flags[kFLAGS.ELEMENTAL_ARROWS] != 4) addButton(7, "Darkness", elementalArrows,DARKNESS);
		if (player.findPerk(PerkLib.Cupid) >= 0 && flags[kFLAGS.CUPID_ARROWS] != 0) addButton(10, "None", toggleflag,kFLAGS.CUPID_ARROWS,false);
		if (player.findPerk(PerkLib.Cupid) >= 0 && player.hasStatusEffect(StatusEffects.KnowsArouse) && flags[kFLAGS.CUPID_ARROWS] != 1) addButton(11, "Arouse", toggleflag,kFLAGS.CUPID_ARROWS,true);
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0 && flags[kFLAGS.ENVENOMED_BOLTS] != 0) addButton(12, "None", toggleflag,kFLAGS.ENVENOMED_BOLTS,false);
		if (player.findPerk(PerkLib.EnvenomedBolt) >= 0
			&& (player.tailType == Tail.BEE_ABDOMEN
			|| player.tailType == Tail.SCORPION
			|| player.tailType == Tail.MANTICORE_PUSSYTAIL
			|| player.faceType == Face.SNAKE_FANGS
			|| player.faceType == Face.SPIDER_FANGS)
			&& flags[kFLAGS.ENVENOMED_BOLTS] != 1) {
            addButton(13, "Venom", toggleflag,kFLAGS.ENVENOMED_BOLTS,true);
		}
		addButton(14, "Back", doubleStrikeOptions);
	}

	public function spellautocastOptions():void {
		clearOutput();
		menu();
		var toggleflag:Function = curry(toggleFlag,spellautocastOptions);
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
		if (player.findPerk(PerkLib.Battleshield) >= 0) {
			outputText("\n<b>Mana Shield:</b> ");
			if (flags[kFLAGS.AUTO_CAST_MANA_SHIELD] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.findPerk(PerkLib.FortressOfIntellect) >= 0) {
			outputText("\n<b>Fortress of Intellect:</b> ");
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) outputText("On");
			else outputText("Off");
		}
		if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 0) addButton(0, "Autocast", toggleflag,kFLAGS.AUTO_CAST_CHARGE_WEAPON,false);
		if (player.findPerk(PerkLib.Spellsword) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 1) addButton(5, "Manual", toggleflag,kFLAGS.AUTO_CAST_CHARGE_WEAPON,true);
		if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 0) addButton(1, "Autocast", toggleflag,kFLAGS.AUTO_CAST_CHARGE_ARMOR,false);
		if (player.findPerk(PerkLib.Spellarmor) >= 0 && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 1) addButton(6, "Manual", toggleflag,kFLAGS.AUTO_CAST_CHARGE_ARMOR,true);
		if (flags[kFLAGS.AUTO_CAST_MIGHT] != 0) addButton(2, "Autocast", toggleflag,kFLAGS.AUTO_CAST_MIGHT,false);
		if (player.findPerk(PerkLib.Battlemage) >= 0 && flags[kFLAGS.AUTO_CAST_MIGHT] != 1) addButton(7, "Manual", toggleflag,kFLAGS.AUTO_CAST_MIGHT,true);
		if (flags[kFLAGS.AUTO_CAST_BLINK] != 0) addButton(3, "Autocast", toggleflag,kFLAGS.AUTO_CAST_BLINK,false);
		if (player.findPerk(PerkLib.Battleflash) >= 0 && flags[kFLAGS.AUTO_CAST_BLINK] != 1) addButton(8, "Manual", toggleflag,kFLAGS.AUTO_CAST_BLINK,true);
		if (flags[kFLAGS.AUTO_CAST_MANA_SHIELD] != 0) addButton(4, "Autocast", toggleflag,kFLAGS.AUTO_CAST_MANA_SHIELD,false);
		if (player.findPerk(PerkLib.Battleshield) >= 0 && flags[kFLAGS.AUTO_CAST_MANA_SHIELD] != 1) addButton(9, "Manual", toggleflag,kFLAGS.AUTO_CAST_MANA_SHIELD,true);
		if (player.findPerk(PerkLib.FortressOfIntellect) >= 0 && !player.hasStatusEffect(StatusEffects.FortressOfIntellect)) addButton(12, "FoI On", toggleFortressOfIntelect,true);
		if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) addButton(13, "FoI Off", toggleFortressOfIntelect,false);

		var e:MouseEvent;
		addButton(14, "Back", displayPerks);

		function toggleFortressOfIntelect(on:Boolean):void{
			if(on){player.createStatusEffect(StatusEffects.FortressOfIntellect,0,0,0,0);}
			else{player.removeStatusEffect(StatusEffects.FortressOfIntellect);}
			spellautocastOptions();
		}
	}

	
	public function summonsbehaviourOptions(page:int = 1):void {
        var attackingElementalTypeFlag:int = flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE];
        var elementalConjuerSummons:int = flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS];
        var setflag:Function = curry(setFlag,summonsbehaviourOptions);
        var attackingElementalType:Function = curry(setflag,kFLAGS.ATTACKING_ELEMENTAL_TYPE);
		clearOutput();
		menu();
		outputText("You can choose how your summoned elementals will behave during each fight.\n\n");
		outputText("\n<b>Elementals behavious:</b>\n");
        if (elementalConjuerSummons == 3) outputText("Elemental will attack enemy on it own alongside PC.");
		if (elementalConjuerSummons == 2) outputText("Attacking instead of PC each time melee attack command is chosen.");
		if (elementalConjuerSummons < 2) outputText("Not participating");
		outputText("\n\n<b>Elemental, which would attack in case option to them helping in attacks is enabled:</b>\n");
        switch(attackingElementalTypeFlag){
			case 1: outputText("Air"); break;
            case 2: outputText("Earth"); break;
            case 3: outputText("Fire"); break;
            case 4: outputText("Water"); break;
            case 10: outputText("Ether"); break;
            case 8: outputText("Wood"); break;
            case 9: outputText("Metal"); break;
            case 5: outputText("Ice"); break;
            case 6: outputText("Lightning"); break;
            case 7: outputText("Darkness"); break;
            case 11: outputText("Poison"); break;
            case 12: outputText("Purity"); break;
            case 13: outputText("Corruption"); break;
		}
		if (page == 1) {
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir) && attackingElementalTypeFlag != 1) addButton(0, "Air", attackingElementalType,1);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth) && attackingElementalTypeFlag != 2) addButton(1, "Earth", attackingElementalType,2);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire) && attackingElementalTypeFlag != 3) addButton(2, "Fire", attackingElementalType,3);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater) && attackingElementalTypeFlag != 4) addButton(3, "Water", attackingElementalType,4);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther) && attackingElementalTypeFlag != 10) addButton(4, "Ether", attackingElementalType,10);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood) && attackingElementalTypeFlag != 8) addButton(5, "Wood", attackingElementalType,8);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal) && attackingElementalTypeFlag != 9) addButton(6, "Metal", attackingElementalType, 9);
			addButton(9, "2nd", summonsbehaviourOptions, page + 1);
		}
		if (page == 2)  {
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce) && attackingElementalTypeFlag != 5) addButton(0, "Ice", attackingElementalType,5);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning) && attackingElementalTypeFlag != 6) addButton(1, "Lightning", attackingElementalType,6);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness) && attackingElementalTypeFlag != 7) addButton(2, "Darkness", attackingElementalType,7);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsPoison) && attackingElementalTypeFlag != 11) addButton(3, "Poison", attackingElementalType,11);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity) && attackingElementalTypeFlag != 12) addButton(4, "Purity", attackingElementalType,12);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption) && attackingElementalTypeFlag != 13) addButton(5, "Corruption", attackingElementalType, 13);
			addButton(9, "1st", summonsbehaviourOptions, page - 1);
		}
		if (elementalConjuerSummons > 1) addButton(10, "NotHelping", setflag,kFLAGS.ELEMENTAL_CONJUER_SUMMONS,1);
		if (elementalConjuerSummons != 2 && player.hasStatusEffect(StatusEffects.SummonedElementals)) addButton(11, "MeleeAtk", elementalAttackReplacingPCmeleeAttack);
		if (elementalConjuerSummons != 3 && player.hasStatusEffect(StatusEffects.SummonedElementals) && player.hasPerk(PerkLib.FirstAttackElementals)) addButton(12, "Helping", setflag,kFLAGS.ELEMENTAL_CONJUER_SUMMONS,3);
		if (CoC.instance.inCombat) addButton(14, "Back", combat.combatMenu);
        else addButton(14, "Back", displayPerks);
        function elementalAttackReplacingPCmeleeAttack():void {
            flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 2;
            if (flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE] == 0) {
                menu();
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) addButton(0, "Air", attackingElementalType,1);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) addButton(1, "Earth", attackingElementalType,2);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) addButton(2, "Fire", attackingElementalType,3);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) addButton(3, "Water", attackingElementalType,4);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) addButton(4, "Ether", attackingElementalType,10);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) addButton(5, "Wood", attackingElementalType,8);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) addButton(6, "Metal", attackingElementalType,9);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) addButton(7, "Ice", attackingElementalType,5);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) addButton(8, "Lightning", attackingElementalType,6);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) addButton(9, "Darkness", attackingElementalType,7);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsPoison)) addButton(10, "Poison", attackingElementalType,11);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) addButton(11, "Purity", attackingElementalType,12);
                if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) addButton(12, "Corruption", attackingElementalType,13);
            }
			else summonsbehaviourOptions();
        }
	}



	public function golemsbehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your pernament golems will behave during each fight.\n\n");
		outputText("\n<b>Pernament golems behavious:</b>\n");
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) outputText("Attacking at the begining of each turn (owner would need to just choose how many of them will be sent).");
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] < 1) outputText("Waiting for the owner to give an attack command each turn.");
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) addButton(10, "Waiting", golemsAttacking,false);
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] != 1) addButton(11, "Attacking", golemsAttacking,true);

		var e:MouseEvent;
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu);
		else addButton(14, "Back", displayPerks);
        function golemsAttacking(attacking:Boolean):void {
            flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] = (attacking)?1:0;
            golemsbehaviourOptions();
        }
	}
	
	public function WOTWbehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your will-o'-the-wisp will behave during each fight.\n\n");
		outputText("\n<b>Will-o'-the-wisp behavious:</b>\n");
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) outputText("Commanding other pets or minions (other minions will get boost to dmg).");
		if (flags[kFLAGS.WILL_O_THE_WISP] < 1) outputText("Attacking at the begining of each turn.");
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) addButton(10, "Attacking", WOTWAttacking,false);
		if (flags[kFLAGS.WILL_O_THE_WISP] != 1) addButton(11, "Commanding", WOTWAttacking,true);

		var e:MouseEvent;
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu);
		else addButton(14, "Back", displayPerks);
        function WOTWAttacking(attacking:Boolean):void {
            flags[kFLAGS.WILL_O_THE_WISP] = (attacking)?1:0;
            WOTWbehaviourOptions();
        }
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
		addButton(9, "Back", displayPerks);
	}
    private function toggleFlag(returnTo:Function,flag:int,on:Boolean):void{
        setFlag(returnTo,flag,((on)?1:0));
    }
	private function setFlag(returnTo:Function,flag:int,val:int):void{
		flags[flag] =  val;
		returnTo();
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
