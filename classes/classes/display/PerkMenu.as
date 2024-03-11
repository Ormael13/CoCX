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
import classes.internals.Utils;
import classes.Parser.Parser;
import classes.PerkClass;
import classes.PerkLib;
import classes.PerkTree;
import classes.PerkType;
import classes.Races;
import classes.Scenes.Combat.CombatAbilities;
import classes.Scenes.NPCs.EvangelineFollower;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.Scenes.SceneLib;
import classes.Stats.StatUtils;
import classes.StatusEffects;

import coc.view.Block;
import coc.view.ButtonDataList;
import coc.view.CoCButton;
import coc.view.MainView;
import coc.view.UIUtils;

import flash.events.MouseEvent;
import flash.events.TextEvent;
import flash.text.TextField;
import flash.text.TextFieldAutoSize;
import flash.utils.Dictionary;

public class PerkMenu extends BaseContent {
	public function PerkMenu() {
	}
	public function displayPerks():void {
		clearOutput();
		displayHeader("Perks (Total: " + (player.perks.length + player.perksCountForMergedOnes()) + " / Merged: " + player.perksCountForMergedOnes() + ")");
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
		} else {
			button(1).show("Menu", newPerkMenu);
		}
		if (player.superPerkPoints > 0) {
			outputText("\n<b>You have " + num2Text(player.superPerkPoints) + " super perk point");
			if(player.superPerkPoints > 1) outputText("s");
			outputText(" to spend.</b>");
		}
		addButton(2, "SuperPerk Up", CoC.instance.playerInfo.superPerkBuyMenu);
		addButton(3, "Mutations DB", mutationsDatabase, 0, true);
		if (sorter === sorterRelativeDistance) sortedPerks = null; // clear cache, relative distance could've been changed
		addButton(4, "Perks Database", perkDatabase);
		if ((player.calculateMultiAttacks() > 1) || combat.canSpearDance() ||player.hasPerk(PerkLib.Poisoning) || player.hasPerk(PerkLib.SwiftCasting) ||
			((player.hasPerk(PerkLib.JobBeastWarrior) || player.hasPerk(PerkLib.HistoryFeral) || player.hasPerk(PerkLib.PastLifeFeral)) && (player.haveNaturalClaws() || player.haveNaturalClawsTypeWeapon())) || player.hasPerk(PerkLib.NaturalInstincts) || player.hasPerk(PerkLib.WayOfTheWarrior) || player.hasPerk(PerkLib.Berzerker) ||
			((player.hasPerk(PerkLib.Lustzerker)) && player.perkv1(IMutationsLib.SalamanderAdrenalGlandsIM) >= 3) || player.hasPerk(PerkLib.LikeAnAsuraBoss) || TyrantiaFollower.TyrantiaTrainingSessions >= 20 || player.isRace(Races.JIANGSHI) ||
			((player.isStaffTypeWeapon() || player.isPartiallyStaffTypeWeapon() && player.weapon != weapons.TIDAR) && player.hasPerk(PerkLib.StaffChanneling))) {
			outputText("\n<b>You can adjust your melee attack settings.</b>");
			addButton(5, "Melee Opt",meleeOptions);
		}
		if (player.calculateMultiAttacks(false) > 1 || player.hasPerk(PerkLib.ELFTwinShot) || player.hasPerk(PerkLib.ElementalArrows) || player.hasPerk(PerkLib.Cupid) || player.hasPerk(PerkLib.EnvenomedBolt) || player.hasPerk(PerkLib.ELFThornShot)) {
			outputText("\n<b>You can adjust your range strike settings.</b>");
			addButton(6, "Range Opt",rangedOptions);
		}
		if (player.hasPerk(PerkLib.Venomancy) || player.hasPerk(PerkLib.DarkRitual) || player.hasPerk(PerkLib.HiddenJobBloodDemon)||
			(player.hasPerk(PerkLib.Autocast) ||  player.hasPerk(PerkLib.FortressOfIntellect))) {
			outputText("\n<b>You can choose and adjust various effects related to your magic.</b>");
			addButton(7, "Magic Opt",magicOption);
		}
		outputText("\n<b>You can choose and adjust miscellaneous effects.</b>");
		addButton(8, "Misc Opt",MiscOption);
		//addButton(10, "Number of", EngineCore.doNothing);
		//addButton(11, "perks: " + player.perks.length, EngineCore.doNothing);
		if (player.hasPerk(PerkLib.FirstAttackFlyingSword)) {
			outputText("\n<b>You can adjust your Flying Sword behaviour during combat.</b>");
			addButton(12, "Flying Sword", flyingSwordBehaviourOptions);
		}
		outputText("\n<b>You can choose and adjust how you minions behave in battle.</b>");
		addButton(13, "Minions", minionOptions);
		if (player.hasStatusEffect(StatusEffects.SimplifiedNonPCTurn)) {
			outputText("\n\n<b>Simplified Pre-Turn is enabled. The strongest possible golems and elementals are selected to attack. The wisp always attacks.</b>");
			addButton(14, "S.PTurn(On)", simplifiedPreTurnOff).hint("Click to disable Simplified Pre-Turn.");
		}
		else {
			outputText("\n\n<b>Simplified Pre-Turn is disabled. You'll need to click through your allies' turns, but you'll be able to choose their actions (if it's possible).\nNote: there is another switch for Will-o-Wisp in battle menu (page 3).</b>");
			addButton(14, "S.PTurn(Off)", simplifiedPreTurnOn).hint("Click to enable Simplified Pre-Turn.");
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

	public function magicOption(e:MouseEvent = null):void {
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.Venomancy)) {
			outputText("<b>You can adjust your Venomancy.</b>\n");
			addButton(1, "Venomancy Opt",venomancyOption);
		}
		if (player.hasPerk(PerkLib.Autocast) || player.hasPerk(PerkLib.FortressOfIntellect)) {
			outputText("<b>You can adjust your spell autocast settings.</b>\n");
			addButton(2, "Spells Opt",spellOptions);
		}
		if (player.hasPerk(PerkLib.DarkRitual) || player.hasPerk(PerkLib.HiddenJobBloodDemon)) {
			if (player.hasPerk(PerkLib.DarkRitual)) outputText("<b>You can choose if you wish to use dark ritual and sacrifice health to empower your magic.</b>\n");
			if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) outputText("<b>You can adjust your Blood Demon hidden job settings.</b>\n");
			addButton(3, "Bloody Opt",darkRitualOption);
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
		if (player.hasCombatAura()) {
			outputText("\n\nYou can suppress your auras. This way, they won't damage/arouse enemies.");
			outputText("\nAuras: <b>" + (flags[kFLAGS.DISABLE_AURAS] ? "Suppressed" : "Active") + "</b>");
			addButton(5, "Auras", curry(toggleFlagMisc, kFLAGS.DISABLE_AURAS));
		}
		// auto hit mode :)
		outputText("\n\nYou can choose to stand still when selecting the 'Wait' actions. This way, you won't attempt to dodge or block any attacks. Why would you do that?!");
		outputText("\nCurrent 'Wait' behaviour: <b>" + (flags[kFLAGS.WAIT_STAND_STILL] ? "Standing still" : "Dodging") + "</b>");
		addButton(6, "Wait", curry(toggleFlagMisc, kFLAGS.WAIT_STAND_STILL));
		// corruption tolerance
		if (player.hasPerk(PerkLib.AscensionTolerance) || !CoC.instance.lockCheats) {
			outputText("\n\nYou can temporarily enable or disable your corruption tolerance.");
			if (!CoC.instance.lockCheats) outputText(" <i>Since you have cheats enabled, you can force it to be 100.</i>");
			outputText("\nCorruption Tolerance mode: <b>" + (
				flags[kFLAGS.CORRUPTION_TOLERANCE_MODE] == 0 ? "Enabled (" + player.corruptionTolerance + ")" :
					flags[kFLAGS.CORRUPTION_TOLERANCE_MODE] == 1 ? "Disabled (0)" : "CHEAT (100)") + "</b>");
			addButton(7, "CorTolerance", toggleCorruptionTolerance);
		}
		// tease healing
		if (player.hasPerk(PerkLib.FueledByDesire) || player.armor == armors.ELFDRES) {
			outputText("\n\nCombat Tease can cause lust reduction: " + (
					flags[kFLAGS.COMBAT_TEASE_HEALING] == 0 ? "Enabled" : "Disabled"
			));
			addButton(10, "C. Tease Heal", curry(toggleFlagMisc, kFLAGS.COMBAT_TEASE_HEALING));
		}
		// your pain, my power wrath generation
		if (player.hasPerk(PerkLib.YourPainMyPower)) {
			outputText("\n\nYou choose whether wrath is generated while healing from blood: " + (
				flags[kFLAGS.YPMP_WRATH_GEN] == 0 ? "Enabled" : "Disabled"
			));
			addButton(11, "YPMP Wrath", curry(toggleFlagMisc, kFLAGS.YPMP_WRATH_GEN));
		}
		addButton(14, "Back", displayPerks);
	}

	public function minionOptions():void {
		var bd:ButtonDataList = new ButtonDataList();
		clearOutput();
		outputText("You can choose how your pets and minions attack:");

		menu();
		if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) {
			outputText("\n<b>You can adjust your elemental summons behaviour during combat.</b>");
			bd.add("Elementals", summonsbehaviourOptions);
		}
		if ((flags[kFLAGS.PERMANENT_GOLEMS_BAG] > 0 || flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] > 0 || flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] > 0 || flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] > 0) || (player.hasPerk(PerkLib.FirstAttackSkeletons) && (player.perkv2(PerkLib.PrestigeJobNecromancer) > 0 || player.perkv1(PerkLib.GreaterHarvest) > 0 || player.perkv2(PerkLib.GreaterHarvest) > 0))) {
			outputText("\n<b>You can adjust your permanent golems (or skeletons) behaviour during combat.</b>");
			bd.add("Golems/Skeletons", golemsskeletonsbehaviourOptions);
		}
		if (player.hasPerk(PerkLib.MyBloodForBloodPuppies)) {
			outputText("\n<b>You can adjust your blood puppies behaviour during combat.</b>");
			bd.add("B. Puppies", bpbehaviourOptions);
		}
		if (player.hasPerk(PerkLib.JobLeader)) {
			outputText("\n<b>You can adjust your Will-o'-the-wisp behaviour during combat.</b>");
			bd.add("Will-o'-the-wisp", wotwBehaviourOptions);
		}
		if (player.hasPerk(PerkLib.MummyLord) && player.perkv1(PerkLib.MummyLord) > 0) {
			outputText("\n<b>You can adjust the behaviour of your mummies during combat.</b>");
			bd.add("Mummies", mummyBehaviourOptions);
		}


		submenu(bd, CoC.instance.inCombat ? curry(combat.combatMenu, false) : displayPerks, 0, false);
	}

	private function toggleCorruptionTolerance():void {
		++flags[kFLAGS.CORRUPTION_TOLERANCE_MODE];
		if (flags[kFLAGS.CORRUPTION_TOLERANCE_MODE] > (CoC.instance.lockCheats ? 1 : 2))
			flags[kFLAGS.CORRUPTION_TOLERANCE_MODE] = 0;
		MiscOption();
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
				.disableIf(!((player.weaponName == "fists" || player.haveWeaponAllowingClaws()) && player.hasNaturalWeapons() || player.haveNaturalClawsTypeWeapon()), "You need to be unarmed and possess a natural weapon OR to have equipped gaunlets with any type of artifical claws.");
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
			|| player.faceType == Face.SPIDER_FANGS
			|| player.hasKeyItem("Sky Poison Pearl") >= 0;
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
		if (player.weapon.isStaffType() || player.weapon.isWandType()) {
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
		var nba:int = player.nextBonusAttack(false);
		if (nba < 0) outputText("You've reached the maximum number of bonus attacks from mastery!");
		else outputText("Next bonus attack at mastery level " + nba);
		outputText("\n\nHow many attacks would you like to deal?");
		menu();
		var atk:int = 0;
		while (atk < maxProj) {
			addButton(atk, NUMBER_WORDS_CAPITAL[atk + 1], multiShotStyle, atk)
				.disableIf(currentProj == atk, "Already selected");
			atk++;
		}
		addButton(14, "Back", rangedOptions);
	}

	public function rangedOptions():void {
		var bd:ButtonDataList = new ButtonDataList();
		var currentProj:int = flags[kFLAGS.MULTISHOT_STYLE];
		var toggleFlagRanged:Function = curry(toggleFlag, rangedOptions);
		currentProj *= (flags[kFLAGS.ELVEN_TWINSHOT_ENABLED] ? 2 : 1);
		clearOutput();
		outputText("You will always shoot " + NUMBER_WORDS_NORMAL[currentProj + 1] + " projectiles."
			+ "\nYou can change it to a different amount of projectiles.");
		bd.add("MultiShot", pickMultishot).hint("Change your amount of projectiles.");
		if (player.hasPerk(PerkLib.ELFThornShot)) {
			outputText("\n\nAs a Wood Elf you can grow Rose thorns on your shafts, inducing a lust poison and bleed effect. (Works only with bows and crosbows)"
				+ "\nThorn shot active: <b>" + (flags[kFLAGS.ELVEN_THORNSHOT_ENABLED] ? "Yes" : "No") + "</b>");
			bd.add("Thorn shot", curry(toggleFlagRanged, kFLAGS.ELVEN_THORNSHOT_ENABLED));
		}
		if (player.hasPerk(PerkLib.ELFTwinShot)) {
			outputText("\n\nThanks to your elven training, you can shoot twice as many arrows as normal (Works only with bows)"
					+ "\nTwin shot active: <b>" + (flags[kFLAGS.ELVEN_TWINSHOT_ENABLED] ? "Yes" : "No") + "</b>");
			bd.add("Twin shot", curry(toggleFlagRanged, kFLAGS.ELVEN_TWINSHOT_ENABLED));
		}
		if (player.hasPerk(PerkLib.ElementalArrows)) {
			outputText("\n\nIf you know specific spells, you can add some magical effects to the projectiles. (Works only with bows and crosbows)");
			outputText("\n\nElemental effect added: <b>" + elementalArr[flags[kFLAGS.ELEMENTAL_ARROWS]][0] + "</b>");
			bd.add("Elemental", curry(selectElemental, rangedOptions, kFLAGS.ELEMENTAL_ARROWS));
		}
		if (player.hasPerk(PerkLib.Cupid)) {
			outputText("\n\nIf you know 'Arouse' spell, you can add its effect to the projectiles. (Works only with bows and crosbows)"
				+ "\nArouse effect added: <b>" + (flags[kFLAGS.CUPID_ARROWS] > 0 ? "Yes" : "No") + "</b>");
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
			["Charge Weapon", kFLAGS.AUTO_CAST_CHARGE_WEAPON_DISABLED, StatusEffects.KnowsCharge],
			["Charge R Weapon", kFLAGS.AUTO_CAST_CHARGE_R_WEAPON_DISABLED, StatusEffects.KnowsChargeR],
			["Charge Armor", kFLAGS.AUTO_CAST_CHARGE_ARMOR_DISABLED, StatusEffects.KnowsChargeA],
			["Might", kFLAGS.AUTO_CAST_MIGHT_DISABLED, StatusEffects.KnowsMight],
			["Blink", kFLAGS.AUTO_CAST_BLINK_DISABLED, StatusEffects.KnowsBlink],
			["Mana Shield", kFLAGS.AUTO_CAST_MANA_SHIELD_DISABLED, StatusEffects.KnowsManaShield],
		];
		var toggleFlagMagic:Function = curry(toggleFlag, spellOptions);
		var btn:int = 0;
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.Autocast)) {
			outputText("You can choose to autocast or not specific buff spells at the start of the combat.");
			for each (var autoItem:Array in autocasts) {
				if (player.hasStatusEffect(autoItem[2])) {
					outputText("\n\n" + autoItem[0] + ": <b>" + (flags[autoItem[1]] ? "Manual" : "Autocast") + "</b>");
					addButton(btn++, autoItem[0], curry(toggleFlagMagic, autoItem[1]));
				}
			}
			outputText("\n\n");
		}
		if (player.hasPerk(PerkLib.FortressOfIntellect)) {
			outputText("Fortress of Intellect: <b>" + (player.hasStatusEffect(StatusEffects.FortressOfIntellect) ? "On" : "Off") + "</b>");
			addButton(btn++, "FoI", toggleFortressOfIntelect);
		}
		addButton(14, "Back", magicOption);

		function toggleFortressOfIntelect():void {
			if (!player.hasStatusEffect(StatusEffects.FortressOfIntellect)) player.createStatusEffect(StatusEffects.FortressOfIntellect, 0, 0, 0, 0);
			else player.removeStatusEffect(StatusEffects.FortressOfIntellect);
			spellOptions();
		}
	}

	public function summonsbehaviourOptions(page:int = 1):void {
        var attackingElementalTypeFlag:int = flags[kFLAGS.ATTACKING_ELEMENTAL_TYPE];
		var attackingEpicElementalTypeFlag:int = flags[kFLAGS.ATTACKING_EPIC_ELEMENTAL_TYPE];
        var elementalConjuerSummons:int = flags[kFLAGS.ELEMENTAL_CONJUER_SUMMONS];
        var setflag:Function = curry(setFlag,summonsbehaviourOptions);
        var attackingElementalType:Function = curry(setflag,kFLAGS.ATTACKING_ELEMENTAL_TYPE);
		var attackingEpicElementalType:Function = curry(setflag,kFLAGS.ATTACKING_EPIC_ELEMENTAL_TYPE);
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
		outputText("\n\n<b>Epic Elemental, which would attack in case option to them helping in attacks is enabled:</b>\n");
        switch(attackingEpicElementalTypeFlag){
			case 31: outputText("Air"); break;
            case 32: outputText("Earth"); break;
            case 33: outputText("Fire"); break;
            case 34: outputText("Water"); break;
		}
		if (page == 1) {
			if (player.statusEffectv1(StatusEffects.SummonedElementals) >= 1) addButton(0, "Basic", summonsbehaviourOptions, 2);
			if (player.hasPerk(PerkLib.FirstAttackElementalsSu) && player.statusEffectv2(StatusEffects.SummonedElementals) > 0) addButton(1, "Epic", summonsbehaviourOptions, 4);
		}
		if (page == 2) {
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir) && attackingElementalTypeFlag != 1) addButton(0, "Air", attackingElementalType,1);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth) && attackingElementalTypeFlag != 2) addButton(1, "Earth", attackingElementalType,2);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire) && attackingElementalTypeFlag != 3) addButton(2, "Fire", attackingElementalType,3);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater) && attackingElementalTypeFlag != 4) addButton(3, "Water", attackingElementalType,4);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther) && attackingElementalTypeFlag != 10) addButton(4, "Ether", attackingElementalType,10);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood) && attackingElementalTypeFlag != 8) addButton(5, "Wood", attackingElementalType,8);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal) && attackingElementalTypeFlag != 9) addButton(6, "Metal", attackingElementalType, 9);
			addButton(9, "2nd", summonsbehaviourOptions, page + 1);
		}
		if (page == 3)  {
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce) && attackingElementalTypeFlag != 5) addButton(0, "Ice", attackingElementalType,5);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning) && attackingElementalTypeFlag != 6) addButton(1, "Lightning", attackingElementalType,6);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness) && attackingElementalTypeFlag != 7) addButton(2, "Darkness", attackingElementalType,7);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsPoison) && attackingElementalTypeFlag != 11) addButton(3, "Poison", attackingElementalType,11);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity) && attackingElementalTypeFlag != 12) addButton(4, "Purity", attackingElementalType,12);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption) && attackingElementalTypeFlag != 13) addButton(5, "Corruption", attackingElementalType, 13);
			addButton(9, "1st", summonsbehaviourOptions, page - 1);
		}
		if (page == 4) {
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAirE) && attackingEpicElementalTypeFlag != 31) addButton(0, "Air", attackingEpicElementalType,31);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarthE) && attackingEpicElementalTypeFlag != 32) addButton(1, "Earth", attackingEpicElementalType,32);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFireE) && attackingEpicElementalTypeFlag != 33) addButton(2, "Fire", attackingEpicElementalType,33);
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWaterE) && attackingEpicElementalTypeFlag != 34) addButton(3, "Water", attackingEpicElementalType,34);
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
		if (page == 1) {
					addButton(14, "Back", minionOptions);
		}
		else {
			addButton(14, "Back", summonsbehaviourOptions, 1);
		}

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

	public function golemsskeletonsbehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your permanent golems will behave during each fight."+(player.hasPerk(PerkLib.FirstAttackSkeletons)?" Or skeletons if you rised any.":"")+"\n\n");
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
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] == 1) addButton(10, "G. Waiting", golemsAttacking,false).hint("Golems will not attack at the beginning of the turn.");
		if (flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] != 1) addButton(11, "G. Attacking", golemsAttacking, true).hint("Golems will attack at the beginning of the turn.");
		if (player.hasPerk(PerkLib.FirstAttackSkeletons) && (player.perkv2(PerkLib.PrestigeJobNecromancer) > 0 || player.perkv1(PerkLib.GreaterHarvest) > 0 || player.perkv2(PerkLib.GreaterHarvest) > 0)) {
			outputText("\n\n<b>Skeletons attack pattern behavious:</b>\n");
			if (flags[kFLAGS.NECROMANCER_SKELETONS] == 1) outputText("Attacking at the begining of each turn.");
			if (flags[kFLAGS.NECROMANCER_SKELETONS] < 1) outputText("Waiting for the owner to give an attack command each turn.");
			if (flags[kFLAGS.NECROMANCER_SKELETONS] == 1) addButton(12, "S. Waiting", skeletonsAttacking,false).hint("Skeletons will not attack at the beginning of the turn.");
			if (flags[kFLAGS.NECROMANCER_SKELETONS] != 1) addButton(13, "S. Attacking", skeletonsAttacking, true).hint("Skeletons will attack at the beginning of the turn.");
		}
		addButton(14, "Back", minionOptions);
		function golemsElementaryWeaponMode(elementalMode:Number):void {
			player.changeStatusValue(StatusEffects.GolemUpgrades1,3,elementalMode);
			golemsskeletonsbehaviourOptions();
		}
		function golemsPoisonedWeaponMode(poisonedMode:Number):void {
			player.changeStatusValue(StatusEffects.GolemUpgrades1,4,poisonedMode);
			golemsskeletonsbehaviourOptions();
		}
        function golemsAttacking(attacking:Boolean):void {
            flags[kFLAGS.GOLEMANCER_PERM_GOLEMS] = (attacking)?1:0;
            golemsskeletonsbehaviourOptions();
        }
        function skeletonsAttacking(attacking:Boolean):void {
            flags[kFLAGS.NECROMANCER_SKELETONS] = (attacking)?1:0;
            golemsskeletonsbehaviourOptions();
        }
	}

	public function bpbehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your blood puppies will behave during each fight.\n\n");
		outputText("Current Behaviour: ");
		switch(flags[kFLAGS.BLOOD_PUPPY_SUMMONS]) {
			case 0: outputText("Not attacking\n\n");
					break;
			case 1: outputText("Blood Swipe\n\n");
					outputText("Ability Information (Will attack once per turn):\n\n");
					outputText(CombatAbilities.BPBloodSwipe.fullDescription(null));
					break;
			case 2: outputText("Blood Dewdrops\n\n");
					outputText("Ability Information (Will attack once per turn):\n\n");
					outputText(CombatAbilities.BPBloodDewdrops.fullDescription(null));
					break;
			case 3: outputText("Heart Seeker\n\n");
					outputText("Ability Information (Will attack once per turn):\n\n");
					outputText(CombatAbilities.BPHeartSeeker.fullDescription(null));
					break;
		}

		var setflag:Function = curry(setFlag,bpbehaviourOptions, kFLAGS.BLOOD_PUPPY_SUMMONS);
		if (flags[kFLAGS.BLOOD_PUPPY_SUMMONS] != 0) {
			addButton(0, "Blood Swipe", setflag, 1)
				.disableIf(flags[kFLAGS.BLOOD_PUPPY_SUMMONS] == 1);
			addButton(1, "Blood Dewdrops", setflag, 2)
				.disableIf(flags[kFLAGS.BLOOD_PUPPY_SUMMONS] == 2);
			addButton(2, "Heart Seeker", setflag, 3)
				.disableIf(flags[kFLAGS.BLOOD_PUPPY_SUMMONS] == 3);
		}
		addButton(10, "Not helping", setflag, 0)
			.disableIf(flags[kFLAGS.BLOOD_PUPPY_SUMMONS] == 0);
		addButton(11, "Helping", setflag, 1)
			.disableIf(flags[kFLAGS.BLOOD_PUPPY_SUMMONS] != 0);
		addButton(14, "Back", minionOptions);
	}

	public function darkRitualOption():void {
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.DarkRitual)) {
			outputText("Set if you will be sacrificing blood to empower your magic or not.\n\n");
			if (!player.hasStatusEffect(StatusEffects.DarkRitual)) {
				outputText("Dark ritual is currently: <b>Inactive</b>.");
				addButton(10, "On", darkRitualOptionOn);
			}
			if (player.hasStatusEffect(StatusEffects.DarkRitual)) {
				outputText("Dark ritual is currently: <b>Active</b>.");
				addButton(11, "Off", darkRitualOptionOff);
			}
			outputText("\n\n");
		}
		if (player.hasPerk(PerkLib.HiddenJobBloodDemon)) {
			outputText("Set if you will be using blood instead of mana to fuel your magic.\n\n");
			if (!player.hasStatusEffect(StatusEffects.BloodMage)) {
				outputText("Blood Mage: <b>Inactive</b>.");
				addButton(0, "On", bloodMageOptionOn);
			}
			if (player.hasStatusEffect(StatusEffects.BloodMage)) {
				outputText("Blood Mage: <b>Active</b>.");
				addButton(1, "Off", bloodMageOptionOff);
			}
			outputText("\n\n");
			outputText("Set if you will be using blood instead of soulforce to fuel your soulskills.\n\n");
			if (!player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				outputText("Blood Cultivator: <b>Inactive</b>.");
				addButton(2, "On", bloodCultivatorOptionOn);
			}
			if (player.hasStatusEffect(StatusEffects.BloodCultivator)) {
				outputText("Blood Cultivator: <b>Active</b>.");
				addButton(3, "Off", bloodCultivatorOptionOff);
			}
		}
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu, false);
		else addButton(14, "Back", displayPerks);
		function darkRitualOptionOn():void {
			player.createStatusEffect(StatusEffects.DarkRitual,0,0,0,0);
			darkRitualOption();
		}
		function darkRitualOptionOff():void {
			player.removeStatusEffect(StatusEffects.DarkRitual);
			darkRitualOption();
		}
		function bloodMageOptionOn():void {
			player.createStatusEffect(StatusEffects.BloodMage,0,0,0,0);
			darkRitualOption();
		}
		function bloodMageOptionOff():void {
			player.removeStatusEffect(StatusEffects.BloodMage);
			darkRitualOption();
		}
		function bloodCultivatorOptionOn():void {
			player.createStatusEffect(StatusEffects.BloodCultivator,0,0,0,0);
			darkRitualOption();
		}
		function bloodCultivatorOptionOff():void {
			player.removeStatusEffect(StatusEffects.BloodCultivator);
			darkRitualOption();
		}
		addButton(14, "Back", magicOption);
	}

	public function venomancyOption():void {
		clearOutput();
		menu();
		if (player.hasPerk(PerkLib.Venomancy)) {
			outputText("Set weither you will be using venom to empower your magic or not.\n\n");
			if (!player.hasStatusEffect(StatusEffects.Venomancy)) {
				outputText("Venomancy is currently: <b>Inactive</b>.");
				addButton(10, "On", venomancyOptionOn);
			}
			if (player.hasStatusEffect(StatusEffects.Venomancy)) {
				outputText("Venomancy is currently: <b>Active</b>.");
				addButton(11, "Off", venomancyOptionOff);
			}
			outputText("\n\n");
		}
		if (SceneLib.combat.inCombat) addButton(14, "Back", combat.combatMenu, false);
		else addButton(14, "Back", displayPerks);
		function venomancyOptionOn():void {
			player.createStatusEffect(StatusEffects.Venomancy,0,0,0,0);
			venomancyOption();
		}
		function venomancyOptionOff():void {
			player.removeStatusEffect(StatusEffects.Venomancy);
			venomancyOption();
		}
		addButton(14, "Back", magicOption);
	}

	public function wotwBehaviourOptions():void {
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

		addButton(14, "Back", minionOptions);
        function WOTWAttacking(attacking:Number):void {
            flags[kFLAGS.WILL_O_THE_WISP] = attacking;
            wotwBehaviourOptions();
        }
	}

	public function flyingSwordBehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your flying sword will behave during each fight.\n\n");
		outputText("\n<b>Flying Sword behaviour:</b>\n");
		if (flags[kFLAGS.FLYING_SWORD] == 0) outputText("Your flying sword will not attack");
		if (flags[kFLAGS.FLYING_SWORD] == 1) {
			outputText("Your flying sword will attack at the begining of each turn.");
			if ((player.hasStatusEffect(StatusEffects.Flying) && player.statusEffectv2(StatusEffects.Flying) == 1) || flags[kFLAGS.AUTO_FLIGHT] == 2) {
				outputText("\n<b>Since you are using your flying sword to fly, ");
				var flyingSwordCount:int = player.weaponFlyingSwords.count;
				if (flyingSwordCount > 1) {
					outputText("you will only deal " + Utils.numberOfThings(flyingSwordCount - 1, "attack") + ".</b>");
				} else {
					outputText("you can't attack with your flying sword. Use a different way to fly, or stay on the ground.</b>");
				}
			}
		}
		addButton(10, "Disable", toggleFlag, flyingSwordBehaviourOptions, kFLAGS.FLYING_SWORD)
			.disableIf(flags[kFLAGS.FLYING_SWORD] == 0);
		addButton(11, "Enable", toggleFlag, flyingSwordBehaviourOptions, kFLAGS.FLYING_SWORD)
			.disableIf(flags[kFLAGS.FLYING_SWORD] == 1);

		addButton(14, "Back", CoC.instance.inCombat ? curry(combat.combatMenu, false) : displayPerks);
	}

	public function mummyBehaviourOptions():void {
		clearOutput();
		menu();
		outputText("You can choose how your mummies will behave during each fight.\n\n");
		outputText("\n<b>Mummy behaviour:</b>\n");
		if (flags[kFLAGS.MUMMY_ATTACK] == 0) outputText("Your mummies will not attack");
		if (flags[kFLAGS.MUMMY_ATTACK] == 1) outputText("Your mummies will attack at the begining of each turn.");
		addButton(10, "Disable", toggleFlag, mummyBehaviourOptions, kFLAGS.MUMMY_ATTACK)
			.disableIf(flags[kFLAGS.MUMMY_ATTACK] != 0);
		addButton(11, "Enable", toggleFlag, mummyBehaviourOptions, kFLAGS.MUMMY_ATTACK)
			.disableIf(flags[kFLAGS.MUMMY_ATTACK] != 1);

		addButton(14, "Back", minionOptions)
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
			mutationsDatabase(pageAdd, false);
		}

		function mutationsDBDragon():void{
			clearOutput();
			//Dragon Mutations
			displayHeader("Dragon Mutations");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) outputText("\nThere is an extra bonus mutation slot given due to NG+");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 2) outputText("\nThere is another extra bonus mutation slot given due to NG++");
			mutationsDatabaseVerify([IMutationsLib.DraconicBonesIM, IMutationsLib.DraconicHeartIM, IMutationsLib.DraconicLungIM]);
			mutationsDatabase(1, false);
		}

		function mutationsDBKitsune():void{
			clearOutput();
			//Kitsune Mutations
			displayHeader("Kitsune Mutations");
			if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) outputText("\nThere is an extra bonus mutation slot given due to NG+");
			mutationsDatabaseVerify([IMutationsLib.KitsuneThyroidGlandIM, IMutationsLib.KitsuneParathyroidGlandsIM]);
			mutationsDatabase(1, false);
		}

		function mutationsDBHuman():void{
			clearOutput();
			//Kitsune Mutations
			displayHeader("Human Mutations");
			//if (flags[kFLAGS.NEW_GAME_PLUS_LEVEL] >= 1) outputText("\nThere is an extra bonus mutation slot given due to NG+");
			mutationsDatabaseVerify([
				IMutationsLib.HumanAdrenalGlandsIM,
				IMutationsLib.HumanBloodstreamIM,
				IMutationsLib.HumanBonesIM,
				IMutationsLib.HumanEyesIM,
				IMutationsLib.HumanFatIM,
				IMutationsLib.HumanMusculatureIM,
				IMutationsLib.HumanOvariesIM,
				IMutationsLib.HumanParathyroidGlandIM,
				IMutationsLib.HumanSmartsIM,
				IMutationsLib.HumanTesticlesIM,
				IMutationsLib.HumanThyroidGlandIM,
				IMutationsLib.HumanVersatilityIM]);
			mutationsDatabase(1, false);
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
		bd.add("Humans", mutationsDBHuman,"Human Mutations");
		submenu(bd, displayPerks, page, false);
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

				if (player.perkv3(mutation) == 1) outputText("\nYour Mutation is empowered, and provides you with a much greater buff!\n");

				if (pMutateLvl > 0) {
					outputText("\nCurrent Tier Description: ");
					if(mutation.mDesc(player.getPerk(mutation), pMutateLvl).length <= 1) {	//Some desc. contains only "."
						outputText("Error in description for Mutation "+ mutation.name() +".");
					} else{
						outputText(mutation.mDesc(player.getPerk(mutation), pMutateLvl));
					}
				}

				if (flags[kFLAGS.IMDB_DETAILS]) {
					outputText("\nAll Tier Descriptions:");
					for (var tier:int = 1; tier <= mutation.maxLvl; ++tier) {
						var temptxt:String = ("\n" + tier + ": " + mutation.mDesc(player.getPerk(mutation), tier));
						var temptxt2:String = mutation.explainBuffs(tier)
						if(!(temptxt2.indexOf("null") >= 0)){
							temptxt += temptxt2;
						}
						outputText(temptxt);
					}
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
	public var preferOld:Boolean = false;
	private var perksByCategory:Dictionary = null;
	private function buildCategories():void {
		perksByCategory = new Dictionary();
		perksByCategory["Common"] = PerkTree.obtainablePerks().filter(function(p:PerkType,...rest):Boolean {
			return !PerkLib.isJob(p) && PerkTree.getJobs(p) == null;
		});
		perksByCategory["Jobs"] = PerkTree.obtainablePerks().filter(function(p:PerkType,...rest):Boolean {
			return PerkLib.isJob(p);
		});
		for each (var job:PerkType in PerkLib.ALL_JOBS) {
			perksByCategory[job] = PerkTree.getJobUnlocks(job);
		}
	}
	private function perksInCategory(perks:/*PerkType*/Array):int {
		var n:int = 0;
		for each (var perk:PerkType in perks) {
			if (!(perk is IMutationPerkType) && !player.hasPerk(perk) && perk.available(player)) n++;
		}
		return n;
	}
	
	// Cached table display elements
	private var blocksCache:/*DisplayObject[]*/Array = [];
	private var perkMenuStyle:int = 2; // 0: desc below name, 1: desc in tooltip, 2: desc in separate column
	private function addRow(perkgrid:Block, row:int, pc:PerkClass):void {
		var perk:PerkType = pc.ptype;
		var btn:CoCButton;
		var text1:TextField;
		var text2:TextField;
		if (blocksCache[row]) {
			btn = blocksCache[row][0] as CoCButton;
			text1 = blocksCache[row][1] as TextField;
			text2 = blocksCache[row][2] as TextField;
		} else {
			btn = new CoCButton({square:true});
			text1 = UIUtils.newTextField({
				defaultTextFormat: mainView.mainText.defaultTextFormat,
				wordWrap: true,
				autoSize: TextFieldAutoSize.LEFT,
				mouseEnabled: false
			});
			text2 = UIUtils.newTextField({
				defaultTextFormat: mainView.mainText.defaultTextFormat,
				wordWrap: true,
				autoSize: TextFieldAutoSize.LEFT,
				mouseEnabled: false
			});
			blocksCache[row] = [btn,text1,text2];
		}
		var textwidth:Number = MainView.TEXTZONE_W - MainView.BTN_H - 16;
		btn.show("", curry(CoC.instance.playerInfo.applyPerk, pc)).icon("Right");
		
		var perkName:String = "<b>"+pc.perkName+"</b>";
		if (perk.tierList) {
			var n:int = perk.tierList.length - perk.tierPos() - 1;
			perkName += (perkMenuStyle == 0) ? " " : "\n";
			perkName += "<b>(+"+n+" follow-up "+(n>1?"perks":"perk")+")</b>";
		}
		
		var desc:String = Parser.recursiveParser(pc.perkDesc);
		var reqs:String = player.hasPerk(perk) ? "" : formatPerkRequirements(perk, true);
		if (reqs) reqs = "\n" + reqs;
		if (player.hasPerk(perk)) {
			btn.disable();
			btn.text("");
			btn.icon("Yes");
		} else if (!perk.available(player)) {
			btn.disable();
			btn.icon("");
			btn.labelText = "?";
		} else if (player.perkPoints <= 0) {
			btn.disable();
			btn.icon("");
		}
		switch (perkMenuStyle) {
			case 0:
				text1.width    = textwidth;
				text1.htmlText = perkName+": \n"+desc+reqs
				perkgrid.addElement(btn);
				perkgrid.addElement(text1);
				break;
			case 1:
				text1.width    = textwidth;
				text1.htmlText = perkName+reqs;
				btn.hint(desc);
				perkgrid.addElement(btn);
				perkgrid.addElement(text1);
				break;
			case 2:
				text1.width    = textwidth / 3;
				text1.htmlText = perkName;
				text2.width    = textwidth * 2 / 3;
				text2.htmlText = desc + reqs;
				perkgrid.addElement(btn);
				perkgrid.addElement(text1);
				perkgrid.addElement(text2);
				break;
		}
	}
	
	public function newPerkMenu(category:*=null):void {
		preferOld = false;
		mainView.toolTipView.hide();
		clearOutput();
		outputText("You have <b>"+numberOfThings(player.perkPoints, "perk point")+"</b>.\n\n");
		
		const NCOLS:int = 15;
		var btn:CoCButton;
		var i:int,c:int,n:int;
		var contentBlock:Block = new Block({
			layoutConfig: {
				type: "flow",
				direction: "column"
			}
		});
		var groupgrid:Block     = new Block({
			layoutConfig: {
				type     : "grid",
				cols     : NCOLS,
				cellWidth: MainView.BTN_H,
				setWidth : true,
				gap      : -1
			},
			width: MainView.TEXTZONE_W - 16
		});
		
		var basicJobs:Array    = [
			["ARr", PerkLib.JobAllRounder],
			["BsW", PerkLib.JobBeastWarrior],
			["Gdn", PerkLib.JobGuardian],
			["Ldr", PerkLib.JobLeader],
			["Rgr", PerkLib.JobRanger],
			["Rog", PerkLib.JobRogue],
			["Sed", PerkLib.JobSeducer],
			["Sor", PerkLib.JobSorcerer],
			["Cul", PerkLib.JobSoulCultivator],
			["Wrr", PerkLib.JobWarrior]
		];
		var advancedJobs:Array = [
			["Bwr", PerkLib.JobBrawler],
			["Csn", PerkLib.JobCourtesan],
			["Dfr", PerkLib.JobDefender],
			["Dvs", PerkLib.JobDervish],
			["ECj", PerkLib.JobElementalConjurer],
			["Enc", PerkLib.JobEnchanter],
			["Ero", PerkLib.JobEromancer],
			["Glm", PerkLib.JobGolemancer],
			["Gsg", PerkLib.JobGunslinger],
			["Hlr", PerkLib.JobHealer],
			["Hnt", PerkLib.JobHunter],
			["Knt", PerkLib.JobKnight],
			["Mnk", PerkLib.JobMonk],
			["Swm", PerkLib.JobSwordsman],
			["Wld", PerkLib.JobWarlord]
		];
		var prestigeJobs:Array = [
			["AAr", PerkLib.PrestigeJobArcaneArcher],
			["APr", PerkLib.PrestigeJobArchpriest],
			["Brd", PerkLib.PrestigeJobBard],
			["Bkr", PerkLib.PrestigeJobBerserker],
			["Bnd", PerkLib.PrestigeJobBindmaster],
			["Drd", PerkLib.PrestigeJobDruid],
			["Nec", PerkLib.PrestigeJobNecromancer],
			["Stl", PerkLib.PrestigeJobSentinel],
			["SAM", PerkLib.PrestigeJobSoulArtMaster],
			["SKt", PerkLib.PrestigeJobSpellKnight],
			["Stl", PerkLib.PrestigeJobStalker],
			["Tmp", PerkLib.PrestigeJobTempest],
			["Wlk", PerkLib.PrestigeJobWarlock]
		];
		var allJobs:Array      = [basicJobs,advancedJobs, prestigeJobs];
		
		if (!perksByCategory) buildCategories();
		c = perksInCategory(perksByCategory["Common"]);
		groupgrid.addElement(new CoCButton({  square   : true})
				.show("Common",curry(newPerkMenu,"Common"))
				.disableIf(category == "Common")
				.hint("Perks not related to any job.")
				.cornerLabel(c > 0 ? String(c) : ""), {colspan: 2});
		c = perksInCategory(perksByCategory["Jobs"]);
		groupgrid.addElement(new CoCButton({square   : true})
				.show("Jobs", curry(newPerkMenu, "Jobs"))
				.disableIf(category == "Jobs")
				.hint("Job perks.")
				.cornerLabel(c > 0 ? String(c) : ""), {colspan: 2});
		groupgrid.addBitmapDataSprite({}, {colspan: Math.max(1, NCOLS - basicJobs.length - 4)});
		
		n = 0;
		function jobPerkClearName(job:PerkType):String {
			return job.name(null).replace(/^Job \( \w+ \):\s*/, "")
		}
		for each (var joblist:Array in allJobs) {
			for each (var entry:Array in joblist) {
				var perk:PerkType = entry[1];
				var name:String = jobPerkClearName(perk);
				c = perksInCategory(perksByCategory[perk]);
				btn = new CoCButton({square: true})
						.show(entry[0], curry(newPerkMenu, perk))
						.disableIf(category == perk)
						.hint("Perks in the " + name + " group.", name)
						.cornerLabel(c > 0 ? String(c) : "");
				if (player.hasPerk(perk)) btn.color("#006000");
				groupgrid.addElement(btn);
				n++;
			}
		}
		groupgrid.doLayout();
		
		var perks:/*PerkType*/Array;
		var catName:String;
		perks = perksByCategory[category] || [];
		if (category == "Common") {
			catName = category;
		} else if (category == "Jobs") {
			catName = category;
		} else if (category is PerkType) {
			catName = jobPerkClearName(category);
		} else {
			category = null;
		}
		trace("perks: "+perks.length);
		perks = perks.filter(function(p:PerkType,...rest):Boolean {
			if (p is IMutationPerkType) return false;
			if (player.hasPerk(p)) return false;
			if (!p.available(player)) {
				var prev:PerkType = p.tierPrev();
				if (prev && !player.hasPerk(prev)) return false;
			}
			return true;
		});
		trace("perks filtered: "+perks.length);
		perks = sortedBy(perks, sorterRelativeDistance);
		
		var nperks:int = 0, navail:int = 0;
		var perkgrid:Block = new Block({
			layoutConfig: {
				type: "grid",
				//setWidth: true,
				columns: perkMenuStyle == 2 ? [40, -1, -2] : [40, -1],
				gap: 2
			},
			width: MainView.TEXTZONE_W - 16
		});
		var row:int = 0;
		for each (perk in perks) {
			var pc:PerkClass = new PerkClass(perk, perk.defaultValue1, perk.defaultValue2, perk.defaultValue3, perk.defaultValue4);
			row++;
			addRow(perkgrid, row, pc);
			if (player.hasPerk(perk) && perk.available(player)) {
				navail++;
			}
			nperks++;
		}
		perkgrid.doLayout();
		
		contentBlock.addTextField({
			defaultTextFormat: mainView.mainText.defaultTextFormat,
			text             : "Perk categories:"
		});
		contentBlock.addElement(groupgrid);
		if (category) {
			contentBlock.addTextField({
				defaultTextFormat: mainView.mainText.defaultTextFormat,
				text             : catName + " perks: (" + navail + "/" + nperks + ")"
			});
			contentBlock.addElement(perkgrid);
		}
		contentBlock.width = MainView.TEXTZONE_W - MainView.VSCROLLBAR_W;
		
		flushOutputTextToGUI();
		mainView.setCustomElement(contentBlock,true,false, true);
		contentBlock.doLayout();
		
		menu();
		button(1).show(player.perkPoints > 0 ? "Skip" : "Exit", playerMenu);
		if (player.perkPoints > 0) {
			button(10).show("Old Menu", CoC.instance.playerInfo.perkBuyMenuOld);
		}
	}

	// Sort by perk name
	private function sorterName(e:PerkType):* {
		return e.name(null).toUpperCase();
	}
	// Sort by absolute distance (from zero)
	private function sorterDistance(e:PerkType):* {
		return e.distance
	}
	// Sort by relative distance (from player)
	public function sorterRelativeDistance(e:PerkType):* {
		return e.distanceFor(player) + e.id.charCodeAt(0)/1000;
	}
	private var sorter:Function = sorterRelativeDistance;
	private var sortedPerks:/*PerkType*/Array;
	
	public function formatPerkRequirements(ptype:PerkType, onlyMissing:Boolean=false):String {
		var reqs:Array = [];
		var color:String;
		for each (var cond:Object in ptype.requirements) {
			if (cond.fn(player)) {
				if (onlyMissing) continue;
				color=(darkTheme()?'#ffffff':'#000000');
			} else color=darkTheme()?'#ff4444':'#aa2222';
			if (cond.text is String){
				reqs.push("<font color='"+color+"'>"+cond.text+"</font>");
			}
			else {
				reqs.push("<font color='"+color+"'>"+cond.text(player)+"</font>");
			}
		}
		if (reqs.length == 0) return "";
		var s:String = "<b>Requires:</b> " + reqs.join(", ")+". ";
//		if (CoC_Settings.debugBuild) s +=  "<i>Distance: "+Math.round(ptype.distanceFor(player))+"/"+Math.round(ptype.distance)+"</i>";
		return s;
	}
	
	public function perkDatabase(page:int=0, count:int=50):void {
		var allPerks:/*PerkType*/Array = sortedPerks ? sortedPerks : (sortedPerks = sortedBy(PerkTree.obtainablePerks(),sorter));
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
		menu(); //Clear the other buttons out the way
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
				outputText("<ul><li>"+formatPerkRequirements(ptype)+"</li></ul>");
			} else {
				outputText("\n");
			}
		}
		if (page>0) addButton(0,"Prev",perkDatabase,page-1);
		else addButtonDisabled(0,"Prev");
		if (page*count<allPerks.length) addButton(1,"Next",perkDatabase,page+1);
		else addButtonDisabled(1,"Next");
		addButton(5,
				sorter === sorterName ? "Sort: Name"
						: sorter === sorterDistance ? "Sort: Dist."
						: "Sort: RelDist",
				perkDbToggleSort, page)
				.hint("Sort by Name - self-explanatory\n" +
						"Sort by Distance - perks with fewer/easier total requirements first\n" +
						"Sort by Relative Distance - perks with fewer/easier unfulfilled requirements first");
		addButton(9, "Back", displayPerks);
	}
	private function perkDbToggleSort(page:int):void {
		if (sorter === sorterName) {
			sorter = sorterDistance;
		} else if (sorter === sorterDistance) {
			sorter = sorterRelativeDistance;
		} else {
			sorter = sorterName;
		}
		sortedPerks = null;
		perkDatabase(page);
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
					else if (cond.type == "noperks"){
						continue;
					}
					else {	//The effect from this cause should never occur, as all these in masterlist should have a perk requirement of some sort.
						requirelen++
					}
				}//Why is this suddenly triggering now? Could it be due to whatever changes were recently added in regards to Orm "merging" perks?
				if (requirelen == pPerk.requirements.length){
					outputText(pPerk.name() + "shouldn't be here. This is a bug. Please report it.");
					trace("pPerk.name() + \"shouldn't be here. This is a bug. Trace is in repPerkClr.");
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
