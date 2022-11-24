/**
 * Created by aimozg on 22.05.2017.
 */
package classes.display {
import classes.BaseContent;
import classes.BodyParts.Face;
import classes.BodyParts.Tail;
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.IMutationPerkType;
import classes.IMutations.*;
import classes.PerkClass;
import classes.PerkLib;
import classes.PerkTree;
import classes.PerkType;
import classes.Races;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.Stats.StatUtils;
import classes.StatusEffects;

import coc.view.ButtonDataList;

import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.utils.Dictionary;

public class PerkMenu extends BaseContent {
	public function PerkMenu() {
	}
	public function displayPerks():void {
		clearOutput();
		displayHeader("Perks (Total: " + player.perks.length + ")");
		if (flags[kFLAGS.NEWPERKSDISPLAY] >= 1){
			playerPerksList();
		}
		else{
			var perkList:Array = player.perks;
			var mutationsArray:Array = IMutationsLib.mutationsArray("");
			mutationsArray.push(IMutationsLib.MutationsTemplateIM);
			//for each (var oldMutate:PerkType in MutationsLib.mutationsArray("", true)){
			//	mutationsArray.push(oldMutate)
			//}
			for each (var temp:PerkClass in perkList){
				if (!(mutationsArray.indexOf(temp.ptype) >= 0))
				{
					try{
						outputText("<b>" + temp.perkName + "</b> - " + temp.perkDesc + "\n");

					} catch (error:Error) {
						outputText(temp.perkName + " has encountered a problem. PLEASE REPORT THIS.");
						trace("Something about " + temp.perkName + " is broken. Might wanna check that?");
					}
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
		if ((player.calculateMultiAttacks() > 1) || combat.canSpearDance() ||player.hasPerk(PerkLib.Poisoning) || player.hasPerk(PerkLib.SwiftCasting) ||
			((player.hasPerk(PerkLib.JobBeastWarrior) || player.hasPerk(PerkLib.HistoryFeral) || player.hasPerk(PerkLib.PastLifeFeral)) && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon())) || player.hasPerk(PerkLib.NaturalInstincts) || player.hasPerk(PerkLib.WayOfTheWarrior) || player.hasPerk(PerkLib.Berzerker) ||
			((player.hasPerk(PerkLib.Lustzerker)) && player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) || player.hasPerk(PerkLib.LikeAnAsuraBoss) || TyrantiaFollower.TyrantiaTrainingSessions >= 20 || player.isRace(Races.JIANGSHI) ||
			((player.isStaffTypeWeapon() || player.isPartiallyStaffTypeWeapon() && player.weapon != weapons.TIDAR) && player.hasPerk(PerkLib.StaffChanneling))) {
			outputText("\n<b>You can adjust your melee attack settings.</b>");
			addButton(5, "Melee Opt",meleeOptions);
		}
		if (player.hasPerk(PerkLib.WeaponRangeDoubleStrike) || player.hasPerk(PerkLib.ElementalArrows) || player.hasPerk(PerkLib.Cupid) || player.hasPerk(PerkLib.EnvenomedBolt) || player.hasPerk(PerkLib.AmateurGunslinger)) {
			outputText("\n<b>You can adjust your range strike settings.</b>");
			addButton(6, "Range Opt",rangedOptions);
		}
		if (player.hasPerk(PerkLib.Venomancy) || player.hasPerk(PerkLib.DarkRitual) || player.hasPerk(PerkLib.HiddenJobBloodDemon)||
			(player.hasPerk(PerkLib.Spellsword) || player.hasPerk(PerkLib.Spellarmor) || player.hasPerk(PerkLib.Battleflash) || player.hasPerk(PerkLib.Battlemage) || player.hasPerk(PerkLib.Battleshield) || player.hasPerk(PerkLib.FortressOfIntellect))) {
			outputText("\n<b>You can choose and adjust various effects related to your magic.</b>");
			addButton(7, "Magic Opt",MagicOption);
		}
		outputText("\n<b>You can choose and adjust miscellaneous effects.</b>");
		addButton(8, "Misc Opt",MiscOption);
		//addButton (9, "PerkDB2", perkDatabase2); //WIP. //Apparently conflicts with Racial Score display
		if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
			outputText("\n<b>You can adjust your elemental summons behaviour during combat.</b>");
			addButton(10, "Elementals",summonsbehaviourOptions);
		}
		if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0 && player.hasPerk(PerkLib.FirstAttackGolems)) {
			outputText("\n<b>You can adjust your permanent golems behaviour during combat.</b>");
			addButton(11, "P.Golems",golemsbehaviourOptions);
		}
		if (player.hasPerk(PerkLib.JobLeader)) {
			outputText("\n<b>You can adjust your Will-o'-the-wisp behaviour during combat.</b>");
			addButton(12, "Will-o'-the-wisp",WOTWbehaviourOptions);
		}
		//addButton(10, "Number of", EngineCore.doNothing);
		//addButton(11, "perks: " + player.perks.length, EngineCore.doNothing);
		if (player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
			outputText("\n\n<b>Simplified Pre-Turn is enabled. The strongest possible golems and elementals are selected to attack. The wisp always attacks.</b>");
			addButton(13, "S.PTurn(On)", simplifiedPreTurnOff).hint("Click to disable Simplified Pre-Turn.");
		}
		else {
			outputText("\n\n<b>Simplified Pre-Turn is disabled. You'll need to click through your allies' turns, but you'll be able to choose their actions (if it's possible).\nNote: there is another switch for Will-o-Wisp in battle menu (page 3).</b>");
			addButton(13, "S.PTurn(Off)", simplifiedPreTurnOn).hint("Click to enable Simplified Pre-Turn.");
		}
	}

	private function simplifiedPreTurnOn():void {
		player.createStatusEffect(StatusEffects.SimplifiedNonPCTurn,0,0,0,0);
		displayPerks();
	}
	private function simplifiedPreTurnOff():void {
		player.removeStatusEffect(StatusEffects.SimplifiedNonPCTurn);
		displayPerks();
	}

	public function MagicOption(e:MouseEvent = null):void {
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.Venomancy)) {
			outputText("<b>You can adjust your Venomancy.</b>\n");
			addButton(1, "Venomancy Opt",VenomancyOption);
		}
		if (player.hasPerk(PerkLib.Spellsword) || player.hasPerk(PerkLib.Spellarmor) || player.hasPerk(PerkLib.Battleflash) || player.hasPerk(PerkLib.Battlemage) || player.hasPerk(PerkLib.Battleshield) || player.hasPerk(PerkLib.FortressOfIntellect)) {
			outputText("<b>You can adjust your spell autocast settings.</b>\n");
			addButton(2, "Spells Opt",spellOptions);
		}
		if (player.hasPerk(PerkLib.DarkRitual) || player.hasPerk(PerkLib.HiddenJobBloodDemon)) {
			if (player.hasPerk(PerkLib.DarkRitual)) outputText("<b>You can choose if you wish to use dark ritual and sacrifice health to empower your magic.</b>\n");
			if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) outputText("<b>You can adjust your Blood Demon hidden job settings.</b>\n");
			addButton(3, "Bloody Opt",DarkRitualOption);
		}
		addButton(14, "Back", displayPerks);
	}

	public function MiscOption():void {
		clearOutput();
		menu();
		var autoFlyingFlag:int = flags[kFLAGS.AUTO_FLIGHT];
        var setflag:Function = curry(setFlag,MiscOption);
		var toggleFlagMisc:Function = curry(toggleFlag,MiscOption);
		var autoFlyingType:Function = curry(setflag,kFLAGS.AUTO_FLIGHT);
        if (player.hasPerk(PerkLib.LiftOff)) {
			outputText("You can choose to start flying or not at the start of each combat.\n");
			outputText("Start: <b>");
			switch(autoFlyingFlag) {
				case 0: outputText("on the ground"); break;
				case 1: outputText("flying (by wings)"); break;
				case 2: outputText("flying (on flying sword)"); break;
				case 3: outputText("flying (using soulforce)"); break;
			}
			outputText("</b>");
			if (autoFlyingFlag != 0) addButton(0, "On Ground", autoFlyingType,0);
			if (player.canFly() && autoFlyingFlag != 1) addButton(1, "By Wings", autoFlyingType,1);
			if (player.hasPerk(PerkLib.FlyingSwordPath) && autoFlyingFlag != 2) addButton(2, "By FlyingSw", autoFlyingType,2);
			if (player.hasPerk(PerkLib.GclassHeavenTribulationSurvivor) && autoFlyingFlag != 3) addButton(3, "By SF", autoFlyingType,3);
		}
		if (player.hasPerk(PerkLib.AuraOfCorruption) || player.hasPerk(PerkLib.AuraOfPurity) || player.hasPerk(PerkLib.ArousingAura)) {
			outputText("\n\nYou can suppress your auras. This way, they won't damage/arouse enemies.");
			outputText("\nAuras: <b>" + (flags[kFLAGS.DISABLE_AURAS] ? "suppressed" : "active") + "</b>");
			addButton(5, "Auras", curry(toggleFlagMisc, kFLAGS.DISABLE_AURAS));
		}
		// auto hit mode :)
		outputText("\n\nYou can choose to stand still when selecting the 'Wait' actions. This way, you won't attempt to dodge or block any attacks. Why would you do that?!");
		outputText("\nCurrent 'Wait' behaviour: <b>" + (flags[kFLAGS.WAIT_STAND_STILL] ? "standing still" : "dodging") + "</b>");
		addButton(6, "StandStill", curry(toggleFlagMisc, kFLAGS.WAIT_STAND_STILL));
		//
		addButton(14, "Back", displayPerks);
	}

	public function meleeOptions():void {
		var bd:ButtonDataList = new ButtonDataList();
		var multiAttackStyle:int = flags[kFLAGS.MULTIATTACK_STYLE];
		var toggleFlagMelee:Function = curry(toggleFlag, meleeOptions);
		var zerkingStyle:Function = curry(setFlag, meleeOptions, kFLAGS.ZERKER_COMBAT_MODE);

		clearOutput();
		outputText("You will always attack " + (multiAttackStyle < 1 ? "once" :
			multiAttackStyle == 1 ? "twice" :
				NUMBER_WORDS_NORMAL[multiAttackStyle + 1] + " times"));
		outputText(" in combat turn."
			+ "\nYou can change it to a different amount of attacks.");
		bd.add("MultiAtk", pickMultiattack).hint("Change your amount of attacks.");
		if (player.hasPerk(PerkLib.SwiftCasting)) {
			outputText("\n\nIf you know specific spells you can cast them after doing a melee attack. (Working only with one-handed weapons and no shield)");
			outputText("\n\nSpell casted: <b>" + elementalArr[flags[kFLAGS.ELEMENTAL_MELEE]][1] + "</b>");
			bd.add("SwiftCasting", curry(selectElemental, meleeOptions, kFLAGS.ELEMENTAL_MELEE));
		}
		//build the buttondatalist
		if (player.hasPerk(PerkLib.JobBeastWarrior) || player.isRace(Races.JIANGSHI)) {
			outputText("\n\nYou can choose between fighting feral or normaly with your fists. (Req. to have natural attacks or a gaunlet type weapon with claws to enable feral mode)");
			outputText("\nFighting Style: <b>" + (flags[kFLAGS.FERAL_COMBAT_MODE] ? "Feral" : "Normal") + "</b>");
			bd.add("Normal/Feral", curry(toggleFlagMelee, kFLAGS.FERAL_COMBAT_MODE))
				.disableIf(!(player.weaponName == "fists" && player.hasNaturalWeapons() || player.haveNaturalClawsTypeWeapon()), "You need to be unarmed and possess a natural weapon OR to have equipped gaunlets with any type of artifical claws.");
		}
		if ((player.hasPerk(PerkLib.Berzerker) || player.hasPerk(PerkLib.Lustzerker)) && player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) {
			outputText("\n\nYou can choose between starting fight with berserker, lustzerker, both or none.");
			outputText("\nBerzerker: <b>" + (getBit(flags[kFLAGS.ZERKER_COMBAT_MODE], 0) ? "Autocast" : "Manual") + "</b>");
			outputText("\nLustzerker: <b>" + (getBit(flags[kFLAGS.ZERKER_COMBAT_MODE], 1) ? "Autocast" : "Manual") + "</b>");
			if (player.hasPerk(PerkLib.Berzerker))
				bd.add("Berserking", curry(zerkingStyle, xorBit(flags[kFLAGS.ZERKER_COMBAT_MODE], 0)));
			if (player.hasPerk(PerkLib.Lustzerker))
				bd.add("Lustzerking", curry(zerkingStyle, xorBit(flags[kFLAGS.ZERKER_COMBAT_MODE], 1)));
		}
		if (player.hasPerk(PerkLib.NaturalInstincts)) {
			outputText("\n\nYou can choose between starting fight with Crinos Shape active or not.");
			outputText("\nCrinos Shape: <b>" + (flags[kFLAGS.CRINOS_SHAPE_COMBAT_MODE] ? "Autocast" : "Manual") + "</b>");
			bd.add("CrinosShape", curry(toggleFlagMelee, kFLAGS.CRINOS_SHAPE_COMBAT_MODE));
		}
		if (player.hasPerk(PerkLib.WayOfTheWarrior)) {
			outputText("\n\nYou can choose between starting fight with warrior's rage active or not.");
			outputText("\nWarrior's Rage: <b>" + (flags[kFLAGS.WARRIORS_RAGE_COMBAT_MODE] ? "Autocast" : "Manual") + "</b>");
			bd.add("WarriorsRage", curry(toggleFlagMelee, kFLAGS.WARRIORS_RAGE_COMBAT_MODE));
		}
		if (TyrantiaFollower.TyrantiaTrainingSessions >= 20) {
			outputText("\n\nYou can choose between starting fight with Tyrant State active or not.");
			outputText("\nTyrant State: <b>" + (flags[kFLAGS.TYRANT_STATE_COMBAT_MODE] ? "Autocast" : "Manual") + "</b>");
			bd.add("TyrantState", curry(toggleFlagMelee, kFLAGS.TYRANT_STATE_COMBAT_MODE));
		}
		if (player.hasPerk(PerkLib.LikeAnAsuraBoss)) {
			outputText("\n\nYou can choose between starting fight with Asura form active or not. (If Crinos Shape toggle is set on Autocast this one toggle will be ignored and only crinos Shape would be autocasted)");
			outputText("\nAsura Form: <b>" + (flags[kFLAGS.ASURA_FORM_COMBAT_MODE] ? "Autocast" : "Manual") + "</b>");
			bd.add("AsuraForm", curry(toggleFlagMelee, kFLAGS.ASURA_FORM_COMBAT_MODE));
		}
		if (player.hasPerk(PerkLib.Poisoning)) {
			outputText("\n\nIf you can naturaly produce venom, you can add its effects to your weapon. (Works only with small weapons; requires to have a poisonous bodypart)");
			outputText("\nVenom effect added: <b>" + (flags[kFLAGS.ENVENOMED_MELEE_ATTACK] ? "Yes" : "No") + "</b>");
			bd.add("Venom", curry(toggleFlagMelee, kFLAGS.ENVENOMED_MELEE_ATTACK))
				.disableIf(!canVenomAttacks(), "You need a source of poison for this.");
		}
		if (player.hasPerk(PerkLib.StaffChanneling)) {
			outputText("\n\nYou can toggle Staff Channeling.");
			outputText("\nStaff Channeling: <b>" + (flags[kFLAGS.STAFF_CHANNELING_MODE] ? "Active" : "Inactive") + "</b>");
			bd.add("Channelling", curry(toggleFlagMelee, kFLAGS.STAFF_CHANNELING_MODE));
		}
		submenu(bd, CoC.instance.inCombat ? curry(combat.combatMenu, false) : displayPerks, 0, false);
	}

	private function canVenomAttacks():Boolean {
		return player.tailType == Tail.BEE_ABDOMEN
			|| player.tailType == Tail.SCORPION
			|| player.tailType == Tail.MANTICORE_PUSSYTAIL
			|| player.faceType == Face.SNAKE_FANGS
			|| player.faceType == Face.SPIDER_FANGS;
	}

	private function get elementalArr():Array {
		return [
			// name, spell name, spell effect; number = array pos
			["None", "None", null],
			["Fire", "Whitefire", StatusEffects.KnowsWhitefire],
			["Ice", "Ice Spike", StatusEffects.KnowsIceSpike],
			["Lightning", "Lightning Bolt", StatusEffects.KnowsLightningBolt],
			["Darkness", "Darkness Shard", StatusEffects.KnowsDarknessShard],
			["Water", "Water Ball", StatusEffects.KnowsWaterBall],
			["Wind", "Wind Bullet", StatusEffects.KnowsWindBullet],
			["Earth", "Stalagmite", StatusEffects.KnowsStalagmite],
			["Acid", "Acid Spray", StatusEffects.KnowsAcidSpray],
		]
	}

	private function selectElemental(back:Function, flag:int):void {
		var scArr:Array = elementalArr;
		var elementalFun:Function = curry(setFlag, back, flag);
		menu();
		for (var id:int = 0; id < scArr.length; ++id) {
			var scItem:Array = scArr[id];
			addButton(id, scItem[0], elementalFun, id)
				.disableIf(flags[flag] == id, "Already selected")
				.disableIf(scItem[2] != null && !player.hasStatusEffect(scItem[2]),
					"You don't possess the knowledge of the required spell (" + scItem[1] + ").");
		}
		addButton(14, "Back", back);
	}

	private function pickMultiattack():void {
		var multiAttackStyle:Function = curry(setFlag, meleeOptions, kFLAGS.MULTIATTACK_STYLE);
		var currentAttacks:int = flags[kFLAGS.MULTIATTACK_STYLE];
		var maxAttacks:int = combat.maxCurrentAttacks();
		clearOutput();
		if (player.weaponSpecials("Staff") || player.weaponSpecials("Wand")) {
			outputText("You can't multi-attack with wands or staves!\n\n");
			doNext(meleeOptions);
			return;
		}
		outputText("Current number of attacks: " + (currentAttacks + 1) + "\n");
		outputText("Maximum number of attacks with your current weapon: " + maxAttacks + "\n");
		var nba:int = player.nextBonusAttack();
		if (nba < 0) outputText("You've reached the maximum number of bonus attacks from mastery!");
		else outputText("Next bonus attack at mastery level " + nba);
		outputText("\n\nHow many attacks would you like to deal?");
		menu();
		var atk:int = 0;
		while (atk < maxAttacks) {
			addButton(atk, NUMBER_WORDS_CAPITAL[atk + 1], multiAttackStyle, atk)
				.disableIf(currentAttacks == atk, "Already selected");
			atk++;
		}
		addButton(14, "Back", meleeOptions);
	}

	private function pickMultishot():void {
		var multiShotStyle:Function = curry(setFlag, rangedOptions, kFLAGS.MULTISHOT_STYLE);
		var currentProj:int = flags[kFLAGS.MULTISHOT_STYLE];
		var maxProj:int = combat.maxCurrentRangeAttacks();
		clearOutput();
		outputText("Current number of projectiles per shot: " + (currentProj + 1) + "\n");
		outputText("Maximum number of projectiles per shot with your current weapon: " + maxProj + "\n");
		menu();
		var atk:int = 0;
		while (atk < maxProj) {
			addButton(atk, NUMBER_WORDS_CAPITAL[atk + 1], multiShotStyle, atk)
				.disableIf(currentProj == atk, "Already selected");
			atk++;
		}
		addButton(14, "Back", meleeOptions);
	}

	public function rangedOptions():void {
		var bd:ButtonDataList = new ButtonDataList();
		var currentProj:int = flags[kFLAGS.MULTISHOT_STYLE];
		var toggleFlagRanged:Function = curry(toggleFlag, rangedOptions);

		clearOutput();
		outputText("You will always shoot " + NUMBER_WORDS_NORMAL[currentProj + 1] + " projectiles."
			+ "\nYou can change it to a different amount of projectiles.");
		bd.add("MultiShot", pickMultishot).hint("Change your amount of projectiles.");
		if (player.hasPerk(PerkLib.ElementalArrows)) {
			outputText("\n\nIf you know specific spells, you can add some magical effects to the projectiles. (Works only with bows and crosbows)");
			outputText("\n\nElemental effect added: <b>" + elementalArr[flags[kFLAGS.ELEMENTAL_ARROWS]][0] + "</b>");
			bd.add("Elemental", curry(selectElemental, rangedOptions, kFLAGS.ELEMENTAL_ARROWS));
		}
		if (player.hasPerk(PerkLib.Cupid)) {
			outputText("\n\nIf you know 'Arouse' spell, you can add its effect to the projectiles. (Works only with bows and crosbows)"
				+ "\nArouse effect added: <b>" + (flags[kFLAGS.CUPID_ARROWS] ? "Yes" : "No") + "</b>");
			if (flags[kFLAGS.CUPID_ARROWS] == 0) outputText("\n\nArouse effect added: <b>None</b>");
			if (flags[kFLAGS.CUPID_ARROWS] == 1) outputText("\n\nBlack Magic effect added: <b>Arouse</b>");
			bd.add("Arouse", curry(toggleFlagRanged, kFLAGS.CUPID_ARROWS))
				.disableIf(!player.hasStatusEffect(StatusEffects.KnowsArouse), "You don't know the required spell.");
		}
		if (player.hasPerk(PerkLib.EnvenomedBolt)) {
			outputText("\n\nIf you can naturaly produce venom, you can add its effects to the projectiles. (Works only with bows and crosbows)"
				+ "\nVenom effect added: <b>" + (flags[kFLAGS.ENVENOMED_BOLTS] ? "Yes" : "No") + "</b>");
			bd.add("Venom", curry(toggleFlagRanged, kFLAGS.ENVENOMED_BOLTS))
				.disableIf(!canVenomAttacks(), "You need a source of poison for this.");
		}
		submenu(bd, CoC.instance.inCombat ? curry(combat.combatMenu, false) : displayPerks, 0, false);
	}

	public function spellOptions():void {
		var autocasts:Array = [
			// Name, flag, requirement
			["Charge Weapon", kFLAGS.AUTO_CAST_CHARGE_WEAPON, PerkLib.Spellsword],
			["Charge Armor", kFLAGS.AUTO_CAST_CHARGE_ARMOR, PerkLib.Spellarmor],
			["Might", kFLAGS.AUTO_CAST_MIGHT, PerkLib.Battlemage],
			["Blink", kFLAGS.AUTO_CAST_BLINK, PerkLib.Battleflash],
			["Mana Shield", kFLAGS.AUTO_CAST_MANA_SHIELD, PerkLib.Battleshield],
		];
		var toggleFlagMagic:Function = curry(toggleFlag, spellOptions);
		var btn:int = 0;
		clearOutput();
		menu();
		outputText("You can choose to autocast or not specific buff spells at the start of the combat.");
		for each (var autoItem:Array in autocasts) {
			if (player.hasPerk(autoItem[2])) {
				outputText("\n\n" + autoItem[0] + ": <b>" + (flags[autoItem[1]] ? "Autocast" : "Manual") + "</b>");
				addButton(btn++, autoItem[0], curry(toggleFlagMagic, autoItem[1]));
			}
		}
		if (player.hasPerk(PerkLib.FortressOfIntellect)) {
			outputText("\n\nFortress of Intellect: <b>" + (player.hasStatusEffect(StatusEffects.FortressOfIntellect) ? "On" : "Off") + "</b>");
			addButton(btn++, "FoI", toggleFortressOfIntelect);
		}
		addButton(14, "Back", MagicOption);

		function toggleFortressOfIntelect():void {
			if (!player.hasStatusEffect(StatusEffects.FortressOfIntellect)) player.createStatusEffect(StatusEffects.FortressOfIntellect, 0, 0, 0, 0);
			else player.removeStatusEffect(StatusEffects.FortressOfIntellect);
			spellOptions();
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
		if (flags[kFLAGS.WILL_O_THE_WISP] == 2) outputText("Commanding other pets or minions (other minions will get boost to dmg).");
		if (flags[kFLAGS.WILL_O_THE_WISP] == 1) outputText("Attacking at the begining of each turn. (Need to confirm attack order each turn)");
		if (flags[kFLAGS.WILL_O_THE_WISP] == 0) outputText("Attacking at the begining of each turn. (No need to confirm attack order each turn)");
		if (flags[kFLAGS.WILL_O_THE_WISP] != 0) addButton(10, "Attacking(A)", WOTWAttacking, 0).hint("Would attack without need to confirm attack order.");
		if (flags[kFLAGS.WILL_O_THE_WISP] != 1) addButton(11, "Attacking(M)", WOTWAttacking, 1).hint("Would attack after confirming attack order.");
		if (flags[kFLAGS.WILL_O_THE_WISP] != 2) addButton(12, "Commanding", WOTWAttacking, 2);

		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu, false);
		else addButton(14, "Back", displayPerks);
        function WOTWAttacking(attacking:Number):void {
            flags[kFLAGS.WILL_O_THE_WISP] = attacking;
            WOTWbehaviourOptions();
        }
	}

	//IMutationsDB!
	public function mutationsDatabase(page:int = 0, review:Boolean = false):void{
		/*
		Source: IMutationsLib.as for all mutations.
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

			outputText("Mutations can be obtained by ");
			if (flags[kFLAGS.MUTATIONS_SPOILERS] || EvangelineFollower.EvangelineAffectionMeter >= 3){
				outputText("finding Evangeline and asking her about it.\n");
			}
			else{
				outputText("looking around for an alchemist specializing in transformatives.\n");
			}
			outputText("Mutations Assistant is toggleable in settings, and hides/shows you available mutations. It is off by default.\n\n");

			outputText("<b><i><u>Mutations used per bodypart:</u></i></b>\n");
			for each (var bodyPart:String in IMutationPerkType.SlotList){
				var mCount:int = 0
				var mPerkarray:Array = IMutationsLib.mutationsArray(bodyPart);
				for each (var mutations:IMutationPerkType in mPerkarray){
					if (player.perkv1(mutations) > 0){
						mCount++;
					}
				}
				mutationCount = player.maxTotalMutationsInSlot(bodyPart);
				outputText(IMutationPerkType.Slots[bodyPart].name + " mutations obtained: ");
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
		}

		function mutationsDBSlot(slot:String, pageAdd:int = 0):void{
			clearOutput();
			//Heart Mutations
			displayHeader(IMutationPerkType.Slots[slot].name+" Mutations:");
			mutationsDatabaseVerify(IMutationsLib.mutationsArray(slot));
			mutationsDatabase(pageAdd);
			addButton(11, moreInfo ? "LESS INFO" : "MORE INFO", moreInfoSwitch, curry(mutationsDBSlot, slot, pageAdd))
				.hint(moreInfo ? "Display only the current and next tiers." : "Display all mutation tiers and stat buffs");
		}

		function mutationsDBDragon():void{
			clearOutput();
			//Dragon Mutations
			displayHeader("Dragon Mutations");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) outputText("\nThere is an extra bonus mutation slot given due to NG+");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) outputText("\nThere is another extra bonus mutation slot given due to NG++");
			mutationsDatabaseVerify([IMutationsLib.DraconicBonesIM, IMutationsLib.DraconicHeartIM, IMutationsLib.DraconicLungIM]);
			mutationsDatabase(1);
			addButton(11, moreInfo ? "LESS INFO" : "MORE INFO", moreInfoSwitch, mutationsDBDragon)
				.hint(moreInfo ? "Display only the current and next tiers." : "Display all mutation tiers and stat buffs");
		}

		function mutationsDBKitsune():void{
			clearOutput();
			//Kitsune Mutations
			displayHeader("Kitsune Mutations");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) outputText("\nThere is an extra bonus mutation slot given due to NG+");
			mutationsDatabaseVerify([IMutationsLib.KitsuneThyroidGlandIM, IMutationsLib.KitsuneParathyroidGlandsIM]);
			mutationsDatabase(1);
			addButton(11, moreInfo ? "LESS INFO" : "MORE INFO", moreInfoSwitch, mutationsDBKitsune)
				.hint(moreInfo ? "Display only the current and next tiers." : "Display all mutation tiers and stat buffs");
		}

		var bd:ButtonDataList = new ButtonDataList();
		//This was originally hard coded buttons. Which it can still be, I suppose.
		bd.add("Heart",  curry(mutationsDBSlot, IMutationPerkType.SLOT_HEART), "Heart Mutations");
		bd.add("Muscle",  curry(mutationsDBSlot, IMutationPerkType.SLOT_MUSCLE), "Muscle Mutations");
		bd.add("Mouth",  curry(mutationsDBSlot, IMutationPerkType.SLOT_MOUTH), "Mouth Mutations");
		bd.add("Adrenal Glands", curry(mutationsDBSlot, IMutationPerkType.SLOT_ADRENALS), "Adrenal Mutations");
		bd.add("Bloodstream", curry(mutationsDBSlot, IMutationPerkType.SLOT_BLOODSTREAM), "Bloodstream Mutations");
		bd.add("Fat and Tissue",  curry(mutationsDBSlot, IMutationPerkType.SLOT_FAT), "FaT Mutations");
		bd.add("Lungs", curry(mutationsDBSlot, IMutationPerkType.SLOT_LUNGS), "Lungs Mutations");
		bd.add("Metabolism",  curry(mutationsDBSlot, IMutationPerkType.SLOT_METABOLISM), "Metabolism Mutations");
		bd.add("Ovaries",  curry(mutationsDBSlot, IMutationPerkType.SLOT_OVARIES), "Ovaries Mutations");
		bd.add("Testicles",  curry(mutationsDBSlot, IMutationPerkType.SLOT_TESTICLES), "Testicle Mutations");
		bd.add("Eyes",  curry(mutationsDBSlot, IMutationPerkType.SLOT_EYES), "Eyes Mutations");
		bd.add("Bone/Marrow",  curry(mutationsDBSlot, IMutationPerkType.SLOT_BONE), "Bone Mutations");
		bd.add("Nerv/Sys", curry(mutationsDBSlot, IMutationPerkType.SLOT_NERVSYS, 1), "Nerv-Sys Mutations");
		bd.add("Thyroid Gland", curry(mutationsDBSlot, IMutationPerkType.SLOT_THYROID, 1), "Thyroid Mutations");
		bd.add("Parathyroid Gland", curry(mutationsDBSlot, IMutationPerkType.SLOT_PARATHYROID, 1), "Parathyroid Mutations");
		bd.add("Adaptations", curry(mutationsDBSlot, IMutationPerkType.SLOT_ADAPTATIONS, 1), "Adaptation Mutations");
		bd.add("Dragons", mutationsDBDragon, "Dragon Mutations");
		bd.add("Kitsunes", mutationsDBKitsune, "Kitsune Mutations");
		submenu(bd, displayPerks, page, false, 11); // reserving 11 for the switch
	}

	private var moreInfo:Boolean = false; //no need to save, so keep it here
	private function moreInfoSwitch(callAfter:Function):void {
		moreInfo = !moreInfo;
		callAfter(); //update text and buttons
	}

	//Mutations check helper. Cloned + stripped requirements logic from PerkMenuDB.
	public function mutationsDatabaseVerify(mutationsArray:Array):void {
		if(flags[kFLAGS.MUTATIONS_SPOILERS]) {
			for each(var mutation:IMutationPerkType in mutationsArray) {
				var pMutateLvl:int = player.perkv1(mutation);
				if (pMutateLvl > 0) {	//Just checking if you have the base.
					outputText("\n" + mutation.name() + ": [font-green]Acquired.[/font]");
				} else {
					outputText("\n" + mutation.name() + ": [font-red]Missing.[/font]");
				}
				outputText("\nTier: " + pMutateLvl + " of " + mutation.maxLvl + ".");
				var reqs:Array = [];
				if (mutation.maxLvl != pMutateLvl) {
					mutation.pReqs()	//Forces requirements to load up
					if (mutation.requirements.length == 0) reqs.push("Missing data. Perhaps Unacquirable?");
					else {
						for each (var cond:Object in mutation.requirements) {
							var reqStr:String = cond.text;
							var color:String = "";
							if (!(reqStr.indexOf("Mutation") >= 0)) { //Ignores the "free mutation slot" note.
								if (cond.fn(player)) {
									color = "[font-green]";
								} else {
									color = "[font-red]";
								}
								reqs.push(color+cond.text+"[/font]");
							}
						}
					}
				}
				if (mutation.maxLvl == pMutateLvl) {	//Highest tier.
					reqs.push("You already have the highest tier.");
				}
				outputText("\nRequirements for next tier: " + reqs.join(", "));

				if (pMutateLvl > 0) {
					outputText("\nCurrent Tier Description: ");
					if(mutation.mDesc(player.getPerk(mutation), pMutateLvl).length <= 1) {	//Some desc. contains only "."
						outputText("Error in description for Mutation "+ mutation.name() +".");
					} else{
						outputText(mutation.mDesc(player.getPerk(mutation), pMutateLvl));
					}
				}

				if (moreInfo) {
					outputText("\nAll Tier Descriptions:");
					for (var tier:int = 1; tier <= mutation.maxLvl; ++tier)
						outputText("\n" + tier + ": " + mutation.mDesc(player.getPerk(mutation), tier) + "; " + mutation.explainBuffs(tier));
				} else if (mutation.maxLvl != pMutateLvl) {
					outputText("\nNext Tier Description: ");
					if (mutation.mDesc(player.getPerk(mutation), pMutateLvl).length <= 1) {	//Some desc. contains only "."
						if (!player.hasMutation(mutation)) outputText(mutation.mDesc(player.getPerk(mutation), 1));
						else outputText("Error in description for Mutation " + mutation.name() + ".");
					} else {
						outputText(mutation.mDesc(player.getPerk(mutation), pMutateLvl + 1));
					}
				}

				outputText("\n\n");
				var tempObj:Object = mutation.pBuffs(player)
				for (var key:String in tempObj) {
					outputText("" + StatUtils.explainBuff(key, tempObj[key]) + "\n");
				}
				outputText("\n");
			}
		}
		else{
			for each(var mutation2:IMutationPerkType in mutationsArray) {
				var pMutateLvl2:int = player.perkv1(mutation2);
				if (player.hasMutation(mutation2)) {
					outputText("\n" + mutation2.name() + ": [font-green]Acquired.[/font]");
					outputText("\nTier: " + player.perkv1(mutation2));
					outputText("\nDescription: ");
					if (mutation2.mDesc(player.getPerk(mutation2), pMutateLvl2).length <= 1) {	//Some desc. contains only "."
						if (player.perkv1(mutation2) == 0) outputText("You don't have this Mutation yet.");
						else outputText("No description available.");
					} else {
						outputText(mutation2.mDesc(player.getPerk(mutation2), pMutateLvl2));
					}
					outputText("\n\n");
					var tempObj2:Object = mutation2.pBuffs(player);
					for (var key2:String in tempObj2) {
						outputText("Buffs " + StatUtils.explainBuff(key2, tempObj2[key2]) + "\n");
					}
				} else {
					outputText("\n???" + "\n Tier: ?" + "\nDescription: ???");
				}
			}
		}
		outputText("\n");
	}

	public function perkDatabase(page:int=0, count:int=50):void {
		var allPerks:Array = PerkTree.obtainablePerks().sort();
		var mutationList2:Array = IMutationsLib.mutationsArray("All");

		var temp:Array = [];
		for each(var pPerks:PerkType in allPerks) {
			if (!(mutationList2.indexOf(pPerks) >= 0)){
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
			var pList2:Array = PerkLib.enemyPerkList(); //No Enemy Perks.
			var pList3:Array = PerkLib.gearPerks();	//No Gear Perks.
			var pList4:Array = PerkLib.weaPerks();	//No Weapons Perks.
			//function pSpecialRem = No Ascension/History/Bloodline/PastLife Perks
			var pList5:Array = IMutationsLib.mutationsArray("All");
			var mArray:Array = arrMerge(pList2, pList3, pList4, pList5);
			for each (var perkTrue:PerkType in perkDict){
				if (!(mArray.indexOf(perkTrue) >= 0) && pSpecialRem(perkTrue)){
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
			var selected:PerkClass = fPerkCList[e.text].perk;	///For some reason, this is triggering and faulting here when opening racial scores from Aimozg.....what???
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

		var lhVal:int = 0;
		function dMenuLinker(tPVal:int, srcArr:Array):void{	//Interaction linking
			var fPerkCList:Array = [];
			lhVal = tPVal;
			mainView.mainText.addEventListener(TextEvent.LINK, curry(pInfoDP, tPVal));
			for each(var perk:PerkType in srcArr.sort()) {
				var p:PerkClass = new PerkClass(perk,
						perk.defaultValue1, perk.defaultValue2, perk.defaultValue3, perk.defaultValue4);
				var lab:* = {label: p.perkName, perk: p};
				fPerkCList.push(lab);
				outputText("<u><a href=\"event:"+fPerkCList.indexOf(lab)+"\">"+p.perkName+"</a></u>\n");
			}
		}

		function cleanupBeforeReturns():void{
			mainView.mainText.removeEventListener(TextEvent.LINK, curry(pInfoDP, lhVal));
			displayPerks();
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
			addButton(14, "Back", cleanupBeforeReturns);
		}

		displayMenu();
	}

	private function toggleFlag(returnTo:Function, flag:int):void {
		setFlag(returnTo, flag, flags[flag] ? 0 : 1);
	}

	private function setFlag(returnTo:Function, flag:int, val:int):void {
		flags[flag] = val;
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
			var mutationList2:Array = IMutationsLib.mutationsArray("All");

			for each(var pPerks:PerkClass in pPerkList) { //Cleans up the list of mutations and no-perk requiring perks
				if (!(mutationList2.indexOf(pPerks.ptype) >= 0)){
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

	public static function arrMerge(...arrays):Array {
		var result:Array = [];
		for(var i:int=0;i<arrays.length;i++){
			result = result.concat(arrays[i]);
		}
		return result.sort();
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
