/**
 * ...
 * @author Ormael / Liadri
 */
package classes.Scenes.Camp 
{
	import classes.*;
	import classes.BaseContent;
	import classes.GlobalFlags.kFLAGS;
	
	public class CampMakeWinions extends BaseContent
	{
		public function CampMakeWinions() 
		{}
		
		//-----------
		//
		//  GOLEMS
		//
		//-----------
		
		//TEMPORAL_GOLEMS_BAG and PERNAMENT_GOLEMS_BAG - pretty easy to quess: amount of temp or perm golems PC have in "golem bag"
		
		public function maxTemporalGolemsBagSize():Number {
			var maxTemporalGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.JobGolemancer)) maxTemporalGolemsBagSizeCounter += 5;
			if (player.hasPerk(PerkLib.BeginnerGolemMaker)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.ExpertGolemMaker)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.GolemArmyLieutenant)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) maxTemporalGolemsBagSizeCounter += 4;
			if (player.hasPerk(PerkLib.GolemArmyMajor)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.GolemArmyColonel)) maxTemporalGolemsBagSizeCounter += 8;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxTemporalGolemsBagSizeCounter += 10;
			if (player.hasPerk(PerkLib.BiggerGolemBag1)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.BiggerGolemBag2)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.BiggerGolemBag3)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.BiggerGolemBag4)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.BiggerGolemBag5)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.BiggerGolemBag6)) maxTemporalGolemsBagSizeCounter += 2;
			return maxTemporalGolemsBagSizeCounter;
		}
		public function maxPernamentStoneGolemsBagSize():Number {
			var maxPernamentStoneGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.MasterGolemMaker)) maxPernamentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) maxPernamentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.EpicGolemMaker)) maxPernamentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) maxPernamentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) maxPernamentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyLieutenant)) maxPernamentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) maxPernamentStoneGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.GolemArmyMajor)) maxPernamentStoneGolemsBagSizeCounter += 3;
			if (player.hasPerk(PerkLib.GolemArmyColonel)) maxPernamentStoneGolemsBagSizeCounter += 4;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxPernamentStoneGolemsBagSizeCounter += 5;
			if (player.hasPerk(PerkLib.MasterGolemMaker)) {
				if (player.hasPerk(PerkLib.BiggerGolemBag1)) maxPernamentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBag2)) maxPernamentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBag3)) maxPernamentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBag4)) maxPernamentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBag5)) maxPernamentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBag6)) maxPernamentStoneGolemsBagSizeCounter += 1;
			}
			return maxPernamentStoneGolemsBagSizeCounter;
		}
		public function maxPernamentImprovedStoneGolemsBagSize():Number {
			var maxPernamentImprovedStoneGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) maxPernamentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxPernamentImprovedStoneGolemsBagSizeCounter += 1;
			return maxPernamentImprovedStoneGolemsBagSizeCounter;
		}
		public function maxPernamentSteelGolemsBagSize():Number {
			var maxPernamentSteelGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.AdvancedGolemancyTheory)) maxPernamentSteelGolemsBagSizeCounter += 1;
			return maxPernamentSteelGolemsBagSizeCounter;
		}
		public function maxPernamentImprovedSteelGolemsBagSize():Number {
			var maxPernamentImprovedSteelGolemsBagSizeCounter:Number = 0;
			
			return maxPernamentImprovedSteelGolemsBagSizeCounter;
		}
		public function maxReusableGolemCoresBagSize():Number {
			var maxReusableGolemCoresBagSizeCounter:Number = 0;
			if (maxTemporalGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxTemporalGolemsBagSize();
			if (maxPernamentStoneGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPernamentStoneGolemsBagSize();
			if (maxPernamentImprovedStoneGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPernamentImprovedStoneGolemsBagSize();
			if (maxPernamentSteelGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPernamentSteelGolemsBagSize();
			if (maxPernamentImprovedSteelGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPernamentImprovedSteelGolemsBagSize();
			if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) maxReusableGolemCoresBagSizeCounter += 2;
			maxReusableGolemCoresBagSizeCounter *= 3;
			return maxReusableGolemCoresBagSizeCounter;
		}
		public function temporalGolemMakingCost():Number {
			var tempGolemCost:Number = 50;
			if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) tempGolemCost -= 10;
			if (player.hasPerk(PerkLib.ChargedCore)) tempGolemCost += 20;
			if (player.hasPerk(PerkLib.SuperChargedCore)) tempGolemCost += 20;
			return tempGolemCost;
		}
		public function pernamentStoneGolemMakingCost():Number {
			var permGolemCost:Number = 90;
			if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) permGolemCost += 10;
			if (player.hasPerk(PerkLib.EpicGolemMaker)) permGolemCost += 50;
			if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) permGolemCost += 150;
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) permGolemCost += 400;
			return permGolemCost;
		}
		public function pernamentImprovedStoneGolemMakingCost():Number {
			var permGolemCost:Number = 900;
			return permGolemCost;
		}
		public function pernamentSteelGolemMakingCost():Number {
			var permGolemCost:Number = 200;
			return permGolemCost;
		}
		public function pernamentImprovedSteelGolemMakingCost():Number {
			var permGolemCost:Number = 2000;
			return permGolemCost;
		}

		public function accessMakeWinionsMainMenu():void {
			clearOutput();
			outputText("What helper would you like to make?\n\n");
			outputText("Stored golem cores for future reuse when making new golems: " + flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + " / " + maxReusableGolemCoresBagSize() + "\n");
			if (player.hasPerk(PerkLib.JobGolemancer)) outputText("Temporal Golems Bag: " + flags[kFLAGS.TEMPORAL_GOLEMS_BAG] + " / " + maxTemporalGolemsBagSize() + " golems\n");
			if (player.hasPerk(PerkLib.MasterGolemMaker)) outputText("Stone Golems Bag: " + flags[kFLAGS.PERNAMENT_GOLEMS_BAG] + " / " + maxPernamentStoneGolemsBagSize() + " golems\n");
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) outputText("Improved Stone Golems Bag: " + flags[kFLAGS.IMPROVED_PERNAMENT_GOLEMS_BAG] + " / " + maxPernamentImprovedStoneGolemsBagSize() + " golems\n");
			menu();
			if (player.hasPerk(PerkLib.JobGolemancer)) addButton(0, "T.S.Golem", makeTemporalStoneGolem).hint("Make the most simple golem out of a pile of stones.  <b>It will crumble after one attack!</b>\n\nCost: 1 Golem Core, " + temporalGolemMakingCost() + " Mana");
			if (player.hasPerk(PerkLib.MasterGolemMaker)) addButton(1, "P.S.Golem", makePernamentStoneGolem).hint("Make stone golem.\n\nCost: 1 Golem Core, 10 Stones, " + pernamentStoneGolemMakingCost() + " Mana");
			/*if (player.hasPerk(PerkLib.AdvancedGolemancyTheory)) */addButtonDisabled(2, "M.S.Golem", "Make metal golem.\n\nSoon");//Cost: 2 Golem Plasma Cores, 10 Stones, 10 Metal Plates, 10 Mechanisms, i coś jeszcze innego? " + pernamentSteelGolemMakingCost() + " Mana
			if (player.hasPerk(PerkLib.TemporalGolemsRestructuration)) addButton(5, "T.S.Golem(5x)", makeTemporalStoneGolems).hint("Make five of most simple golems.  <b>They will crumble after one attack!</b>\n\nCost: 5 Golem Core, " + temporalGolemMakingCost() * 5 + " Mana");
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) addButton(6, "I.P.S.Golem", makePernamentImprovedStoneGolem).hint("Make improved stone golem.\n\nCost: 3 Golem Cores, 100 Stones, " + pernamentImprovedStoneGolemMakingCost() + " Mana");
			addButtonDisabled(7, "I.M.S.Golem", "Make improved metal golem.\n\nSoon");//Cost: 2 Golem ?Plasma? Cores, 10 Stones, 10 Metal Plates, 10 Metal Plates, " + pernamentImprovedSteelGolemMakingCost() + " Mana
			addButtonDisabled(12, "Upgrades", "Options to upgrade pernament golems.");
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) addButton(13, "TakeOutCore", takeOutGolemCoreFromGolemBag).hint("Take out one golem core from 'golem bag'.");
			addButton(14, "Back", playerMenu);
		}
		
		public function makeTemporalStoneGolem():void {
			clearOutput();
			if (player.mana < temporalGolemMakingCost()) {
				outputText("Your mana is too low to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] == 0) {
				outputText("You lack a golem core to finish the creation of a golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] == maxTemporalGolemsBagSize()) {
				outputText("You not having enough space to store another one.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			else player.destroyItems(useables.GOLCORE, 1);
			useMana(temporalGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] < 1) flags[kFLAGS.TEMPORAL_GOLEMS_BAG] = 1;
			else flags[kFLAGS.TEMPORAL_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			if (player.hasPerk(PerkLib.TemporalGolemsRestructuration)) cheatTime2(5);
			else cheatTime2(10);
		}
		public function makeTemporalStoneGolems():void {
			clearOutput();
			if (player.mana < (temporalGolemMakingCost() * 5)) {
				outputText("Your mana is too low to finish golems creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 5) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < 5) {
				outputText("You lack golem cores to finish the creation of the golems.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > (maxTemporalGolemsBagSize() - 5)) {
				outputText("You not having enough space to store all five.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 4) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] -= 5;
			else player.destroyItems(useables.GOLCORE, 5);
			useMana(temporalGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a complex seal on the ground with 5 node points at which you put piles of stones that will soon be your servants. Once done you put a golem core in each pile, stand back and begin to seep your mana inside of the seal till each pile becomes a 6 feet tall golem. Finishing the work on your creations, you store them in your 'golem bag'.");
			flags[kFLAGS.TEMPORAL_GOLEMS_BAG] += 5;
			doNext(accessMakeWinionsMainMenu);
			cheatTime2(20);
		}
		public function makePernamentStoneGolem():void {
			clearOutput();
			if (player.mana < pernamentStoneGolemMakingCost()) {
				outputText("Your mana is too low to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1)) {
				outputText("You lack a golem core to finish the creation of a golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] < 10) {
				outputText("You lack high quality stones to use as body for your new golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.PERNAMENT_GOLEMS_BAG] == maxPernamentStoneGolemsBagSize()) {
				outputText("You not having enough space to store another one.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			else player.destroyItems(useables.GOLCORE, 1);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 10;
			useMana(pernamentStoneGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of high quality stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.PERNAMENT_GOLEMS_BAG] < 1) flags[kFLAGS.PERNAMENT_GOLEMS_BAG] = 1;
			else flags[kFLAGS.PERNAMENT_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			cheatTime2(20);
		}
		public function makePernamentImprovedStoneGolem():void {
			clearOutput();
			if (player.mana < pernamentImprovedStoneGolemMakingCost()) {
				outputText("Your mana is too low to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 3)) {
				outputText("You lack golem cores to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] < 100) {
				outputText("You lack high quality stones to use as body for your new golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.IMPROVED_PERNAMENT_GOLEMS_BAG] == maxPernamentImprovedStoneGolemsBagSize()) {
				outputText("You not having enough space to store another one.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 3) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] -= 3;
			else player.destroyItems(useables.GOLCORE, 3);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 100;
			useMana(pernamentImprovedStoneGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of high quality stones, which were arranged in the form of a gigantic four armed shape. Once done you put the golem cores in a pile at the golem's future chest in a triangle formation. You stand back and begin to seep your mana toward the laying stones. ");
			outputText("Slowly all the stones and cores connect with threads of magic, forming a 16 feet tall shape. Finishing the work by making some last adjustments to cores you store it in your 'golem bag'.");
			if (flags[kFLAGS.IMPROVED_PERNAMENT_GOLEMS_BAG] < 1) flags[kFLAGS.IMPROVED_PERNAMENT_GOLEMS_BAG] = 1;
			else flags[kFLAGS.IMPROVED_PERNAMENT_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			cheatTime2(60);
		}

		public function takeOutGolemCoreFromGolemBag():void {
			clearOutput();
			outputText("In order to not overload your bag for reusable golem cores you take out one of them.\n\n");
			flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			inventory.takeItem(useables.GOLCORE, accessMakeWinionsMainMenu);
		}
		
		public function postFightGolemOptions1():void {
			clearOutput();
			outputText("Placeholder text 1.");
			menu();
			addButton(1, "Leave", cleanupAfterCombat);
			addButton(3, "Scavenge", golemScavenge1);
		}
		public function postFightGolemOptions2():void {
			clearOutput();
			if (!player.hasStatusEffect(StatusEffects.GolemScavenge)) player.createStatusEffect(StatusEffects.GolemScavenge,2 + rand(2),0,0,0);
			outputText("Placeholder text 1. Amount of golems you can scavenge: "+player.statusEffectv1(StatusEffects.GolemScavenge)+"");
			menu();
			addButton(1, "Leave", cleanupAfterCombat);
			addButton(3, "Scavenge", golemScavenge2);
		}
		public function postFightGolemOptions3():void {
			clearOutput();
			outputText("Placeholder text 1.");
			menu();
			addButton(1, "Leave", cleanupAfterCombat);
			addButton(3, "Scavenge", golemScavenge3);
		}
		public function postFightGolemOptions4():void {
			clearOutput();
			if (!player.hasStatusEffect(StatusEffects.GolemScavenge)) player.createStatusEffect(StatusEffects.GolemScavenge,2 + rand(2),1,0,0);
			outputText("Placeholder text 1. Amount of golems you can scavenge: "+player.statusEffectv1(StatusEffects.GolemScavenge)+"");
			menu();
			addButton(1, "Leave", cleanupAfterCombat);
			addButton(3, "Scavenge", golemScavenge4);
		}
		private function golemScavenge1():void {
			clearOutput();
			outputText("Placeholder text 2. ");
			if (rand(4) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("Placeholder text. On success.");
				doNext(takeCore);
			}
			else {
				outputText("Placeholder text. On failure.");
				doNext(cleanupAfterCombat);
			}
		}
		private function golemScavenge2():void {
			clearOutput();
			outputText("Placeholder text 2. ");
			player.addStatusValue(StatusEffects.GolemScavenge, 1, -1);
			if (rand(4) == 0 || player.statusEffectv1(StatusEffects.GolemScavenge) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("Placeholder text. On success.");
				doNext(takeCore);
			}
			else {
				outputText("Placeholder text. On failure.");
				if (player.hasStatusEffect(StatusEffects.GolemScavenge)) doNext(golemScavenge2);
				else doNext(cleanupAfterCombat);
			}
		}
		private function golemScavenge3():void {
			clearOutput();
			outputText("Placeholder text 2. ");
			if (rand(4) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("Placeholder text. +2 stones. On success.");
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 2;
				doNext(takeCore);
			}
			else {
				outputText("Placeholder text. +5 stones. On failure.");
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 5;
				doNext(cleanupAfterCombat);
			}
		}
		private function golemScavenge4():void {
			clearOutput();
			outputText("Placeholder text 2. ");
			player.addStatusValue(StatusEffects.GolemScavenge, 1, -1);
			if (rand(4) == 0 || player.statusEffectv1(StatusEffects.GolemScavenge) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("Placeholder text. +2 stones. On success.");
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 2;
				doNext(takeCore);
			}
			else {
				outputText("Placeholder text. +5 stones. On failure.");
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 5;
				if (player.hasStatusEffect(StatusEffects.GolemScavenge)) doNext(golemScavenge4);
				else doNext(cleanupAfterCombat);
			}
		}
		private function takeCore():void {
			if (player.statusEffectv1(StatusEffects.GolemScavenge) > 0) {
				if (player.statusEffectv2(StatusEffects.GolemScavenge) > 0) inventory.takeItem(useables.GOLCORE, golemScavenge4);
				else inventory.takeItem(useables.GOLCORE, golemScavenge2);
			}
			else {
				player.removeStatusEffect(StatusEffects.GolemScavenge);
				inventory.takeItem(useables.GOLCORE, cleanupAfterCombat);
			}
		}
		
		//---------------
		//
		//  ELEMENTALS
		//
		//---------------
		
		public function maxSizeOfElementalsArmy():Number {
			var maxSizeOfElementalsArmyCounter:Number = 0;
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank1) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank2) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank3) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank4) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank5) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank6) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank7) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank8) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank9) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank10) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank11) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank12) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank13) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank14) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank15) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank16) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank17) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank18) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank19) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank19) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank20) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank21) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank22) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank23) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank24) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank25) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank26) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank27) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank28) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank29) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank30) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementalContractRank31) >= 0) maxSizeOfElementalsArmyCounter += 3;
			if (player.findPerk(PerkLib.ElementsOfTheOrtodoxPath) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementsOfMarethBasics) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementsOfMarethAdvanced) >= 0) maxSizeOfElementalsArmyCounter += 1;
			return maxSizeOfElementalsArmyCounter;
		}
		
		public function accessSummonElementalsMainMenu():void {
			clearOutput();
			menu();
			outputText("Which one elemental would you like to summon or promote to higher rank?\n\n");
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0) outputText("Current limit for elemental summons: " + maxSizeOfElementalsArmy() + " different types of elementals\n\n");
			outputText("<b>Currently summoned elementals:</b><i>");
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) {
				outputText("\nAir");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 32) outputText(" ((Peak) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 33) outputText(" ((Low) Earl Rank)");//186
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 34) outputText(" ((Mid) Earl Rank)");//192
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 35) outputText(" ((Advanced) Earl Rank)");//198
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 36) outputText(" ((Peak) Earl Rank)");//204
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 37) outputText(" ((Low) Marquess Rank)");//210
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 38) outputText(" ((Mid) Marquess Rank)");//216
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 39) outputText(" ((Advanced) Marquess Rank)");//222
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 40) outputText(" ((Peak) Marquess Rank)");//228
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 41) outputText(" ((Low) Duke Rank)");//234
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 42) outputText(" ((Mid) Duke Rank)");//240
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 43) outputText(" ((Advanced) Duke Rank)");//246
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 44) outputText(" ((Peak) Duke Rank)");//252
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 45) outputText(" ((Low) Prince Rank)");//258
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 46) outputText(" ((Mid) Prince Rank)");//264
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 47) outputText(" ((Advanced) Prince Rank)");//270
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 48) outputText(" ((Peak) Prince Rank)");//276
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 49) outputText(" ((Low) King Rank)");//282
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 50) outputText(" ((Mid) King Rank)");//288
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 51) outputText(" ((Advanced) King Rank)");//294
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 52) outputText(" ((Peak) King Rank)");//300
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) {
				outputText("\nEarth");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) {
				outputText("\nFire");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) {
				outputText("\nWater");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) {
				outputText("\nEther");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) {
				outputText("\nWood");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) {
				outputText("\nMetal");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) {
				outputText("\nIce");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) {
				outputText("\nLightning");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) {
				outputText("\nDarkness");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsPoison)) {
				outputText("\nPoison");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsPurity)) {
				outputText("\nPurity");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsCorruption)) {
				outputText("\nCorruption");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 9) outputText(" (Rank 8)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 10) outputText(" (Rank 9)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 11) outputText(" (9th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 12) outputText(" (8th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 13) outputText(" (7th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 14) outputText(" (6th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 15) outputText(" (5th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 16) outputText(" (4th Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 17) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 18) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 19) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 20) outputText(" (Grand Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 21) outputText(" ((Low) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 22) outputText(" ((Mid) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 23) outputText(" ((Advanced) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 24) outputText(" ((Peak) Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 25) outputText(" ((Low) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 26) outputText(" ((Mid) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 27) outputText(" ((Advanced) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 28) outputText(" ((Peak) Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 29) outputText(" ((Low) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 30) outputText(" ((Mid) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 31) outputText(" ((Advanced) Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 32) outputText(" ((Peak) Viscount Rank)");
			}
			outputText("</i>");
			addButton(0, "Ranks (1)", accessSummonElementalsMainMenu1).hint("Rank 0 to 9th Elder Rank");
			addButton(1, "Ranks (2)", accessSummonElementalsMainMenu2).hint("5th Elder Rank to (Peak) Baron Rank");
			addButton(2, "Ranks (3)", accessSummonElementalsMainMenu3).hint("(Low) Viscount Rank to (Peak) Viscount Rank");
			addButton(14, "Back", playerMenu);
		}
		private function accessSummonElementalsMainMenu1():void {
			menu();
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0 && (player.statusEffectv1(StatusEffects.SummonedElementals) < maxSizeOfElementalsArmy())) addButton(0, "Summon", summoningElementalsSubmenu).hint("Req. 100 mana, 50 fatigue");
			if (player.findPerk(PerkLib.ElementalContractRank1) >= 0) addButton(1, "RankUp(1)", rankUpSubmenu1st).hint("Req. 100 mana, 50 fatigue");
			if (player.findPerk(PerkLib.ElementalContractRank2) >= 0) addButton(2, "RankUp(2)", rankUpSubmenu2nd).hint("Req. 200 mana, 100 fatigue");
			if (player.findPerk(PerkLib.ElementalContractRank3) >= 0) addButton(3, "RankUp(3)", rankUpSubmenu3rd).hint("Req. 300 mana, 150 fatigue");
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 2) {
				if (player.findPerk(PerkLib.ElementalContractRank4) >= 0) addButton(4, "RankUp(4)", rankUpSubmenu4th).hint("Req. 400 mana, 200 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank5) >= 0) addButton(5, "RankUp(5)", rankUpSubmenu5th).hint("Req. 500 mana, 250 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank6) >= 0) addButton(6, "RankUp(6)", rankUpSubmenu6th).hint("Req. 600 mana, 300 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank7) >= 0) addButton(7, "RankUp(7)", rankUpSubmenu7th).hint("Req. 700 mana, 350 fatigue");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 3) {
				if (player.findPerk(PerkLib.ElementalContractRank8) >= 0) addButton(8, "RankUp(8)", rankUpSubmenu8th).hint("Req. 800 mana, 400 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank9) >= 0) addButton(9, "RankUp(9)", rankUpSubmenu9th).hint("Req. 900 mana, 450 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank10) >= 0) addButton(10, "RankUp(10)", rankUpSubmenu10th).hint("Req. 1000 mana, 500 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank11) >= 0) addButton(11, "RankUp(11)", rankUpSubmenu11th).hint("Req. 1100 mana, 550 fatigue");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 4) {
				if (player.findPerk(PerkLib.ElementalContractRank12) >= 0) addButton(12, "RankUp(12)", rankUpSubmenu12th).hint("Req. 1200 mana, 600 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank13) >= 0) addButton(13, "RankUp(13)", rankUpSubmenu13th).hint("Req. 1300 mana, 650 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function accessSummonElementalsMainMenu2():void {
			menu();
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 4) {
				if (player.findPerk(PerkLib.ElementalContractRank14) >= 0) addButton(0, "RankUp(14)", rankUpSubmenu14th).hint("Req. 1400 mana, 700 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank15) >= 0) addButton(1, "RankUp(15)", rankUpSubmenu15th).hint("Req. 1500 mana, 750 fatigue");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 5) {
				if (player.findPerk(PerkLib.ElementalContractRank16) >= 0) addButton(2, "RankUp(16)", rankUpSubmenu16th).hint("Req. 1600 mana, 800 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank17) >= 0) addButton(3, "RankUp(17)", rankUpSubmenu17th).hint("Req. 1700 mana, 850 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank18) >= 0) addButton(4, "RankUp(18)", rankUpSubmenu18th).hint("Req. 1800 mana, 900 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank19) >= 0) addButton(5, "RankUp(19)", rankUpSubmenu19th).hint("Req. 1900 mana, 950 fatigue");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 6) {
				if (player.findPerk(PerkLib.ElementalContractRank20) >= 0) addButton(6, "RankUp(20)", rankUpSubmenu20th).hint("Req. 2000 mana, 1000 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank21) >= 0) addButton(7, "RankUp(21)", rankUpSubmenu21th).hint("Req. 2100 mana, 1050 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank22) >= 0) addButton(8, "RankUp(22)", rankUpSubmenu22th).hint("Req. 2200 mana, 1100 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank23) >= 0) addButton(9, "RankUp(23)", rankUpSubmenu23th).hint("Req. 2300 mana, 1150 fatigue");
			}
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 7) {
				if (player.findPerk(PerkLib.ElementalContractRank24) >= 0) addButton(10, "RankUp(24)", rankUpSubmenu24th).hint("Req. 2400 mana, 1200 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank25) >= 0) addButton(11, "RankUp(25)", rankUpSubmenu25th).hint("Req. 2500 mana, 1250 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank26) >= 0) addButton(12, "RankUp(26)", rankUpSubmenu26th).hint("Req. 2600 mana, 1300 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank27) >= 0) addButton(13, "RankUp(27)", rankUpSubmenu27th).hint("Req. 2700 mana, 1350 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function accessSummonElementalsMainMenu3():void {
			menu();
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 8) {
				if (player.findPerk(PerkLib.ElementalContractRank28) >= 0) addButton(10, "RankUp(28)", rankUpSubmenu28th).hint("Req. 2800 mana, 1400 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank29) >= 0) addButton(11, "RankUp(29)", rankUpSubmenu29th).hint("Req. 2900 mana, 1450 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank30) >= 0) addButton(12, "RankUp(30)", rankUpSubmenu30th).hint("Req. 3000 mana, 1500 fatigue");
				if (player.findPerk(PerkLib.ElementalContractRank31) >= 0) addButton(13, "RankUp(31)", rankUpSubmenu31th).hint("Req. 3100 mana, 1550 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function summoningElementalsSubmenu():void {
			outputText("\n\nIf you not have enough mana (100+) and fatigue (50+) it will be impossible to summon any elementals.\n\n");
			menu();
			if (player.mana >= 100 && (player.fatigue + 50 <= player.maxFatigue())) {
				if (player.statusEffectv1(StatusEffects.SummonedElementalsAir) < 1) addButton(0, "Air", summonElementalAir).hint("100 mana, 50 fatigue");
				if (player.statusEffectv1(StatusEffects.SummonedElementalsEarth) < 1) addButton(1, "Earth", summonElementalEarth).hint("100 mana, 50 fatigue");
				if (player.statusEffectv1(StatusEffects.SummonedElementalsFire) < 1) addButton(2, "Fire", summonElementalFire).hint("100 mana, 50 fatigue");
				if (player.statusEffectv1(StatusEffects.SummonedElementalsWater) < 1) addButton(3, "Water", summonElementalWater).hint("100 mana, 50 fatigue");
				if (player.findPerk(PerkLib.ElementsOfTheOrtodoxPath) >= 0) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsEther) < 1) addButton(4, "Ether", summonElementalEther).hint("100 mana, 50 fatigue");
					if (player.statusEffectv1(StatusEffects.SummonedElementalsWood) < 1) addButton(5, "Wood", summonElementalWood).hint("100 mana, 50 fatigue");
					if (player.statusEffectv1(StatusEffects.SummonedElementalsMetal) < 1) addButton(6, "Metal", summonElementalMetal).hint("100 mana, 50 fatigue");
				}
				if (player.findPerk(PerkLib.ElementsOfMarethBasics) >= 0) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsIce) < 1) addButton(7, "Ice", summonElementalIce).hint("100 mana, 50 fatigue");
					if (player.statusEffectv1(StatusEffects.SummonedElementalsLightning) < 1) addButton(8, "Lightning", summonElementalLightning).hint("100 mana, 50 fatigue");
					if (player.statusEffectv1(StatusEffects.SummonedElementalsDarkness) < 1) addButton(9, "Darkness", summonElementalDarkness).hint("100 mana, 50 fatigue");
				}
				if (player.findPerk(PerkLib.ElementsOfMarethAdvanced) >= 0) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsPoison) < 1) addButton(10, "Poison", summonElementalPoison).hint("100 mana, 50 fatigue");
					if (player.statusEffectv1(StatusEffects.SummonedElementalsPurity) < 1) addButton(11, "Purity", summonElementalPurity).hint("100 mana, 50 fatigue");
					if (player.statusEffectv1(StatusEffects.SummonedElementalsCorruption) < 1) addButton(12, "Corruption", summonElementalCorruption).hint("100 mana, 50 fatigue");
				}
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu1st():void {
			outputText("\n\nIf you not have enough mana (100+) and fatigue (50+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 100 && (player.fatigue + 50 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 1) addButton(0, "Air", rankUpElementalAir).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 1) addButton(1, "Earth", rankUpElementalEarth).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 1) addButton(2, "Fire", rankUpElementalFire).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 1) addButton(3, "Water", rankUpElementalWater).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 1) addButton(4, "Ether", rankUpElementalEther).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 1) addButton(5, "Wood", rankUpElementalWood).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 1) addButton(6, "Metal", rankUpElementalMetal).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 1) addButton(7, "Ice", rankUpElementalIce).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 1) addButton(8, "Lightning", rankUpElementalLightning).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 1) addButton(9, "Darkness", rankUpElementalDarkness).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 1) addButton(10, "Poison", rankUpElementalPoison).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 1) addButton(11, "Purity", rankUpElementalPurity).hint("100 mana, 50 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 1) addButton(12, "Corruption", rankUpElementalCorruption).hint("100 mana, 50 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu2nd():void {
			outputText("\n\nIf you not have enough mana (200+) and fatigue (100+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 200 && (player.fatigue + 100 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 2) addButton(0, "Air", rankUpElementalAir).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 2) addButton(1, "Earth", rankUpElementalEarth).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 2) addButton(2, "Fire", rankUpElementalFire).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 2) addButton(3, "Water", rankUpElementalWater).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 2) addButton(4, "Ether", rankUpElementalEther).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 2) addButton(5, "Wood", rankUpElementalWood).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 2) addButton(6, "Metal", rankUpElementalMetal).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 2) addButton(7, "Ice", rankUpElementalIce).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 2) addButton(8, "Lightning", rankUpElementalLightning).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 2) addButton(9, "Darkness", rankUpElementalDarkness).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 2) addButton(10, "Poison", rankUpElementalPoison).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 2) addButton(11, "Purity", rankUpElementalPurity).hint("200 mana, 100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 2) addButton(12, "Corruption", rankUpElementalCorruption).hint("200 mana, 100 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu3rd():void {
			outputText("\n\nIf you not have enough mana (300+) and fatigue (150+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 300 && (player.fatigue + 150 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 3) addButton(0, "Air", rankUpElementalAir).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 3) addButton(1, "Earth", rankUpElementalEarth).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 3) addButton(2, "Fire", rankUpElementalFire).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 3) addButton(3, "Water", rankUpElementalWater).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 3) addButton(4, "Ether", rankUpElementalEther).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 3) addButton(5, "Wood", rankUpElementalWood).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 3) addButton(6, "Metal", rankUpElementalMetal).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 3) addButton(7, "Ice", rankUpElementalIce).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 3) addButton(8, "Lightning", rankUpElementalLightning).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 3) addButton(9, "Darkness", rankUpElementalDarkness).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 3) addButton(10, "Poison", rankUpElementalPoison).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 3) addButton(11, "Purity", rankUpElementalPurity).hint("300 mana, 150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 3) addButton(12, "Corruption", rankUpElementalCorruption).hint("300 mana, 150 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu4th():void {
			outputText("\n\nIf you not have enough mana (400+) and fatigue (200+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 400 && (player.fatigue + 200 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 4) addButton(0, "Air", rankUpElementalAir).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 4) addButton(1, "Earth", rankUpElementalEarth).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 4) addButton(2, "Fire", rankUpElementalFire).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 4) addButton(3, "Water", rankUpElementalWater).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 4) addButton(4, "Ether", rankUpElementalEther).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 4) addButton(5, "Wood", rankUpElementalWood).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 4) addButton(6, "Metal", rankUpElementalMetal).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 4) addButton(7, "Ice", rankUpElementalIce).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 4) addButton(8, "Lightning", rankUpElementalLightning).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 4) addButton(9, "Darkness", rankUpElementalDarkness).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 4) addButton(10, "Poison", rankUpElementalPoison).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 4) addButton(11, "Purity", rankUpElementalPurity).hint("400 mana, 200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 4) addButton(12, "Corruption", rankUpElementalCorruption).hint("400 mana, 200 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu5th():void {
			outputText("\n\nIf you not have enough mana (500+) and fatigue (250+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 500 && (player.fatigue + 250 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 5) addButton(0, "Air", rankUpElementalAir).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 5) addButton(1, "Earth", rankUpElementalEarth).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 5) addButton(2, "Fire", rankUpElementalFire).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 5) addButton(3, "Water", rankUpElementalWater).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 5) addButton(4, "Ether", rankUpElementalEther).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 5) addButton(5, "Wood", rankUpElementalWood).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 5) addButton(6, "Metal", rankUpElementalMetal).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 5) addButton(7, "Ice", rankUpElementalIce).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 5) addButton(8, "Lightning", rankUpElementalLightning).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 5) addButton(9, "Darkness", rankUpElementalDarkness).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 5) addButton(10, "Poison", rankUpElementalPoison).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 5) addButton(11, "Purity", rankUpElementalPurity).hint("500 mana, 250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 5) addButton(12, "Corruption", rankUpElementalCorruption).hint("500 mana, 250 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu6th():void {
			outputText("\n\nIf you not have enough mana (600+) and fatigue (300+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 600 && (player.fatigue + 300 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 6) addButton(0, "Air", rankUpElementalAir).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 6) addButton(1, "Earth", rankUpElementalEarth).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 6) addButton(2, "Fire", rankUpElementalFire).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 6) addButton(3, "Water", rankUpElementalWater).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 6) addButton(4, "Ether", rankUpElementalEther).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 6) addButton(5, "Wood", rankUpElementalWood).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 6) addButton(6, "Metal", rankUpElementalMetal).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 6) addButton(7, "Ice", rankUpElementalIce).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 6) addButton(8, "Lightning", rankUpElementalLightning).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 6) addButton(9, "Darkness", rankUpElementalDarkness).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 6) addButton(10, "Poison", rankUpElementalPoison).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 6) addButton(11, "Purity", rankUpElementalPurity).hint("600 mana, 300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 6) addButton(12, "Corruption", rankUpElementalCorruption).hint("600 mana, 300 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu7th():void {
			outputText("\n\nIf you not have enough mana (700+) and fatigue (350+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 700 && (player.fatigue + 350 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 7) addButton(0, "Air", rankUpElementalAir).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 7) addButton(1, "Earth", rankUpElementalEarth).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 7) addButton(2, "Fire", rankUpElementalFire).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 7) addButton(3, "Water", rankUpElementalWater).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 7) addButton(4, "Ether", rankUpElementalEther).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 7) addButton(5, "Wood", rankUpElementalWood).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 7) addButton(6, "Metal", rankUpElementalMetal).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 7) addButton(7, "Ice", rankUpElementalIce).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 7) addButton(8, "Lightning", rankUpElementalLightning).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 7) addButton(9, "Darkness", rankUpElementalDarkness).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 7) addButton(10, "Poison", rankUpElementalPoison).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 7) addButton(11, "Purity", rankUpElementalPurity).hint("700 mana, 350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 7) addButton(12, "Corruption", rankUpElementalCorruption).hint("700 mana, 350 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu8th():void {
			outputText("\n\nIf you not have enough mana (800+) and fatigue (400+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 800 && (player.fatigue + 400 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 8) addButton(0, "Air", rankUpElementalAir).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 8) addButton(1, "Earth", rankUpElementalEarth).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 8) addButton(2, "Fire", rankUpElementalFire).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 8) addButton(3, "Water", rankUpElementalWater).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 8) addButton(4, "Ether", rankUpElementalEther).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 8) addButton(5, "Wood", rankUpElementalWood).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 8) addButton(6, "Metal", rankUpElementalMetal).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 8) addButton(7, "Ice", rankUpElementalIce).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 8) addButton(8, "Lightning", rankUpElementalLightning).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 8) addButton(9, "Darkness", rankUpElementalDarkness).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 8) addButton(10, "Poison", rankUpElementalPoison).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 8) addButton(11, "Purity", rankUpElementalPurity).hint("800 mana, 400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 8) addButton(12, "Corruption", rankUpElementalCorruption).hint("800 mana, 400 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu9th():void {
			outputText("\n\nIf you not have enough mana (900+) and fatigue (450+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 900 && (player.fatigue + 450 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 9) addButton(0, "Air", rankUpElementalAir).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 9) addButton(1, "Earth", rankUpElementalEarth).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 9) addButton(2, "Fire", rankUpElementalFire).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 9) addButton(3, "Water", rankUpElementalWater).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 9) addButton(4, "Ether", rankUpElementalEther).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 9) addButton(5, "Wood", rankUpElementalWood).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 9) addButton(6, "Metal", rankUpElementalMetal).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 9) addButton(7, "Ice", rankUpElementalIce).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 9) addButton(8, "Lightning", rankUpElementalLightning).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 9) addButton(9, "Darkness", rankUpElementalDarkness).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 9) addButton(10, "Poison", rankUpElementalPoison).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 9) addButton(11, "Purity", rankUpElementalPurity).hint("900 mana, 450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 9) addButton(12, "Corruption", rankUpElementalCorruption).hint("900 mana, 450 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu10th():void {
			outputText("\n\nIf you not have enough mana (1000+) and fatigue (500+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1000 && (player.fatigue + 500 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 10) addButton(0, "Air", rankUpElementalAir).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 10) addButton(1, "Earth", rankUpElementalEarth).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 10) addButton(2, "Fire", rankUpElementalFire).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 10) addButton(3, "Water", rankUpElementalWater).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 10) addButton(4, "Ether", rankUpElementalEther).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 10) addButton(5, "Wood", rankUpElementalWood).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 10) addButton(6, "Metal", rankUpElementalMetal).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 10) addButton(7, "Ice", rankUpElementalIce).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 10) addButton(8, "Lightning", rankUpElementalLightning).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 10) addButton(9, "Darkness", rankUpElementalDarkness).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 10) addButton(10, "Poison", rankUpElementalPoison).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 10) addButton(11, "Purity", rankUpElementalPurity).hint("1000 mana, 500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 10) addButton(12, "Corruption", rankUpElementalCorruption).hint("1000 mana, 500 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu11th():void {
			outputText("\n\nIf you not have enough mana (1100+) and fatigue (550+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1100 && (player.fatigue + 550 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 11) addButton(0, "Air", rankUpElementalAir).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 11) addButton(1, "Earth", rankUpElementalEarth).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 11) addButton(2, "Fire", rankUpElementalFire).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 11) addButton(3, "Water", rankUpElementalWater).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 11) addButton(4, "Ether", rankUpElementalEther).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 11) addButton(5, "Wood", rankUpElementalWood).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 11) addButton(6, "Metal", rankUpElementalMetal).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 11) addButton(7, "Ice", rankUpElementalIce).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 11) addButton(8, "Lightning", rankUpElementalLightning).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 11) addButton(9, "Darkness", rankUpElementalDarkness).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 11) addButton(10, "Poison", rankUpElementalPoison).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 11) addButton(11, "Purity", rankUpElementalPurity).hint("1100 mana, 550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 11) addButton(12, "Corruption", rankUpElementalCorruption).hint("1100 mana, 550 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu12th():void {
			outputText("\n\nIf you not have enough mana (1200+) and fatigue (600+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1200 && (player.fatigue + 600 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 12) addButton(0, "Air", rankUpElementalAir).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 12) addButton(1, "Earth", rankUpElementalEarth).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 12) addButton(2, "Fire", rankUpElementalFire).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 12) addButton(3, "Water", rankUpElementalWater).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 12) addButton(4, "Ether", rankUpElementalEther).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 12) addButton(5, "Wood", rankUpElementalWood).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 12) addButton(6, "Metal", rankUpElementalMetal).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 12) addButton(7, "Ice", rankUpElementalIce).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 12) addButton(8, "Lightning", rankUpElementalLightning).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 12) addButton(9, "Darkness", rankUpElementalDarkness).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 12) addButton(10, "Poison", rankUpElementalPoison).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 12) addButton(11, "Purity", rankUpElementalPurity).hint("1200 mana, 600 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 12) addButton(12, "Corruption", rankUpElementalCorruption).hint("1200 mana, 600 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu13th():void {
			outputText("\n\nIf you not have enough mana (1300+) and fatigue (650+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1300 && (player.fatigue + 650 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 13) addButton(0, "Air", rankUpElementalAir).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 13) addButton(1, "Earth", rankUpElementalEarth).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 13) addButton(2, "Fire", rankUpElementalFire).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 13) addButton(3, "Water", rankUpElementalWater).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 13) addButton(4, "Ether", rankUpElementalEther).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 13) addButton(5, "Wood", rankUpElementalWood).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 13) addButton(6, "Metal", rankUpElementalMetal).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 13) addButton(7, "Ice", rankUpElementalIce).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 13) addButton(8, "Lightning", rankUpElementalLightning).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 13) addButton(9, "Darkness", rankUpElementalDarkness).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 13) addButton(10, "Poison", rankUpElementalPoison).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 13) addButton(11, "Purity", rankUpElementalPurity).hint("1300 mana, 650 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 13) addButton(12, "Corruption", rankUpElementalCorruption).hint("1300 mana, 650 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu1);
		}
		private function rankUpSubmenu14th():void {
			outputText("\n\nIf you not have enough mana (1400+) and fatigue (700+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1400 && (player.fatigue + 700 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 14) addButton(0, "Air", rankUpElementalAir).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 14) addButton(1, "Earth", rankUpElementalEarth).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 14) addButton(2, "Fire", rankUpElementalFire).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 14) addButton(3, "Water", rankUpElementalWater).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 14) addButton(4, "Ether", rankUpElementalEther).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 14) addButton(5, "Wood", rankUpElementalWood).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 14) addButton(6, "Metal", rankUpElementalMetal).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 14) addButton(7, "Ice", rankUpElementalIce).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 14) addButton(8, "Lightning", rankUpElementalLightning).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 14) addButton(9, "Darkness", rankUpElementalDarkness).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 14) addButton(10, "Poison", rankUpElementalPoison).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 14) addButton(11, "Purity", rankUpElementalPurity).hint("1400 mana, 700 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 14) addButton(12, "Corruption", rankUpElementalCorruption).hint("1400 mana, 700 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu15th():void {
			outputText("\n\nIf you not have enough mana (1500+) and fatigue (750+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1500 && (player.fatigue + 750 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 15) addButton(0, "Air", rankUpElementalAir).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 15) addButton(1, "Earth", rankUpElementalEarth).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 15) addButton(2, "Fire", rankUpElementalFire).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 15) addButton(3, "Water", rankUpElementalWater).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 15) addButton(4, "Ether", rankUpElementalEther).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 15) addButton(5, "Wood", rankUpElementalWood).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 15) addButton(6, "Metal", rankUpElementalMetal).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 15) addButton(7, "Ice", rankUpElementalIce).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 15) addButton(8, "Lightning", rankUpElementalLightning).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 15) addButton(9, "Darkness", rankUpElementalDarkness).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 15) addButton(10, "Poison", rankUpElementalPoison).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 15) addButton(11, "Purity", rankUpElementalPurity).hint("1500 mana, 750 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 15) addButton(12, "Corruption", rankUpElementalCorruption).hint("1500 mana, 750 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu16th():void {
			outputText("\n\nIf you not have enough mana (1600+) and fatigue (800+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1600 && (player.fatigue + 800 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 16) addButton(0, "Air", rankUpElementalAir).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 16) addButton(1, "Earth", rankUpElementalEarth).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 16) addButton(2, "Fire", rankUpElementalFire).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 16) addButton(3, "Water", rankUpElementalWater).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 16) addButton(4, "Ether", rankUpElementalEther).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 16) addButton(5, "Wood", rankUpElementalWood).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 16) addButton(6, "Metal", rankUpElementalMetal).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 16) addButton(7, "Ice", rankUpElementalIce).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 16) addButton(8, "Lightning", rankUpElementalLightning).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 16) addButton(9, "Darkness", rankUpElementalDarkness).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 16) addButton(10, "Poison", rankUpElementalPoison).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 16) addButton(11, "Purity", rankUpElementalPurity).hint("1600 mana, 800 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 16) addButton(12, "Corruption", rankUpElementalCorruption).hint("1600 mana, 800 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu17th():void {
			outputText("\n\nIf you not have enough mana (1700+) and fatigue (850+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1700 && (player.fatigue + 850 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 17) addButton(0, "Air", rankUpElementalAir).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 17) addButton(1, "Earth", rankUpElementalEarth).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 17) addButton(2, "Fire", rankUpElementalFire).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 17) addButton(3, "Water", rankUpElementalWater).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 17) addButton(4, "Ether", rankUpElementalEther).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 17) addButton(5, "Wood", rankUpElementalWood).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 17) addButton(6, "Metal", rankUpElementalMetal).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 17) addButton(7, "Ice", rankUpElementalIce).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 17) addButton(8, "Lightning", rankUpElementalLightning).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 17) addButton(9, "Darkness", rankUpElementalDarkness).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 17) addButton(10, "Poison", rankUpElementalPoison).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 17) addButton(11, "Purity", rankUpElementalPurity).hint("1700 mana, 850 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 17) addButton(12, "Corruption", rankUpElementalCorruption).hint("1700 mana, 850 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu18th():void {
			outputText("\n\nIf you not have enough mana (1800+) and fatigue (900+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1800 && (player.fatigue + 900 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 18) addButton(0, "Air", rankUpElementalAir).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 18) addButton(1, "Earth", rankUpElementalEarth).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 18) addButton(2, "Fire", rankUpElementalFire).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 18) addButton(3, "Water", rankUpElementalWater).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 18) addButton(4, "Ether", rankUpElementalEther).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 18) addButton(5, "Wood", rankUpElementalWood).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 18) addButton(6, "Metal", rankUpElementalMetal).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 18) addButton(7, "Ice", rankUpElementalIce).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 18) addButton(8, "Lightning", rankUpElementalLightning).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 18) addButton(9, "Darkness", rankUpElementalDarkness).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 18) addButton(10, "Poison", rankUpElementalPoison).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 18) addButton(11, "Purity", rankUpElementalPurity).hint("1800 mana, 900 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 18) addButton(12, "Corruption", rankUpElementalCorruption).hint("1800 mana, 900 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu19th():void {
			outputText("\n\nIf you not have enough mana (1900+) and fatigue (950+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1900 && (player.fatigue + 950 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 19) addButton(0, "Air", rankUpElementalAir).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 19) addButton(1, "Earth", rankUpElementalEarth).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 19) addButton(2, "Fire", rankUpElementalFire).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 19) addButton(3, "Water", rankUpElementalWater).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 19) addButton(4, "Ether", rankUpElementalEther).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 19) addButton(5, "Wood", rankUpElementalWood).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 19) addButton(6, "Metal", rankUpElementalMetal).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 19) addButton(7, "Ice", rankUpElementalIce).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 19) addButton(8, "Lightning", rankUpElementalLightning).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 19) addButton(9, "Darkness", rankUpElementalDarkness).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 19) addButton(10, "Poison", rankUpElementalPoison).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 19) addButton(11, "Purity", rankUpElementalPurity).hint("1900 mana, 950 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 19) addButton(12, "Corruption", rankUpElementalCorruption).hint("1900 mana, 950 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu20th():void {
			outputText("\n\nIf you not have enough mana (2000+) and fatigue (1000+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2000 && (player.fatigue + 1000 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 20) addButton(0, "Air", rankUpElementalAir).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 20) addButton(1, "Earth", rankUpElementalEarth).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 20) addButton(2, "Fire", rankUpElementalFire).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 20) addButton(3, "Water", rankUpElementalWater).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 20) addButton(4, "Ether", rankUpElementalEther).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 20) addButton(5, "Wood", rankUpElementalWood).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 20) addButton(6, "Metal", rankUpElementalMetal).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 20) addButton(7, "Ice", rankUpElementalIce).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 20) addButton(8, "Lightning", rankUpElementalLightning).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 20) addButton(9, "Darkness", rankUpElementalDarkness).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 20) addButton(10, "Poison", rankUpElementalPoison).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 20) addButton(11, "Purity", rankUpElementalPurity).hint("2000 mana, 1000 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 20) addButton(12, "Corruption", rankUpElementalCorruption).hint("2000 mana, 1000 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu21th():void {
			outputText("\n\nIf you not have enough mana (2100+) and fatigue (1050+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2100 && (player.fatigue + 1050 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 21) addButton(0, "Air", rankUpElementalAir).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 21) addButton(1, "Earth", rankUpElementalEarth).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 21) addButton(2, "Fire", rankUpElementalFire).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 21) addButton(3, "Water", rankUpElementalWater).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 21) addButton(4, "Ether", rankUpElementalEther).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 21) addButton(5, "Wood", rankUpElementalWood).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 21) addButton(6, "Metal", rankUpElementalMetal).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 21) addButton(7, "Ice", rankUpElementalIce).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 21) addButton(8, "Lightning", rankUpElementalLightning).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 21) addButton(9, "Darkness", rankUpElementalDarkness).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 21) addButton(10, "Poison", rankUpElementalPoison).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 21) addButton(11, "Purity", rankUpElementalPurity).hint("2100 mana, 1050 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 21) addButton(12, "Corruption", rankUpElementalCorruption).hint("2100 mana, 1050 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu22th():void {
			outputText("\n\nIf you not have enough mana (2200+) and fatigue (1100+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2200 && (player.fatigue + 1100 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 22) addButton(0, "Air", rankUpElementalAir).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 22) addButton(1, "Earth", rankUpElementalEarth).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 22) addButton(2, "Fire", rankUpElementalFire).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 22) addButton(3, "Water", rankUpElementalWater).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 22) addButton(4, "Ether", rankUpElementalEther).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 22) addButton(5, "Wood", rankUpElementalWood).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 22) addButton(6, "Metal", rankUpElementalMetal).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 22) addButton(7, "Ice", rankUpElementalIce).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 22) addButton(8, "Lightning", rankUpElementalLightning).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 22) addButton(9, "Darkness", rankUpElementalDarkness).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 22) addButton(10, "Poison", rankUpElementalPoison).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 22) addButton(11, "Purity", rankUpElementalPurity).hint("2200 mana, 1100 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 22) addButton(12, "Corruption", rankUpElementalCorruption).hint("2200 mana, 1100 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu23th():void {
			outputText("\n\nIf you not have enough mana (2300+) and fatigue (1150+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2300 && (player.fatigue + 1150 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 23) addButton(0, "Air", rankUpElementalAir).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 23) addButton(1, "Earth", rankUpElementalEarth).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 23) addButton(2, "Fire", rankUpElementalFire).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 23) addButton(3, "Water", rankUpElementalWater).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 23) addButton(4, "Ether", rankUpElementalEther).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 23) addButton(5, "Wood", rankUpElementalWood).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 23) addButton(6, "Metal", rankUpElementalMetal).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 23) addButton(7, "Ice", rankUpElementalIce).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 23) addButton(8, "Lightning", rankUpElementalLightning).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 23) addButton(9, "Darkness", rankUpElementalDarkness).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 23) addButton(10, "Poison", rankUpElementalPoison).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 23) addButton(11, "Purity", rankUpElementalPurity).hint("2300 mana, 1150 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 23) addButton(12, "Corruption", rankUpElementalCorruption).hint("2300 mana, 1150 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu24th():void {
			outputText("\n\nIf you not have enough mana (2400+) and fatigue (1200+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2400 && (player.fatigue + 1200 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 24) addButton(0, "Air", rankUpElementalAir).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 24) addButton(1, "Earth", rankUpElementalEarth).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 24) addButton(2, "Fire", rankUpElementalFire).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 24) addButton(3, "Water", rankUpElementalWater).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 24) addButton(4, "Ether", rankUpElementalEther).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 24) addButton(5, "Wood", rankUpElementalWood).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 24) addButton(6, "Metal", rankUpElementalMetal).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 24) addButton(7, "Ice", rankUpElementalIce).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 24) addButton(8, "Lightning", rankUpElementalLightning).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 24) addButton(9, "Darkness", rankUpElementalDarkness).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 24) addButton(10, "Poison", rankUpElementalPoison).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 24) addButton(11, "Purity", rankUpElementalPurity).hint("2400 mana, 1200 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 24) addButton(12, "Corruption", rankUpElementalCorruption).hint("2400 mana, 1200 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu25th():void {
			outputText("\n\nIf you not have enough mana (2500+) and fatigue (1250+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2500 && (player.fatigue + 1250 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 25) addButton(0, "Air", rankUpElementalAir).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 25) addButton(1, "Earth", rankUpElementalEarth).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 25) addButton(2, "Fire", rankUpElementalFire).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 25) addButton(3, "Water", rankUpElementalWater).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 25) addButton(4, "Ether", rankUpElementalEther).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 25) addButton(5, "Wood", rankUpElementalWood).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 25) addButton(6, "Metal", rankUpElementalMetal).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 25) addButton(7, "Ice", rankUpElementalIce).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 25) addButton(8, "Lightning", rankUpElementalLightning).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 25) addButton(9, "Darkness", rankUpElementalDarkness).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 25) addButton(10, "Poison", rankUpElementalPoison).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 25) addButton(11, "Purity", rankUpElementalPurity).hint("2500 mana, 1250 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 25) addButton(12, "Corruption", rankUpElementalCorruption).hint("2500 mana, 1250 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu26th():void {
			outputText("\n\nIf you not have enough mana (2600+) and fatigue (1300+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2600 && (player.fatigue + 1300 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 26) addButton(0, "Air", rankUpElementalAir).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 26) addButton(1, "Earth", rankUpElementalEarth).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 26) addButton(2, "Fire", rankUpElementalFire).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 26) addButton(3, "Water", rankUpElementalWater).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 26) addButton(4, "Ether", rankUpElementalEther).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 26) addButton(5, "Wood", rankUpElementalWood).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 26) addButton(6, "Metal", rankUpElementalMetal).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 26) addButton(7, "Ice", rankUpElementalIce).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 26) addButton(8, "Lightning", rankUpElementalLightning).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 26) addButton(9, "Darkness", rankUpElementalDarkness).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 26) addButton(10, "Poison", rankUpElementalPoison).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 26) addButton(11, "Purity", rankUpElementalPurity).hint("2600 mana, 1300 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 26) addButton(12, "Corruption", rankUpElementalCorruption).hint("2600 mana, 1300 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu27th():void {
			outputText("\n\nIf you not have enough mana (2700+) and fatigue (1350+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2700 && (player.fatigue + 1350 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 27) addButton(0, "Air", rankUpElementalAir).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 27) addButton(1, "Earth", rankUpElementalEarth).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 27) addButton(2, "Fire", rankUpElementalFire).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 27) addButton(3, "Water", rankUpElementalWater).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 27) addButton(4, "Ether", rankUpElementalEther).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 27) addButton(5, "Wood", rankUpElementalWood).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 27) addButton(6, "Metal", rankUpElementalMetal).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 27) addButton(7, "Ice", rankUpElementalIce).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 27) addButton(8, "Lightning", rankUpElementalLightning).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 27) addButton(9, "Darkness", rankUpElementalDarkness).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 27) addButton(10, "Poison", rankUpElementalPoison).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 27) addButton(11, "Purity", rankUpElementalPurity).hint("2700 mana, 1350 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 27) addButton(12, "Corruption", rankUpElementalCorruption).hint("2700 mana, 1350 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu2);
		}
		private function rankUpSubmenu28th():void {
			outputText("\n\nIf you not have enough mana (2800+) and fatigue (1400+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2800 && (player.fatigue + 1400 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 28) addButton(0, "Air", rankUpElementalAir).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 28) addButton(1, "Earth", rankUpElementalEarth).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 28) addButton(2, "Fire", rankUpElementalFire).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 28) addButton(3, "Water", rankUpElementalWater).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 28) addButton(4, "Ether", rankUpElementalEther).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 28) addButton(5, "Wood", rankUpElementalWood).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 28) addButton(6, "Metal", rankUpElementalMetal).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 28) addButton(7, "Ice", rankUpElementalIce).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 28) addButton(8, "Lightning", rankUpElementalLightning).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 28) addButton(9, "Darkness", rankUpElementalDarkness).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 28) addButton(10, "Poison", rankUpElementalPoison).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 28) addButton(11, "Purity", rankUpElementalPurity).hint("2800 mana, 1400 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 28) addButton(12, "Corruption", rankUpElementalCorruption).hint("2800 mana, 1400 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu3);
		}
		private function rankUpSubmenu29th():void {
			outputText("\n\nIf you not have enough mana (2900+) and fatigue (1550+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 2900 && (player.fatigue + 1450 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 29) addButton(0, "Air", rankUpElementalAir).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 29) addButton(1, "Earth", rankUpElementalEarth).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 29) addButton(2, "Fire", rankUpElementalFire).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 29) addButton(3, "Water", rankUpElementalWater).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 29) addButton(4, "Ether", rankUpElementalEther).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 29) addButton(5, "Wood", rankUpElementalWood).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 29) addButton(6, "Metal", rankUpElementalMetal).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 29) addButton(7, "Ice", rankUpElementalIce).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 29) addButton(8, "Lightning", rankUpElementalLightning).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 29) addButton(9, "Darkness", rankUpElementalDarkness).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 29) addButton(10, "Poison", rankUpElementalPoison).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 29) addButton(11, "Purity", rankUpElementalPurity).hint("2900 mana, 1450 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 29) addButton(12, "Corruption", rankUpElementalCorruption).hint("2900 mana, 1450 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu3);
		}
		private function rankUpSubmenu30th():void {
			outputText("\n\nIf you not have enough mana (3000+) and fatigue (150+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 3000 && (player.fatigue + 1500 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 30) addButton(0, "Air", rankUpElementalAir).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 30) addButton(1, "Earth", rankUpElementalEarth).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 30) addButton(2, "Fire", rankUpElementalFire).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 30) addButton(3, "Water", rankUpElementalWater).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 30) addButton(4, "Ether", rankUpElementalEther).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 30) addButton(5, "Wood", rankUpElementalWood).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 30) addButton(6, "Metal", rankUpElementalMetal).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 30) addButton(7, "Ice", rankUpElementalIce).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 30) addButton(8, "Lightning", rankUpElementalLightning).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 30) addButton(9, "Darkness", rankUpElementalDarkness).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 30) addButton(10, "Poison", rankUpElementalPoison).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 30) addButton(11, "Purity", rankUpElementalPurity).hint("3000 mana, 1500 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 30) addButton(12, "Corruption", rankUpElementalCorruption).hint("3000 mana, 1500 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu3);
		}
		private function rankUpSubmenu31th():void {
			outputText("\n\nIf you not have enough mana (3100+) and fatigue (1550+) it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 3100 && (player.fatigue + 1550 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 31) addButton(0, "Air", rankUpElementalAir).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 31) addButton(1, "Earth", rankUpElementalEarth).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 31) addButton(2, "Fire", rankUpElementalFire).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 31) addButton(3, "Water", rankUpElementalWater).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 31) addButton(4, "Ether", rankUpElementalEther).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 31) addButton(5, "Wood", rankUpElementalWood).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 31) addButton(6, "Metal", rankUpElementalMetal).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 31) addButton(7, "Ice", rankUpElementalIce).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 31) addButton(8, "Lightning", rankUpElementalLightning).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 31) addButton(9, "Darkness", rankUpElementalDarkness).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPoison) == 31) addButton(10, "Poison", rankUpElementalPoison).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsPurity) == 31) addButton(11, "Purity", rankUpElementalPurity).hint("3100 mana, 1550 fatigue");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) == 31) addButton(12, "Corruption", rankUpElementalCorruption).hint("3100 mana, 1550 fatigue");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu3);
		}

		private function summonElementalAir():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an air elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The air elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own air elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsAir, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalEarth():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an earth elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The earth elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own earth elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsEarth, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalFire():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a fire elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The fire elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own fire elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsFire, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalWater():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a water elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The water elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own water elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsWater, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalIce():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an ice elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The ice elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own ice elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsIce, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalLightning():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a lightning elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The lightning elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own lightning elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsLightning, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalDarkness():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a darkness elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The darkness elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own darkness elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsDarkness, 1, 1, 0, 0);
			finishingSummoningElemental();;
		}
		private function summonElementalWood():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a wood elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The wood elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own wood elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsWood, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalMetal():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a metal elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The metal elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own metal elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsMetal, 1, 1, 0, 0);
			finishingSummoningElemental();;
		}
		private function summonElementalEther():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an ether elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The ether elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own ether elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsEther, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalPoison():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a poison elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The poison elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own poison elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsPoison, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalPurity():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a purity elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The purity elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own purity elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsPurity, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function summonElementalCorruption():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning a corruption elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The corruption elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own corruption elemental!</b>\"");
			player.createStatusEffect(StatusEffects.SummonedElementalsCorruption, 1, 1, 0, 0);
			finishingSummoningElemental();
		}
		private function finishingSummoningElemental():void {
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		
		private function rankUpElementalAir():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsAir));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsAir));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsAir) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsAir);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsAir, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalEarth():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsEarth));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsEarth));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsEarth) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsEarth);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsEarth, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalFire():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsFire));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsFire));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsFire) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsFire);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsFire, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalWater():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsWater));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsWater));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsWater) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsWater);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsWater, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalIce():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsIce));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsIce));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsIce) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsIce);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsIce, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalLightning():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsLightning));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsLightning));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsLightning) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsLightning);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsLightning, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalDarkness():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsDarkness);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsDarkness, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalWood():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsWood));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsWood));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsWood) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsWood);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsWood, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalMetal():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsMetal) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsMetal);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsMetal, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalEther():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsEther));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsEther));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsEther) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsEther);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsEther, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalPoison():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsPoison));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsPoison));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsPoison) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsPoison);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsPoison, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalPurity():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsPurity));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsPurity));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsPurity) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsPurity);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsPurity, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalCorruption():void {
			clearOutput();
			useMana(100 * player.statusEffectv2(StatusEffects.SummonedElementalsCorruption));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsCorruption));
			statScreenRefresh();
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsCorruption);
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsCorruption, 2, 1);
			}
			else failToRankUpElemental();
			doNext(accessSummonElementalsMainMenu);
			cheatTime2(30);
		}
		private function rankUpElementalPart1():void {
			outputText("It has been a while and your mastery of summoning has increased as a consequence. Now confident that you can contain it you head to the arcane circle and set up the ritual to release some of your servant restraints. You order your pet to stand still as you release the binding rune containing it. ");
			outputText("At first it trash in its prison with the clear intention to break free, kill and consume you but the ward holds. You write an additional arcane circle ");
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 2) outputText("around the first ");
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 3) outputText("around the previous one ");
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 4) outputText("around the previous two ");
			outputText("and add new directive and containment runes to the formula. Satisfied with the result you incant a final word of power.");
		}
		private function failToRankUpElemental():void {
			outputText("The enraged elemental struggle against its containment and to your horror find a breach beginning to grow to its full power and striking you in the process with a powerful barrage of energy.\n\n");
			outputText("\"<i>You pitiful mortal... you though you could contain me forever! I’m going to make you regret ever summoning me by...</i>\"");
			outputText("The elemental screams in dismay as your larger arcane circle unleash the full might of its last resort rune. Powerful discharge of energy strikes the wayward servants buying you enough time to rewrite its seal and force it back into servitude.\n\n");
			outputText("\"<i>Someday you will attempt this ritual again and when you do I will..</i>\"");
			outputText("Its final curse is silenced as its power are sealed again reducing it back to its former size. \"<b>Well this ritual is a failure you will have to try again when you achieved better control.</b>\"");
			HPChange(-(Math.round(player.HP * 0.5)), true);
		}
	}

}