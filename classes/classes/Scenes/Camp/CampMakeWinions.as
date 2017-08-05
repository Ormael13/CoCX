/**
 * ...
 * @author Ormael
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
		
		//TEMPORAL_GOLEMS_BAG and PERNAMENT_GOLEMS_BAG - pretty easy to quess: amount of temp or perm golems PC have in "golem bag"
		
		public function maxTemporalGolemsBagSize():Number {
			var maxTemporalGolemsBagSizeCounter:Number = 0;
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) maxTemporalGolemsBagSizeCounter += 3;
			if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) maxTemporalGolemsBagSizeCounter += 2;
			return maxTemporalGolemsBagSizeCounter;
		}
		public function maxPernamentGolemsBagSize():Number {
			var maxPernamentGolemsBagSizeCounter:Number = 0;
			return maxPernamentGolemsBagSizeCounter;
		}
		public function maxReusableGolemCoresBagSize():Number {
			var maxReusableGolemCoresBagSizeCounter:Number = 0;
			if (maxTemporalGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxTemporalGolemsBagSize();
			if (maxPernamentGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPernamentGolemsBagSize();
			maxReusableGolemCoresBagSizeCounter *= 2;
			return maxReusableGolemCoresBagSizeCounter;
		}
		public function temporalGolemMakingCost():Number {
			var tempGolemCost:Number = 50;
			if (player.findPerk(PerkLib.ApprenticeGolemMaker) >= 0) tempGolemCost -= 10;
			return tempGolemCost;
		}
		
		public function accessMakeWinionsMainMenu():void {
			clearOutput();
			menu();
			outputText("What helper would you like to make?\n");
			outputText("Stored golem cores for future reuse when making new golems: " + flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + " / " + maxReusableGolemCoresBagSize() + "\n");
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) outputText("Temporal Golems Bag: " + flags[kFLAGS.TEMPORAL_GOLEMS_BAG] + " golems\n");
		//	if (player.findPerk(PerkLib.) >= 0) outputText("Pernament Golems Bag: " + flags[kFLAGS.PERNAMENT_GOLEMS_BAG] + " golems\n");
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) addButton(0, "T.S.Golem", makeTemporalStoneGolem).hint("Make most simply golem made of pile of stones.  <b>It will cruble after one attack!</b>\n\nCost: " + temporalGolemMakingCost() + "")
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) addButton(13, "TakeOutCore", takeOutGolemCoreFromGolemBag).hint("Take out one golem core from 'golem bag'.")
			addButton(14, "Back", playerMenu);
		}
		
		public function makeTemporalStoneGolem():void {
			clearOutput();
			if (player.mana < temporalGolemMakingCost()) {
				outputText("Your mana is too low to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1)) {
				outputText("You lack golem core to finish golem creation.");
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
			player.mana -= 50;
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] < 1) flags[kFLAGS.TEMPORAL_GOLEMS_BAG] = 1;
			else flags[kFLAGS.TEMPORAL_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			cheatTime(1/4);
		}
		
		public function takeOutGolemCoreFromGolemBag():void {
			clearOutput();
			outputText("In order to not overload your bad ofr reusable golem cores you took one of them.\n\n");
			flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			inventory.takeItem(useables.GOLCORE, accessMakeWinionsMainMenu);
		}
		
		public function maxSizeOfElementalsArmy():Number {
			var maxSizeOfElementalsArmyCounter:Number = 0;
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank1) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank2) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank3) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementsOfMarethBasics) >= 0) maxSizeOfElementalsArmyCounter += 2;
			return maxSizeOfElementalsArmyCounter;
		}
		
		public function accessSummonElementalsMainMenu():void {
			clearOutput();
			menu();
			outputText("Which one elemental would you like to summon or promote to higher rank?\n");
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0) outputText("Current limit for elemental summons: " + maxSizeOfElementalsArmy() + " different types of elementals\n");
			outputText("<b>Currently summoned elementals:</b><i>");
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAir)) {
				outputText("\nAir");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 3) outputText(" (Rank 2)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarth)) {
				outputText("\nEarth");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 3) outputText(" (Rank 2)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFire)) {
				outputText("\nFire");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 3) outputText(" (Rank 2)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWater)) {
				outputText("\nWater");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 3) outputText(" (Rank 2)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsIce)) {
				outputText("\nIce");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 3) outputText(" (Rank 2)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsLightning)) {
				outputText("\nLightning");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 2) outputText(" (Rank 1)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsDarkness)) {
				outputText("\nDarkness");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 2) outputText(" (Rank 1)");
			}
			outputText("</i>");
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0 && (player.statusEffectv1(StatusEffects.SummonedElementals) < maxSizeOfElementalsArmy())) addButton(0, "Summon", summoningElementalsSubmenu);
			if (player.findPerk(PerkLib.ElementalContractRank1) >= 0) addButton(1, "RankUp(1)", rankUpSubmenu1st);
			//if (player.findPerk(PerkLib.ElementalContractRank2) >= 0) addButton(2, "RankUp(2)", );
			//addButton(3, "RankUp(3)", );
			//addButton(4, "RankUp(4)", );
			addButton(14, "Back", playerMenu);
		}
		private function summoningElementalsSubmenu():void {
			menu();
			if (player.statusEffectv1(StatusEffects.SummonedElementalsAir) < 1) addButton(0, "Air", summonElementalAir);
			if (player.statusEffectv1(StatusEffects.SummonedElementalsEarth) < 1) addButton(1, "Earth", summonElementalEarth);
			if (player.statusEffectv1(StatusEffects.SummonedElementalsFire) < 1) addButton(2, "Fire", summonElementalFire);
			if (player.statusEffectv1(StatusEffects.SummonedElementalsWater) < 1) addButton(3, "Water", summonElementalWater);
		//	if (player.statusEffectv1(StatusEffects.SummonedElementalsIce) < 1) addButton(5, "Ice", summonElementalEarth);
		//	if (player.statusEffectv1(StatusEffects.SummonedElementalsLightning) < 1) addButton(6, "Lightning", summonElementalEarth);
		//	if (player.statusEffectv1(StatusEffects.SummonedElementalsDarkness) < 1) addButton(7, "Darkness", summonElementalEarth);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu1st():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 1) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 1) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 1) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 1) addButton(3, "Water", rankUpElementalWater);
		//	if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 1) addButton(5, "Ice", summonElementalEarth);
		//	if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 1) addButton(6, "Lightning", summonElementalEarth);
		//	if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 1) addButton(7, "Darkness", summonElementalEarth);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		
		private function summonElementalAir():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon air elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon air elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsAir, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalEarth():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon earth elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon earth elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsEarth, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalFire():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon fire elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon fire elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsFire, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalWater():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon water elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon water elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsWater, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		
		private function rankUpElementalAir():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to rank up air elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to rank up air elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			player.addStatusValue(StatusEffects.SummonedElementalsAir, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalEarth():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to rank up earth elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to rank up earth elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			player.addStatusValue(StatusEffects.SummonedElementalsEarth, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalFire():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to rank up fire elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to rank up fire elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			player.addStatusValue(StatusEffects.SummonedElementalsFire, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalWater():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to rank up water elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to rank up water elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("(PLACEHOLDER TEXT SO PLEASE NOT REPORT IS AS BUG) You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			player.addStatusValue(StatusEffects.SummonedElementalsWater, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
	}

}