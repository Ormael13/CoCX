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
		
		//TEMPORAL_GOLEMS_BAG and PERNAMENT_GOLEMS_BAG - pretty easy to quess: amount of temp or perm golems PC have in "golem bag"
		
		public function maxTemporalGolemsBagSize():Number {
			var maxTemporalGolemsBagSizeCounter:Number = 0;
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) maxTemporalGolemsBagSizeCounter += 3;
			if (player.findPerk(PerkLib.BeginnerGolemMaker) >= 0) maxTemporalGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.ApprenticeGolemMaker) >= 0) maxTemporalGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.ExpertGolemMaker) >= 0) maxTemporalGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.GolemArmyLieutenant) >= 0) maxTemporalGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.GolemArmyCaptain) >= 0) maxTemporalGolemsBagSizeCounter += 2;
			if (player.findPerk(PerkLib.GolemArmyMajor) >= 0) maxTemporalGolemsBagSizeCounter += 3;
			if (player.findPerk(PerkLib.GolemArmyColonel) >= 0) maxTemporalGolemsBagSizeCounter += 4;
			if (player.findPerk(PerkLib.GolemArmyGeneral) >= 0) maxTemporalGolemsBagSizeCounter += 5;
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
			if (player.findPerk(PerkLib.MasterGolemMaker) >= 0) maxPernamentGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.GrandMasterGolemMaker) >= 0) maxPernamentGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.EpicGolemMaker) >= 0) maxPernamentGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.LegendaryGolemMaker) >= 0) maxPernamentGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.MythicalGolemMaker) >= 0) maxPernamentGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.GolemArmyLieutenant) >= 0) maxPernamentGolemsBagSizeCounter += 1;
			if (player.findPerk(PerkLib.GolemArmyCaptain) >= 0) maxPernamentGolemsBagSizeCounter += 2;
			if (player.findPerk(PerkLib.GolemArmyMajor) >= 0) maxPernamentGolemsBagSizeCounter += 3;
			if (player.findPerk(PerkLib.GolemArmyColonel) >= 0) maxPernamentGolemsBagSizeCounter += 4;
			if (player.findPerk(PerkLib.GolemArmyGeneral) >= 0) maxPernamentGolemsBagSizeCounter += 5;
			if (player.findPerk(PerkLib.MasterGolemMaker) >= 0) {
				if (player.findPerk(PerkLib.BiggerGolemBag1) >= 0) maxPernamentGolemsBagSizeCounter += 1;
				if (player.findPerk(PerkLib.BiggerGolemBag2) >= 0) maxPernamentGolemsBagSizeCounter += 1;
				if (player.findPerk(PerkLib.BiggerGolemBag3) >= 0) maxPernamentGolemsBagSizeCounter += 1;
				if (player.findPerk(PerkLib.BiggerGolemBag4) >= 0) maxPernamentGolemsBagSizeCounter += 1;
				if (player.findPerk(PerkLib.BiggerGolemBag5) >= 0) maxPernamentGolemsBagSizeCounter += 1;
				if (player.findPerk(PerkLib.BiggerGolemBag6) >= 0) maxPernamentGolemsBagSizeCounter += 1;
			}
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
		public function pernamentGolemMakingCost():Number {
			var permGolemCost:Number = 90;
			if (player.findPerk(PerkLib.GrandMasterGolemMaker) >= 0) permGolemCost += 10;
			if (player.findPerk(PerkLib.EpicGolemMaker) >= 0) permGolemCost += 50;
			if (player.findPerk(PerkLib.LegendaryGolemMaker) >= 0) permGolemCost += 150;
			if (player.findPerk(PerkLib.MythicalGolemMaker) >= 0) permGolemCost += 400;
			return permGolemCost;
		}

		public function accessMakeWinionsMainMenu():void {
			clearOutput();
			outputText("What helper would you like to make?\n\n");
			outputText("Stored golem cores for future reuse when making new golems: " + flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + " / " + maxReusableGolemCoresBagSize() + "\n");
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) outputText("Temporal Golems Bag: " + flags[kFLAGS.TEMPORAL_GOLEMS_BAG] + " / " + maxTemporalGolemsBagSize() + " golems\n");
			if (player.findPerk(PerkLib.MasterGolemMaker) >= 0) outputText("Permanent Golems Bag: " + flags[kFLAGS.PERNAMENT_GOLEMS_BAG] + " / " + maxPernamentGolemsBagSize() + " golems\n");
			menu();
			if (player.findPerk(PerkLib.JobGolemancer) >= 0) addButton(0, "T.S.Golem", makeTemporalStoneGolem).hint("Make most simply golem made of pile of stones.  <b>It will cruble after one attack!</b>\n\nCost: 1 Golem Core, " + temporalGolemMakingCost() + " Mana");
			if (player.findPerk(PerkLib.MasterGolemMaker) >= 0) addButton(1, "P.S.Golem", makePernamentStoneGolem).hint("Make simply stone golem.</b>\n\nCost: 1 Golem Core, 10 Stones, " + pernamentGolemMakingCost() + " Mana");
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
			useMana(temporalGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] < 1) flags[kFLAGS.TEMPORAL_GOLEMS_BAG] = 1;
			else flags[kFLAGS.TEMPORAL_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			cheatTime(1/4);
		}
		public function makePernamentStoneGolem():void {
			clearOutput();
			if (player.mana < pernamentGolemMakingCost()) {
				outputText("Your mana is too low to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1)) {
				outputText("You lack golem core to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] < 10) {
				outputText("You lack high quality stones to use as body for your new golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.PERNAMENT_GOLEMS_BAG] == maxPernamentGolemsBagSize()) {
				outputText("You not having enough space to store another one.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			else player.destroyItems(useables.GOLCORE, 1);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 10;
			useMana(pernamentGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of high quality stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.PERNAMENT_GOLEMS_BAG] < 1) flags[kFLAGS.PERNAMENT_GOLEMS_BAG] = 1;
			else flags[kFLAGS.PERNAMENT_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
		}

		public function takeOutGolemCoreFromGolemBag():void {
			clearOutput();
			outputText("In order to not overload your bag for reusable golem cores you take out one of them.\n\n");
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
			if (player.findPerk(PerkLib.ElementalContractRank9) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank10) >= 0) maxSizeOfElementalsArmyCounter += 2;
			if (player.findPerk(PerkLib.ElementalContractRank11) >= 0) maxSizeOfElementalsArmyCounter += 2;
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 12) outputText(" (Grand Elder Rank)");
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
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 9) outputText(" (3rd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 10) outputText(" (2nd Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 11) outputText(" (1st Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 12) outputText(" (Grand Elder Rank)");
			}
			outputText("</i>");
			if (player.findPerk(PerkLib.JobElementalConjurer) >= 0 && (player.statusEffectv1(StatusEffects.SummonedElementals) < maxSizeOfElementalsArmy())) addButton(0, "Summon", summoningElementalsSubmenu);
			if (player.findPerk(PerkLib.ElementalContractRank1) >= 0) addButton(1, "RankUp(1)", rankUpSubmenu1st);
			if (player.findPerk(PerkLib.ElementalContractRank2) >= 0) addButton(2, "RankUp(2)", rankUpSubmenu2nd);
			if (player.findPerk(PerkLib.ElementalContractRank3) >= 0) addButton(3, "RankUp(3)", rankUpSubmenu3rd);
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 2) {
				if (player.findPerk(PerkLib.ElementalContractRank4) >= 0) addButton(4, "RankUp(4)", rankUpSubmenu4th);
				if (player.findPerk(PerkLib.ElementalContractRank5) >= 0) addButton(5, "RankUp(5)", rankUpSubmenu5th);
				if (player.findPerk(PerkLib.ElementalContractRank6) >= 0) addButton(6, "RankUp(6)", rankUpSubmenu6th);
				if (player.findPerk(PerkLib.ElementalContractRank7) >= 0) addButton(7, "RankUp(7)", rankUpSubmenu7th);
			}
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] >= 3) {
				if (player.findPerk(PerkLib.ElementalContractRank8) >= 0) addButton(8, "RankUp(8)", rankUpSubmenu8th);
				if (player.findPerk(PerkLib.ElementalContractRank9) >= 0) addButton(9, "RankUp(9)", rankUpSubmenu9th);
				if (player.findPerk(PerkLib.ElementalContractRank10) >= 0) addButton(10, "RankUp(10)", rankUpSubmenu10th);
				if (player.findPerk(PerkLib.ElementalContractRank11) >= 0) addButton(11, "RankUp(11)", rankUpSubmenu11th);
			}
			addButton(14, "Back", playerMenu);
		}
		private function summoningElementalsSubmenu():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to summon any elementals.\n\n");
			menu();
			if (player.mana >= 100 && (player.fatigue + 50 <= player.maxFatigue())) {
				if (player.statusEffectv1(StatusEffects.SummonedElementalsAir) < 1) addButton(0, "Air", summonElementalAir);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsEarth) < 1) addButton(1, "Earth", summonElementalEarth);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsFire) < 1) addButton(2, "Fire", summonElementalFire);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsWater) < 1) addButton(3, "Water", summonElementalWater);
				if (player.findPerk(PerkLib.ElementsOfTheOrtodoxPath) >= 0) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsEther) < 1) addButton(4, "Ether", summonElementalEther);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsWood) < 1) addButton(5, "Wood", summonElementalWood);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsMetal) < 1) addButton(6, "Metal", summonElementalMetal);
				}
				if (player.findPerk(PerkLib.ElementsOfMarethBasics) >= 0) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsIce) < 1) addButton(7, "Ice", summonElementalIce);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsLightning) < 1) addButton(8, "Lightning", summonElementalLightning);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsDarkness) < 1) addButton(9, "Darkness", summonElementalDarkness);
				}
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu1st():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 100 && (player.fatigue + 50 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu2nd():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 200 && (player.fatigue + 100 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu3rd():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 300 && (player.fatigue + 150 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu4th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 400 && (player.fatigue + 200 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu5th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 500 && (player.fatigue + 250 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu6th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 600 && (player.fatigue + 300 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu7th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 700 && (player.fatigue + 350 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu8th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 800 && (player.fatigue + 400 <= player.maxFatigue())) {
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
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu9th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 900 && (player.fatigue + 450 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 9) addButton(0, "Air", rankUpElementalAir);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 9) addButton(1, "Earth", rankUpElementalEarth);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 9) addButton(2, "Fire", rankUpElementalFire);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 9) addButton(3, "Water", rankUpElementalWater);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 9) addButton(4, "Ether", rankUpElementalEther);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 9) addButton(5, "Wood", rankUpElementalWood);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 9) addButton(6, "Metal", rankUpElementalMetal);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 9) addButton(7, "Ice", rankUpElementalIce);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 9) addButton(8, "Lightning", rankUpElementalLightning);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 9) addButton(9, "Darkness", rankUpElementalDarkness);
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu10th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1000 && (player.fatigue + 500 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 10) addButton(0, "Air", rankUpElementalAir);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 10) addButton(1, "Earth", rankUpElementalEarth);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 10) addButton(2, "Fire", rankUpElementalFire);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 10) addButton(3, "Water", rankUpElementalWater);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 10) addButton(4, "Ether", rankUpElementalEther);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 10) addButton(5, "Wood", rankUpElementalWood);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 10) addButton(6, "Metal", rankUpElementalMetal);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 10) addButton(7, "Ice", rankUpElementalIce);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 10) addButton(8, "Lightning", rankUpElementalLightning);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 10) addButton(9, "Darkness", rankUpElementalDarkness);
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function rankUpSubmenu11th():void {
			outputText("\n\nIf you not have enough mana and fatigue it will be impossible to rank up any of your elementals. And even if you got it whole process can end in failure.\n\n");
			menu();
			if (player.mana >= 1100 && (player.fatigue + 550 <= player.maxFatigue())) {
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAir) == 11) addButton(0, "Air", rankUpElementalAir);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarth) == 11) addButton(1, "Earth", rankUpElementalEarth);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFire) == 11) addButton(2, "Fire", rankUpElementalFire);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWater) == 11) addButton(3, "Water", rankUpElementalWater);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEther) == 11) addButton(4, "Ether", rankUpElementalEther);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWood) == 11) addButton(5, "Wood", rankUpElementalWood);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsMetal) == 11) addButton(6, "Metal", rankUpElementalMetal);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsIce) == 11) addButton(7, "Ice", rankUpElementalIce);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsLightning) == 11) addButton(8, "Lightning", rankUpElementalLightning);
				if (player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) == 11) addButton(9, "Darkness", rankUpElementalDarkness);
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}

		private function summonElementalAir():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an air elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The air elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own air elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsAir, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalEarth():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an earth elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The earth elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own earth elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsEarth, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalFire():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an fire elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The fire elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own fire elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsFire, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalWater():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an water elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The water elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own water elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsWater, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalIce():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an ice elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The ice elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own ice elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsIce, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalLightning():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an lightning elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The lightning elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own lightning elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsLightning, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalDarkness():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an darkness elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The darkness elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own darkness elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsDarkness, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalWood():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an wood elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The wood elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own wood elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsWood, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalMetal():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an metal elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The metal elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own metal elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsMetal, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
		}
		private function summonElementalEther():void {
			clearOutput();
			useMana(100);
			fatigue(50);
			statScreenRefresh();
			outputText("As it will be your first time summoning an ether elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The ether elemental appear within the circle. At first huge and terrifying, it fight against its binding trying to break through. ");
			outputText("The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own ether elemental!</b>\"");
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 1, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 1, 0, 0, 0);
			player.createStatusEffect(StatusEffects.SummonedElementalsEther, 1, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
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
			cheatTime(1/2);
		}
		private function rankUpElementalPart1():void {
			outputText("It has been a while and your mastery of summoning has increased as a consequence. Now confident that you can contain it you head to the arcane circle and set up the ritual to release some of your servant restraints. You order your pet to stand still as you release the binding rune containing it. ");
			outputText("At first it trash in its prison with the clear intention to break free, kill and consume you but the ward holds. You write an additional arcane circle ");
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 2)outputText("around the first ");
			if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] == 3)outputText("around the previous one ");
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

}