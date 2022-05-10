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
		
		public function maxTemporalGolemsBagSize():Number {
			var maxTemporalGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.JobGolemancer)) maxTemporalGolemsBagSizeCounter += 15;
			if (player.hasPerk(PerkLib.BeginnerGolemMaker)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.ApprenticeGolemMaker)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.ExpertGolemMaker)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.GolemArmyJuniorLieutenant)) maxTemporalGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.GolemArmyLieutenant)) maxTemporalGolemsBagSizeCounter += 4;
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.GolemArmyMajor)) maxTemporalGolemsBagSizeCounter += 8;
			if (player.hasPerk(PerkLib.GolemArmyLieutenantColonel)) maxTemporalGolemsBagSizeCounter += 10;
			if (player.hasPerk(PerkLib.GolemArmyColonel)) maxTemporalGolemsBagSizeCounter += 12;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxTemporalGolemsBagSizeCounter += 14;
			if (player.hasPerk(PerkLib.GolemArmyMajorGeneral)) maxTemporalGolemsBagSizeCounter += 16;
			if (player.hasPerk(PerkLib.TemporalGolemsRestructuration)) maxTemporalGolemsBagSizeCounter += 5;
			if (player.hasPerk(PerkLib.TemporalGolemsRestructurationEx)) maxTemporalGolemsBagSizeCounter += 10;
			if (player.hasPerk(PerkLib.BiggerGolemBagI)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.BiggerGolemBagII)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.BiggerGolemBagIII)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.BiggerGolemBagIV)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.BiggerGolemBagV)) maxTemporalGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.BiggerGolemBagVI)) maxTemporalGolemsBagSizeCounter += 6;
			return maxTemporalGolemsBagSizeCounter;
		}
		public function maxPermanentStoneGolemsBagSize():Number {
			var maxPermanentStoneGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.MasterGolemMaker)) maxPermanentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) maxPermanentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.EpicGolemMaker)) maxPermanentStoneGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) maxPermanentStoneGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) maxPermanentStoneGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) maxPermanentStoneGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) maxPermanentStoneGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.GolemArmyJuniorLieutenant)) maxPermanentStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyLieutenant)) maxPermanentStoneGolemsBagSizeCounter += 2;
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) maxPermanentStoneGolemsBagSizeCounter += 3;
			if (player.hasPerk(PerkLib.GolemArmyMajor)) maxPermanentStoneGolemsBagSizeCounter += 4;
			if (player.hasPerk(PerkLib.GolemArmyLieutenantColonel)) maxPermanentStoneGolemsBagSizeCounter += 5;
			if (player.hasPerk(PerkLib.GolemArmyColonel)) maxPermanentStoneGolemsBagSizeCounter += 6;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxPermanentStoneGolemsBagSizeCounter += 7;
			if (player.hasPerk(PerkLib.GolemArmyMajorGeneral)) maxPermanentStoneGolemsBagSizeCounter += 8;
			if (player.hasPerk(PerkLib.MasterGolemMaker)) {
				if (player.hasPerk(PerkLib.BiggerGolemBagI)) maxPermanentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBagII)) maxPermanentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBagIII)) maxPermanentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBagIV)) maxPermanentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBagV)) maxPermanentStoneGolemsBagSizeCounter += 1;
				if (player.hasPerk(PerkLib.BiggerGolemBagVI)) maxPermanentStoneGolemsBagSizeCounter += 1;
			}
			return maxPermanentStoneGolemsBagSizeCounter;
		}
		public function maxPermanentImprovedStoneGolemsBagSize():Number {
			var maxPermanentImprovedStoneGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.EpicGolemMaker)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyMajor)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyLieutenantColonel)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyColonel)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyMajorGeneral)) maxPermanentImprovedStoneGolemsBagSizeCounter += 1;
			return maxPermanentImprovedStoneGolemsBagSizeCounter;
		}
		public function maxPermanentSteelGolemsBagSize():Number {
			var maxPermanentSteelGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.AdvancedGolemancyTheory)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyCaptain)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyMajor)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyLieutenantColonel)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyColonel)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxPermanentSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyMajorGeneral)) maxPermanentSteelGolemsBagSizeCounter += 1;
			return maxPermanentSteelGolemsBagSizeCounter;
		}
		public function maxPermanentImprovedSteelGolemsBagSize():Number {
			var maxPermanentImprovedSteelGolemsBagSizeCounter:Number = 0;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) maxPermanentImprovedSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.LegendaryGolemMaker2ndCircle)) maxPermanentImprovedSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyColonel)) maxPermanentImprovedSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyGeneral)) maxPermanentImprovedSteelGolemsBagSizeCounter += 1;
			if (player.hasPerk(PerkLib.GolemArmyMajorGeneral)) maxPermanentImprovedSteelGolemsBagSizeCounter += 1;
			return maxPermanentImprovedSteelGolemsBagSizeCounter;
		}
		public function maxReusableGolemCoresBagSize():Number {
			var maxReusableGolemCoresBagSizeCounter:Number = 0;
			if (maxTemporalGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxTemporalGolemsBagSize();
			if (maxPermanentStoneGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPermanentStoneGolemsBagSize();
			if (maxPermanentImprovedStoneGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPermanentImprovedStoneGolemsBagSize();
			if (maxPermanentSteelGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPermanentSteelGolemsBagSize();
			if (maxPermanentImprovedSteelGolemsBagSize() > 0) maxReusableGolemCoresBagSizeCounter += maxPermanentImprovedSteelGolemsBagSize();
			if (player.hasPerk(PerkLib.BeginnerGolemMaker)) maxReusableGolemCoresBagSizeCounter += 2;
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
		public function permanentStoneGolemMakingCost():Number {
			var permGolemCost:Number = 90;
			if (player.hasPerk(PerkLib.GrandMasterGolemMaker)) permGolemCost += 10;
			if (player.hasPerk(PerkLib.EpicGolemMaker)) permGolemCost += 50;
			if (player.hasPerk(PerkLib.EpicGolemMaker2ndCircle)) permGolemCost += 150;
			if (player.hasPerk(PerkLib.EpicGolemMaker3rdCircle)) permGolemCost += 400;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) == 1)) permGolemCost *= 2;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) == 1)) permGolemCost *= 2;
			permGolemCost = Math.round(permGolemCost);
			return permGolemCost;
		}
		public function permanentImprovedStoneGolemMakingCost():Number {
			var permIGolemCost:Number = 900;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) == 1)) permIGolemCost *= 2;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) == 1)) permIGolemCost *= 2;
			permIGolemCost = Math.round(permIGolemCost);
			return permIGolemCost;
		}
		public function permanentSteelGolemMakingCost():Number {
			var permSGolemCost:Number = 200;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) == 1)) permSGolemCost *= 2;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) == 1)) permSGolemCost *= 2;
			permSGolemCost = Math.round(permSGolemCost);
			return permSGolemCost;
		}
		public function permanentImprovedSteelGolemMakingCost():Number {
			var permISGolemCost:Number = 2000;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv1(StatusEffects.GolemUpgrades1) == 1)) permISGolemCost *= 2;
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv2(StatusEffects.GolemUpgrades1) == 1)) permISGolemCost *= 2;
			permISGolemCost = Math.round(permISGolemCost);
			return permISGolemCost;
		}
		private function counterOfPernamentGolems():Number {
			var counterOfPernamentGolems:Number = 0;
			counterOfPernamentGolems += flags[kFLAGS.PERMANENT_GOLEMS_BAG];
			counterOfPernamentGolems += flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG];
			counterOfPernamentGolems += flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG];
			counterOfPernamentGolems += flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG];
			return counterOfPernamentGolems;
		}

		public function accessMakeWinionsMainMenu():void {
			clearOutput();
			outputText("What helper would you like to make?\n\n");
			outputText("<b>Stored golem cores for future reuse when making new golems:</b> " + flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] + " / " + maxReusableGolemCoresBagSize() + "\n");
			if (player.hasPerk(PerkLib.AdvancedGolemancyTheory) || player.hasPerk(PerkLib.EpicGolemMaker)) outputText("<b>Energy Cores:</b> " + flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] + "\n");
			outputText("<b>Stones:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "\n");
			if (player.hasPerk(PerkLib.AdvancedGolemancyTheory)) {
				outputText("<b>Metal Pieces:</b> " + flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] + "\n");
				outputText("<b>Mechanisms:</b> " + flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] + "\n");
			}
			if (player.hasPerk(PerkLib.JobGolemancer)) outputText("\n<b>Temporal Golems Bag:</b> " + flags[kFLAGS.TEMPORAL_GOLEMS_BAG] + " / " + maxTemporalGolemsBagSize() + " golems\n");
			if (player.hasPerk(PerkLib.MasterGolemMaker)) outputText("<b>Stone Golems Bag:</b> " + flags[kFLAGS.PERMANENT_GOLEMS_BAG] + " / " + maxPermanentStoneGolemsBagSize() + " golems\n");
			if (player.hasPerk(PerkLib.EpicGolemMaker)) outputText("<b>Improved Stone Golems Bag:</b> " + flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] + " / " + maxPermanentImprovedStoneGolemsBagSize() + " golems\n");
			if (player.hasPerk(PerkLib.AdvancedGolemancyTheory)) outputText("<b>Steel Golems Bag:</b> " + flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] + " / " + maxPermanentSteelGolemsBagSize() + " golems\n");
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) outputText("<b>Improved Steel Golems Bag:</b> " + flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] + " / " + maxPermanentImprovedSteelGolemsBagSize() + " golems\n");
			var eleShardCost:String = "";
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0) eleShardCost = "1 Elemental Shard, ";
			menu();
			if (player.hasPerk(PerkLib.JobGolemancer)) addButton(0, "T.S.Golem", makeTemporalStoneGolem).hint("Make the most simple golem out of a pile of stones.  <b>It will crumble after one attack!</b>\n\nCost: 1 Golem Core, " + temporalGolemMakingCost() + " Mana");
			if (player.hasPerk(PerkLib.MasterGolemMaker)) addButton(1, "P.S.Golem", makePermanentStoneGolem).hint("Make stone golem.\n\nCost: 1 Golem Core, 10 Stones, " + eleShardCost + permanentStoneGolemMakingCost() + " Mana");
			else addButtonDisabled(1, "P.S.Golem", "Req. Master Golem Maker perk.");
			if (player.hasPerk(PerkLib.AdvancedGolemancyTheory)) addButton(2, "S.Golem", makePermanentSteelGolem).hint("Make steel golem.\n\nCost: 1 Golem Core, 2 Energy Cores, 10 Metal Plates, 4 Mechanisms, " + eleShardCost + permanentSteelGolemMakingCost() + " Mana");
			else addButtonDisabled(2, "M.Golem", "Req. Advanced Golemancy Theory perk.");
			if (player.hasPerk(PerkLib.TemporalGolemsRestructuration)) addButton(5, "T.S.Golem(5x)", makeTemporalStoneGolems).hint("Make five of most simple golems.  <b>They will crumble after one attack!</b>\n\nCost: 5 Golem Core, " + temporalGolemMakingCost() * 5 + " Mana");
			else addButtonDisabled(5, "T.S.Golem(5x)", "Req. Temporal Golems Restructuration perk.");
			if (player.hasPerk(PerkLib.EpicGolemMaker)) addButton(6, "I.P.S.Golem", makePermanentImprovedStoneGolem).hint("Make improved stone golem.\n\nCost: 3 Golem Cores, 1 Energy Core, 50 Stones, " + eleShardCost + permanentImprovedStoneGolemMakingCost() + " Mana");
			else addButtonDisabled(6, "I.P.S.Golem", "Req. Epic Golem Maker perk.");
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) addButton(7, "I.M.Golem", makePermanentImprovedSteelGolem).hint("Make improved steel golem.\n\nCost: 3 Golem Cores, 6 Energy Cores, 50 Metal Plates, 12 Mechanisms, " + eleShardCost + permanentImprovedSteelGolemMakingCost() + " Mana");
			else addButtonDisabled(7, "I.M.Golem", "Req. Legendary Golem Maker perk.");
			if (player.hasPerk(PerkLib.TemporalGolemsRestructurationEx)) addButton(10, "T.S.Golem(20x)", makeTemporalStoneGolemsMore).hint("Make twenty of most simple golems.  <b>They will crumble after one attack!</b>\n\nCost: 20 Golem Core, " + temporalGolemMakingCost() * 20 + " Mana");
			else addButtonDisabled(10, "T.S.Golem(20x)", "Req. Temporal Golems Restructuration (Ex) perk.");
			if (player.hasItem(useables.GOLCORE, 1) && (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < maxReusableGolemCoresBagSize())) addButton(11, "PutInCore", putInGolemCoreIntoGolemBag).hint("Put in one golem core into 'golem bag'.")
			else addButtonDisabled(11, "PutInCore", "You not have any golem core in your inventory to put in 'golem bag'.");
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) addButton(12, "TakeOutCore", takeOutGolemCoreFromGolemBag).hint("Take out one golem core from 'golem bag'.");
			else addButtonDisabled(12, "TakeOutCore", "Your 'golem bag' not have any golem cores in it.");
			if (player.hasKeyItem("Golems, Animations and You") >= 0) {
				if (counterOfPernamentGolems() > 0) addButton(13, "Upgrades", upgradesForPernamentGolems).hint("Options to upgrade permanent golems.");
				else addButtonDisabled(13, "Upgrades", "You not have any pernament golem created yet.");
			}
			else addButtonDisabled(13, "Upgrades", "Req. 'Golems, Animations and You' manual.");
			addButton(14, "Back", camp.campWinionsArmySim);
		}
		
		public function makeTemporalStoneGolem():void {
			clearOutput();
			if (player.mana < temporalGolemMakingCost()) {
				outputText("Your mana runs dry halfway through the golem creation process. The rocks you were using crumble, falling apart as the magic binding them together fails.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] == 0) {
				outputText("You lack a golem core to finish the creation of a golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] == maxTemporalGolemsBagSize()) {
				outputText("You try to place your new golem into your bag, but it's already full. You groan, annoyed at your embarassing mistake.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			else player.destroyItems(useables.GOLCORE, 1);
			useMana(temporalGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground, placing a ring of stones along the inside edge. Next, you put the golem core in the middle of the seal, with another line of smaller stones around the core. With the groundwork done, you stand back and begin to chant, mana flowing from your hands into the seal. The stones glow, the smaller ring coating the core as it rises from the ground. One by one, the stones on the outer ring leap from the earth, attaching to the core and forming a rough bumanoid shape, just over six feet tall. The golem stands, the seal vanishing from the earth. You order the newly created golem to come to you, storing it in your golem bag.");
			if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] < 1) flags[kFLAGS.TEMPORAL_GOLEMS_BAG] = 1;
			else flags[kFLAGS.TEMPORAL_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			if (player.hasPerk(PerkLib.TemporalGolemsRestructuration)) eachMinuteCount(5);
			else eachMinuteCount(10);
		}
		public function makeTemporalStoneGolems():void {
			clearOutput();
			if (player.mana < (temporalGolemMakingCost() * 5)) {
				outputText("Your mana runs dry halfway through the golem creation process. The rocks you were using crumble, falling apart as the magic binding them together fails.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 5) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < 5) {
				outputText("You lack golem cores to finish the creation of the golems.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > (maxTemporalGolemsBagSize() - 5)) {
				outputText("You try to place your new golem into your bag, but it's already full. You groan, annoyed at your embarassing mistake.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 4) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] -= 5;
			else player.destroyItems(useables.GOLCORE, 5);
			useMana(temporalGolemMakingCost() * 5);
			statScreenRefresh();
			outputText("You draw five seals in the ground, each with a ring of stones, golem core in the middle and another line of smaller stones. With the groundwork done, you stand back and begin to chant, mana flowing from your hands into the seals. The stones glow, the smaller rings coating the five cores as they rise from the ground. One by one, the stones cover the cores, forming five rough bumanoid shapes. The golems stand, the seals vanishing from the earth. You order the newly created golems to come to you, storing them in your golem bag.");
			flags[kFLAGS.TEMPORAL_GOLEMS_BAG] += 5;
			doNext(accessMakeWinionsMainMenu);
			if (player.hasPerk(PerkLib.TemporalGolemsRestructurationEx)) eachMinuteCount(15);
			else eachMinuteCount(20);
		}
		public function makeTemporalStoneGolemsMore():void {
			clearOutput();
			if (player.mana < (temporalGolemMakingCost() * 20)) {
				outputText("Your mana runs dry halfway through the golem creation process. The rocks you were using crumble, falling apart as the magic binding them together fails.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 20) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < 20) {
				outputText("You lack golem cores to finish the creation of the golems.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.TEMPORAL_GOLEMS_BAG] > (maxTemporalGolemsBagSize() - 20)) {
				outputText("Your golem bag may be able to store 20 golems, but you still have too many.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 19) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] -= 20;
			else player.destroyItems(useables.GOLCORE, 20);
			useMana(temporalGolemMakingCost() * 20);
			statScreenRefresh();
			outputText("You draw a complex seal on the ground with 20 node points, complete with golem core and a pile of stones. Once done, you stand back and begin to seep your mana into the seal. Each pile becomes a 6 feet tall golem. Finishing the work on your creations, you store them in your 'golem bag'.");
			flags[kFLAGS.TEMPORAL_GOLEMS_BAG] += 20;
			doNext(accessMakeWinionsMainMenu);
			eachMinuteCount(40);
		}
		public function makePermanentStoneGolem():void {
			clearOutput();
			if (player.mana < permanentStoneGolemMakingCost()) {
				outputText("Your mana is too low to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < 1) {
				outputText("You lack a golem core to finish the creation of a golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && !player.hasItem(useables.ELSHARD, 1)) {
				outputText("You don't have the elemental shards you need to upgrade your golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] < 10) {
				outputText("You lack high quality stones to use as the body for your new golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] == maxPermanentStoneGolemsBagSize()) {
				outputText("There's no more space in your golem bag.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			else player.destroyItems(useables.GOLCORE, 1);
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && player.hasItem(useables.ELSHARD, 1)) player.destroyItems(useables.ELSHARD, 1);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 10;
			useMana(permanentStoneGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of high quality stones that will soon be your servant. Once done you put golem core in pile, stand back and begin to seep your mana inside of the pile till it form 6 feet tall shape. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.PERMANENT_GOLEMS_BAG] < 1) flags[kFLAGS.PERMANENT_GOLEMS_BAG] = 1;
			else flags[kFLAGS.PERMANENT_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			eachMinuteCount(20);
		}
		public function makePermanentImprovedStoneGolem():void {
			clearOutput();
			if (player.mana < permanentImprovedStoneGolemMakingCost()) {
				outputText("Your mana runs dry halfway through the golem creation process. The rocks you were using crumble, falling apart as the magic binding them together fails.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 3) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < 3) {
				outputText("You lack golem cores.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] < 1) {
				outputText("You don't have an energy core. No power, no golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && !player.hasItem(useables.ELSHARD, 1)) {
				outputText("You lack the elemental shard you need.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] < 50) {
				outputText("You lack high quality stones to use as body for your new golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] == maxPermanentImprovedStoneGolemsBagSize()) {
				outputText("There's no more space in your golem bag.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 3) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] -= 3;
			else player.destroyItems(useables.GOLCORE, 3);
			flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] -= 1;
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && player.hasItem(useables.ELSHARD, 1)) player.destroyItems(useables.ELSHARD, 1);
			flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] -= 50;
			useMana(permanentImprovedStoneGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of high quality stones, which were arranged in the form of a gigantic four armed shape. Once done you put the energy core in the upper section of the torso and golem cores in a pile at the golem's future chest in a triangle formation. You stand back and begin to seep your mana toward the laying stones. ");
			outputText("Slowly all the stones and cores connect with threads of magic, forming a hulking, 12 foot tall shape. Making some last adjustments to the cores, you store it in your 'golem bag'.");
			if (flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] < 1) flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG] = 1;
			else flags[kFLAGS.IMPROVED_PERMANENT_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			eachMinuteCount(40);
		}
		public function makePermanentSteelGolem():void {
			clearOutput();
			if (player.mana < permanentSteelGolemMakingCost()) {
				outputText("Your mana is too low to make another golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 1) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < 1) {
				outputText("You need more golem cores.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] < 2) {
				outputText("You lack energy cores.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && !player.hasItem(useables.ELSHARD, 1)) {
				outputText("You lack the elemental shards for this work.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] < 10) {
				outputText("You don't have enough metal to make a new golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] < 4) {
				outputText("You lack mechanisms for your new golem body.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] == maxPermanentSteelGolemsBagSize()) {
				outputText("Your golem bag is already full.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 0) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			else player.destroyItems(useables.GOLCORE, 1);
			flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] -= 2;
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && player.hasItem(useables.ELSHARD, 1)) player.destroyItems(useables.ELSHARD, 1);
			flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 10;
			flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] -= 4;
			useMana(permanentSteelGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground, and inside, you delicately place a golem core, wrapping it in metal pieces. Mechanisms branch out, forming a rough torso, and you attach golem cores throughout the frame, ending with humanoid arms and legs, wrapped in solid metal. You stand back, examining your handiwork for a moment, before splaying your fingers out over it. You pull mana through your body, tendrils of power lancing into the now clattering metal frame.");
			outputText("One by one, the cores you placed by the limbs light up, making your creation glow from within. A powerful humming noise sounds, and the mechanisms on the limbs begin to move. As you watch, with bated breath, your lumbering creation bends its legs, levering itself to its spiked feet. Standing over seven feet tall, with glowing red sensory units covered with blackened steel, your creation is imposing, at the very least. It marches itself to you, and you store it in your golem bag");
			if (flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] < 1) flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG] = 1;
			else flags[kFLAGS.PERMANENT_STEEL_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			eachMinuteCount(20);
		}
		public function makePermanentImprovedSteelGolem():void {
			clearOutput();
			if (player.mana < permanentImprovedSteelGolemMakingCost()) {
				outputText("You don't have the mana to make another golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (!player.hasItem(useables.GOLCORE, 3) && flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] < 3) {
				outputText("Upon closer inspection of your supplies, you realize you don't have enough golem cores!");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] < 6) {
				outputText("Your new creation will need power, and you don't have enough cores for it!");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && !player.hasItem(useables.ELSHARD, 1)) {
				outputText("You lack elemental shard to finish golem creation.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] < 50) {
				outputText("Your metal reserves are low. You'll need to find some more before you can make more golems.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] < 12) {
				outputText("You lack the mechanisms for your new golem.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			else if (flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] == maxPermanentImprovedSteelGolemsBagSize()) {
				outputText("Your golem bag is full. You cannot store any more.");
				doNext(accessMakeWinionsMainMenu);
				return;
			}
			if (flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] > 3) flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG] -= 3;
			else player.destroyItems(useables.GOLCORE, 3);
			flags[kFLAGS.CAMP_CABIN_ENERGY_CORE_RESOURCES] -= 6;
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0 && player.hasItem(useables.ELSHARD, 1)) player.destroyItems(useables.ELSHARD, 1);
			flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] -= 50;
			flags[kFLAGS.CAMP_CABIN_MECHANISM_RESOURCES] -= 12;
			useMana(permanentSteelGolemMakingCost());
			statScreenRefresh();
			outputText("You draw a seal in the ground around the body of your future servant. All parts are put in precise place be it mechanisms or each energy cores hidden beneath metal plates. Once done you put golem cores at the golem's future chest in a triangle formation and cover them with last two metal plates. You stand back and begin to seep your mana toward the laying parts as it begin to connect ");
			outputText("each part of the future golem body. After few moments mechanisms comes alive supplied with energy from inserted energy cores under main cores control. It slowly rising up reaching a bit over 14 feet tall with six arms and whole body covered by metal plates and glowing red eyes. Finishing the work on your creation you store it in your 'golem bag'.");
			if (flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] < 1) flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG] = 1;
			else flags[kFLAGS.IMPROVED_PERMANENT_STEEL_GOLEMS_BAG]++;
			doNext(accessMakeWinionsMainMenu);
			eachMinuteCount(40);
		}

		public function putInGolemCoreIntoGolemBag():void {
			clearOutput();
			outputText("In order to have some free space in your backpack you put one of golem cores into your bag.\n\n");
			player.destroyItems(useables.GOLCORE, 1);
			flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]++;
			doNext(accessMakeWinionsMainMenu);
		}
		public function takeOutGolemCoreFromGolemBag():void {
			clearOutput();
			outputText("In order to not overload your bag for reusable golem cores you take one out, putting it in your backpack.\n\n");
			flags[kFLAGS.REUSABLE_GOLEM_CORES_BAG]--;
			inventory.takeItem(useables.GOLCORE, accessMakeWinionsMainMenu);
		}
		
		public function upgradesForPernamentGolems():void {
			clearOutput();
			var element:String = "Inactive (not yet upgraded)";
			var poison:String = "Inactive (not yet upgraded)";
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1)) {
				if (player.statusEffectv3(StatusEffects.GolemUpgrades1) > 0) {
					if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 5) element = "Darkness";
					else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 4) element = "Lightning";
					else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 3) element = "Ice";
					else if (player.statusEffectv3(StatusEffects.GolemUpgrades1) == 2) element = "Fire";
					else element = "Inactive";
				}
				if (player.statusEffectv4(StatusEffects.GolemUpgrades1) > 0) {
					if (player.statusEffectv4(StatusEffects.GolemUpgrades1) == 2) poison = "Active";
					else poison = "Inactive";
				}
			}
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1)) var impMC:Number = player.statusEffectv2(StatusEffects.GolemUpgrades1);
			outputText("You takes out the 'Golems, Animations and You' manual from your bag and opening it at index. Which one upgrade should you apply to your golems?\n\n");
			outputText("<b>Stones:</b> " + flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] + "\n");
			if (player.hasPerk(PerkLib.AdvancedGolemancyTheory)) outputText("<b>Metal Pieces:</b> " + flags[kFLAGS.CAMP_CABIN_METAL_PIECES_RESOURCES] + "\n");
			outputText("\n<u>Index of upgrades:</u>\n");
			outputText("\n-Multi Attacks (Rank: "+(player.hasStatusEffect(StatusEffects.GolemUpgrades1)?""+player.statusEffectv1(StatusEffects.GolemUpgrades1)+"":"0")+") (Passive)");
			outputText("\n-Improved Mana Circuit (Rank: "+(player.hasStatusEffect(StatusEffects.GolemUpgrades1)?""+impMC+"":"0")+") (-"+(player.hasStatusEffect(StatusEffects.GolemUpgrades1)?""+impMC*15+"":"0")+"% req. mana for activation, +"+(player.hasStatusEffect(StatusEffects.GolemUpgrades1)?""+impMC*25+"":"0")+"% base dmg) (Passive)");
			outputText("\n-Elemental Weaponry ("+element+")");
			outputText("\n-Poisoned Weaponry ("+poison+")");
			menu();
			addButton(0, "MultiAtks", upgradesForPernamentGolemsMultiAttacks);
			addButton(1, "I.M.Circ.", upgradesForPernamentGolemsImprovedManaCircuit);
			if ((player.hasStatusEffect(StatusEffects.GolemUpgrades1) && player.statusEffectv3(StatusEffects.GolemUpgrades1) == 0) || !player.hasStatusEffect(StatusEffects.GolemUpgrades1)) addButton(2, "Elem.Weapons", upgradesForPernamentGolemsElementalWeaponry);
			else addButtonDisabled(2, "Elem.Weapons", "You already used this upgrade option on your golems.");
			//poisoned weapons
			addButton(14, "Back", accessMakeWinionsMainMenu);
		}
		public function upgradesForPernamentGolemsMultiAttacks():void {
			menu();
			if (player.statusEffectv1(StatusEffects.GolemUpgrades1) == 0) addButton(0, "MultiAtks(1)", upgradesForPernamentGolemsMultiAttacksRank1);
			else addButtonDisabled(0, "MultiAtks(1)", "You already used this upgrade option on your golems.");
			if (player.statusEffectv1(StatusEffects.GolemUpgrades1) < 1) addButtonDisabled(1, "MultiAtks(2)", "You can't use this upgrade option without previous one.");
			else {
				if (player.statusEffectv1(StatusEffects.GolemUpgrades1) == 1) addButton(1, "MultiAtks(2)", upgradesForPernamentGolemsMultiAttacksRank2);
				else addButtonDisabled(1, "MultiAtks(2)", "You already used this upgrade option on your golems.");
			}
			addButton(14, "Back", upgradesForPernamentGolems);
		}
		public function upgradesForPernamentGolemsMultiAttacksRank1():void {
			clearOutput();
			outputText("You decided to work on multi attack upgrade of your golem.\n\n");
			outputText("Checking the page for this upgrade, you see it would req. 100 mana for each permanent golem to make that modification.\n\n");
			if (player.mana >= (100 * counterOfPernamentGolems())) doYesNo(upgradesForPernamentGolemsMultiAttacksRank1Yes, upgradesForPernamentGolemsMultiAttacks);
			else {
				outputText("It seems you're too low on mana to proceed with this upgrade.\n\n");
				doNext(upgradesForPernamentGolemsMultiAttacks);
			}
		}
		public function upgradesForPernamentGolemsMultiAttacksRank1Yes():void {
			useMana((100 * counterOfPernamentGolems()));
			outputText("Focusing on the instructions, you take each pernament golem out of your bag and start engraving new mana pathways. It's slow work, but you know that a 2nd attack is worth the time. Each attack will drain more mana from you, but you deem the cost worth it.\n");
			player.addStatusValue(StatusEffects.GolemUpgrades1, 1, 1);
			doNext(upgradesForPernamentGolemsMultiAttacks);
			eachMinuteCount(30);
		}
		public function upgradesForPernamentGolemsMultiAttacksRank2():void {
			clearOutput();
			outputText("You decided to work on multi attack upgrade of your golem.\n\n");
			outputText("Checking page for this upgrade you see it would req. 100 mana per each possesed pernament golem to make that modification.\n\n");
			if (player.mana >= (100 * counterOfPernamentGolems())) doYesNo(upgradesForPernamentGolemsMultiAttacksRank2Yes, upgradesForPernamentGolemsMultiAttacks);
			else {
				outputText("It seems you're too low on mana to proceed with this upgrade.\n\n");
				doNext(upgradesForPernamentGolemsMultiAttacks);
			}
		}
		public function upgradesForPernamentGolemsMultiAttacksRank2Yes():void {
			useMana((100 * counterOfPernamentGolems()));
			outputText("Focusing on the instructions, you take each pernament golem out of your bag and start engraving new mana pathways. It's slow work, but you know that a 3rd attack is worth the time. Each attack will drain more mana from you, but you deem the cost worth it.\n");
			player.addStatusValue(StatusEffects.GolemUpgrades1, 1, 1);
			doNext(upgradesForPernamentGolemsMultiAttacks);
			eachMinuteCount(30);
		}
		public function upgradesForPernamentGolemsImprovedManaCircuit():void {
			menu();
			if (player.statusEffectv2(StatusEffects.GolemUpgrades1) == 0) addButton(0, "I.M.Circ.(1)", upgradesForPernamentGolemsImprovedManaCircuitRank1);
			else addButtonDisabled(0, "I.M.Circ.(1)", "You already used this upgrade option on your golems.");
			if (player.statusEffectv2(StatusEffects.GolemUpgrades1) < 1) addButtonDisabled(1, "I.M.Circ.(2)", "You can't use this upgrade options without previous one.");
			else {
				if (player.statusEffectv2(StatusEffects.GolemUpgrades1) == 1) addButton(1, "I.M.Circ.(2)", upgradesForPernamentGolemsImprovedManaCircuitRank2);
				else addButtonDisabled(1, "I.M.Circ.(2)", "You already used this upgrade option on your golems.");
			}/*
			if (player.hasPerk(PerkLib.LegendaryGolemMaker)) {
				if (player.statusEffectv2(StatusEffects.GolemUpgrades1) == 0) addButton(2, "I.M.Circ.(3)", upgradesForPernamentGolemsImprovedManaCircuitRank3);
				else addButtonDisabled(2, "I.M.Circ.(3)", "You already used this upgrade option on your golems.");
			}
			else addButtonDisabled(2, "I.M.Circ.(3)", "You need to reach at least Legendary Golem Maker to work on this upgrade.");*/
			addButton(14, "Back", upgradesForPernamentGolems);
		}
		public function upgradesForPernamentGolemsImprovedManaCircuitRank1():void {
			clearOutput();
			outputText("You decided to work on mana circuits upgrade of your golem.\n\n");
			outputText("Checking page for this upgrade you see it would req. 150 mana per each possesed pernament golem to make that modification.\n\n");
			if (player.mana >= (150 * counterOfPernamentGolems())) doYesNo(upgradesForPernamentGolemsImprovedManaCircuitRank1Yes, upgradesForPernamentGolemsImprovedManaCircuit);
			else {
				outputText("It seems you're too low on mana to proceed with this upgrade.\n\n");
				doNext(upgradesForPernamentGolemsImprovedManaCircuit);
			}
		}
		public function upgradesForPernamentGolemsImprovedManaCircuitRank1Yes():void {
			useMana((150 * counterOfPernamentGolems()));
			outputText("Focusing on the instructions, you take out each permanent golem out of your bag. You sit down beside each golem, removing the old mana circuits. Once that's done, you engrave new, more efficient pathways. Once you're done, these new and improved golems will not only be more effective in combat, but also be much easier on your mana reserves.\n");
			player.addStatusValue(StatusEffects.GolemUpgrades1, 2, 1);
			doNext(upgradesForPernamentGolemsImprovedManaCircuit);
			eachMinuteCount(30);
		}
		public function upgradesForPernamentGolemsImprovedManaCircuitRank2():void {
			clearOutput();
			outputText("You decided to work on mana circuits upgrade of your golem.\n\n");
			outputText("Checking the page for this upgrade, you see it would req. 150 mana for each permanent golem to make that modification.\n\n");
			if (player.mana >= (150 * counterOfPernamentGolems())) doYesNo(upgradesForPernamentGolemsImprovedManaCircuitRank2Yes, upgradesForPernamentGolemsImprovedManaCircuit);
			else {
				outputText("It seems you're too low on mana to proceed with this upgrade.\n\n");
				doNext(upgradesForPernamentGolemsImprovedManaCircuit);
			}
		}
		public function upgradesForPernamentGolemsImprovedManaCircuitRank2Yes():void {
			useMana((150 * counterOfPernamentGolems()));
			outputText("Focusing on the instructions, you take out each permanent golem out of your bag. You sit down beside each golem, removing the old mana circuits. Once that's done, you engrave new, more efficient pathways. Once you're done, these new and improved golems will not only be more effective in combat, but also be much easier on your mana reserves.\\n");
			player.addStatusValue(StatusEffects.GolemUpgrades1, 2, 1);
			doNext(upgradesForPernamentGolemsImprovedManaCircuit);
			eachMinuteCount(30);
		}
		public function upgradesForPernamentGolemsElementalWeaponry():void {
			clearOutput();
			outputText("You decided to work on mana circuits upgrade of your golem.\n\n");
			outputText("Checking page for this upgrade you see it would req. 25 mana and 1 elemental shard per each possesed pernament golem to make that modification.\n\n");
			if (player.mana >= (25 * counterOfPernamentGolems()) && player.hasItem(useables.ELSHARD, counterOfPernamentGolems())) doYesNo(upgradesForPernamentGolemsElementalWeaponryYes, upgradesForPernamentGolems);
			else {
				outputText("It seems you're too low on mana or lacking elemental shards to proceed with this upgrade.\n\n");
				doNext(upgradesForPernamentGolems);
			}
		}
		public function upgradesForPernamentGolemsElementalWeaponryYes():void {
			useMana((25 * counterOfPernamentGolems()));
			player.destroyItems(useables.ELSHARD, counterOfPernamentGolems());
			outputText("Focusing on the instruction you take out each pernament golem out of your bag and start slow process of engraving patchways using elemental shards as material and mana as medium to do allow shards become engraving. After finished process each golem have new multicolor shining think patterns over their arms that would allow to convert pure mana into specific elemental mana.\n");
			if (player.hasStatusEffect(StatusEffects.GolemUpgrades1)) player.addStatusValue(StatusEffects.GolemUpgrades1, 3, 1);
			else player.createStatusEffect(StatusEffects.GolemUpgrades1, 0, 0, 1, 0);
			doNext(upgradesForPernamentGolems);
			eachMinuteCount(30);
		}
		public function upgradesForPernamentGolemsPoisonedWeaponry():void {
			clearOutput();
			
		}/*
		public function upgradesForPernamentGolems():void {
			clearOutput();
			
		}
		public function upgradesForPernamentGolems():void {
			clearOutput();
			
		}
		public function upgradesForPernamentGolems():void {
			clearOutput();
			
		}*/
		
		public function postFightGolemOptions1():void {
			clearOutput();
			outputText("What you gonna do now?\n\n");
			menu();
			addButton(10, "Scavenge", golemScavenge1);
			addButton(14, "Leave", cleanupAfterCombat);
		}
		public function postFightGolemOptions2():void {
			clearOutput();
			if (!player.hasStatusEffect(StatusEffects.GolemScavenge)) player.createStatusEffect(StatusEffects.GolemScavenge,2 + rand(2),0,0,0);
			outputText("What you gonna do now?\n\nAmount of golems you can scavenge: "+player.statusEffectv1(StatusEffects.GolemScavenge)+"\n\n");
			menu();
			addButton(10, "Scavenge", golemScavenge2);
			addButton(14, "Leave", cleanupAfterCombat);
		}
		public function postFightGolemOptions3():void {
			clearOutput();
			outputText("What you gonna do now?\n\n");
			menu();
			addButton(10, "Scavenge", golemScavenge3);
			addButton(14, "Leave", cleanupAfterCombat);
		}
		public function postFightGolemOptions4():void {
			clearOutput();
			if (!player.hasStatusEffect(StatusEffects.GolemScavenge)) player.createStatusEffect(StatusEffects.GolemScavenge,2 + rand(2),1,0,0);
			outputText("What you gonna do now?\n\nAmount of golems you can scavenge: "+player.statusEffectv1(StatusEffects.GolemScavenge)+"\n\n");
			menu();
			addButton(10, "Scavenge", golemScavenge4);
			addButton(14, "Leave", cleanupAfterCombat);
		}
		private function golemScavenge1():void {
			clearOutput();
			outputText("You sit down by the golem and begin extracting the core from the big chunk that remains of its chest. ");
			if (rand(4) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("At first the core resists, but after a few tries you successfully manage to harvest the golem core.");
				doNext(takeCore);
			}
			else {
				outputText("Sadly despite your best efforts the core is damaged during the extraction and rendered useless.");
				doNext(cleanupAfterCombat);
			}
		}
		private function golemScavenge2():void {
			clearOutput();
			outputText("You sit down by the golem and begin extracting the core from the big chunk that remains of its chest. ");
			player.addStatusValue(StatusEffects.GolemScavenge, 1, -1);
			if (rand(4) == 0 || player.statusEffectv1(StatusEffects.GolemScavenge) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("At first the core resists, but after a few tries you successfully manage to harvest the golem core.");
				doNext(takeCore);
			}
			else {
				outputText("Sadly despite your best efforts the core is damaged during the extraction and rendered useless.");
				if (player.hasStatusEffect(StatusEffects.GolemScavenge)) doNext(golemScavenge2);
				else doNext(cleanupAfterCombat);
			}
		}
		private function golemScavenge3():void {
			clearOutput();
			outputText("You sit down by the golem and begin extracting the core from the big chunk that remains of its chest. ");
			if (rand(4) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("At first the core resist but after a few tries you successfully manage to harvest the golem core. Not one to waste spare material you gather the remaining stone. (+2 stones)");
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 2;
				doNext(takeCore);
			}
			else {
				outputText("Sadly despite your best efforts the core is damaged during the extraction and rendered useless. Not one to waste spare material you gather the remaining stone. (+5 stones)");
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 5;
				doNext(cleanupAfterCombat);
			}
		}
		private function golemScavenge4():void {
			clearOutput();
			outputText("You sit down by the golem and begin extracting the core from the big chunk that remains of its chest. ");
			player.addStatusValue(StatusEffects.GolemScavenge, 1, -1);
			if (rand(4) == 0 || player.statusEffectv1(StatusEffects.GolemScavenge) == 0 || player.hasPerk(PerkLib.JobGolemancer)) {
				outputText("At first the core resist but after a few tries you successfully manage to harvest the golem core. Not one to waste spare material you gather the remaining stone. (+2 stones)");
				flags[kFLAGS.CAMP_CABIN_STONE_RESOURCES] += 2;
				doNext(takeCore);
			}
			else {
				outputText("Sadly despite your best efforts the core is damaged during the extraction and rendered useless. Not one to waste spare material you gather the remaining stone. (+5 stones)");
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
		
		//--------------
		//
		//  ELEMENTALS
		//
		//--------------
		
		private function maxSizeOfElementalsArmy():Number {
			var maxSizeOfElementalsArmyCounter:Number = 0;
			if (player.hasPerk(PerkLib.JobElementalConjurer)) maxSizeOfElementalsArmyCounter += 3;
			if (player.hasPerk(PerkLib.ElementalContractRank1)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank2)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank3)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank4)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank5)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank6)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank7)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank8)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank9)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank10)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank11)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank12)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank13)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank14)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank15)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank16)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank17)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank18)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank19)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank20)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank21)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank22)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank23)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank24)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank25)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank26)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank27)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank28)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank29)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank30)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementalContractRank31)) maxSizeOfElementalsArmyCounter += 1;
			if (player.hasPerk(PerkLib.ElementsOfTheOrtodoxPath)) maxSizeOfElementalsArmyCounter += 2;
			if (player.hasPerk(PerkLib.ElementsOfMarethBasics)) maxSizeOfElementalsArmyCounter += 2;
			if (player.hasPerk(PerkLib.ElementsOfMarethAdvanced)) maxSizeOfElementalsArmyCounter += 2;
			return maxSizeOfElementalsArmyCounter;
		}
		private function currentSizeOfElementalsArmy():Number {
			var currentSizeOfElementalsArmyCounter:Number = 0;
			if (player.statusEffectv1(StatusEffects.SummonedElementals) > 0) currentSizeOfElementalsArmyCounter += player.statusEffectv1(StatusEffects.SummonedElementals);
			if (player.statusEffectv2(StatusEffects.SummonedElementals) > 0) currentSizeOfElementalsArmyCounter += player.statusEffectv2(StatusEffects.SummonedElementals) * 2;
			return currentSizeOfElementalsArmyCounter;
		}
		
		public function accessSummonElementalsMainMenu():void {
			clearOutput();
			outputText("Which one elemental would you like to summon or promote to higher rank?\n\n");
			if (player.hasPerk(PerkLib.JobElementalConjurer)) {
				outputText("Current limit for elemental summons: " + maxSizeOfElementalsArmy() + " different types of elementals\n");
				outputText("Current summoned elementals count\n<i>");
				if (player.hasStatusEffect(StatusEffects.SummonedElementals)) {
					outputText("-Normal: " + player.statusEffectv1(StatusEffects.SummonedElementals) + " (" + player.statusEffectv1(StatusEffects.SummonedElementals) + ")\n");
					outputText("-Epic: " + player.statusEffectv2(StatusEffects.SummonedElementals) + " (" + player.statusEffectv2(StatusEffects.SummonedElementals) * 2 + ")\n");
				}
				outputText("-Unique: 0</i>\n\n");
			}
			if (player.hasStatusEffect(StatusEffects.ElementalEnergyConduits)) outputText("Elemental Energy Stored in Conduits: <i>"+player.statusEffectv1(StatusEffects.ElementalEnergyConduits)+" / "+player.statusEffectv2(StatusEffects.ElementalEnergyConduits)+"</i>\n\n");
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
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsAirE)) {
				outputText("\nAir <b>(Elite)</b>");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 1) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 2) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 3) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 4) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 5) outputText(" (Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 6) outputText(" (Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 7) outputText(" (Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 8) outputText(" (Viscount Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 9) outputText(" (Earl Rank)");//204
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 10) outputText(" (Marquess Rank)");//228
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 11) outputText(" (Duke Rank)");//252
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 12) outputText(" (Prince Rank)");//276
				if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) == 13) outputText(" (King Rank)");//300
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsEarthE)) {
				outputText("\nEarth <b>(Elite)</b>");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 1) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 2) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 3) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 4) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 5) outputText(" (Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 6) outputText(" (Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 7) outputText(" (Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) == 8) outputText(" (Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsFireE)) {
				outputText("\nFire <b>(Elite)</b>");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 1) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 2) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 3) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 4) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 5) outputText(" (Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 6) outputText(" (Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 7) outputText(" (Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) == 8) outputText(" (Viscount Rank)");
			}
			if (player.hasStatusEffect(StatusEffects.SummonedElementalsWaterE)) {
				outputText("\nWater <b>(Elite)</b>");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 1) outputText(" (Rank 1)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 2) outputText(" (Rank 2)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 3) outputText(" (Rank 3)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 4) outputText(" (Rank 4)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 5) outputText(" (Elder Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 6) outputText(" (Lord Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 7) outputText(" (Baron Rank)");
				if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) == 8) outputText(" (Viscount Rank)");
			}
			outputText("</i>");
			menu();
			if (player.hasPerk(PerkLib.JobElementalConjurer) && (currentSizeOfElementalsArmy() < maxSizeOfElementalsArmy())) addButton(0, "Summon(N)", summoningElementalsSubmenu).hint("Summon a Normal-tier Elementals");
			else addButtonDisabled(0, "Summon(N)", "You either summoned all possible Normal-tier elementals or reached limit of how many elementals you can command at once.");
			if (player.hasPerk(PerkLib.JobElementalConjurer) && ((currentSizeOfElementalsArmy() + 1) < maxSizeOfElementalsArmy())) addButton(1, "Summon(E)", summoningEpicElementalsSubmenu).hint("Summon an Epic-tier Elementals");
			else addButtonDisabled(1, "Summon(E)", "You either summoned all possible Epic-tier elementals or reached limit of how many elementals you can command at once.");
			if (currentSizeOfElementalsArmy() > 0) addButton(5, "ElementUp", elementaLvlUp,-9000,-9000,-9000,"Level up your Normal Elementals!")
			else addButtonDisabled(5, "ElementUp", "You don't have any normal elementals, try summoning one!");
			if (player.statusEffectv2(StatusEffects.SummonedElementals) > 0) addButton(6, "ElementUp(E)", elementaLvlUpEpic);
			else addButtonDisabled(6, "ElementUp(E)", "You don't have any epic elementals, try summoning one!");
			if (player.statusEffectv3(StatusEffects.ElementalEnergyConduits) >= 1) addButton(12, "E.S.Conv.", elementalShardsConversion).hint("Conversion of Elemental Shards"+(player.hasPerk(PerkLib.ElementalConjurerKnowledgeSu)?" of Soulforce":"")+" into energy stored in arcane circle elemental conduit.");
			else addButtonDisabled(12, "E.S.Conv.", "You need to have any elemental conduit added to the arcane circle to use this option.");
			addButton(13, "EvocationTome", evocationTome).hint("Description of various elemental powers.");
			addButton(14, "Back", camp.campWinionsArmySim);
		}
		private function elementaLvlUp():void {
			var elementalTypes:Array = [];
			var contractRankI:int = 0;
			var btnInt:int = 0;
			var pPerkList:Array = player.perks;
			menu();
			elementalTypes.push(StatusEffects.SummonedElementalsAir, rankUpElementalAir, "air");
			elementalTypes.push(StatusEffects.SummonedElementalsEarth, rankUpElementalEarth, "earthen");
			elementalTypes.push(StatusEffects.SummonedElementalsFire, rankUpElementalFire, "flaming");
			elementalTypes.push(StatusEffects.SummonedElementalsWater, rankUpElementalWater, "flowing");
			elementalTypes.push(StatusEffects.SummonedElementalsEther, rankUpElementalEther, "ethereal");
			elementalTypes.push(StatusEffects.SummonedElementalsWood, rankUpElementalWood, "wooden");
			elementalTypes.push(StatusEffects.SummonedElementalsMetal, rankUpElementalMetal, "metallic");
			elementalTypes.push(StatusEffects.SummonedElementalsIce, rankUpElementalIce, "icy");
			elementalTypes.push(StatusEffects.SummonedElementalsLightning, rankUpElementalLightning, "electrifying");
			elementalTypes.push(StatusEffects.SummonedElementalsDarkness, rankUpElementalDarkness, "shadowy");
			elementalTypes.push(StatusEffects.SummonedElementalsPoison, rankUpElementalPoison, "poisonous");
			elementalTypes.push(StatusEffects.SummonedElementalsPurity, rankUpElementalPurity, "pure");
			elementalTypes.push(StatusEffects.SummonedElementalsCorruption, rankUpElementalCorruption, "corrupted");
			for each(var pPerks:PerkClass in pPerkList) { //Cheaty way of getting value equivalences.
				var temp:String = pPerks.perkName
				if (temp.indexOf("Elemental Contract Rank") >= 0){
					temp = temp.replace("Elemental Contract Rank ", "");
					var temp2:int = parseInt(temp, 10);
					if (temp2 > contractRankI){
						contractRankI = temp2;
					}
				}
			}
			var arcaneCMax:int = (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE]*4);
			for (var i:int = 0,j:int = elementalTypes.length; i < j; i++){
				if (i % 3 == 0){
					var btnName:String = elementalTypes[i];
					btnName = btnName.replace("\"Summoned Elementals ", "").replace("\"", "");
					//outputText(btnName);
					var pElemLvlStat:int = player.statusEffectv2(elementalTypes[i]);
					if (pElemLvlStat <= contractRankI && pElemLvlStat > 0){//Checks Elemental level lower than max, but not 0.
						if (pElemLvlStat < arcaneCMax){	//If lower, don't care. You have the circle and the highest level circle can support.
							addButton(btnInt, btnName,elementalLvlUpCostCheck , elementalTypes[i + 1], pElemLvlStat, btnName, "Level up your "+ elementalTypes[i + 2] +" elemental!");
						}
						else{//Outside Bracket.
							addButtonDisabled(btnInt, btnName,"Your Arcane Circle can't handle the elemental level up safely!");
						}
					}
					else if (pElemLvlStat == 0){
						addButtonDisabled(btnInt, btnName,"You don't have this elemental yet!");
					}
					else{
						addButtonDisabled(btnInt, btnName,"You can't handle this elemental if you go further!");
					}
					btnInt += 1;
				}
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function elementalLvlUpCostCheck(elemType:Function, elemLvl:int, btnName:String):void{ //Check if player can afford to do so.
			clearOutput();
			menu();
			outputText("It will cost you " + rankUpElementalManaCost() * elemLvl + " mana and " + rankUpElementalFatigueCost() * elemLvl + " fatigue. Are you sure you want to proceed?");
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) {
				outputText("\n\nYou could also replace mana and fatigue by elemental energy ("+((rankUpElementalElementalEnergyCost()*elemLvl)/4)+") stored into energy conduits. (Elemental energy would have priority on what resources are gonna be used)\n\n");
				if (player.hasStatusEffect(StatusEffects.ElementalEnergyConduits)) outputText("Elemental Energy Stored in Conduits: <i>"+player.statusEffectv1(StatusEffects.ElementalEnergyConduits)+" / "+player.statusEffectv2(StatusEffects.ElementalEnergyConduits)+"</i>\n\n");
			}
			if (player.hasStatusEffect(StatusEffects.ElementalEnergyConduits) && player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && ((rankUpElementalElementalEnergyCost()*elemLvl)/4) > player.statusEffectv1(StatusEffects.ElementalEnergyConduits)){
				addButtonDisabled(0, btnName,"You don't have enough Elemental energy in energy conduits. Try again when you have "+ ((rankUpElementalElementalEnergyCost()*elemLvl)/4) +" stored up!");
			}
			if (rankUpElementalManaCost()*elemLvl > player.mana){
				addButtonDisabled(0, btnName,"You don't have enough Mana within you. Try again when you have "+ rankUpElementalManaCost()*elemLvl +" stored up!");
			}
			else if(player.maxFatigue() <= (player.fatigue + rankUpElementalFatigueCost()*elemLvl)){
				addButtonDisabled(0, btnName,"You are too tired to attempt this. Try again when you have more energy!");
			}
			else{
				addButton(0, btnName, elemType, null, null, null, "Let's do this!")
			}
			addButton(14, "Back", elementaLvlUp);
		}
		private function elementaLvlUpEpic():void {
			menu();
			if (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) < 5) {
				if (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) * rankUpElementalElementalEnergyCost())) {
					if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > player.statusEffectv2(StatusEffects.SummonedElementalsAirE)) addButton(0, "Air", rankUpElementalAirEpic);
					else addButtonDisabled(0, "Air", "Your Arcane Circle can't handle the epic elemental level up safely!");
				}
				else addButtonDisabled(0, "Air", "Your stored elemental energy is too low. Missing: "+((player.statusEffectv2(StatusEffects.SummonedElementalsAirE) * rankUpElementalElementalEnergyCost())-player.statusEffectv1(StatusEffects.ElementalEnergyConduits))+"");
			}
			if (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) < 5) {
				if (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) * rankUpElementalElementalEnergyCost())) {
					if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > player.statusEffectv2(StatusEffects.SummonedElementalsEarthE)) addButton(1, "Earth", rankUpElementalEarthEpic);
					else addButtonDisabled(1, "Earth", "Your Arcane Circle can't handle the epic elemental level up safely!");
				}
				else addButtonDisabled(1, "Earth", "Your stored elemental energy is too low. Missing: "+((player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) * rankUpElementalElementalEnergyCost())-player.statusEffectv1(StatusEffects.ElementalEnergyConduits))+"");
			}
			if (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) < 5) {
				if (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) * rankUpElementalElementalEnergyCost())) {
					if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > player.statusEffectv2(StatusEffects.SummonedElementalsFireE)) addButton(2, "Fire", rankUpElementalFireEpic);
					else addButtonDisabled(2, "Fire", "Your Arcane Circle can't handle the epic elemental level up safely!");
				}
				else addButtonDisabled(2, "Fire", "Your stored elemental energy is too low. Missing: "+((player.statusEffectv2(StatusEffects.SummonedElementalsFireE) * rankUpElementalElementalEnergyCost())-player.statusEffectv1(StatusEffects.ElementalEnergyConduits))+"");
			}
			if (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) < 5) {
				if (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) * rankUpElementalElementalEnergyCost())) {
					if (flags[kFLAGS.CAMP_UPGRADES_ARCANE_CIRCLE] > player.statusEffectv2(StatusEffects.SummonedElementalsWaterE)) addButton(3, "Water", rankUpElementalWaterEpic);
					else addButtonDisabled(3, "Water", "Your Arcane Circle can't handle the epic elemental level up safely!");
				}
				else addButtonDisabled(3, "Water", "Your stored elemental energy is too low. Missing: "+((player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) * rankUpElementalElementalEnergyCost())-player.statusEffectv1(StatusEffects.ElementalEnergyConduits))+"");
			}
			addButton(14, "Back", accessSummonElementalsMainMenu)
		}
		private function elementalShardsConversion():void {
			clearOutput();
			outputText("Elemental Energy Stored in Conduits: <i>"+player.statusEffectv1(StatusEffects.ElementalEnergyConduits)+" / "+player.statusEffectv2(StatusEffects.ElementalEnergyConduits)+"</i>\n\n");
			outputText("Do you like to convert elemental shard into energy stored in conduit? (Excess energy will be lost)\n\n");
			menu();
			if (player.hasItem(useables.ELSHARD, 1)) addButton(1, "Yes", elementalShardsConversionGo);
			else addButtonDisabled(1, "Yes", "You not have any Elemental Shards to convert currently.");
			addButton(3, "Back", accessSummonElementalsMainMenu);
		}
		private function elementalShardsConversionGo():void {
			clearOutput();
			outputText("You remove the elemental shard from your pack, taking it in both hands. You sit in the middle of your circle, the shard resting in your palms. You close your eyes, letting your mana spread into the crystal. As you focus your power, the crystal shatters, little pieces floating around your head. You can’t see, but you feel it as the shards liquify, crystal bits becoming globes, shimmering with power. With a thought, you will the globes down, into the leylines you’ve made in the ground, into the engravings of your circle. You feel the power settle, a magical pulse that you feel, ready to be unleashed.\n\n");
			player.destroyItems(useables.ELSHARD, 1);
			var convertedShard:Number = 0;
			if (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) + 400 > player.statusEffectv2(StatusEffects.ElementalEnergyConduits)) convertedShard += (player.statusEffectv2(StatusEffects.ElementalEnergyConduits) - player.statusEffectv1(StatusEffects.ElementalEnergyConduits));
			else convertedShard += 400;
			player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,convertedShard);
			doNext(elementalShardsConversion);
		}
		private function evocationTome():void {
			clearOutput();
			menu();
			outputText("Which element would you like to read about?\n\n");
			addButton(0, "Air", evocationTomeAir).hint(" Information about the Air Elements.");
			addButton(1, "Earth", evocationTomeEarth).hint(" Information about the Earth Elements.");
			addButton(2, "Fire", evocationTomeFire).hint(" Information about the Fire Elements.");
			addButton(3, "Water", evocationTomeWater).hint(" Information about the Water Elements.");
			if (player.hasPerk(PerkLib.ElementsOfTheOrtodoxPath)) {
				addButton(4, "Ether", evocationTomeEther).hint(" Information about the Ether Elements.");
				addButton(5, "Wood", evocationTomeWood).hint(" Information about the Wood Elements.");
				addButton(6, "Metal", evocationTomeMetal).hint(" Information about the Metal Elements.");
			}
			else {
				addButtonDisabled(4, "Ether", "Req. Elements of the orthodox Path perk.");
				addButtonDisabled(5, "Wood", "Req. Elements of the orthodox Path perk.");
				addButtonDisabled(6, "Metal", "Req. Elements of the orthodox Path perk.");
			}
			if (player.hasPerk(PerkLib.ElementsOfMarethBasics)) {
				addButton(7, "Ice", evocationTomeIce).hint(" Information about the Ice Elements.");
				addButton(8, "Lightning", evocationTomeLightning).hint(" Information about the Lightning Elements.");
				addButton(9, "Darkness", evocationTomeDarkness).hint(" Information about the Darkness Elements.");
			}
			else {
				addButtonDisabled(7, "Ice", "Req. Elements of Mareth: Basics perk.");
				addButtonDisabled(8, "Lightning", "Req. Elements of Mareth: Basics perk.");
				addButtonDisabled(9, "Darkness", "Req. Elements of Mareth: Basics perk.");
			}
			if (player.hasPerk(PerkLib.ElementsOfMarethAdvanced)) {
				addButton(10, "Poison", evocationTomePoison).hint(" Information about the Poison Elements.");
				addButton(11, "Purity", evocationTomePurity).hint(" Information about the Purity Elements.");
				addButton(12, "Corruption", evocationTomeCorruption).hint(" Information about the Corruption Elements.");
			}
			else {
				addButtonDisabled(10, "Poison", "Req. Elements of Mareth: Advanced perk.");
				addButtonDisabled(11, "Purity", "Req. Elements of Mareth: Advanced perk.");
				addButtonDisabled(12, "Corruption", "Req. Elements of Mareth: Advanced perk.");
			}
			//addButtonDisabled(13, "???", "You need to take some time to understand what you've learned. Come back later."); //Silly mode tooltip possible? "This isn't a cram school, stop forcing books into your head!"
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}
		private function evocationTomeAir():void {
			clearOutput();
			outputText("<b>Air Elemental</b>\n\n");
			outputText("-When attacking, it has an increased critical damage chance by 10%.\n");
			outputText("-When attacking, it has an increased critical damage multiplied from 150% to 175%.\n");
			outputText("-When attacking, it will ignore enemy damage reduction.\n");
			outputText("-M. Special: Creates a Wind Wall that deflects incoming projectiles for few turns. Duration depends on elemental rank.\n");
			doNext(evocationTome);
		}
		private function evocationTomeEarth():void {
			clearOutput();
			outputText("<b>Earth Elemental</b>\n\n");
			outputText("-When attacking, it has an increased damage by 100%.\n");
			outputText("-When attacking, it will deal Earth type damage.\n");
			outputText("-M. Special: Creates an Earth armor around PC, increasing armor and magic resistance for a few turns. Duration depends on elemental rank.\n");
			doNext(evocationTome);
		}
		private function evocationTomeFire():void {
			clearOutput();
			outputText("<b>Fire Elemental</b>\n\n");
			outputText("-When attacking, it will deal Fire type damage.\n");
			outputText("-M. Special: Stronger version of fire attributed attack.\n");
			doNext(evocationTome);
		}
		private function evocationTomeWater():void {
			clearOutput();
			outputText("<b>Water Elemental</b>\n\n");
			outputText("-When attacking, it has an increased critical damage chance by 10%.\n");
			outputText("-When attacking, it will deal Water type damage.\n");
			outputText("-M. Special: Heals PC.\n");
			doNext(evocationTome);
		}
		private function evocationTomeEther():void {
			clearOutput();
			outputText("<b>Ether Elemental</b>\n\n");
			outputText("-When attacking, it has an increased critical damage chance by 10%.\n");
			outputText("-When attacking, it has an increased critical damage multiplied from 150% to 200%.\n");
			outputText("-When attacking, it will ignore enemy damage reduction.\n");
			outputText("-M. Special: Deals increased damage as a bonus to enemy if enemy is weak to any of the four major elements.\n");
			doNext(evocationTome);
		}
		private function evocationTomeWood():void {
			clearOutput();
			outputText("<b>Wood Elemental</b>\n\n");
			outputText("-When attacking, it has an increased damage by 100%.\n");
			outputText("-M. Special: PC (Minor) Healing and small increase to armor / magic resistance for a few turns. Duration depends on elemental rank.\n");
			doNext(evocationTome);
		}
		private function evocationTomeMetal():void {
			clearOutput();
			outputText("<b>Metal Elemental</b>\n\n");
			outputText("-When attacking, it has an increased critical damage chance by 10%.\n");
			outputText("-When attacking, it has an increased critical damage multiplied from 150% to 175%.\n");
			outputText("-When attacking, it has an increased damage by 30%.\n");
			outputText("-M. Special: Increases PC unarmed damage for a few turns. Duration depends on elemental rank.\n");
			doNext(evocationTome);
		}
		private function evocationTomeIce():void {
			clearOutput();
			outputText("<b>Ice Elemental</b>\n\n");
			outputText("-When attacking, it will deal Ice type damage.\n");
			outputText("-M. Special: Stronger version of ice attributed attack.\n");
			doNext(evocationTome);
		}
		private function evocationTomeLightning():void {
			clearOutput();
			outputText("<b>Lightning Elemental</b>\n\n");
			outputText("-When attacking, it will deal Lightning type damage.\n");
			outputText("-M. Special: Stronger version of lightning attributed attack.\n");
			doNext(evocationTome);
		}
		private function evocationTomeDarkness():void {
			clearOutput();
			outputText("<b>Darkness Elemental</b>\n\n");
			outputText("-When attacking, it will deal Darkness type damage.\n");
			outputText("-M. Special: Stronger version of darkness attributed attack.\n");
			doNext(evocationTome);
		}
		private function evocationTomePoison():void {
			clearOutput();
			outputText("<b>Poison Elemental</b>\n\n");
			outputText("-When attacking, it will deal Poison type damage.\n");
			outputText("-M. Special: Stronger version of poison attributed attack.\n");
			doNext(evocationTome);
		}
		private function evocationTomePurity():void {
			clearOutput();
			outputText("<b>Purity Elemental</b>\n\n");
			outputText("-When attacking, it will deal increased damage based on enemy corruption. The higher the corruption the higher bonus to damage. (60%-300%)\n");
			outputText("-M. Special: Stronger version of purity attributed attack.\n");
			doNext(evocationTome);
		}
		private function evocationTomeCorruption():void {
			clearOutput();
			outputText("<b>Corruption Elemental</b>\n\n");
			outputText("-When attacking, it will deal increased damage based on enemy corruption. The lower the corruption the higher bonus to damage. (60%-300%)\n");
			outputText("-M. Special: Stronger version of corruption attributed attack.\n");
			doNext(evocationTome);
		}
		private function evocationTome4():void {
			clearOutput();
			outputText("<b>1 Elemental</b>\n\n");
			outputText("-M. Special: \n");
			doNext(evocationTome);
		}
		private function evocationTome3():void {
			clearOutput();
			outputText("<b>1 Elemental</b>\n\n");
			outputText("-M. Special: \n");
			doNext(evocationTome);
		}
		private function evocationTome2():void {
			clearOutput();
			outputText("<b>1 Elemental</b>\n\n");
			outputText("-M. Special: \n");
			doNext(evocationTome);
		}
		private function evocationTome1():void {
			clearOutput();
			outputText("<b>1 Elemental</b>\n\n");
			outputText("-M. Special: \n");
			doNext(evocationTome);
		}
		private function summoningElementalsSubmenu():void {
			clearOutput();
			outputText("If you don't have enough mana (100+) and fatigue (50+) it will be impossible to summon any elementals.\n\n");
			menu();
			if (player.mana >= 100 && (player.fatigue + 50 <= player.maxFatigue())) {
				if (player.statusEffectv1(StatusEffects.SummonedElementalsAir) < 1) addButton(0, "Air", summonElementalAir);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsEarth) < 1) addButton(1, "Earth", summonElementalEarth);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsFire) < 1) addButton(2, "Fire", summonElementalFire);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsWater) < 1) addButton(3, "Water", summonElementalWater);
				if (player.hasPerk(PerkLib.ElementsOfTheOrtodoxPath)) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsEther) < 1) addButton(4, "Ether", summonElementalEther);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsWood) < 1) addButton(5, "Wood", summonElementalWood);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsMetal) < 1) addButton(6, "Metal", summonElementalMetal);
				}
				if (player.hasPerk(PerkLib.ElementsOfMarethBasics)) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsIce) < 1) addButton(7, "Ice", summonElementalIce);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsLightning) < 1) addButton(8, "Lightning", summonElementalLightning);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsDarkness) < 1) addButton(9, "Darkness", summonElementalDarkness);
				}
				if (player.hasPerk(PerkLib.ElementsOfMarethAdvanced)) {
					if (player.statusEffectv1(StatusEffects.SummonedElementalsPoison) < 1) addButton(10, "Poison", summonElementalPoison);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsPurity) < 1) addButton(11, "Purity", summonElementalPurity);
					if (player.statusEffectv1(StatusEffects.SummonedElementalsCorruption) < 1) addButton(12, "Corruption", summonElementalCorruption);
				}
			}
			addButton(14, "Back", accessSummonElementalsMainMenu);
		}

		private function summoningEpicElementalsSubmenu():void {
			clearOutput();
			outputText("If you not have matching item, two elemental shards and enough fatigue (200+) it will be impossible to summon any epic elementals.\n\n");
			menu();
			if (player.hasItem(useables.ELSHARD, 2) && (player.fatigue + 200 <= player.maxFatigue())) {
				if (player.statusEffectv1(StatusEffects.SummonedElementalsAirE) < 1) addButton(0, "Air", summonElementalAirEpic);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsEarthE) < 1) addButton(1, "Earth", summonElementalEarthEpic);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsFireE) < 1) addButton(2, "Fire", summonElementalFireEpic);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsWaterE) < 1) addButton(3, "Water", summonElementalWaterEpic);
				/*if (player.statusEffectv1(StatusEffects.SummonedElementalsEther) < 1) addButton(4, "Ether", summonElementalEther);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsWood) < 1) addButton(5, "Wood", summonElementalWood);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsMetal) < 1) addButton(6, "Metal", summonElementalMetal);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsIce) < 1) addButton(7, "Ice", summonElementalIce);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsLightning) < 1) addButton(8, "Lightning", summonElementalLightning);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsDarkness) < 1) addButton(9, "Darkness", summonElementalDarkness);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsPoison) < 1) addButton(10, "Poison", summonElementalPoison);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsPurity) < 1) addButton(11, "Purity", summonElementalPurity);
				if (player.statusEffectv1(StatusEffects.SummonedElementalsCorruption) < 1) addButton(12, "Corruption", summonElementalCorruption);*/
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
			finishingSummoningElemental();
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
			finishingSummoningElemental();
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
			eachMinuteCount(30);
		}
		private function summonElementalAirEpic():void {
			clearOutput();
			if (player.hasKeyItem("Air Sylph Core") >= 0) {
				player.removeKeyItem("Air Sylph Core");
				player.destroyItems(useables.ELSHARD, 2);
				fatigue(200);
				statScreenRefresh();
				outputText("As it will be your first time summoning an epic air elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. In centre you place Air Sylph Core. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The air elemental appear within the circle. ");
				outputText("At first huge and terrifying, it fight against its binding trying to break through. The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. During decreasing size it shape also morph into masculine humanoid form of sylph instead of generic shape of all elementals. ");
				outputText("Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own epic air elemental!</b>\"");
				player.createStatusEffect(StatusEffects.SummonedElementalsAirE, 1, 1, 0, 0);
				finishingSummoningEpicElemental();
			}
			else {
				outputText("Looks like you lack most important part 'Air Sylph Core'. Without it there is no point to attempt summoning epic air elemental.");
				doNext(accessSummonElementalsMainMenu);
			}
		}
		private function summonElementalEarthEpic():void {
			clearOutput();
			if (player.hasKeyItem("Earth Golem Core") >= 0) {
				player.removeKeyItem("Earth Golem Core");
				player.destroyItems(useables.ELSHARD, 2);
				fatigue(200);
				statScreenRefresh();
				outputText("As it will be your first time summoning an epic earth elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. In centre you place Earth Golem Core. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The earth elemental appear within the circle. ");
				outputText("At first huge and terrifying, it fight against its binding trying to break through. The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. During decreasing size it shape also morph into feminine humanoid form of golem instead of generic shape of all elementals. ");
				outputText("Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own epic earth elemental!</b>\"");
				player.createStatusEffect(StatusEffects.SummonedElementalsEarthE, 1, 1, 0, 0);
				finishingSummoningEpicElemental();
			}
			else {
				outputText("Looks like you lack most important part 'Earth Golem Core'. Without it there is no point to attempt summoning epic earth elemental.");
				doNext(accessSummonElementalsMainMenu);
			}
		}
		private function summonElementalFireEpic():void {
			clearOutput();
			if (player.hasKeyItem("Fire Ifrit Core") >= 0) {
				player.removeKeyItem("Fire Ifrit Core");
				player.destroyItems(useables.ELSHARD, 2);
				fatigue(200);
				statScreenRefresh();
				outputText("As it will be your first time summoning an epic fire elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. In centre you place Fire Ifrit Core. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The fire elemental appear within the circle. ");
				outputText("At first huge and terrifying, it fight against its binding trying to break through. The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. During decreasing size it shape also morph into feminine humanoid form of ifrit instead of generic shape of all elementals. ");
				outputText("Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own epic fire elemental!</b>\"");
				player.createStatusEffect(StatusEffects.SummonedElementalsFireE, 1, 1, 0, 0);
				finishingSummoningEpicElemental();
			}
			else {
				outputText("Looks like you lack most important part 'Fire Ifrit Core'. Without it there is no point to attempt summoning epic fire elemental.");
				doNext(accessSummonElementalsMainMenu);
			}
		}
		private function summonElementalWaterEpic():void {
			clearOutput();
			if (player.hasKeyItem("Water Undine Core") >= 0) {
				player.removeKeyItem("Water Undine Core");
				player.destroyItems(useables.ELSHARD, 2);
				fatigue(200);
				statScreenRefresh();
				outputText("As it will be your first time summoning an epic water elemental, you begin the ritual by drawing a small circle of rune inside the larger arcane circle you already built, including runes for binding, and directive. In centre you place Water Undine Core. That done you initiate the most dangerous part of the ritual, invoking the primal might of the elemental. The water elemental appear within the circle. ");
				outputText("At first huge and terrifying, it fight against its binding trying to break through. The binding circle holds however acting as a mighty barrier the creature cannot breach. As the restraint rune takes hold it slowly shrink in size to something you can properly control. During decreasing size it shape also morph into masculine humanoid form of undine instead of generic shape of all elementals. ");
				outputText("Their duty fulfilled the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is finally complete congratulation is in order as you bound your very own epic water elemental!</b>\"");
				player.createStatusEffect(StatusEffects.SummonedElementalsWaterE, 1, 1, 0, 0);
				finishingSummoningEpicElemental();
			}
			else {
				outputText("Looks like you lack most important part 'Water Undine Core'. Without it there is no point to attempt summoning epic water elemental.");
				doNext(accessSummonElementalsMainMenu);
			}
		}
		private function finishingSummoningEpicElemental():void {
			if (player.hasStatusEffect(StatusEffects.SummonedElementals)) player.addStatusValue(StatusEffects.SummonedElementals, 2, 1);
			else player.createStatusEffect(StatusEffects.SummonedElementals, 0, 1, 0, 0);
			doNext(accessSummonElementalsMainMenu);
			eachMinuteCount(30);
		}
		
		private function rankUpElementalAir():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsAir))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsAir))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsAir));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsAir));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsAir) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsAir);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsAir, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalEarth():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsEarth))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsEarth))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsEarth));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsEarth));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsEarth) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsEarth);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsEarth, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalFire():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsFire))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsFire))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsFire));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsFire));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsFire) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsFire);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsFire, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalWater():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsWater))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsWater))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsWater));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsWater));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsWater) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsWater);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsWater, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalIce():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsIce))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsIce))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsIce));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsIce));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsIce) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsIce);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsIce, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalLightning():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsLightning))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsLightning))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsLightning));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsLightning));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsLightning) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsLightning);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsLightning, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalDarkness():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsDarkness))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsDarkness))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsDarkness));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsDarkness) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsDarkness);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsDarkness, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalWood():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsWood))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsWood))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsWood));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsWood));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsWood) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsWood);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsWood, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalMetal():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsMetal))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsMetal))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsMetal));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsMetal));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsMetal) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsMetal);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsMetal, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalEther():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsEther))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsEther))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsEther));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsEther));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsEther) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsEther);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsEther, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalPoison():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsPoison))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsPoison))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsPoison));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsPoison));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsPoison) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsPoison);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsPoison, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalPurity():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsPurity))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsPurity))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsPurity));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsPurity));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsPurity) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsPurity);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsPurity, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalCorruption():void {
			clearOutput();
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx) && (player.statusEffectv1(StatusEffects.ElementalEnergyConduits) >= ((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsCorruption))/4))) player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-((rankUpElementalElementalEnergyCost()*player.statusEffectv2(StatusEffects.SummonedElementalsCorruption))/4));
			else {
				useMana(rankUpElementalManaCost() * player.statusEffectv2(StatusEffects.SummonedElementalsCorruption));
				fatigue(rankUpElementalFatigueCost() * player.statusEffectv2(StatusEffects.SummonedElementalsCorruption));
				statScreenRefresh();
			}
			rankUpElementalPart1();
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsCorruption) * 25) summmast += 25;
			else summmast += player.wis / player.statusEffectv2(StatusEffects.SummonedElementalsCorruption);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("The outraged elemental start by struggling but unable to defeat its binding let go and stand still awaiting your commands. Their duty fulfilled, the binding runes fades disappearing into the elemental until you call upon them again. \"<b>The ritual is complete and your elemental empowered as such!</b>\"");
				player.addStatusValue(StatusEffects.SummonedElementalsCorruption, 2, 1);
			}
			else failToRankUpElemental();
			doNext(elementaLvlUp);
			eachMinuteCount(30);
		}
		private function rankUpElementalManaCost():Number {
			var rankUpElementalManaCost:Number = 100;
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledge)) rankUpElementalManaCost -= 40;
			return rankUpElementalManaCost;
		}
		private function rankUpElementalFatigueCost():Number {
			var rankUpElementalFatigueCost:Number = 50;
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledge)) rankUpElementalFatigueCost -= 20;
			return rankUpElementalFatigueCost;
		}
		private function rankUpElementalElementalEnergyCost():Number {
			var rankUpElementalElementalEnergyCost:Number = 1200;
			return rankUpElementalElementalEnergyCost;
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
			HPChange(-(Math.round(player.HP * failToRankUpHPCost())), true);
		}
		private function failToRankUpHPCost():Number {
			var failure:Number = 0.5;
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledge)) failure -= 0.2;
			return failure;
		}
		private function rankUpElementalAirEpic():void {
			clearOutput();
			player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-(player.statusEffectv2(StatusEffects.SummonedElementalsAirE) * rankUpElementalElementalEnergyCost()));
			outputText("Finally feeling like you could coax a little more power out of your Epic Air elemental, you begin drawing runes in your magic circle, far more intricate than your older, lesser rituals.\n\n");
			outputText("You start with three circles, offset from the very center of the magic circle. Each with a slightly different color of light-blue. Each circle consists of the \"Control\" rune, of uniform size, each running into the next with no space between them.\n\n");
			outputText("Spiraling runes of black, white and grey come next, coming out from the center and wrapping around the group of three circles, binding them together. \"Power\" forms the majority of them, but you throw in \"flow\" and \"wind\" periodically, each of those runes forming their own miniature swirl of runes. ");
			outputText("Finally, at the edge, \"Movement\", and \"Freedom\" runes adorn the outside edge. With that last step completed, you sit, mentally calling for your Epic Air elemental.\n\n");
			outputText("A swirl of air, barely more than a breeze, forms into solid mass, your epic air elemental, its arms folded, stares at you.\n\n");
			outputText("\"<i>What is the meaning of this containment?</i>\" It looks down at the clearly magical circle. You explain that it’s time to upgrade its power.\n\n");
			outputText("\"<i>So even the most abhorrent creations serve a purpose. Very well.</i>\"\n\n");
			outputText("You call to your power, magic enfusing the runes in the middle. Your three circles shoot up, growing larger at the top, and shrinking down into the three small circles at the ground. Your waves of spiralling runes are taken with them, ");
			outputText("the trails of different colored runes bleeding into each other, lashing in dizzying, chaotic flows. In the center, in the middle of those three runic tornadoes, your epic air elemental raises its hands, calm in the eye of your storm.\n\n");
			outputText("<i>Winds howl, the sky’s fury made will. Land and Sea bow before it.</i> Lightning strikes your runes, and the wind howls, nearly picking you up off the ground. <i>Breath of life, storm of Death, the line between them ragged and torn.</i>\n\n");
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsAirE) * 100) summmast += 25;
			else summmast += player.wis / (player.statusEffectv2(StatusEffects.SummonedElementalsAirE) * 4);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("Your storm, as quickly as it had formed, is drawn into the center. The three howling tornadoes shrink into one, then are pulled down, down further, back towards the ground. Your runes wrap around the wrists of your epic air elemental, and are absorbed, bit by bit, into the creature’s body.\n\n");
				outputText("\"<i>But in that uncertainty lies power, for the bold...or the foolish.</i>\" Your epic air elemental begins to fade into ethereality, a bit bigger than before. \"<i>Call upon me soon, [master].</i>\"\n\n");
				player.addStatusValue(StatusEffects.SummonedElementalsAirE, 2, 1);
			}
			else {
				outputText("Your magic circle groans, your control runes warping. You watch in horror as one of your runes is pulled in between two of the three swirling vortexes...and is promptly torn to shreds. As if a switch had been pulled, the winds explode in a howling, screaming force, throwing you away from the circle. ");
				outputText("You hit a rock back-first, and as you sit there, dazed, the figure of your epic air elemental lowers itself in front of you.\n\n");
				outputText("\"<i>The storm seems to have failed to claim you. Good. Call upon the winds once more, once you have recovered.</i>\" Your epic air elemental fades from view, a light warm breeze blowing past your face.\n\n");
				HPChange(-(Math.round(player.HP * failToRankUpHPCost())), true);
			}
			doNext(elementaLvlUpEpic);
			eachMinuteCount(45);
		}
		private function rankUpElementalEarthEpic():void {
			clearOutput();
			player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-(player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) * rankUpElementalElementalEnergyCost()));
			outputText("Finally feeling like you could coax a little more power out of your Epic Earth elemental, you begin drawing runes in your magic circle, far more intricate than your older, lesser rituals.\n\n");
			outputText("First, you coat the outside of the circle in green ink, stenciling in \"Control\". Nodes of brown and grey runes, clumped into seemingly random spots along the summoning circle, spell \"Power\". On completion, each rune shakes a little before stopping, in a slightly different place than you drew it in.\n\n");
			outputText("\"Ground\", \"Earth\" and \"Stone\" runes line the inner layers, painted in red, blue and green. As you finish each one, it begins to shine from within, and you can see the stone you painted it on, underneath.\n\n");
			outputText("Finally, a layer of gold-colored runes in the very center, spiraling out. The runes shine, glittering as if a spotlight was shone on a gold bar.\n\n");
			outputText("Encouraged, you call out to your epic earth elemental.\n\n");
			outputText("\"<i>You called?</i>\" Rising from within the circle, your epic earth elemental pops from the ground. Her eyes are gemstones, red and green, and a simple ring of sapphires adorn what would be her ‘neck’. Other than that, your elemental looks like a well-made statue of a nubile young woman. She sits in the circle, feminine legs crossed, and tilts her head as your elemental considers you.\n\n");
			outputText("\"<i>What needs to be swallowed?</i>\" You tell your epic earth elemental that you are preparing to draw out more of its power. Its gem eyes light up, and you swear you could see a smile on its face.\n\n");
			outputText("\"<i>Let us begin, then!</i>\" Your earth elemental stands, folding her arms over her ample chest and looking down at the runes below.\n\n");
			outputText("You call out to your power, mana visibly clumping into pieces, then latching themselves onto your runes. As you pour more mana into the ritual, a gold band forms, rising from the inner circle and spinning rapidly. Your control runes shoot up, carried by crude spikes of stone that curve inwards, forming a mountainous cocoon around your circle and blocking out the light.\n\n");
			outputText("Your flickering, glowing runes in the inner circle are the next to rise, floating in midair. Despite the darkness, they shine with an inner light, almost like enchanted gemstones. The rocks around you stop shaking, and for a moment, all is still.\n\n");
			outputText("\"<i>Gold, Gems, Plant, Animal: All come from the cradle of the earth. And to Earth they all return...</i>\"\n\n");
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) * 100) summmast += 25;
			else summmast += player.wis / (player.statusEffectv2(StatusEffects.SummonedElementalsEarthE) * 4);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("\"<i>And the earth hungers.</i>\" The mountain crumbles, showering you and your elemental in stone. Your gemstone runes fade, and your epic earth elemental stands, arching its back as the last light from the runes shoot into its body. \"<i>Well done, [master].</i>\"\n\n");
				player.addStatusValue(StatusEffects.SummonedElementalsEarthE, 2, 1);
			}
			else {
				outputText("\"<i>Some sooner than most.</i>\" Your mountain caves inward, spikes of stone forming on the inside. You charge one side of your magic circle, and the thin spire of stone explodes outwards. Finally disrupted, the gemstones shatter, pelting you in painful shards. ");
				outputText("As the dust settles, cuts on your [skin] gushing blood, your elemental frowns, shaking its head. \"<i>A disappointment, to be sure.</i>\"\n\n");
				HPChange(-(Math.round(player.HP * failToRankUpHPCost())), true);
			}
			doNext(elementaLvlUpEpic);
			eachMinuteCount(45);
		}
		private function rankUpElementalFireEpic():void {
			clearOutput();
			player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-(player.statusEffectv2(StatusEffects.SummonedElementalsFireE) * rankUpElementalElementalEnergyCost()));
			outputText("Finally feeling like you could coax a little more power out of your Epic Fire elemental, you begin drawing runes in your magic circle, far more intricate than your older, lesser rituals. In red ink, you stencil runes reading \"power\", in thin, curving lines inside the circle. As you complete each section of the fiery pattern, you can feel the air around you heat up slightly.\n\n");
			outputText("Inside of each line, you stencil curls of \"control\" runes in orange. Each rune flickers as you complete it, making each rune slightly harder to create.\n\n");
			outputText("Yellow ink comes next: you write \"Heat\" in waves, rising from between the orange curls towards the center of the circle. As you draw each one, the center of the circle begins to shimmer, distorting what you can see through it.\n\n");
			outputText("You draw wavy lines from the center of your circle, where the heat is, twelve in total, in a white color.\n\n");
			outputText("Upon completion, the runes shift, beginning to move, flickering like the flames their design suggests. Encouraged by this, you sit in your magic circle, and call upon your Epic Fire Elemental. At your call, you feel a stirring, rising heat in your head.\n\n");
			outputText("\"<i>What shall we turn to ash, [master]?</i>\" The womanly form of your Elemental appears in the summoning circle, her face featureless except for burning yellow eyes.\n\n");
			outputText("You tell your elemental that the time has come to draw upon more of her power.\n\n");
			outputText("\"<i>How bold...Calling so much heat into the world...Very well. So it shall be...If you can handle more of me.</i>\"\n\n");
			outputText("As your elemental settles in, the flickering runes rise from the ground, the red splitting, mixing. Your elemental leans back, womanly curves setting the runes ablaze. Strings of runic power mix with the flames, the mixture wrapping around the edges of the circle. A pillar of flame and text sear the edges of the circle, reaching skyward with hungry intent.\n\n");
			outputText("\"<i>All fires wish to grow, to consume…So it has always been...</i>\"\n\n");
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsFireE) * 100) summmast += 25;
			else summmast += player.wis / (player.statusEffectv2(StatusEffects.SummonedElementalsFireE) * 4);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("Your elemental floats up, into the center of the circle. Your runes float towards her, sticking to her body, the text slowly merging with the writhing flames of her body. Quicker and quicker, the flames enter, whipping past your body. The heat rises, rises...You close your eyes as a flash of light envelops the area.\n\n");
				outputText("When you open your eyes, your epic flame elemental is lounging in midair. She seems slightly bigger than before, her flames brighter.\n\n");
				outputText("\"<i>And so it shall be. Show this world our heat. Consume what you will.</i>\" Your elemental vanishes, leaving your [skin] looking like you’d spent a week in the sun.\n\n");
				player.addStatusValue(StatusEffects.SummonedElementalsFireE, 2, 1);
			}
			else {
				outputText("The flames roar, and your elemental winces, vanishing from the circle. You watch in horror as the flames roar out of control, consuming your runes, turning them black before they vanish. The lines of your magic circle whine, barely containing the raging inferno. You wince, enduring the flames as best you can, but before it dies down, you’ve taken a lot of damage.\n\n");
				outputText("\"<i>...And it will consume those who underestimate its power. Perhaps another time, [master].</i>\"\n\n");
				HPChange(-(Math.round(player.HP * failToRankUpHPCost())), true);
			}
			doNext(elementaLvlUpEpic);
			eachMinuteCount(45);
		}
		private function rankUpElementalWaterEpic():void {
			clearOutput();
			player.addStatusValue(StatusEffects.ElementalEnergyConduits,1,-(player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) * rankUpElementalElementalEnergyCost()));
			outputText("Finally feeling like you could coax a little more power out of your Epic Water elemental, you begin drawing runes in your magic circle, far more intricate than your older, lesser rituals. You start with rolling lines of \"control\" runes, in a dark, almost black blue, then a line of lighter blue waves of \"Power\" runes, all along the outside of the circle. ");
			outputText("In the middle, you draw a single circle of \"Tide\" runes in white, with smaller circles inside.\n\nAs you complete the last of the \"Tide\" runes, you notice your white runes in the middle spin, slow at first, but picking up speed. As it does, the runes along the outside begin to move, colors mixing and flowing like water. ");
			outputText("The white keeps spinning, seemingly pulling the outer ‘waves’ along with it.\n\nYou know that the time to call upon your epic water elemental has come. You feel your mana drain, and a deep, masculine voice sounds in your head.\n\n");
			outputText("\"<i>So you call me.</i>\" Very well. Water erupts from the ground below you, quickly forming into a masculine form. Your epic water elemental stands, body shifting visibly as the tide runes below him rotate. He sits, shifting with the tides below.\n\n");
			outputText("You explain to your elemental that you can draw more power, and it nods. \"<i>So it would seem. I will not attempt to stop you.</i>\"\n\n");
			outputText("You call upon your power, and a roaring sound fills your ears. Your runes whip around inside the circle, and your waves rise, spraying up around the edges. Your white moon below begins to glow, and the water moves faster, still faster.\n\n");
			outputText("\"<i>Mighty is the great flow: For none can stand forever. The rivers flow, the oceans roar...</i>\"\n\n");
			var summmast:Number = 0;
			if (player.wis > player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) * 25) summmast += 25;
			else summmast += player.wis / (player.statusEffectv2(StatusEffects.SummonedElementalsWaterE) * 4);
			if (player.hasPerk(PerkLib.ElementalConjurerKnowledgeEx)) summmast += 25;
			if (rand(summmast) > 5) {
				outputText("Your epic elemental grabs hold of the white orb in the center of the circle. It begins to glow, and as it does, the spiraling flow of runic water comes in, closer and closer...and as it nears the orb, it vanishes, absorbed into the fluids of your epic elemental. The water roars, faster...Faster…It stings your everything, and keeping your eyes open is impossible.\n\n");
				outputText("The roaring stops. You open your eyes to see your masculine water elemental, arms crossed, and as you see it, the creature nods.\n\n");
				outputText("\"<i>But the water’s flow can be beneficial, to those who can bend.</i>\" The elemental closes its eyes. \"<i>We are more powerful. Wash away those who defy us.</i>\" It vanishes, leaving you soaking wet.\n\n");
				player.addStatusValue(StatusEffects.SummonedElementalsWaterE, 2, 1);
			}
			else {
				outputText("The moon-runes underneath you warp and groan, the white-whipped waters thrash harder. A single rune in the thrashing waves shudders...and shatters. This unleashes a wave of power that shatters your control runes. Stuck in the magic circle, you hunker down as the roaring water strikes you from every side. ");
				outputText("For what feels like hours, you sit in your circle, enduring the waves you unleashed until your power runes are spent.\n\n");
				outputText("\"<i>...and wash away those foolish enough to think they can weather the storm.</i>\" Your epic water elemental stands. \"<i>A pity, that more of my power cannot be unleashed in this realm.</i>\"\n\n");
				HPChange(-(Math.round(player.HP * failToRankUpHPCost())), true);
			}
			doNext(elementaLvlUpEpic);
			eachMinuteCount(45);
		}
		
		//-------------
		//
		//  SKELETONS
		//
		//-------------
		
		public function maxDemonBonesStored():Number {
			var maxDemonBonesStoredCounter:Number = 100;
			return maxDemonBonesStoredCounter;
		}
		public function maxSkeletonWarriors():Number {
			var maxSkeletonWarriorsCounter:Number = 0;
			if (player.hasPerk(PerkLib.PrestigeJobNecromancer)) maxSkeletonWarriorsCounter += 3;
			if (player.hasPerk(PerkLib.GreaterHarvest)) maxSkeletonWarriorsCounter += 3;
			if (player.hasPerk(PerkLib.BoneSoul)) maxSkeletonWarriorsCounter += 4;
			return maxSkeletonWarriorsCounter;
		}
		public function maxSkeletonArchers():Number {
			var maxSkeletonArchersCounter:Number = 0;
			if (player.hasPerk(PerkLib.GreaterHarvest)) maxSkeletonArchersCounter += 3;
			if (player.hasPerk(PerkLib.BoneSoul)) maxSkeletonArchersCounter += 3;
			if (player.hasPerk(PerkLib.SkeletonLord)) maxSkeletonArchersCounter += 4;
			return maxSkeletonArchersCounter;
		}
		public function maxSkeletonMages():Number {
			var maxSkeletonMagesCounter:Number = 0;
			if (player.hasPerk(PerkLib.GreaterHarvest)) maxSkeletonMagesCounter += 3;
			if (player.hasPerk(PerkLib.BoneSoul)) maxSkeletonMagesCounter += 3;
			if (player.hasPerk(PerkLib.SkeletonLord)) maxSkeletonMagesCounter += 4;
			return maxSkeletonMagesCounter;
		}
		
		public function accessMakeSkeletonWinionsMainMenu():void {
			clearOutput();
			outputText("What skeleton would you like to make?\n\n");
			outputText("<b>Stored Demon Bones:</b> " + player.perkv1(PerkLib.PrestigeJobNecromancer) + " / " + maxDemonBonesStored() + "\n");
			outputText("<b>Skeleton Warriors:</b> " + player.perkv2(PerkLib.PrestigeJobNecromancer) + " / " + maxSkeletonWarriors() + "\n");
			if (player.hasPerk(PerkLib.GreaterHarvest)) {
				outputText("<b>Skeleton Archers:</b> " + player.perkv1(PerkLib.GreaterHarvest) + " / " + maxSkeletonArchers() + "\n");
				outputText("<b>Skeleton Mages:</b> " + player.perkv2(PerkLib.GreaterHarvest) + " / " + maxSkeletonMages() + "\n");
			}
			menu();
			if (player.perkv1(PerkLib.PrestigeJobNecromancer) >= 20 && player.soulforce >= 5000) {
				addButton(0, "C.Skeleton(W)", createSkeletonWarrior).hint("Create Skeleton Warrior.");
				if (player.hasPerk(PerkLib.GreaterHarvest)) {
					if (player.perkv1(PerkLib.PrestigeJobNecromancer) > 0) {
						if (player.perkv2(PerkLib.PrestigeJobNecromancer) > 0) addButton(1, "C.Skeleton(A)", createSkeletonArcher).hint("Create Skeleton Archer.");
						else addButtonDisabled(1, "C.Skeleton(A)", "Req. to create at least 1 Skeleton Warrior before creating Skeleton Archer.");
						if (player.perkv1(PerkLib.GreaterHarvest) > 0) addButton(2, "C.Skeleton(M)", createSkeletonMage).hint("Create Skeleton Mage.");
						else addButtonDisabled(2, "C.Skeleton(M)", "Req. to create at least 1 Skeleton Archer before creating Skeleton Mage.");
					}
				}
				else {
					addButtonDisabled(1, "???", "Req. Greater harvest perk to unlock this option.");
					addButtonDisabled(2, "???", "Req. Greater harvest perk to unlock this option.");
				}
				
			}
			else {
				addButtonDisabled(0, "C.Skeleton(W)", "You lack required amont of demon bones (20+) and/or soulforce (5000+) to create skeleton warrior.");
				if (player.hasPerk(PerkLib.GreaterHarvest)) {
					addButtonDisabled(1, "C.Skeleton(A)", "You lack required amont of demon bones (20+) and/or soulforce (5000+) to create skeleton archer.");
					addButtonDisabled(2, "C.Skeleton(M)", "You lack required amont of demon bones (20+) and/or soulforce (5000+) to create skeleton mage.");
				}
				else {
					addButtonDisabled(1, "???", "Req. Greater harvest perk to unlock this option.");
					addButtonDisabled(2, "???", "Req. Greater harvest perk to unlock this option.");
				}
			}
			addButton(14, "Back", camp.campWinionsArmySim);
		}
		
		public function createSkeletonWarrior():void {
			clearOutput();
			if (player.perkv2(PerkLib.PrestigeJobNecromancer) == maxSkeletonWarriors()) {
				outputText("You already got as many Skeleton Warriors as you could realistically control.");
				doNext(accessMakeSkeletonWinionsMainMenu);
				return;
			}
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, -20);
			player.soulforce -= 5000;
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of bone that will soon be your servant. Once done you stand back and begin to seep your soulforce inside of the pile aligning joints together into a large 10 feet tall shape. Finishing the link on your creation you begin to feel its every movement on your fingertips. Satisfied you admire your brand new Skeleton Warrior, ready to fight things and do anything your finger will request.");
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 2, 1);
			doNext(accessMakeSkeletonWinionsMainMenu);
			eachMinuteCount(10);
		}
		public function createSkeletonArcher():void {
			clearOutput();
			if (player.perkv1(PerkLib.GreaterHarvest) == maxSkeletonArchers()) {
				outputText("You already got as many Skeleton Archers as you could realistically control.");
				doNext(accessMakeSkeletonWinionsMainMenu);
				return;
			}
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, -20);
			player.soulforce -= 5000;
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of bone that will soon be your servant. Once done you stand back and begin to seep your soulforce inside of the pile aligning joints together into a large 10 feet tall shape. Finishing the link on your creation you begin to feel its every movement on your fingertips. Satisfied you admire your brand new Skeleton Archer, ready to fight things and do anything your finger will request.");
			player.addPerkValue(PerkLib.GreaterHarvest, 1, 1);
			doNext(accessMakeSkeletonWinionsMainMenu);
			eachMinuteCount(10);
		}
		public function createSkeletonMage():void {
			clearOutput();
			if (player.perkv2(PerkLib.GreaterHarvest) == maxSkeletonMages()) {
				outputText("You already got as many Skeleton Mages as you could realistically control.");
				doNext(accessMakeSkeletonWinionsMainMenu);
				return;
			}
			player.addPerkValue(PerkLib.PrestigeJobNecromancer, 1, -20);
			player.soulforce -= 5000;
			statScreenRefresh();
			outputText("You draw a seal in the ground around the pile of bone that will soon be your servant. Once done you stand back and begin to seep your soulforce inside of the pile aligning joints together into a large 10 feet tall shape. Finishing the link on your creation you begin to feel its every movement on your fingertips. Satisfied you admire your brand new Skeleton Mage, ready to fight things and do anything your finger will request.");
			player.addPerkValue(PerkLib.GreaterHarvest, 2, 1);
			doNext(accessMakeSkeletonWinionsMainMenu);
			eachMinuteCount(10);
		}
	}
}

