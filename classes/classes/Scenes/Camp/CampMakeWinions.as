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
			if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) maxTemporalGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.ApprenticeGolemMaker) >= 0) maxTemporalGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.ExpertGolemMaker) >= 0) maxTemporalGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.BiggerGolemBag1) >= 0) maxTemporalGolemsBagSizeCounter += 2;
			if (player.findPerk(PerkLib.BiggerGolemBag2) >= 0) maxTemporalGolemsBagSizeCounter += 2;
			if (player.findPerk(PerkLib.BiggerGolemBag3) >= 0) maxTemporalGolemsBagSizeCounter += 2;
			if (player.findPerk(PerkLib.BiggerGolemBag4) >= 0) maxTemporalGolemsBagSizeCounter += 2;
			if (player.findPerk(PerkLib.BiggerGolemBag5) >= 0) maxTemporalGolemsBagSizeCounter += 2;
			if (player.findPerk(PerkLib.BiggerGolemBag6) >= 0) maxTemporalGolemsBagSizeCounter += 2;
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
			if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) maxReusableGolemCoresBagSizeCounter += 2;
			maxReusableGolemCoresBagSizeCounter *= 2;
			return maxReusableGolemCoresBagSizeCounter;
		}
		public function temporalGolemMakingCost():Number {
			var tempGolemCost:Number = 50;
			if (player.findPerk(PerkLib.ApprenticeGolemMaker) >= 0) tempGolemCost -= 10;
			if (player.findPerk(PerkLib.ChargedCore) >= 0) tempGolemCost += 20;
			if (player.findPerk(PerkLib.SuperChargedCore) >= 0) tempGolemCost += 20;
			return tempGolemCost;
		}
		
		public function accessMakeWinionsMainMenu():void {
			clearOutput();
			menu();
			outputText("What helper would you like to make?\n");
			outputText("Stored golem cores for future reuse when making new golems: " + flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + " / " + maxReusableGolemCoresBagSize() + "\n");
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) outputText("Temporal Golems Bag: " + flags[kFLAGS.TEMPORAL_GOLEMS_BAG] + " / " + maxTemporalGolemsBagSize() + " golems\n");
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
			if (player.findPerk(PerkLib.ElementalContractRank4) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank5) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank6) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank7) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementalContractRank8) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementsOfTheOrtodoxPath) >= 0) maxSizeOfElementalsArmyCounter += 1;
			if (player.findPerk(PerkLib.ElementsOfMarethBasics) >= 0) maxSizeOfElementalsArmyCounter += 1;
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 9) outputText(" (Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 9) outputText(" (Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 9) outputText(" (Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 9) outputText(" (Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 9) outputText(" (Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 9) outputText(" (Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 9) outputText(" (Elder Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWood)) {
				outputText("\nDarkness");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 9) outputText(" (Elder Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsMetal)) {
				outputText("\nDarkness");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 9) outputText(" (Elder Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEther)) {
				outputText("\nDarkness");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 1) outputText(" (Rank 0)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 2) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 3) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 4) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 5) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 6) outputText(" (Rank 5)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 7) outputText(" (Rank 6)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 8) outputText(" (Rank 7)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 9) outputText(" (Elder Rank)");
			}
			outputText("</i>");
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0 && (player.statusEffectv1(StatusEffects.SummonedElementals) < maxSizeOfElementalsArmy())) addButton(0, "Summon", summoningElementalsSubmenu);
			if (player.findPerk(PerkLib.ElementalContractRank1) >= 0) addButton(1, "RankUp(1)", rankUpSubmenu1st);
			if (player.findPerk(PerkLib.ElementalContractRank2) >= 0) addButton(2, "RankUp(2)", rankUpSubmenu2nd);
			if (player.findPerk(PerkLib.ElementalContractRank3) >= 0) addButton(3, "RankUp(3)", rankUpSubmenu3rd);
			if (player.findPerk(PerkLib.ElementalContractRank4) >= 0) addButton(4, "RankUp(4)", rankUpSubmenu4th);
			if (player.findPerk(PerkLib.ElementalContractRank5) >= 0) addButton(5, "RankUp(5)", rankUpSubmenu5th);
			if (player.findPerk(PerkLib.ElementalContractRank6) >= 0) addButton(6, "RankUp(6)", rankUpSubmenu6th);
			if (player.findPerk(PerkLib.ElementalContractRank7) >= 0) addButton(7, "RankUp(7)", rankUpSubmenu7th);
			if (player.findPerk(PerkLib.ElementalContractRank8) >= 0) addButton(8, "RankUp(8)", rankUpSubmenu8th);
			addButton(14, "Back", playerMenu);
		}
		private function summoningElementalsSubmenu():void {
			menu();
			if (player.statusEffectv1(StatusEffects.SummonedElementalsAir) < 1) addButton(0, "Air", summonElementalAir);
			if (player.statusEffectv1(StatusEffects.SummonedElementalsEarth) < 1) addButton(1, "Earth", summonElementalEarth);
			if (player.statusEffectv1(StatusEffects.SummonedElementalsFire) < 1) addButton(2, "Fire", summonElementalFire);
			if (player.statusEffectv1(StatusEffects.SummonedElementalsWater) < 1) addButton(3, "Water", summonElementalWater);
			if (player.findPerk(PerkLib.ElementsOfTheOrtodoxPath) >= 0) {
				if (player.statusEffectv1(StatusEffects.SummonedElementalsEther) < 1) addButton(4, "Ether", summonElementalEther);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsLightning) < 1) addButton(5, "Wood", summonElementalWood);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsDarkness) < 1) addButton(6, "Metal", summonElementalMetal);
			}
			if (player.findPerk(PerkLib.ElementsOfMarethBasics) >= 0) {
				if (player.statusEffectv1(StatusEffects.SummonedElementalsIce) < 1) addButton(7, "Ice", summonElementalIce);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsLightning) < 1) addButton(8, "Lightning", summonElementalLightning);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsDarkness) < 1) addButton(9, "Darkness", summonElementalDarkness);
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu1st():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 1) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 1) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 1) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 1) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 1) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 1) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 1) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 1) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 1) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 1) addButton(9, "Darkness", rankUpElementalDarkness);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu2nd():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 2) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 2) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 2) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 2) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 2) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 2) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 2) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 2) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 2) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 2) addButton(9, "Darkness", rankUpElementalDarkness);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu3rd():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 3) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 3) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 3) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 3) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 3) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 3) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 3) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 3) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 3) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 3) addButton(9, "Darkness", rankUpElementalDarkness);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu4th():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 4) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 4) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 4) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 4) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 4) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 4) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 4) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 4) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 4) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 4) addButton(9, "Darkness", rankUpElementalDarkness);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu5th():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 5) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 5) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 5) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 5) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 5) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 5) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 5) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 5) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 5) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 5) addButton(9, "Darkness", rankUpElementalDarkness);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu6th():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 6) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 6) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 6) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 6) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 6) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 6) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 6) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 6) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 6) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 6) addButton(9, "Darkness", rankUpElementalDarkness);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu7th():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 7) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 7) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 7) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 7) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 7) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 7) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 7) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 7) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 7) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 7) addButton(9, "Darkness", rankUpElementalDarkness);
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu8th():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 8) addButton(0, "Air", rankUpElementalAir);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 8) addButton(1, "Earth", rankUpElementalEarth);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 8) addButton(2, "Fire", rankUpElementalFire);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 8) addButton(3, "Water", rankUpElementalWater);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 8) addButton(4, "Ether", rankUpElementalEther);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 8) addButton(5, "Wood", rankUpElementalWood);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 8) addButton(6, "Metal", rankUpElementalMetal);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 8) addButton(7, "Ice", rankUpElementalIce);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 8) addButton(8, "Lightning", rankUpElementalLightning);
			if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 8) addButton(9, "Darkness", rankUpElementalDarkness);
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
			outputText("You call on an air elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
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
			outputText("You call on an earth elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
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
			outputText("You call on a fire elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
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
			outputText("You call on a water elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsWater, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalIce():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon ice elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon ice elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("You call on an ice elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsIce, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalLightning():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon lightning elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon lightning elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("You call on a lightning elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsLightning, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalDarkness():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon darkness elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon darkness elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("You call on a darkness elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsDarkness, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalWood():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon wood elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon wood elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("You call on a wood elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsWood, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalMetal():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon metal elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon metal elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("You call on a metal elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsMetal, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalEther():void {
			clearOutput();
			if (player.mana < 100) {
				outputText("Your mana is too low to summon ether elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + 50 > player.maxFatigue()) {
				outputText("You're too tired to summon ether elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= 100;
			fatigue(50);
			statScreenRefresh();
			outputText("You call on an ether elemental pulling energy from the ether so to allow the being to enter your world.\n\n");
			outputText("The elemental appear at your side in a spontaneous explosion of energy.");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsEther, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		
		private function rankUpElementalAir():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsAir))) {
				outputText("Your mana is too low to rank up air elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsAir)) > player.maxFatigue()) {
				outputText("You're too tired to rank up air elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsAir));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsAir));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsAir, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalEarth():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsEarth))) {
				outputText("Your mana is too low to rank up earth elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsEarth)) > player.maxFatigue()) {
				outputText("You're too tired to rank up earth elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsEarth));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsEarth));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsEarth, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalFire():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsFire))) {
				outputText("Your mana is too low to rank up fire elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsFire)) > player.maxFatigue()) {
				outputText("You're too tired to rank up fire elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsFire));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsFire));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsFire, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalWater():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsWater))) {
				outputText("Your mana is too low to rank up water elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsWater)) > player.maxFatigue()) {
				outputText("You're too tired to rank up water elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsWater));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsWater));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsWater, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalIce():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsIce))) {
				outputText("Your mana is too low to rank up ice elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsIce)) > player.maxFatigue()) {
				outputText("You're too tired to rank up ice elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsIce));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsIce));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsIce, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalLightning():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsLightning))) {
				outputText("Your mana is too low to rank up lightning elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsLightning)) > player.maxFatigue()) {
				outputText("You're too tired to rank up lightning elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsLightning));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsLightning));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsLightning, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalDarkness():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness))) {
				outputText("Your mana is too low to rank up darkness elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness)) > player.maxFatigue()) {
				outputText("You're too tired to rank up darkness elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsDarkness, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalWood():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsWood))) {
				outputText("Your mana is too low to rank up wood elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsWood)) > player.maxFatigue()) {
				outputText("You're too tired to rank up wood elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsWood));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsWood));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsWood, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalMetal():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal))) {
				outputText("Your mana is too low to rank up metal elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal)) > player.maxFatigue()) {
				outputText("You're too tired to rank up metal elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsMetal));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsMetal, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function rankUpElementalEther():void {
			clearOutput();
			if (player.mana < (100 * player.statusEffectv2(StatusEffects.SummonedElementalsEther))) {
				outputText("Your mana is too low to rank up ether elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			else if (player.fatigue + (50 * player.statusEffectv2(StatusEffects.SummonedElementalsEther)) > player.maxFatigue()) {
				outputText("You're too tired to rank up ether elemental.");
				doNext(accessSummonElementalsMainMenu);
				return;
			}
			player.mana -= (100 * player.statusEffectv2(StatusEffects.SummonedElementalsEther));
			fatigue(50 * player.statusEffectv2(StatusEffects.SummonedElementalsEther));
			statScreenRefresh();
			outputText("You decide to reinforce your pact with your elemental drawing a few runic circles on the ground. As the ritual near its end the runes fly upward and merge into the elemental body increasing its power and the strength of your bound.");
			player.addStatusValue(StatusEffects.SummonedElementalsEther, 2, 1);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
	}

}