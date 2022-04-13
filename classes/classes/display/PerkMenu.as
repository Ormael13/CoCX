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
import classes.MutationsLib;
import classes.PerkTree;
import classes.PerkType;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.StatusEffects;
import flash.utils.Dictionary;
import flash.events.TextEvent;

import flash.events.MouseEvent;

public class PerkMenu extends BaseContent {
	public function PerkMenu() {
	}
	public function displayPerks(e:MouseEvent = null):void {
		clearOutput();
		displayHeader("Perks (Total: " + player.perks.length + ")");
		if (flags[kFLAGS.NEWPERKSDISPLAY] >= 1){
			playerPerksList();
		}
		else{
			var perkList:Array = player.perks;
			for each (var temp:PerkClass in perkList){
				try{
					outputText("<b>" + temp.perkName + "</b> - " + temp.perkDesc + "\n");

				} catch (error:Error) {
					outputText(temp.perkName + " has encountered a problem. PLEASE REPORT THIS.");
					trace("Something about " + temp.perkName + " is broken. Might wanna check that?");
				}
			}
		}

		menu();
		addButton(0, "Next", playerMenu);
		if (player.perkPoints > 0) {
			outputText("\n<b>You have " + num2Text(player.perkPoints) + " perk point");
			if(player.perkPoints > 1) outputText("s");
			outputText(" to spend.</b>");
			addButton(1, "Perk Up", CoC.instance.playerInfo.perkBuyMenu);
		}
		if (player.superPerkPoints > 0) {
			outputText("\n<b>You have " + num2Text(player.superPerkPoints) + " super perk point");
			if(player.superPerkPoints > 1) outputText("s");
			outputText(" to spend.</b>");
		}
		addButton(2, "SuperPerk Up", CoC.instance.playerInfo.superPerkBuyMenu);
		addButton(3, "Mutations DB", mutationsDatabase, 0, true);
		addButton(4, "Perks Database", perkDatabase);
		if (player.hasPerk(PerkLib.DoubleAttack) || player.hasPerk(PerkLib.DoubleAttackLarge) || player.hasPerk(PerkLib.DoubleAttackSmall) || player.hasPerk(PerkLib.Combo) || combat.canSpearDance() ||player.hasPerk(PerkLib.Poisoning) || player.hasPerk(PerkLib.SwiftCasting) ||
			(player.hasPerk(PerkLib.JobBeastWarrior) && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon())) || player.hasPerk(PerkLib.NaturalInstincts) || player.hasPerk(PerkLib.WayOfTheWarrior) || player.hasPerk(PerkLib.Berzerker) ||
			((player.hasPerk(PerkLib.Lustzerker)) && player.hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved)) || player.hasPerk(PerkLib.LikeAnAsuraBoss) || TyrantiaFollower.TyrantiaTrainingSessions >= 20 || player.jiangshiScore() >= 20) {
			outputText("\n<b>You can adjust your melee attack settings.</b>");
			addButton(5, "Melee Opt",doubleAttackOptions);
		}
		if (player.hasPerk(PerkLib.DoubleStrike) || player.hasPerk(PerkLib.ElementalArrows) || player.hasPerk(PerkLib.Cupid) || player.hasPerk(PerkLib.EnvenomedBolt) || player.hasPerk(PerkLib.AmateurGunslinger)) {
			outputText("\n<b>You can adjust your range strike settings.</b>");
			addButton(6, "Range Opt",doubleStrikeOptions);
		}
		if (player.hasPerk(PerkLib.Venomancy) || player.hasPerk(PerkLib.DarkRitual) || player.hasPerk(PerkLib.HiddenJobBloodDemon)||
			(player.hasPerk(PerkLib.Spellsword) || player.hasPerk(PerkLib.Spellarmor) || player.hasPerk(PerkLib.Battleflash) || player.hasPerk(PerkLib.Battlemage) || player.hasPerk(PerkLib.Battleshield) || player.hasPerk(PerkLib.FortressOfIntellect))) {
			outputText("\n<b>You can choose and adjust various effects related to your magic.</b>");
			addButton(7, "Magic Opt",MagicOption);
		}
		if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
			outputText("\n<b>You can adjust your elemental summons behaviour during combat.</b>");
			addButton(8, "Elementals",summonsbehaviourOptions);
		}
		if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0 && player.hasPerk(PerkLib.FirstAttackGolems)) {
			outputText("\n<b>You can adjust your permanent golems behaviour during combat.</b>");
			addButton(9, "P.Golems",golemsbehaviourOptions);
		}
		//addButton(10, "Number of", EngineCore.doNothing);
		//addButton(11, "perks: " + player.perks.length, EngineCore.doNothing);
		if (player.hasPerk(PerkLib.LiftOff)) {
			outputText("\n<b>You can choose and adjust various misc effects.</b>");
			addButton(12, "Misc Opt",MiscOption);
		}
		addButton (13, "PerkDB2", perkDatabase2); //WIP.
		if (player.hasPerk(PerkLib.JobLeader)) {
			outputText("\n<b>You can adjust your Will-o'-the-wisp behaviour during combat.</b>");
			addButton(14, "Will-o'-the-wisp",WOTWbehaviourOptions);
		}
	}

	public function MagicOption(e:MouseEvent = null):void {
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.Venomancy)) {
			outputText("\n<b>You can adjust your Venomancy.</b>");
			addButton(1, "Venomancy Opt",VenomancyOption);
		}
		if (player.hasPerk(PerkLib.Spellsword) || player.hasPerk(PerkLib.Spellarmor) || player.hasPerk(PerkLib.Battleflash) || player.hasPerk(PerkLib.Battlemage) || player.hasPerk(PerkLib.Battleshield) || player.hasPerk(PerkLib.FortressOfIntellect)) {
			outputText("\n<b>You can adjust your spell autocast settings.</b>");
			addButton(2, "Spells Opt",spellautocastOptions);
		}
		if (player.hasPerk(PerkLib.DarkRitual) || player.hasPerk(PerkLib.HiddenJobBloodDemon)) {
			if (player.hasPerk(PerkLib.DarkRitual)) outputText("\n<b>You can choose if you wish to use dark ritual and sacrifice health to empower your magic.</b>");
			if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) outputText("\n<b>You can adjust your Blood Demon hidden job settings.</b>");
			addButton(3, "Bloody Opt",DarkRitualOption);
		}
		addButton(14, "Back", displayPerks);
	}

	public function MiscOption(e:MouseEvent = null):void {
		clearOutput();
		menu();
		var autoFlyingFlag:int = flags[kFLAGS.AUTO_FLIGHT];
        var setflag:Function = curry(setFlag,MiscOption);
		var autoFlyingType:Function = curry(setflag,kFLAGS.AUTO_FLIGHT);
        if (player.hasPerk(PerkLib.LiftOff)) {
			outputText("You can choose to start flying or not at the start of each combat.\n");
			outputText("Start ");
			switch(autoFlyingFlag) {
				case 0: outputText("on the ground"); break;
				case 1: outputText("flying (by wings)"); break;
				case 2: outputText("flying (on flying sword)"); break;
				case 3: outputText("flying (using soulforce)"); break;
			}
		}
		if (autoFlyingFlag != 0) addButton(0, "On Ground", autoFlyingType,0);
		if (player.canFly() && autoFlyingFlag != 1) addButton(1, "By Wings", autoFlyingType,1);
		if (player.hasPerk(PerkLib.FlyingSwordPath) && autoFlyingFlag != 2) addButton(2, "By FlyingS", autoFlyingType,2);
		if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor) && autoFlyingFlag != 3) addButton(3, "By SF", autoFlyingType,3);
		addButton(14, "Back", displayPerks);
	}

	public function doubleAttackOptions():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
		const WATER:int = 5;
		const WIND:int = 6;
		const EARTH:int = 7;
		const ACID:int = 8;
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
		if (player.hasPerk(PerkLib.JobBeastWarrior) || player.jiangshiScore() >= 20) {
			outputText("\n\nYou can choose between fighting feral or normaly with your fists. (Req. to have natural attacks or a gaunlet type weapon with claws to enable feral mode)");
			if (flags[kFLAGS.FERAL_COMBAT_MODE] == 0) outputText("\n\nFighting Style: <b>Normal</b>");
			if (flags[kFLAGS.FERAL_COMBAT_MODE] == 1) outputText("\n\nFighting Style: <b>Feral</b>");
		}
		if ((player.hasPerk(PerkLib.Berzerker) || player.hasPerk(PerkLib.Lustzerker)) && player.hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved)) {
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
		if (player.hasPerk(PerkLib.NaturalInstincts)) {
			outputText("\n\nYou can choose between starting fight with Crinos Shape active or not.");
			outputText("\n\nCrinos Shape: <b>");
			if (flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] == 1) outputText("Autocast");
			if (flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] == 0) outputText("Manual");
			outputText("</b>");
		}
		if (player.hasPerk(PerkLib.WayOfTheWarrior)) {
			outputText("\n\nYou can choose between starting fight with warrior's rage active or not.");
			outputText("\n\nWarrior's Rage: <b>");
			if (flags[kFLAGS.WARRIORS_RAGE_COMBAT_MODE] == 1) outputText("Autocast");
			if (flags[kFLAGS.WARRIORS_RAGE_COMBAT_MODE] == 0) outputText("Manual");
			outputText("</b>");
		}
		if (TyrantiaFollower.TyrantiaTrainingSessions >= 20) {
			outputText("\n\nYou can choose between starting fight with Tyrant State active or not.");
			outputText("\n\nTyrant State: <b>");
			if (flags[kFLAGS.TYRANT_STATE_COMBAT_MODE] == 1) outputText("Autocast");
			if (flags[kFLAGS.TYRANT_STATE_COMBAT_MODE] == 0) outputText("Manual");
			outputText("</b>");
		}
		if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
			outputText("\n\nYou can choose between starting fight with Asura form active or not. (If Crinos Shape toggle is set on Autocast this one toggle will be ignored and only crinos Shape would be autocasted)");//"+(player.hasPerk(PerkLib.)?"":"")+"
			outputText("\n\nAsura Form: <b>");
			if (flags[kFLAGS.ASURA_FORM_COMBAT_MODE] == 1) outputText("Autocast");
			if (flags[kFLAGS.ASURA_FORM_COMBAT_MODE] == 0) outputText("Manual");
			outputText("</b>");
		}
		if (player.hasPerk(PerkLib.Poisoning)) {
			outputText("\n\nIf you can naturaly produce venom then you could add it effects to weapon. (Working only with small weapons)");
			if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 0) outputText("\n\nVenom effect added: <b>No</b>");
			if (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] == 1) outputText("\n\nVenom effect added: <b>Yes</b>");
		}
		if (player.hasPerk(PerkLib.SwiftCasting)) {
			outputText("\n\nIf you learned specific spells you could cast them after doing melee attack. (Working only with one handed weapons and no shield)");
			outputText("\n\nSpell casted: <b>");
			switch(flags[kFLAGS.ELEMENTAL_MELEE]){
				case NONE: outputText("None");break;
				case FIRE: outputText("Whitefire");break;
				case ICE : outputText("Ice Spike") ;break;
				case LIGHTNING: outputText("Lightning Bolt");break;
				case DARKNESS: outputText("Darkness Shard");break;
				case WATER: outputText("Water Ball");break;
				case WIND: outputText("Wind Bullet");break;
				case EARTH: outputText("Darkness Shard");break;
				case ACID: outputText("Darkness Shard");break;
			}
			outputText("</b>");
		}

        var maxCurrentAttacks:int = combat.maxCurrentAttacks();
		var maxAttacks:int = Math.max(combat.maxFistAttacks(),combat.maxClawsAttacks(),combat.maxSmallAttacks(),combat.maxLargeAttacks(),combat.maxCommonAttacks(), maxCurrentAttacks);

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

		addButton(4, "Others(1)", doubleAttackOptions2);
		addButton(9, "Others(2)", doubleAttackOptions3);

		if (CoC.instance.inCombat) addButton(14, "Back", combat.combatMenu, false);
        else addButton(14, "Back", displayPerks);
	}
	public function doubleAttackOptions2():void {
		var toggleflag:Function = curry(toggleFlag, doubleAttackOptions2);
		var zerkingStyle:Function = curry(setFlag, doubleAttackOptions2, kFLAGS.ZERKER_COMBAT_MODE);
		menu();
		if (player.hasPerk(PerkLib.NaturalInstincts)) {
			if (flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] != 0) addButton(0, "Manual", toggleflag,kFLAGS.CRINOS_SHAPE_COMBAT_MODE,false);
			if (flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] != 1) addButton(5, "Autocast", toggleflag,kFLAGS.CRINOS_SHAPE_COMBAT_MODE,true);
		}
		if (player.hasPerk(PerkLib.WayOfTheWarrior)) {
			if (flags[kFLAGS.WARRIORS_RAGE_COMBAT_MODE] != 0) addButton(1, "Manual", toggleflag,kFLAGS.WARRIORS_RAGE_COMBAT_MODE,false);
			if (flags[kFLAGS.WARRIORS_RAGE_COMBAT_MODE] != 1) addButton(6, "Autocast", toggleflag,kFLAGS.WARRIORS_RAGE_COMBAT_MODE,true);
		}
		if (TyrantiaFollower.TyrantiaTrainingSessions >= 20) {
			if (flags[kFLAGS.TYRANT_STATE_COMBAT_MODE] != 0) addButton(2, "Manual", toggleflag,kFLAGS.TYRANT_STATE_COMBAT_MODE,false);
			if (flags[kFLAGS.TYRANT_STATE_COMBAT_MODE] != 1) addButton(7, "Autocast", toggleflag,kFLAGS.TYRANT_STATE_COMBAT_MODE,true);
		}
		if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
			if (flags[kFLAGS.ASURA_FORM_COMBAT_MODE] != 0) addButton(3, "Manual", toggleflag,kFLAGS.ASURA_FORM_COMBAT_MODE,false);
			if (flags[kFLAGS.ASURA_FORM_COMBAT_MODE] != 1) addButton(8, "Autocast", toggleflag,kFLAGS.ASURA_FORM_COMBAT_MODE,true);
		}
		if (player.hasPerk(PerkLib.JobBeastWarrior) || player.jiangshiScore() >= 20) {
			if (flags[kFLAGS.FERAL_COMBAT_MODE] != 0) addButton(4, "Normal", toggleflag, kFLAGS.FERAL_COMBAT_MODE, false);
			if (((player.weaponName == "fists" && player.hasNaturalWeapons()) || player.haveNaturalClawsTypeWeapon()) && flags[kFLAGS.FERAL_COMBAT_MODE] != 1) addButton(9, "Feral", toggleflag , kFLAGS.FERAL_COMBAT_MODE, true);
			else addButtonDisabled(9, "Feral", "You do not meet all req. to use this. You need to be unarmed and possess a natural weapon OR to have equipped gaunlet with any type of artifical claws.");
		}
		if ((player.hasPerk(PerkLib.Berzerker) || player.hasPerk(PerkLib.Lustzerker)) && player.hasPerk(MutationsLib.SalamanderAdrenalGlandsEvolved)) {
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 0) addButton(10, "None", zerkingStyle,0);
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 1) addButton(11, "Berserking", zerkingStyle,1);
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 2) addButton(12, "Lustzerking", zerkingStyle,2);
			if (flags[kFLAGS.ZERKER_COMBAT_MODE] != 3) addButton(13, "Both", zerkingStyle,3);
		}
		addButton(14, "Back", doubleAttackOptions);
	}
	public function doubleAttackOptions3():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
		const WATER:int = 5;
		const WIND:int = 6;
		const EARTH:int = 7;
		const ACID:int = 8;
		var toggleflag:Function = curry(toggleFlag, doubleAttackOptions3);
        var elementalMelee:Function = curry(setFlag, doubleAttackOptions3, kFLAGS.ELEMENTAL_MELEE);
		var poisoningStyle:Function = curry(setFlag, doubleAttackOptions3, kFLAGS.ENVENOMED_MELEE_ATTACK);
		menu();
		if (player.hasPerk(PerkLib.SwiftCasting) && flags[kFLAGS.ELEMENTAL_MELEE] != 0) addButton(0, "None", elementalMelee,NONE);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && flags[kFLAGS.ELEMENTAL_MELEE] != 1) addButton(1, "Fire", elementalMelee,FIRE);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && flags[kFLAGS.ELEMENTAL_MELEE] != 2) addButton(2, "Ice", elementalMelee,ICE);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && flags[kFLAGS.ELEMENTAL_MELEE] != 3) addButton(3, "Lightning", elementalMelee,LIGHTNING);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && flags[kFLAGS.ELEMENTAL_MELEE] != 4) addButton(4, "Darkness", elementalMelee, DARKNESS);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsWaterBall) && flags[kFLAGS.ELEMENTAL_MELEE] != 5) addButton(5, "Water", elementalMelee, WATER);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsWindBullet) && flags[kFLAGS.ELEMENTAL_MELEE] != 6) addButton(6, "Wind", elementalMelee, WIND);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsStalagmite) && flags[kFLAGS.ELEMENTAL_MELEE] != 7) addButton(7, "Earth", elementalMelee, EARTH);
		if (player.hasPerk(PerkLib.SwiftCasting) && player.hasStatusEffect(StatusEffects.KnowsAcidSpray) && flags[kFLAGS.ELEMENTAL_MELEE] != 8) addButton(8, "Acid", elementalMelee, ACID);
		if (player.hasPerk(PerkLib.Poisoning)
			&& (player.tailType == Tail.BEE_ABDOMEN
			|| player.tailType == Tail.SCORPION
			|| player.tailType == Tail.MANTICORE_PUSSYTAIL
			|| player.faceType == Face.SNAKE_FANGS
			|| player.faceType == Face.SPIDER_FANGS)
			&& flags[kFLAGS.ENVENOMED_MELEE_ATTACK] != 1) {
            addButton(12, "Venom", toggleflag,kFLAGS.ENVENOMED_MELEE_ATTACK,true);
		}
		if (player.hasPerk(PerkLib.Poisoning) && flags[kFLAGS.ENVENOMED_MELEE_ATTACK] != 0) addButton(13, "None", toggleflag,kFLAGS.ENVENOMED_MELEE_ATTACK,false);
		addButton(14, "Back", doubleAttackOptions);
	}

	public function doubleStrikeOptions():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
		const WATER:int = 5;
		const WIND:int = 6;
		const EARTH:int = 7;
		const ACID:int = 8;
		var toggleflag:Function = curry(toggleFlag,doubleStrikeOptions);
        var doubleStrikeStyle:Function = curry(setFlag,doubleStrikeOptions,kFLAGS.DOUBLE_STRIKE_STYLE);
        var elementalArrows:Function = curry(setFlag,doubleStrikeOptions,kFLAGS.ELEMENTAL_ARROWS);
		clearOutput();
		menu();
		outputText("You will always shoot ");
        var doubleStrikeVal:int = flags[kFLAGS.DOUBLE_STRIKE_STYLE];
		if (doubleStrikeVal == 6) outputText("seven");
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
		if (player.hasPerk(PerkLib.ElementalArrows)) {
			outputText("\n\nIf you learned specific techniques you could even add some magical effects to the projectiles. (Working only with bows and crosbows)");
			outputText("\n\nElemental effect added: <b>");
			switch(flags[kFLAGS.ELEMENTAL_ARROWS]){
				case NONE: outputText("None");break;
				case FIRE: outputText("Fire");break;
				case ICE : outputText("Ice") ;break;
				case LIGHTNING: outputText("Lightning");break;
				case DARKNESS: outputText("Darkness");break;
				case WATER: outputText("Water");break;
				case WIND: outputText("Wind");break;
				case EARTH: outputText("Earth");break;
				case ACID: outputText("Acid");break;
			}
			outputText("</b>");
		}
		if (player.hasPerk(PerkLib.Cupid)) {
			outputText("\n\nIf you learned specific black magical you could add it effects to the projectiles. (Working only with bows and crosbows)");
			if (flags[kFLAGS.CUPID_ARROWS] == 0) outputText("\n\nBlack Magic effect added: <b>None</b>");
			if (flags[kFLAGS.CUPID_ARROWS] == 1) outputText("\n\nBlack Magic effect added: <b>Arouse</b>");
		}
		if (player.hasPerk(PerkLib.EnvenomedBolt)) {
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
		if (maxRangeAttacks >= 7 && doubleStrikeVal != 6) {
			if (maxCurrentRangeAttacks < 7) addButtonDisabled(8, "All Septa", "You current range weapon not allow to use this option");
			else addButton(8, "All Septa", doubleStrikeStyle,6);
		}
		addButton(13, "Enchantments", doubleStrikeOptions2);
        if (CoC.instance.inCombat) addButton(14, "Back", combat.combatMenu, false);
        else addButton(14, "Back", displayPerks);
	}
	public function doubleStrikeOptions2():void {
		const NONE:int = 0;
		const FIRE:int = 1;
		const ICE :int = 2;
		const LIGHTNING:int = 3;
		const DARKNESS:int = 4;
		const WATER:int = 5;
		const WIND:int = 6;
		const EARTH:int = 7;
		const ACID:int = 8;
		var toggleflag:Function = curry(toggleFlag,doubleStrikeOptions2);
        var doubleStrikeStyle:Function = curry(setFlag,doubleStrikeOptions2,kFLAGS.DOUBLE_STRIKE_STYLE);
        var elementalArrows:Function = curry(setFlag,doubleStrikeOptions2,kFLAGS.ELEMENTAL_ARROWS);
		menu();
		if (player.hasPerk(PerkLib.ElementalArrows) && flags[kFLAGS.ELEMENTAL_ARROWS] != 0) addButton(0, "None", elementalArrows,NONE);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsWhitefire) && flags[kFLAGS.ELEMENTAL_ARROWS] != 1) addButton(1, "Fire", elementalArrows,FIRE);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsIceSpike) && flags[kFLAGS.ELEMENTAL_ARROWS] != 2) addButton(2, "Ice", elementalArrows,ICE);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsLightningBolt) && flags[kFLAGS.ELEMENTAL_ARROWS] != 3) addButton(3, "Lightning", elementalArrows,LIGHTNING);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsDarknessShard) && flags[kFLAGS.ELEMENTAL_ARROWS] != 4) addButton(4, "Darkness", elementalArrows,DARKNESS);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsWaterBall) && flags[kFLAGS.ELEMENTAL_ARROWS] != 5) addButton(5, "Water", elementalArrows,WATER);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsWindBullet) && flags[kFLAGS.ELEMENTAL_ARROWS] != 6) addButton(6, "Wind", elementalArrows,WIND);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsStalagmite) && flags[kFLAGS.ELEMENTAL_ARROWS] != 7) addButton(7, "Earth", elementalArrows,EARTH);
		if (player.hasPerk(PerkLib.ElementalArrows) && player.hasStatusEffect(StatusEffects.KnowsAcidSpray) && flags[kFLAGS.ELEMENTAL_ARROWS] != 8) addButton(8, "Acid", elementalArrows,ACID);
		if (player.hasPerk(PerkLib.Cupid) && flags[kFLAGS.CUPID_ARROWS] != 0) addButton(10, "None", toggleflag,kFLAGS.CUPID_ARROWS,false);
		if (player.hasPerk(PerkLib.Cupid) && player.hasStatusEffect(StatusEffects.KnowsArouse) && flags[kFLAGS.CUPID_ARROWS] != 1) addButton(11, "Arouse", toggleflag,kFLAGS.CUPID_ARROWS,true);
		if (player.hasPerk(PerkLib.EnvenomedBolt) && flags[kFLAGS.ENVENOMED_BOLTS] != 0) addButton(12, "None", toggleflag,kFLAGS.ENVENOMED_BOLTS,false);
		if (player.hasPerk(PerkLib.EnvenomedBolt)
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
		if (player.hasPerk(PerkLib.Spellsword)) {
			outputText("\n<b>Charge Weapon:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.Spellarmor)) {
			outputText("\n<b>Charge Armor:</b> ");
			if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.Battlemage)) {
			outputText("\n<b>Might:</b> ");
			if (flags[kFLAGS.AUTO_CAST_MIGHT] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.Battleflash)) {
			outputText("\n<b>Blink:</b> ");
			if (flags[kFLAGS.AUTO_CAST_BLINK] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.Battleshield)) {
			outputText("\n<b>Mana Shield:</b> ");
			if (flags[kFLAGS.AUTO_CAST_MANA_SHIELD] == 1) outputText("Manual");
			else outputText("Autocast");
		}
		if (player.hasPerk(PerkLib.FortressOfIntellect)) {
			outputText("\n<b>Fortress of Intellect:</b> ");
			if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) outputText("On");
			else outputText("Off");
		}
		if (flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 0) addButton(0, "Autocast", toggleflag,kFLAGS.AUTO_CAST_CHARGE_WEAPON,false);
		if (player.hasPerk(PerkLib.Spellsword) && flags[kFLAGS.AUTO_CAST_CHARGE_WEAPON] != 1) addButton(5, "Manual", toggleflag,kFLAGS.AUTO_CAST_CHARGE_WEAPON,true);
		if (flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 0) addButton(1, "Autocast", toggleflag,kFLAGS.AUTO_CAST_CHARGE_ARMOR,false);
		if (player.hasPerk(PerkLib.Spellarmor) && flags[kFLAGS.AUTO_CAST_CHARGE_ARMOR] != 1) addButton(6, "Manual", toggleflag,kFLAGS.AUTO_CAST_CHARGE_ARMOR,true);
		if (flags[kFLAGS.AUTO_CAST_MIGHT] != 0) addButton(2, "Autocast", toggleflag,kFLAGS.AUTO_CAST_MIGHT,false);
		if (player.hasPerk(PerkLib.Battlemage) && flags[kFLAGS.AUTO_CAST_MIGHT] != 1) addButton(7, "Manual", toggleflag,kFLAGS.AUTO_CAST_MIGHT,true);
		if (flags[kFLAGS.AUTO_CAST_BLINK] != 0) addButton(3, "Autocast", toggleflag,kFLAGS.AUTO_CAST_BLINK,false);
		if (player.hasPerk(PerkLib.Battleflash) && flags[kFLAGS.AUTO_CAST_BLINK] != 1) addButton(8, "Manual", toggleflag,kFLAGS.AUTO_CAST_BLINK,true);
		if (flags[kFLAGS.AUTO_CAST_MANA_SHIELD] != 0) addButton(4, "Autocast", toggleflag,kFLAGS.AUTO_CAST_MANA_SHIELD,false);
		if (player.hasPerk(PerkLib.Battleshield) && flags[kFLAGS.AUTO_CAST_MANA_SHIELD] != 1) addButton(9, "Manual", toggleflag,kFLAGS.AUTO_CAST_MANA_SHIELD,true);
		if (player.hasPerk(PerkLib.FortressOfIntellect) && !player.hasStatusEffect(StatusEffects.FortressOfIntellect)) addButton(12, "FoI On", toggleFortressOfIntelect,true);
		if (player.hasStatusEffect(StatusEffects.FortressOfIntellect)) addButton(13, "FoI Off", toggleFortressOfIntelect,false);

		var e:MouseEvent;
		addButton(14, "Back", MagicOption);

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
		if (elementalConjuerSummons == 4) outputText("Elemental will attack enemy on it own alongside PC + Attacking instead of PC each time melee attack command is chosen");
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
		if (elementalConjuerSummons > 1) addButton(10, "NotHelping", setflag, kFLAGS.ELEMENTAL_CONJUER_SUMMONS, 1);
		if (player.hasStatusEffect(StatusEffects.SummonedElementals)) {
			if (elementalConjuerSummons != 2) addButton(11, "MeleeAtk", elementalAttackReplacingPCmeleeAttack);
			if (player.hasPerk(PerkLib.FirstAttackElementals)) {
				if (elementalConjuerSummons != 3) addButton(12, "Helping", setflag,kFLAGS.ELEMENTAL_CONJUER_SUMMONS,3);
				if (elementalConjuerSummons != 4) addButton(13, "Melee+Help", elementalAttackReplacingPCmeleeAttack2);
			}
			else {
				addButtonDisabled(12, "Helping", "Req. First Attack: Elementals perk.");
				addButtonDisabled(13, "Melee+Help", "Req. First Attack: Elementals perk.");
			}
		}
		else {
			addButtonDisabled(11, "MeleeAtk", "Req. to have summoned at least 1 elemental.");
			addButtonDisabled(12, "Helping", "Req. to have summoned at least 1 elemental.");
			addButtonDisabled(13, "Melee+Help", "Req. to have summoned at least 1 elemental.");
		}
		if (CoC.instance.inCombat) addButton(14, "Back", combat.combatMenu, false);
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
        function elementalAttackReplacingPCmeleeAttack2():void {
            flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS] = 4;
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
		outputText("You can choose how your permanent golems will behave during each fight.\n\n");
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1)) {
			if (player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0) {
				var element:Number = player.statusEffectv3(StatusEffects.GolemUpgrades1);
				outputText("<b>Elemental Weaponry:</b>\n");
				switch(element){
					case 1: outputText("Inactive"); break;
					case 2: outputText("Fire"); break;
					case 3: outputText("Ice"); break;
					case 4: outputText("Lightning"); break;
					case 5: outputText("Darkness"); break;
				}
				outputText("\n\n");
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 1) addButton(0, "Inactivate", golemsElementaryWeaponMode, 1);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 2) addButton(1, "Fire", golemsElementaryWeaponMode, 2);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 3) addButton(2, "Ice", golemsElementaryWeaponMode, 3);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 4) addButton(3, "Lightning", golemsElementaryWeaponMode, 4);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 5) addButton(4, "Darkness", golemsElementaryWeaponMode, 5);
			}
			if (player.statusEffectv4(StatusEffects.GolemUpgrades1) > 0) {
				var poison:String = "";
				outputText("Poisoned Weaponry Upgrade status <b>("+poison+")</b>"+player.statusEffectv4(StatusEffects.GolemUpgrades1)+"\n\n");
				if (player.statusEffectv4(StatusEffects.GolemUpgrades1) == 2) poison = "Active";
				else poison = "Inactive";
				if (player.statusEffectv4(StatusEffects.GolemUpgrades1) == 2) addButton(5, "Inactivate", golemsPoisonedWeaponMode, 1);
				else addButton(6, "Activate", golemsPoisonedWeaponMode, 2);
			}
		}
		outputText("<b>Permanent golems attack pattern behavious:</b>\n");
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) outputText("Attacking at the begining of each turn (owner would need to just choose how many of them will be sent).");
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] < 1) outputText("Waiting for the owner to give an attack command each turn.");
		if (player.hasStatusEffect(StatusEffects.GolemUpgrades1)) {
			if (player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0) {
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 1) addButton(0, "Inactivate", golemsElementaryWeaponMode, 1);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 2) addButton(1, "Fire", golemsElementaryWeaponMode, 2);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 3) addButton(2, "Ice", golemsElementaryWeaponMode, 3);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 4) addButton(3, "Lightning", golemsElementaryWeaponMode, 4);
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) != 5) addButton(4, "Darkness", golemsElementaryWeaponMode, 5);
			}
			if (player.statusEffectv4(StatusEffects.GolemUpgrades1) > 0) {
				if (player.statusEffectv4(StatusEffects.GolemUpgrades1) == 2) addButton(5, "Inactivate", golemsPoisonedWeaponMode, 1);
				else addButton(6, "Activate", golemsPoisonedWeaponMode, 2);
			}
		}
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) addButton(10, "Waiting", golemsAttacking,false);
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] != 1) addButton(11, "Attacking", golemsAttacking,true);

		var e:MouseEvent;
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu, false);
		else addButton(14, "Back", displayPerks);
		function golemsElementaryWeaponMode(elementalMode:Number):void {
			player.changeStatusValue(StatusEffects.GolemUpgrades1,3,elementalMode);
			golemsbehaviourOptions();
		}
		function golemsPoisonedWeaponMode(poisonedMode:Number):void {
			player.changeStatusValue(StatusEffects.GolemUpgrades1,4,poisonedMode);
			golemsbehaviourOptions();
		}
        function golemsAttacking(attacking:Boolean):void {
            flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] = (attacking)?1:0;
            golemsbehaviourOptions();
        }
	}

	public function DarkRitualOption():void {
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.DarkRitual)) {
			outputText("Set weither you will be sacrificing blood to empower your magic or not.\n\n");
			if (!player.hasStatusEffect(StatusEffects.DarkRitual)) {
				outputText("Dark ritual is currently: <b>Inactive</b>.");
				addButton(10, "On", DarkRitualOptionOn);
			}
			if (player.hasStatusEffect(StatusEffects.DarkRitual)) {
				outputText("Dark ritual is currently: <b>Active</b>.");
				addButton(11, "Off", DarkRitualOptionOff);
			}
			outputText("\n\n");
		}
		if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) {
			outputText("Set if you will be using blood instead of mana to fuel your magic.\n\n");
			if (!player.hasStatusEffect(StatusEffects.BloodMage)) {
				outputText("Blood Mage: <b>Inactive</b>.");
				addButton(0, "On", BloodMageOptionOn);
			}
			if (player.hasStatusEffect(StatusEffects.BloodMage)) {
				outputText("Blood Mage: <b>Active</b>.");
				addButton(1, "Off", BloodMageOptionOff);
			}
			outputText("\n\n");
			if (player.hasPerk(PerkLib.WayOfTheBlood)) {
				outputText("Set if you will be using blood instead of soulforce to fuel your soulskills.\n\n");
				if (!player.hasStatusEffect(StatusEffects.BloodCultivator)) {
					outputText("Blood Cultivator: <b>Inactive</b>.");
					addButton(2, "On", BloodCultivatorOptionOn);
				}
				if (player.hasStatusEffect(StatusEffects.BloodCultivator)) {
					outputText("Blood Cultivator: <b>Active</b>.");
					addButton(3, "Off", BloodCultivatorOptionOff);
				}
			}
		}
		var e:MouseEvent;
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu, false);
		else addButton(14, "Back", displayPerks);
		function DarkRitualOptionOn():void {
			player.createStatusEffect(StatusEffects.DarkRitual,0,0,0,0);
			DarkRitualOption();
		}
		function DarkRitualOptionOff():void {
			player.removeStatusEffect(StatusEffects.DarkRitual);
			DarkRitualOption();
		}
		function BloodMageOptionOn():void {
			player.createStatusEffect(StatusEffects.BloodMage,0,0,0,0);
			DarkRitualOption();
		}
		function BloodMageOptionOff():void {
			player.removeStatusEffect(StatusEffects.BloodMage);
			DarkRitualOption();
		}
		function BloodCultivatorOptionOn():void {
			player.createStatusEffect(StatusEffects.BloodCultivator,0,0,0,0);
			DarkRitualOption();
		}
		function BloodCultivatorOptionOff():void {
			player.removeStatusEffect(StatusEffects.BloodCultivator);
			DarkRitualOption();
		}
		addButton(14, "Back", MagicOption);
	}

	public function VenomancyOption():void {
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.Venomancy)) {
			outputText("Set weither you will be using venom to empower your magic or not.\n\n");
			if (!player.hasStatusEffect(StatusEffects.Venomancy)) {
				outputText("Venomancy is currently: <b>Inactive</b>.");
				addButton(10, "On", VenomancyOptionOn);
			}
			if (player.hasStatusEffect(StatusEffects.Venomancy)) {
				outputText("Venomancy is currently: <b>Active</b>.");
				addButton(11, "Off", VenomancyOptionOff);
			}
			outputText("\n\n");
		}
		var e:MouseEvent;
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu, false);
		else addButton(14, "Back", displayPerks);
		function VenomancyOptionOn():void {
			player.createStatusEffect(StatusEffects.Venomancy,0,0,0,0);
			VenomancyOption();
		}
		function VenomancyOptionOff():void {
			player.removeStatusEffect(StatusEffects.Venomancy);
			VenomancyOption();
		}
		addButton(14, "Back", MagicOption);
	}

	public function WOTWbehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your will-o'-the-wisp will behave during each fight.\n\n");
		outputText("\n<b>Will-o'-the-wisp behaviour:</b>\n");
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) outputText("Commanding other pets or minions (other minions will get boost to dmg).");
		if (flags[kFLAGS.WILL_O_THE_WISP] < 1) outputText("Attacking at the begining of each turn.");
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) addButton(10, "Attacking", WOTWAttacking,false);
		if (flags[kFLAGS.WILL_O_THE_WISP] != 1) addButton(11, "Commanding", WOTWAttacking,true);

		var e:MouseEvent;
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu, false);
		else addButton(14, "Back", displayPerks);
        function WOTWAttacking(attacking:Boolean):void {
            flags[kFLAGS.WILL_O_THE_WISP] = (attacking)?1:0;
            WOTWbehaviourOptions();
        }
	}

	//MutationsDB!
	public function mutationsDatabase(page:int = 0, review:Boolean = false):void{
		/*
		Source: MutationsLib.as for all mutations.
 		*/
		if (review) {	//Initial screen for user to know how many points they have per part
			clearOutput();
			displayHeader("Mutation Stats");
			if (flags[kFLAGS.MUTATIONS_SPOILERS]) {
				outputText("Mutations Assistant: <b>On</b>\n");
			}
			else{
				outputText("Mutations Assistant: <b>Off</b>\n");
			}
			var mutationCount:int = 1
			if (player.hasPerk(PerkLib.AscensionAdditionalOrganMutationX)) mutationCount += player.perkv1(PerkLib.AscensionAdditionalOrganMutationX);
			outputText("You have " + mutationCount + " mutation slot" + (mutationCount > 1 ? "s":"") + " per part." +
					"\nNote: Not all body parts will use all available slots.\n\n");

			outputText("<b><i><u>Mutations used per bodypart:</u></i></b>\n");
			var bPartlist:Array = ["Heart", "Muscle", "Mouth", "Adrenals", "Bloodstream", "FaT", "Lungs", "Metabolism", "Ovaries", "Testicles", "Eyes", "Bone", "Nerv/Sys", "Thyroid", "PThyroid", "Adaptations"]
			for each (var bodyPart:String in bPartlist){
				var mCount:int = 0
				var mPerkarray:Array = MutationsLib.mutationsArray(bodyPart);
				for each (var pPerk:Array in mPerkarray){
					if (player.hasPerk(pPerk[0])){
						mCount++;
						if (bodyPart == "Adaptations") mutationCount++;
					}
				}
				outputText(bodyPart + " mutations obtained: ");
				if (mCount > mutationCount){
					outputText("<font color=\"#800000\">");
				}
				else{
					outputText("<font color=\"#008000\">");
				}
				outputText( mCount +"</font> of " + (mutationCount > mPerkarray.length ? mPerkarray.length : mutationCount) + ". Max:(");
				if (flags[kFLAGS.MUTATIONS_SPOILERS]){
					outputText(mPerkarray.length + ")\n");
				}
				else{
					if (mPerkarray.length == mCount){
						outputText(mPerkarray.length + ")\n");
					}
					else{
						outputText("?)\n");
					}
				}
			}
			outputText("Mutations can be obtained by ");
			if (flags[kFLAGS.MUTATIONS_SPOILERS] || EvangelineFollower.EvangelineAffectionMeter >= 3){
				outputText("finding Evangeline and asking her about it.\n");
			}
			else{
				outputText("looking around for an alchemist specializing in transformatives.\n");
			}
			outputText("Mutations Assistant is toggleable in settings, and hides/shows you available mutations. It is off by default.\n");
		}

		function mutationsDBHeart():void{
			clearOutput();
			//Heart Mutations
			displayHeader("Heart Mutations:");
			for each (var mutate:Array in MutationsLib.mutationsArray("Heart")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBMuscle():void{
			clearOutput();
			//Muscle Mutations
			displayHeader("Muscle Mutations:");
			for each (var mutate:Array in MutationsLib.mutationsArray("Muscle")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBMouth():void{
			clearOutput();
			//Mouth Mutations
			displayHeader("Mouth Mutations:");
			for each (var mutate:Array in MutationsLib.mutationsArray("Mouth")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBAdrenals():void{
			clearOutput();
			//Adrenal Glands Mutations
			displayHeader("Adrenal Gland Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Adrenals")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBBloodstream():void{
			clearOutput();
			//Bloodstream Mutations, not bloodsteam, unless you're boiling blood.
			displayHeader("Bloodstream Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Bloodstream")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBFaTissue():void{
			clearOutput();
			//Fat tissue Mutations
			displayHeader("Fat and Tissue Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("FaT")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBLungs():void{
			clearOutput();
			//Lungs Mutations
			displayHeader("Lungs Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Lungs")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBMetabolism():void{
			clearOutput();
			//Metabolism Mutations
			displayHeader("Metabolism Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Metabolism")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBOvaries():void{
			clearOutput();
			//Ovaries Mutations
			displayHeader("Ovaries Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Ovaries")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBTesticles():void{
			clearOutput();
			//Testicle Mutations
			displayHeader("Balls Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Testicles")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBEyes():void{
			clearOutput();
			//Eyes Mutations
			displayHeader("Eye Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Eyes")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBBoneMarrow():void{
			clearOutput();
			//Bones and Marrow Mutations
			displayHeader("Bones and Marrow Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Bone")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase();
		}

		function mutationsDBPNervSys():void{
			clearOutput();
			//Peripheral/NervSys Mutations
			displayHeader("Peripheral Nervous System Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Nerv/Sys")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase(1);
		}

		function mutationsDBThyroidGlands():void{
			clearOutput();
			//Thyroid Glands Mutations
			displayHeader("Thyroid Gland Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Thyroid")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase(1);
		}

		function mutationsDBParathyroid():void{
			clearOutput();
			//ParaThyroid Glands Mutations.
			displayHeader("ParaThyroid Glands Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("PThyroid")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase(1);
		}

		function mutationsDBAdaptations():void{
			clearOutput();
			//Adaptation Mutations.
			displayHeader("Adaptation Mutations");
			for each (var mutate:Array in MutationsLib.mutationsArray("Adaptations")){
				mutationsDatabaseVerify(mutate);
			}
			mutationsDatabase(1);
		}

		function mutationsDBDragon():void{
			clearOutput();
			//Dragon Mutations
			displayHeader("Dragon Mutations");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) outputText("\nThere is an extra bonus mutation slot given due to NG+");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) outputText("\nThere is another extra bonus mutation slot given due to NG++");
			mutationsDatabaseVerify([MutationsLib.DraconicBones, MutationsLib.DraconicBonesPrimitive, MutationsLib.DraconicBonesEvolved]);
			mutationsDatabaseVerify([MutationsLib.DraconicHeart, MutationsLib.DraconicHeartPrimitive, MutationsLib.DraconicHeartEvolved]);
			mutationsDatabaseVerify([MutationsLib.DraconicLungs, MutationsLib.DraconicLungsPrimitive, MutationsLib.DraconicLungsEvolved]);
			mutationsDatabase(1);
		}

		function mutationsDBKitsune():void{
			clearOutput();
			//Kitsune Mutations
			displayHeader("Kitsune Mutations");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) outputText("\nThere is an extra bonus mutation slot given due to NG+");
			mutationsDatabaseVerify([MutationsLib.KitsuneThyroidGland, MutationsLib.KitsuneThyroidGlandPrimitive, MutationsLib.KitsuneThyroidGlandEvolved]);
			//mutationsDatabaseVerify([MutationsLib.KitsuneParathyroidGlands, MutationsLib.KitsuneParathyroidGlandsEvolved, MutationsLib.KitsuneParathyroidGlandsFinalForm]);
			mutationsDatabase(1);
		}

		menu();
		var menuItems:Array = [];
		//This was originally hard coded buttons. Which it can still be, I suppose.
		menuItems.push("Heart", mutationsDBHeart, "Heart Mutations");
		menuItems.push("Muscle", mutationsDBMuscle, "Muscle Mutations");
		menuItems.push("Mouth", mutationsDBMouth, "Mouth Mutations");
		menuItems.push("Adrenal Glands",mutationsDBAdrenals, "Adrenal Mutations");
		menuItems.push("Bloodstream",mutationsDBBloodstream, "Bloodstream Mutations");
		menuItems.push("Fat and Tissue", mutationsDBFaTissue, "FaT Mutations");
		menuItems.push("Lungs",mutationsDBLungs, "Lungs Mutations");
		menuItems.push("Metabolism", mutationsDBMetabolism, "Metabolism Mutations");
		menuItems.push("Ovaries", mutationsDBOvaries, "Ovaries Mutations");
		menuItems.push("Testicles", mutationsDBTesticles, "Testicle Mutations");
		menuItems.push("Eyes", mutationsDBEyes, "Eyes Mutations");
		menuItems.push("Bone/Marrow", mutationsDBBoneMarrow, "Bone Mutations");
		// Due to not being able to return which page I am at in submenu,
		// I cannot keep the menu to be at a specific page beyond this.
		// Thus, hardcoded into the function.
		menuItems.push("Nerv/Sys", mutationsDBPNervSys, "Nerv-Sys Mutations");
		menuItems.push("Thyroid Gland", mutationsDBThyroidGlands, "Thyroid Mutations");
		menuItems.push("Parathyroid Gland", mutationsDBParathyroid, "Parathyroid Mutations");
		menuItems.push("Adaptations", mutationsDBAdaptations, "Adaptation Mutations");
		menuItems.push("Dragons", mutationsDBDragon, "Dragon Mutations");
		menuItems.push("Kitsunes", mutationsDBKitsune, "Kitsune Mutations");
		menuGen(menuItems, page, displayPerks);
	}

	//Mutations check helper. Cloned + stripped requirements logic from PerkMenuDB.
	public function mutationsDatabaseVerify(perkName:Array, acquireReq:String = ""):void {
		var perkCount:int = 0;
		if(perkName.length > 1){	//Checks if perk has tiers. Temp solution until Orm uses the perk versioning system.
			for each(var perkTier:PerkType in perkName) {
				if (player.hasPerk(perkTier)){
					perkCount += 1;
				}
				else{
					break;
				}
			}
		}
		if (flags[kFLAGS.MUTATIONS_SPOILERS]) { //Help On
			if (player.hasPerk(perkName[0])) {	//Just checking if you have the base.
				outputText("\n" + perkName[0].name() + ": <font color=\"#008000\">Acquired.</font>");
			} else {
				outputText("\n" + perkName[0].name() + ": <font color=\"#800000\">Missing.</font>");
			}
			outputText("\nTier: " + String(perkCount) + " of " + String(perkName.length) + ".");
			if (acquireReq == "") {	//In case manual information dump required, e.g. mutation handled in different way.
				var reqs:Array = [];
				if (perkCount != perkName.length && perkName[perkCount].requirements.length > 0) {
					for each (var cond:Object in perkName[perkCount].requirements) {
						var reqStr:String = cond.text;
						var color:String = "";
						if (!(reqStr.indexOf("Mutation") >= 0)) { //Ignores the "free mutation slot" note.
							if (cond.fn(player)) {
								color = "#008000";
							}
							else {
								color = "#800000";
							}
							reqs.push("<font color='"+color+"'>"+cond.text+"</font>");
						}
					}
				}
				else if (perkCount == perkName.length){	//Highest tier.
					reqs.push("You already have the highest tier.");
				}
				else{	//Information not available.
					reqs.push("Missing data. Perhaps Unacquirable?");
				}
				outputText("\nRequirements for next tier: " + reqs.join(", "));
			}
			else {	//Manual done this way.
				outputText("\nRequirements for next tier: " + acquireReq + ".");
			}
			//Description of mutations.
			if (!perkCount == 0){	//De-sync between desc.
				perkCount -= 1;
			}
			outputText("\nDescription: ");
			if(perkName[perkCount].desc().length == 1) {	//Some desc. contains only "."
				outputText("No description available.");
			}
			else{
				outputText(perkName[perkCount].desc());
			}
		}
		else { //Help Off
			if (player.hasPerk(perkName[0])) {
				outputText("\n" + perkName[0].name() + ": <font color=\"#008000\">Acquired.</font>");
				outputText("\nTier: " + String(perkCount));
				if (!perkCount == 0){	//De-sync between desc.
					perkCount -= 1;
				}
				outputText("\nDescription: ");
				if(perkName[perkCount].desc().length == 1) {	//Some desc. contains only "."
					outputText("No description available.");
				}
				else{
					outputText(perkName[perkCount].desc());
				}
			}
			else {
				outputText("\n???" + "\n Tier: ?" + "\nDescription: ???");
			}
		}
		outputText("\n");
	}

	public function mutationsDatabaseVerify2(perks:Array, acquireReq:String = ""):void {
		var perkCount:int = player.perkv1(perks[0]);
		if (flags[kFLAGS.MUTATIONS_SPOILERS]) { //Help On
			if (player.hasPerk(perks[0])) {	//Just checking if you have the base.
				outputText("\n" + perks.name() + ": <font color=\"#008000\">Acquired.</font>");
			} else {
				outputText("\n" + perks.name() + ": <font color=\"#800000\">Missing.</font>");
			}
			outputText("\nPerk Rank: " + String(perkCount) + ".");
			if (acquireReq == "") {	//In case manual information dump required, e.g. mutation handled in different way.
				var reqs:Array = [];
				for each (var cond:Object in perks[0].requirements) {
					var reqStr:String = cond.text;
					var color:String = "";
					if (!(reqStr.indexOf("Mutation") >= 0)) { //Ignores the "free mutation slot" note.
						if (cond.fn(player)) {
							color = "#008000";
						} else {
							color = "#800000";
						}
						reqs.push("<font color='" + color + "'>" + cond.text + "</font>");
					} else if (perkCount == perks[1]){
						outputText("\"You already have the highest tier.\"")
					}
					else {	//Information not available.
						reqs.push("Missing data. Perhaps Unacquirable?");
					}
					outputText("\nRequirements for next tier: " + reqs.join(", "));
				}
			}
			else {	//Manual done this way.
				outputText("\nRequirements for next tier: " + acquireReq + ".");
			}
			outputText("\nDescription: ");
			if(perks[0].desc().length <= 1) {	//Some desc. contains only "."
				outputText("No description available.");
			}
			else{
				outputText(perks[0].desc());
			}
		}
		else { //Help Off
			if (player.hasPerk(perks[0])) {
				outputText("\n" + perks.name() + ": <font color=\"#008000\">Acquired.</font>");
				outputText("\nTier: " + player.perkv1(perks[0]));
				outputText("\nDescription: ");
				if(perks[0].desc().length <= 1) {	//Some desc. contains only "."
					outputText("No description available.");
				}
				else{
					outputText(perks[0].desc());
				}
			}
			else {
				outputText("\n???" + "\n Tier: ?" + "\nDescription: ???");
			}
		}
		outputText("\n");
	}


	public function perkDatabase(page:int=0, count:int=50):void {
		var allPerks:Array = PerkTree.obtainablePerks().sort();
		var mutationList:Array = MutationsLib.mutationsArray("",true);
		var temp:Array = [];
		for each(var pPerks:PerkType in allPerks) {
			if (!(mutationList.indexOf(pPerks) >= 0)){
				//allPerks.splice(allPerks.indexOf(pPerks), 1);
				temp.push(pPerks)
			}
		}
		allPerks = temp;
		clearOutput();
		var perks:Array = allPerks.slice(page*count,(page+1)*count);
		displayHeader("All Perks ("+(1+page*count)+"-"+(page*count+perks.length)+
					  "/"+allPerks.length+")");
		for each (var ptype:PerkType in perks) {
			var pclass:PerkClass = player.getPerk(ptype)

			var color:String;
			if (pclass) color=(darkTheme()?'#ffffff':'#000000'); // has perk
			else if (ptype.available(player)) color=darkTheme()?'#44cc44':'#228822'; // can take on next lvl
			else color=darkTheme()?'#ffcc44':'#aa8822'; // requirements not met

			outputText("<font color='" +color +"'><b>"+ptype.name()+"</b></font>: ");
			outputText(pclass?ptype.desc(pclass):ptype.longDesc);
			if (!pclass && ptype.requirements.length>0) {
				var reqs:Array = [];
				for each (var cond:Object in ptype.requirements) {
					if (cond.fn(player)) color=(darkTheme()?'#ffffff':'#000000');
					else color=darkTheme()?'#ff4444':'#aa2222';
					if (cond.text is String){
						reqs.push("<font color='"+color+"'>"+cond.text+"</font>");
					}
					else {
						reqs.push("<font color='"+color+"'>"+cond.text(player)+"</font>");
					}
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

	public function perkDatabase2():void { //Messy code... Again, probably optimizable by someone else with more experience.
		clearOutput();
		menu();
		var perkDict:Dictionary = PerkType.getPerkLibrary();
		var tPerkList:Array = [];	//Master Source Perk Array.
		var fPerkList:Array = [];	//Final Perk Array, of Arrays.
		var mPerkList:Array = [];	//Master Removal Perk Array.
		var fPerkCList:Array = [];	//PerkDisplayInfo.
		var pSpecials:Array = [];
		var pRelations:Dictionary = new Dictionary();	//Perk relations Dictionary.
		//key = Perk on screen, value = [anyperk][allperk][requires] (needs,needs,opens)

		//var pCount:int = 0;

		function pDictPrep():void{	//Perk Dictionary preperations/Filter
			var pList1:Array = MutationsLib.mutationsArray("",true); //No Mutations Perks
			var pList2:Array = PerkLib.enemyPerkList(); //No Enemy Perks.
			var pList3:Array = PerkLib.gearPerks();	//No Gear Perks.
			var pList4:Array = PerkLib.weaPerks();	//No Weapons Perks.
			//function pSpecialRem = No Ascension/History/Bloodline/PastLife Perks
			var pList5:Array = MutationsLib.mutationsArray("Deprecated");
			for each (var perkTrue:PerkType in perkDict){
				if (!(pList1.indexOf(perkTrue) >= 0) && !(pList2.indexOf(perkTrue) >= 0) && !(pList3.indexOf(perkTrue) >= 0) && !(pList4.indexOf(perkTrue) >= 0) && !(pList5.indexOf(perkTrue) >= 0) && pSpecialRem(perkTrue)){
					tPerkList.push(perkTrue);
				}
			}
			//trace(pList1.length + " < 1 - 2 > " + pList2.length + "\n");
		}

		function pSpecialRem(perkTrue:PerkType):Boolean{	//SpecialCases
			var pName:String = perkTrue.name();
			var rez:Boolean = true;
			for each (var temp1:String in ["Ascension", "Bloodline", "History", "Past Life", "Pierced", "Prestige", "Slime Metabolism", "Draconic", "Cave Wyrm Lungs", "Hidden Job", "Super Perk", "!!!"]){
				if (pName.indexOf(temp1) >= 0){
					trace(pName);
					rez = false;
					pSpecials.push(perkTrue);
					break;
				}
			}
			return rez;
		}

		function initTier():void{	//Initial tier 0,1.
			var bPList:Array = [];
			var b2PList:Array = [];
			for each (var pPerkDBLP:PerkType in tPerkList){
				if (pPerkDBLP.requirements.length == 0){
					bPList.push(pPerkDBLP);
					mPerkList.push(pPerkDBLP)
				}
				else {
					var pReqFail:Boolean = false
					for each (var temp1:Object in pPerkDBLP.requirements){
						if (temp1.hasOwnProperty("perk") || temp1.hasOwnProperty("perks") || temp1.hasOwnProperty("allperks")){
							pReqFail = true;
							break;
						}
					}
					if (!pReqFail){
						b2PList.push(pPerkDBLP);
						mPerkList.push(pPerkDBLP);
					}
				}
			}
			perkArrMgmt(bPList);
			fPerkList.push(bPList);		//No Perk Requirements. Tier 0. Big list, needs refining.
			perkArrMgmt(b2PList);
			fPerkList.push(b2PList);	//Perk Requirements, but not requiring other perks beforehand. Tier 1.
			for each (var pPerk:PerkType in pSpecials){
				mPerkList.push(pPerk);
			}
			repPerkClr();
		}

		function repPerkClr(pLvl:int = 1):void{	//tier 2+
			var nList:Array = [];
			for each(var pPerk:PerkType in tPerkList){
				try{
					var change:Boolean = false;
					var requirelen:int = 0;
					for each (var cond:Object in pPerk.requirements) {
						/*if (cond.type == "level"){
							if (cond.level < pLvl){
								change = false;
								break;
							}
						}*/
						if (cond.type == "allperks"){		//Checks if player has all required perks
							var iterval:int = 0;
							for each (var pPerk1:PerkType in cond.allperks) {
								if (!mPerkList.indexOf(pPerk1) >= 0){
									change = false;
									break;
								}
								iterval++
							}
							if (iterval == cond.allperks.length){
								change = true;
							}
							else{
								break;
							}
						}
						else if (cond.type == "anyperk"){	//Checks if player has any of the perks
							var anyChk:Boolean = false;
							for each (var pPerk2:PerkType in cond.perks) {
								if (mPerkList.indexOf(pPerk2) >= 0){
									change = true;
									anyChk = true;
									break;
								}
							}
							if (!anyChk){ //in case both any and all are in req.
								change = false;
								break;
							}
						}
						else if (cond.type == "perk"){		//Checks if player has the perk
							var pPerk3:PerkType = cond.perk;
							if (mPerkList.indexOf(pPerk3) >= 0){
								change = true;
							}
							else {
								if (change) change = false;
								break;
							}
						}
						else {	//The effect from this cause should never occur, as all these in masterlist should have a perk requirement of some sort.
							requirelen++
						}
					}
					if (requirelen == pPerk.requirements.length){
						outputText(pPerk.name() + "shouldn't be here. This is a bug. Please report it.");
						trace(pPerk.name() + "Error. Sth is wrong, and I'm too tired to figure it out.")
					}
					else if(change){
						nList.push(pPerk);
						//mPerkList.push(pPerk);
						change = false;
					}
				}
				catch(e:Error){
					trace(e)
				}
			}
			if (nList.length > 0){
				perkArrMgmt(nList);
				fPerkList.push(nList);
				repPerkClr();
			}
		}

		function perkArrMgmt(remArr:Array):void{	//Source List clearing.
			var srcArr:Array = tPerkList;
			for each (var pPerk:PerkType in remArr){
				srcArr.splice(srcArr.indexOf(pPerk),1);
				mPerkList.push(pPerk);
			}
		}

		function perkRelationsDict():void{	//Perk Relations.
			var req1:Array = [];
			var req2:Array = [];
			//var req3:Array = [];
			for each (var pPerk:PerkType in tPerkList){
				for each (var cond:Object in pPerk.requirements) {
					if (cond.type == "allperks"){
						for each (var pPerk1:PerkType in cond.allperks) {
							req1.push(pPerk1);
						}
					}
					else if (cond.type == "anyperk"){
						for each (var pPerk2:PerkType in cond.perks) {
							req2.push(pPerk2);
						}
					}
					else if (cond.type == "perk"){
						req1.push(cond.perk);
					}
				}
				//req3 = CoC.instance.perkTree.listUnlocks(pPerk); //For some reason, does not want to work. Seems to really only want it from PerkClass.ptype.
				//trace(req3);
				pRelations[pPerk] = [req1, req2];
				req1 = [];
				req2 = [];
				//req3 = [];
			}
		}

		function pInfoDP(tPVal:int, e:TextEvent):void{	//Perk Display Information
			clearOutput();
			var selected:PerkClass = fPerkCList[e.text].perk;
			var tempStr:String = "";
			var pPerkGDesc:Array = ["\nRequires (All of these perks): ", "\nRequires (Any of these perks): ", "\nUnlocks: "]
			var pPerkGroup:Array = pRelations[selected.ptype];
			var reqs:Array = [];
			pPerkGroup.push(CoC.instance.perkTree.listUnlocks(selected.ptype));
			outputText("<b>" + selected.perkName + ":</b>");
			for each (var cond:Object in selected.ptype.requirements) {
				if (!(cond.type == "allperks" || cond.type == "anyperk" || cond.type == "perk")){
					if (cond.text is String){
						reqs.push(cond.text);
					}
					else {
						reqs.push(cond.text(player));
					}
				}
			}
			if (reqs.length > 0){
				outputText("\nRequires (Non-perk requirements): " + reqs.join(", "));
			}
			for (var i:int = 0; i <= 2; i++){
				if (pPerkGroup[i].length > 0){
					outputText(pPerkGDesc[i]);
					for each (var pPerk1:PerkType in pPerkGroup[i]){
						tempStr = tempStr + pPerk1.name() + ", ";
					}
					tempStr = tempStr.slice(0, -2);
					outputText(tempStr);
					tempStr = "";
				}
			}
			outputText("\n\n");
			outputText(selected?selected.ptype.desc(selected):selected.ptype.longDesc);
			menu();
			addButton(14, "Back", displayMenu, tPVal);
		}

		function dMenuLinker(tPVal:int, srcArr:Array):void{	//Interaction linking
			fPerkCList = [];
			mainView.mainText.addEventListener(TextEvent.LINK, curry(pInfoDP, tPVal));
			for each(var perk:PerkType in srcArr.sort()) {
				var p:PerkClass = new PerkClass(perk,
						perk.defaultValue1, perk.defaultValue2, perk.defaultValue3, perk.defaultValue4);
				var lab:* = {label: p.perkName, perk: p};
				fPerkCList.push(lab);
				outputText("<u><a href=\"event:"+fPerkCList.indexOf(lab)+"\">"+p.perkName+"</a></u>\n");
			}
		}

		function displayMenu(tPVal:int = 0):void{	//Main Perk Database Display
			if (fPerkList.length == 0){
				pDictPrep();
				perkRelationsDict();
				initTier();
				fPerkList.push(tPerkList);
			}
			clearOutput();
			menu();
			displayHeader("Perk Tier: " + tPVal);
			//outputText(tPerkList.length + "\n");
			if (tPVal == 0){
				outputText("Tier 0 contains all perks that do not have any requirements!\n");
				outputText("It also contains perks that may not be handled in the standard manner.\n");
				outputText("Note: This is still in beta, but works for the 90%. Odd side cases are attributed to weirdness in perk code.\n");
			}
			else if (tPVal == 1){
				outputText("Tier 1 contains all perks that have a requirement, but do not require perks.\n");
			}
			else if (tPVal == 18){
				outputText("Tier 18 contains perks that don't associate properly.\n");
			}
			else {
				outputText("This tier contains perks that require one or more of any perks found in previous tiers!\n");
			}
			outputText("Note: Perks are sorted into tiers via relations to other perks only. Other requirements are stated, but are not taken into consideration here.\n")
			//outputText("Note: Work in progress. Send feedback to JTecx.\n");
			var tfArr:Array = fPerkList[tPVal];
			dMenuLinker(tPVal, tfArr);
			if (tPVal > 0){
				addButton(0, "Prev Page", displayMenu,tPVal - 1);
			} else{
				addButtonDisabled(0,"Prev Page", "Lowest Tier.")
			}
			if (tPVal < fPerkList.length - 1){
				addButton(4, "Next Page", displayMenu,tPVal + 1);
			} else{
				addButtonDisabled(4,"Next Page", "Highest Tier.")
			}
			addButton(14, "Back", displayPerks);
		}

		displayMenu();
	}

    private function toggleFlag(returnTo:Function,flag:int,on:Boolean):void{
        setFlag(returnTo,flag,((on)?1:0));
    }
	private function setFlag(returnTo:Function,flag:int,val:int):void{
		flags[flag] =  val;
		returnTo();
	}

	public function playerPerksList():void {	//Can this be done better? Very likely. But hell, I'm not a programmer.
		var pPerkList:Array = player.perks;	 	//Player Perks
		var masterlist:Array = [];				//Temp hold of above
		var ignorelist:Array = [];				//List to check against repetitively
		var endlist:Array = [];					//Final list of perks to output
		//var pPerkList:Array = PerkTree.obtainablePerks();	//DebugLine. Returns most perks.
		var maxpPerks:int = 0;					//DebugLine

		function initSet():void {
			var mutationList:Array = MutationsLib.mutationsArray("",true)
			for each(var pPerks:PerkClass in pPerkList) { //Cleans up the list of mutations and no-perk requiring perks
				if (!(mutationList.indexOf(pPerks.ptype) >= 0)){
					//maxpPerks++
					var pPerkReq:PerkType = pPerks.ptype
					var perkno:Boolean = true;
					for each (var temp1:Object in pPerkReq.requirements) {
						if (temp1.hasOwnProperty("perk") || temp1.hasOwnProperty("perks") || temp1.hasOwnProperty("allperks")){
							masterlist.push(pPerkReq);
							perkno = false;
							break;
						}
					}
					if (perkno) {
						ignorelist.push(pPerkReq);
						endlist.push(pPerkReq);
					}
				}
			}
			repPerkClr();
		}

		function repPerkClr():void { //Cycling perks against requirements until no higher can be achieved per.
			var change:Boolean = false;
			//outputText("Hit! Current list length: " + masterlist.length + "\n");	//DebugLine
			for each(var pPerk:PerkType in masterlist){
				var requirelen:int = 0;
				for each (var cond:Object in pPerk.requirements) {
					if (cond.type == "allperks"){		//Checks if player has all required perks
						var iterval:int = 0;
						for each (var pPerk1:PerkType in cond.allperks) {
							if (ignorelist.indexOf(pPerk1) >= 0){
								iterval++
							}
							if (iterval == cond.allperks.length){
								for each (var temp1:PerkType in cond.allperks){
									perkArrMgmt(temp1, pPerk);
									change = true;
								}
							}
						}
					}
					else if (cond.type == "anyperk"){	//Checks if player has any of the perks
						for each (var pPerk2:PerkType in cond.perks) {
							if (ignorelist.indexOf(pPerk2) >= 0){
								perkArrMgmt(pPerk2, pPerk);
								change = true;
							}
						}
					}
					else if (cond.type == "perk"){		//Checks if player has the perk
						var pPerk3:PerkType = cond.perk;
						if (ignorelist.indexOf(pPerk3) >= 0){
							perkArrMgmt(pPerk3, pPerk);
							change = true;
						}
					}
					else {	//The effect from this cause should never occur, as all these in masterlist should have a perk requirement of some sort.
						requirelen++
					}
				}
				if (requirelen == pPerk.requirements.length){
					outputText(pPerk.name() + "shouldn't be here. This is a bug. Please report it.");
				}
			}
			if (change){
				repPerkClr();
			}
			else{
				perkOut();
				//tempchk();	//DebugLine
			}
		}

		function perkArrMgmt(pval1:PerkType, pval2:PerkType):void{
			if (endlist.indexOf(pval1) >= 0){
				endlist.splice(endlist.indexOf(pval1), 1);
			}
			if (endlist.indexOf(pval2) < 0){
				endlist.push(pval2);
				ignorelist.push(pval2);
				masterlist.splice(masterlist.indexOf(pval2), 1);
			}
		}

		function perkOut():void {//Results of just the perks that are left.
			for each(var pPerk:PerkType in endlist.sort()) {
				outputText("<b>" + pPerk.name() + ":</b> ");
				try {
					var pclass:PerkClass = player.getPerk(pPerk);
					outputText(pclass?pPerk.desc(pclass):pPerk.longDesc);
				} catch (error:Error) {
					outputText("No description.");
				}
				outputText(" \n");
			}
		}

		function tempchk():void{//Debug function to see where specific perks have been sent to.
			//List of perks on my save that currently do not go where they're supposed to + neighbours/ expected sequence.
			var temp123:Array = [];
			//temp123 = masterlist.sort();
			//temp123.push();
			for each (var pPerks1:PerkType in temp123){
				var hi:Boolean = false;
				outputText(pPerks1.name() + ": ");
				if (masterlist.indexOf(pPerks1) >= 0){
					outputText("MasterList");
					hi = true
				}
				if (ignorelist.indexOf(pPerks1) >= 0){
					outputText("IgnoreList");
					hi = true
				}
				if (endlist.indexOf(pPerks1) >= 0){
					outputText("EndList");
					hi = true
				}
				if (!hi){
					outputText("Lost to the void");
				}
				outputText("\n");
			}
			outputText("Leftover/Cleared/Original Total: " +masterlist.length.toString() + "/" + ignorelist.length.toString() + "/" + maxpPerks.toString() + "\n");

		}
		initSet();
	}
	/* [INTERMOD: revamp]
	 public function ascToleranceOption():void{
	 clearOutput();
	 menu();
	 if (player.perkv2(PerkLib.AscensionTolerance) == 0){
	 outputText("Corruption Tolerance is under effect, giving you " + player.corruptionTolerance + " tolerance on most corruption events." +
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