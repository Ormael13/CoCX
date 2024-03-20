/**
 * Coded by Ormael on 31.01.2019.
 */
package classes.Scenes.Combat 
{
import classes.CoC;
import classes.EngineCore;
import classes.Races;
import classes.GlobalFlags.kFLAGS;
import classes.IMutations.IMutationsLib;
import classes.Scenes.SceneLib;
import classes.Scenes.NPCs.TyrantiaFollower;
import classes.PerkLib;
import classes.StatusEffects;
import classes.StatusEffects.VampireThirstEffect;

	public class CombatFollowersActions extends BaseCombatContent
	{
		
		public function CombatFollowersActions() {
		}
		
		public function increasedEfficiencyOfAttacks():Number {
			var IEoA:Number = 0;
			if (player.hasPerk(PerkLib.Motivation)) {
				IEoA += 0.5;
			}
			if (player.hasPerk(PerkLib.MotivationEx)) {
				if (player.level >= 6) IEoA += 0.5;
				if (player.level >= 27) IEoA += 0.5;
				if (player.level >= 54) IEoA += 0.5;
				if (player.level >= 102) IEoA += 0.5;
			}
			if (player.hasPerk(PerkLib.MotivationSu)) IEoA *= 1.5;
			IEoA += 1;
			//ITEMS EFFEC TS? MISC ACC / RINGS / NECK / HEAD ACC, WEAPON?
			return IEoA;
		}

		public function neisaCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerNeisa) > 0) {
				var choice1:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) neisaCombatActions0();
					else {
						if (choice1 < 5) neisaCombatActions1();
						if (choice1 >= 5 && choice1 < 10) neisaCombatActions2();
						if (choice1 >= 10 && choice1 < 15) neisaCombatActions3();
						if (choice1 >= 15) neisaCombatActions4();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice1 < 4) neisaCombatActions0();
					if (choice1 >= 4 && choice1 < 11) neisaCombatActions1();
					if (choice1 >= 11 && choice1 < 16) neisaCombatActions2();
					if (choice1 >= 16 && choice1 < 19) neisaCombatActions3();
					if (choice1 == 19) neisaCombatActions4();
				}
				else {
					if (choice1 < 10) neisaCombatActions0();
					if (choice1 >= 10 && choice1 < 14) neisaCombatActions1();
					if (choice1 >= 14 && choice1 < 17) neisaCombatActions2();
					if (choice1 == 17 || choice1 == 18) neisaCombatActions3();
					if (choice1 == 19) neisaCombatActions4();
				}
			}
			else {
				outputText("Neisa steps forward, shield at the ready in order to defend you.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerNeisa, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function neisaCombatActions0():void {
			outputText("Neisa looks for an opening in the battle.\n\n");
		}
		public function neisaCombatActions1():void {
			var dmg1:Number = player.statusEffectv1(StatusEffects.CombatFollowerNeisa);
			var weaponNeisa:Number = player.statusEffectv2(StatusEffects.CombatFollowerNeisa);
			dmg1 += scalingBonusStrengthCompanion() * 0.5;
			if (weaponNeisa < 51) dmg1 *= (1 + (weaponNeisa * 0.03));
			else if (weaponNeisa >= 51 && weaponNeisa < 101) dmg1 *= (2.5 + ((weaponNeisa - 50) * 0.025));
			else if (weaponNeisa >= 101 && weaponNeisa < 151) dmg1 *= (3.75 + ((weaponNeisa - 100) * 0.02));
			else if (weaponNeisa >= 151 && weaponNeisa < 201) dmg1 *= (4.75 + ((weaponNeisa - 150) * 0.015));
			else dmg1 *= (5.5 + ((weaponNeisa - 200) * 0.01));
			dmg1 = Math.round(dmg1 * increasedEfficiencyOfAttacks());
			outputText("Neisa slashes at [themonster] with her sword. ");
			doDamage(dmg1, true, true);
			outputText("\n\n");
		}
		public function neisaCombatActions2():void {
			outputText("Neisa moves in front of you, deflecting the opponent’s attacks with her shield in order to assist your own defence.\n\n");
			player.createStatusEffect(StatusEffects.CompBoostingPCArmorValue, 0, 0, 0, 0);
		}
		public function neisaCombatActions3():void {
			outputText("Neisa smashes her shield on [themonster]’s head, ");
			if (!monster.hasPerk(PerkLib.Resolute)) {
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				outputText("stunning it.\n\n");
			} else {
				outputText("but the enemy endured it.\n\n");
			}
		}
		public function neisaCombatActions4():void {
			outputText("Neisa viciously rams her shield on [themonster], ");
			if (!monster.hasPerk(PerkLib.Resolute)) {
				monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				outputText("dazing it.\n\n");
			} else {
				outputText("but the enemy endured it.\n\n");
			}
		}
		
		public function dianaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerDiana) > 0) {
				var choice2:Number = rand(20);
				if (choice2 < 10) outputText("\n\n");
				if (choice2 >= 10 && choice2 < 14) outputText("\n\n");
				if (choice2 >= 14 && choice2 < 17) outputText("\n\n");
				if (choice2 == 17 || choice2 == 18) outputText("\n\n");
				if (choice2 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerDiana, 4, 1);
			}
		}
		public function dianaCombatActions0():void {

		}
		public function dianaCombatActions1():void {

		}
		public function dianaCombatActions2():void {

		}
		public function dianaCombatActions3():void {

		}
		
		public function nadiaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerNadia) > 0) {
				var choice2:Number = rand(20);
				if (choice2 < 10) outputText("\n\n");
				if (choice2 >= 10 && choice2 < 14) outputText("\n\n");
				if (choice2 >= 14 && choice2 < 17) outputText("\n\n");
				if (choice2 == 17 || choice2 == 18) outputText("\n\n");
				if (choice2 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerNadia, 4, 1);
			}
		}
		public function nadiaCombatActions0():void {

		}
		public function nadiaCombatActions1():void {

		}
		public function nadiaCombatActions2():void {

		}
		public function nadiaCombatActions3():void {

		}
		
		public function etnaCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerEtna) > 0) {
				var choice3:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) etnaCombatActions0();
					else {
						if (choice3 < 7) etnaCombatActions1();
						if (choice3 >= 7 && choice3 < 15) etnaCombatActions2();
						if (choice3 >= 15) etnaCombatActions3();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice3 < 4) etnaCombatActions0();
					if (choice3 >= 4 && choice3 < 10) etnaCombatActions1();
					if (choice3 >= 10 && choice3 < 16) etnaCombatActions2();
					if (choice3 >= 16) etnaCombatActions3();
				}
				else {
					if (choice3 < 10) etnaCombatActions0();
					if (choice3 >= 10 && choice3 < 14) etnaCombatActions1();
					if (choice3 >= 14 && choice3 < 18) etnaCombatActions2();
					if (choice3 >= 18) etnaCombatActions3();
				}
			}
			else {
				outputText("Etna takes flight, her tail taking aim at [themonster], ready for aerial bombardment.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerEtna, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function etnaCombatActions0():void {
			outputText("Etna flies around, looking for an opportunity to strike.\n\n");
		}
		public function etnaCombatActions1():void {
			var lustDmg:Number = Math.round((player.statusEffectv2(StatusEffects.CombatFollowerEtna) / 6) * increasedEfficiencyOfAttacks());
			outputText("Etna shoots a spike at [themonster], you can see the telltale sign of arousal in [monster his] movement. ");
			monster.teased(Math.round(monster.lustVuln * lustDmg));
			outputText("\n\n");
		}
		public function etnaCombatActions2():void {
			var dmg2:Number = player.statusEffectv1(StatusEffects.CombatFollowerEtna);
			dmg2 += scalingBonusStrengthCompanion() * 0.5;
			dmg2 = Math.round(dmg2 * increasedEfficiencyOfAttacks());
			outputText("Etna dives at [themonster], mauling [monster his] viciously with her claws before taking flight again. ");
			doDamage(dmg2, true, true);
			outputText("\n\n");
		}
		public function etnaCombatActions3():void {
			outputText("Etna dives at [themonster] and crashes boob first into [monster his] face, ");
			if (!monster.hasPerk(PerkLib.Resolute)) {
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				outputText("staggering it before taking flight again.\n\n");
			} else {
				outputText("but the enemy shook off the blow.\n\n");
			}
		}
		
		public function auroraCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerAurora) > 0) {
				var choice4:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) auroraCombatActions0();
					else {
						if (choice4 < 5) auroraCombatActions1();
						if (choice4 >= 5 && choice4 < 10) auroraCombatActions2();
						if (choice4 >= 10 && choice4 < 15) auroraCombatActions3();
						if (choice4 >= 15) auroraCombatActions4();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice4 < 4) auroraCombatActions0();
					if (choice4 >= 4 && choice4 < 11) auroraCombatActions1();
					if (choice4 >= 11 && choice4 < 15) auroraCombatActions2();
					if (choice4 >= 15 && choice4 < 18) auroraCombatActions3();
					if (choice4 >= 18) auroraCombatActions4();
				}
				else {
					if (choice4 < 10) auroraCombatActions0();
					if (choice4 >= 10 && choice4 < 13) auroraCombatActions1();
					if (choice4 >= 13 && choice4 < 16) auroraCombatActions2();
					if (choice4 == 16 || choice4 == 17) auroraCombatActions3();
					if (choice4 >= 18) auroraCombatActions4();
				}
			}
			else {
				outputText("Aurora assume combat stance.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerAurora, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Aurora" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Aurora" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Aurora" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function auroraCombatActions0():void {
			outputText("Aurora look for an opening in the battle.\n\n");
		}
		public function auroraCombatActions1():void {
			var dmg01:Number = player.statusEffectv1(StatusEffects.CombatFollowerAurora);
			var weaponAurora1:Number = player.statusEffectv3(StatusEffects.CombatFollowerAurora);
			dmg01 += scalingBonusStrengthCompanion() * 0.5;
			if (weaponAurora1 < 51) dmg01 *= (1 + (weaponAurora1 * 0.03));
			else if (weaponAurora1 >= 51 && weaponAurora1 < 101) dmg01 *= (2.5 + ((weaponAurora1 - 50) * 0.025));
			else if (weaponAurora1 >= 101 && weaponAurora1 < 151) dmg01 *= (3.75 + ((weaponAurora1 - 100) * 0.02));
			else if (weaponAurora1 >= 151 && weaponAurora1 < 201) dmg01 *= (4.75 + ((weaponAurora1 - 150) * 0.015));
			else dmg01 *= (5.5 + ((weaponAurora1 - 200) * 0.01));
			dmg01 = Math.round(dmg01 * increasedEfficiencyOfAttacks());
			outputText("Aurora thrust her hand at [themonster]. ");
			doDamage(dmg01, true, true);
			outputText("\n\n");
		}
		public function auroraCombatActions2():void {
			outputText("Aurora move in front of you deflecting the opponent attacks with her body in order to assist your own defence.\n\n");
			player.createStatusEffect(StatusEffects.CompBoostingPCArmorValue, 0, 0, 0, 0);
		}
		public function auroraCombatActions3():void {
			var dmg3:Number = player.statusEffectv1(StatusEffects.CombatFollowerAurora);
			var weaponAurora:Number = player.statusEffectv3(StatusEffects.CombatFollowerAurora);
			dmg3 += scalingBonusStrengthCompanion();
			if (weaponAurora < 51) dmg3 *= (1 + (weaponAurora * 0.03));
			else if (weaponAurora >= 51 && weaponAurora < 101) dmg3 *= (2.5 + ((weaponAurora - 50) * 0.025));
			else if (weaponAurora >= 101 && weaponAurora < 151) dmg3 *= (3.75 + ((weaponAurora - 100) * 0.02));
			else if (weaponAurora >= 151 && weaponAurora < 201) dmg3 *= (4.75 + ((weaponAurora - 150) * 0.015));
			else dmg3 *= (5.5 + ((weaponAurora - 200) * 0.01));
			dmg3 *= 3;
			dmg3 = Math.round(dmg3 * increasedEfficiencyOfAttacks());
			outputText("Aurora thrust her hand at [themonster]. Her claws hits thrice against [themonster], dealing ");
			doDamage(dmg3, true, true);
			outputText(" damage!\n\n");
		}
		public function auroraCombatActions4():void {
			var dmg3a:Number = (scalingBonusStrengthCompanion() + scalingBonusToughnessCompanion()) / 6;
			dmg3a = Math.round(dmg3a * increasedEfficiencyOfAttacks());
			outputText("Aurora flaps her huge bat wings at [themonster] trying to knock it down. ");
			doDamage(dmg3a, true, true);
			if (!monster.hasPerk(PerkLib.Resolute)) {
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				outputText("\n\n");
			} else {
				outputText("However, [themonster] was able to stand their ground.\n\n");
			}
		}
		
		public function ghoulishVampServCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerGVampServ) > 0) {
				var choice5:Number = rand(3);
				if (choice5 == 0) ghoulishVampServCombatActions1();
				if (choice5 == 1) ghoulishVampServCombatActions2();
				if (choice5 == 2) ghoulishVampServCombatActions3();
			}
			else {
				outputText(flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" assume combat stance.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerGVampServ, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == ""+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+"" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function ghoulishVampServCombatActions1():void {
			var dmg02:Number = player.statusEffectv1(StatusEffects.CombatFollowerGVampServ);
			var weaponGhoul1:Number = player.statusEffectv2(StatusEffects.CombatFollowerGVampServ);
			dmg02 += scalingBonusStrengthCompanion() * 0.5;
			dmg02 *= (1 + (weaponGhoul1 * 0.03));
			dmg02 = Math.round(dmg02 * increasedEfficiencyOfAttacks());
			outputText(flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" leaps into the fray, delivering a deadly slash with "+(SceneLib.ghoulishVampireServant.ghoulGender()?"her":"his")+" clawed hand. [Themonster] begins to bleed ");
			doDamage(dmg02, true, true);
			if (monster.canMonsterBleed()) {
				outputText(" profusely");
				if (monster.hasStatusEffect(StatusEffects.Hemorrhage))  monster.removeStatusEffect(StatusEffects.Hemorrhage);
                monster.createStatusEffect(StatusEffects.Hemorrhage, 5, 0.01, 0, 0);
			}
			outputText(".");
			if (player.racialScore(Races.VAMPIRE) >= 20 || player.racialScore(Races.DRACULA) >= 22) {
				outputText(" The blood being redirected and absorbed by you!");
				HPChange(dmg02, true);
				var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
				var drinked:Number = 1;
				if (player.perkv1(IMutationsLib.HollowFangsIM) >= 3) drinked += 1;
				if (player.perkv1(IMutationsLib.HollowFangsIM) >= 4) drinked += 3;
				if (player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 4) drinked *= 2;
				if (player.hasPerk(PerkLib.BloodMastery)) drinked *= 2;
				thirst.drink(drinked);
			}
			outputText("\n\n");
		}
		public function ghoulishVampServCombatActions2():void {
			outputText(flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" leaps onto your opponent, attempting to hold it in place as "+flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" tries to get in a vicious bite! ");
			if (rand(3) > 0) {
				var dmg03:Number = scalingBonusStrengthCompanion() * 0.4;
				dmg03 = Math.round(dmg03 * increasedEfficiencyOfAttacks());
				outputText("[Themonster] is pinned under your ghoulish partner's body!");
				doDamage(dmg03, true, true);
				if (!monster.hasPerk(PerkLib.Resolute)) {
					monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				} else {
					outputText("\nHowever, [Themonster] was able to get free!");
				}
			}
			else outputText("[Themonster] manages to shove your servant back!");
			outputText("\n\n");
		}
		public function ghoulishVampServCombatActions3():void {
			var dmg04:Number = scalingBonusStrengthCompanion() * 0.4;
			var weaponGhoul2:Number = player.statusEffectv2(StatusEffects.CombatFollowerGVampServ);
			dmg04 *= (1 + (weaponGhoul2 * 0.02));
			dmg04 = Math.round(dmg04 * increasedEfficiencyOfAttacks());
			outputText(flags[kFLAGS.GHOULISH_VAMPIRE_SERVANT_NAME]+" charges from a wide angle, surprising your opponent and biting straight into "+(monster.hasCock()?"his":"her")+" flesh to extract some of its soul force. The ghoul is pushed back, but still manages to steal a bite and some soul force from "+(SceneLib.ghoulishVampireServant.ghoulGender()?"her":"his")+" victim! ");
			doDamage(dmg04, true, true);
			HPChange(dmg04, true);
			EngineCore.SoulforceChange(Math.round(dmg04 * 0.2));
			var thirst:VampireThirstEffect = player.statusEffectByType(StatusEffects.VampireThirst) as VampireThirstEffect;
			var drinked:Number = 1;
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 3) drinked += 1;
			if (player.perkv1(IMutationsLib.HollowFangsIM) >= 4) drinked += 3;
			if (player.perkv1(IMutationsLib.VampiricBloodstreamIM) >= 4) drinked *= 2;
			if (player.hasPerk(PerkLib.BloodMastery)) drinked *= 2;
			thirst.drink(drinked);
			outputText("\n\n");
		}
		
		public function ayaneCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 0) {
				var choice5:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) ayaneCombatActions0();
					else {
						if (choice5 < 7) {
							if (player.HP < player.maxOverHP()) ayaneCombatActions1();
							else {
								if (rand(2) == 0) {
									if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 1) ayaneCombatActions3();
									else ayaneCombatActions2();
								}
								else ayaneCombatActions3();
							}
						}
						if (choice5 >= 7 && choice5 < 15) {
							if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 1) ayaneCombatActions3();
							else ayaneCombatActions2();
						}
						if (choice5 >= 15) ayaneCombatActions3();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice5 < 4) ayaneCombatActions0();
					if (choice5 >= 4 && choice5 < 10) {
						if (player.HP < player.maxOverHP()) ayaneCombatActions1();
						else {
							if (rand(2) == 0) {
								if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 1) ayaneCombatActions3();
								else ayaneCombatActions2();
							}
							else ayaneCombatActions3();
						}
					}
					if (choice5 >= 10 && choice5 < 16) {
						if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 1) ayaneCombatActions3();
						else ayaneCombatActions2();
					}
					if (choice5 >= 16) ayaneCombatActions3();
				}
				else {
					if (choice5 < 10) ayaneCombatActions0();
					if (choice5 >= 10 && choice5 < 14) {
						if (player.HP < player.maxOverHP()) ayaneCombatActions1();
						else {
							if (rand(2) == 0) {
								if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 1) ayaneCombatActions3();
								else ayaneCombatActions2();
							}
							else ayaneCombatActions3();
						}
					}
					if (choice5 >= 14 && choice5 < 18) {
						if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 1) ayaneCombatActions3();
						else ayaneCombatActions2();
					}
					if (choice5 >= 18) ayaneCombatActions3();
				}
			}
			else {
				outputText("Ayane takes her staff and arcane focus out, ready to assist you.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerAyane, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Ayane" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Ayane" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Ayane" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function ayaneCombatActions0():void {
			outputText("Ayane looks for an opening in the battle.\n\n");
		}
		public function ayaneCombatActions1():void {
			outputText("Ayane incants a spell and you sigh in relief as your wounds heal slightly.");
			var heal1:Number = player.statusEffectv1(StatusEffects.CombatFollowerAyane);
			heal1 += scalingBonusIntelligenceCompanion();
			heal1 *= player.statusEffectv3(StatusEffects.CombatFollowerAyane);
			//Determine if critical heal!
			var crit:Boolean = false;
			var critHeal:int = 25;
			if (rand(100) < critHeal) {
				crit = true;
				heal1 *= 1.75;
			}
			heal1 = Math.round(heal1);
			if (player.hasStatusEffect(StatusEffects.CombatWounds)) {
				if (player.statusEffectv1(StatusEffects.CombatWounds) > 0.03) player.addStatusValue(StatusEffects.CombatWounds, 1, -0.03);
				else player.removeStatusEffect(StatusEffects.CombatWounds);
			}
			outputText("<b>(<font color=\"#008000\">+" + heal1 + "</font>)</b>.");
			if (crit) outputText(" <b>*Critical Heal!*</b>");
			HPChange(heal1, false);
			outputText("\n\n");
		}
		public function ayaneCombatActions2():void {
			outputText("Ayane surges in front of you, her staff at the ready.\n\n");
			player.addStatusValue(StatusEffects.CombatFollowerAyane, 4, 1);
		}
		public function ayaneCombatActions3():void {
			outputText("Ayane spins her staff in a circle as her tails starts to move, wildly dousing [themonster] in foxfire. ");
			var damageFF:Number = player.statusEffectv1(StatusEffects.CombatFollowerAyane) + player.statusEffectv2(StatusEffects.CombatFollowerAyane);
			damageFF += (scalingBonusIntelligenceCompanion() * 0.6) + (scalingBonusWisdomCompanion() * 0.4);
			//Determine if critical hit!
			var crit:Boolean = false;
			var critChance:int = 25;
			if (monster.isImmuneToCrits() && !player.hasPerk(PerkLib.EnableCriticals)) critChance = 0;
			if (rand(100) < critChance) {
				crit = true;
				damageFF *= 1.75;
			}
			damageFF *= 0.5;
			damageFF *= (1 + ((player.statusEffectv3(StatusEffects.CombatFollowerAyane) * 2) - 2));
			//High damage to goes.
			if(monster.short == "goo-girl") damageFF = Math.round(damageFF * 1.5);
			damageFF *= 4;
			damageFF = Math.round(damageFF * increasedEfficiencyOfAttacks());
			if (monster.lustVuln == 0) {
				outputText("  It has no effect!  Ayane foe clearly does not experience lust in the same way as her.");
			}
			var lustDmg:Number = monster.lustVuln * ((player.statusEffectv1(StatusEffects.CombatFollowerAyane) / 12 + player.statusEffectv2(StatusEffects.CombatFollowerAyane) / 8) * (((player.statusEffectv3(StatusEffects.CombatFollowerAyane) * 2) / 2) + rand(monster.lib + monster.cor) / 5));
			if (monster.lust < (monster.maxLust() * 0.3)) outputText("[Themonster] squirms as the magic affects [monster him].  ");
			if (monster.lust >= (monster.maxLust() * 0.3) && monster.lust < (monster.maxLust() * 0.6)) {
				if(monster.plural) outputText("[Themonster] stagger, suddenly weak and having trouble focusing on staying upright.  ");
				else outputText("[Themonster] staggers, suddenly weak and having trouble focusing on staying upright.  ");
			}
			if (monster.lust >= (monster.maxLust() * 0.6)) {
				outputText("[Themonster]'");
				if(!monster.plural) outputText("s");
				outputText(" eyes glaze over with desire for a moment.  ");
			}
			lustDmg *= 0.125;
			lustDmg = Math.round(monster.lustVuln * lustDmg);
			monster.teased(lustDmg);
			outputText(" ");
			doFireDamage(damageFF, true, true);
			if (crit) outputText(" <b>*Critical Hit!*</b>");
			outputText("\n\n");
		}

		public function divaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerDiva) > 0) {
				var choice6:Number = rand(20);
				if (choice6 < 10) outputText("\n\n");
				if (choice6 >= 10 && choice6 < 14) outputText("\n\n");
				if (choice6 >= 14 && choice6 < 17) outputText("\n\n");
				if (choice6 == 17 || choice6 == 18) outputText("\n\n");
				if (choice6 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerDiva, 4, 1);
			}
		}
		public function divaCombatActions0():void {

		}/*
		
		public function divaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.) > 0) {
				var choice7:Number = rand(20);
				if (choice7 < 10) outputText("\n\n");
				if (choice7 >= 10 && choice7 < 14) outputText("\n\n");
				if (choice7 >= 14 && choice7 < 17) outputText("\n\n");
				if (choice7 == 17 || choice7 == 18) outputText("\n\n");
				if (choice7 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.addStatusValue(StatusEffects., 4, 1);
			}
		}*/
		
		public function alvinaCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerAlvina) > 0) {
				var choice8:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) alvinaCombatActions0();
					else {
						if (choice8 < 9) alvinaCombatActions1();
						if (choice8 >= 9 && choice8 < 12) alvinaCombatActions2();
						if (choice8 >= 12 && choice8 < 16) alvinaCombatActions3();
						if (choice8 >= 16 && choice8 < 19) alvinaCombatActions4();
						if (choice8 == 19) alvinaCombatActions5();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice8 < 4) alvinaCombatActions0();
					if (choice8 >= 4 && choice8 < 11) alvinaCombatActions1();
					if (choice8 >= 11 && choice8 < 14) alvinaCombatActions2();
					if (choice8 >= 14 && choice8 < 17) alvinaCombatActions3();
					if (choice8 >= 17 && choice8 < 19) alvinaCombatActions4();
					if (choice8 == 19) alvinaCombatActions5();
				}
				else {
					if (choice8 < 10) alvinaCombatActions0();
					if (choice8 >= 10 && choice8 < 13) alvinaCombatActions1();
					if (choice8 >= 13 && choice8 < 15) alvinaCombatActions2();
					if (choice8 >= 15 && choice8 < 17) alvinaCombatActions3();
					if (choice8 >= 17 && choice8 < 19) alvinaCombatActions4();
					if (choice8 == 19) alvinaCombatActions5();
				}
			}
			else {
				outputText("Alvina nonchalantly grabs her scythe, smirking sadistically as she opens her spellbook.\n\n");
				outputText("\"<i>I’m amused you would have me fight with you against such a lowly opponent [name]. This is a task unworthy of my time but regardless I will take great pleasure in destroying ");
				if (monster.plural) outputText("these");
				else outputText("this");
				outputText(" vermin. It's not worth me trying too hard however, just enough that I can record the results into my field experimentation book.</i>\"\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerAlvina, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function alvinaCombatActions0():void {
			outputText("Alvina is studying her spellbook, readying her next action.\n\n");
		}
		public function alvinaCombatActions1():void {
			var damage1:Number = player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
			damage1 += scalingBonusIntelligenceCompanion() * 4;
			damage1 = Math.round(damage1 * increasedEfficiencyOfAttacks());
			outputText("Alvina incants a spell and freezes the enemy solid, now's your chance! ");
			doIceDamage(damage1, true, true);
			if (!monster.hasPerk(PerkLib.Resolute)) {
				monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			} else {
				outputText("\nHowever, [Themonster] was able to break out of its prison!");
			}
			outputText("\n\n");
		}
		public function alvinaCombatActions2():void {
			var lustDmg:Number = Math.round(player.statusEffectv2(StatusEffects.CombatFollowerAlvina) / 3);
			lustDmg + (rand(player.statusEffectv3(StatusEffects.CombatFollowerAlvina) - player.statusEffectv2(StatusEffects.CombatFollowerAlvina) * 2 + monster.cor) / 3);
			lustDmg = Math.round(lustDmg * increasedEfficiencyOfAttacks());
			outputText("Alvina incants a spell and a powerful wave of lust hits [themonster], leaving it more than aroused! ");
			monster.teased(Math.round(monster.lustVuln * lustDmg));
			outputText("\n\n");
		}
		public function alvinaCombatActions3():void {
			var dmg1:Number = player.statusEffectv1(StatusEffects.CombatFollowerAlvina);
			var weaponAlvina:Number = 25;
			dmg1 += scalingBonusStrengthCompanion() * 0.5;
			if (weaponAlvina < 51) dmg1 *= (1 + (weaponAlvina * 0.03));
			else if (weaponAlvina >= 51 && weaponAlvina < 101) dmg1 *= (2.5 + ((weaponAlvina - 50) * 0.025));
			else if (weaponAlvina >= 101 && weaponAlvina < 151) dmg1 *= (3.75 + ((weaponAlvina - 100) * 0.02));
			else if (weaponAlvina >= 151 && weaponAlvina < 201) dmg1 *= (4.75 + ((weaponAlvina - 150) * 0.015));
			else dmg1 *= (5.5 + ((weaponAlvina - 200) * 0.01));
			dmg1 = Math.round(dmg1 * increasedEfficiencyOfAttacks());
			outputText("Alvina slices at [themonster] with her scythe, leaving deep wounds. ");
			doDamage(dmg1, true, true);
			outputText("\n\n");
			if (!monster.isImmuneToBleed()) {
				if (monster.hasStatusEffect(StatusEffects.Hemorrhage2)) monster.addStatusValue(StatusEffects.Hemorrhage2, 1, 1);
				else monster.createStatusEffect(StatusEffects.Hemorrhage2, 3, 0.1, 0, 0);
			}
		}
		public function alvinaCombatActions4():void {
			var damage2:Number = player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
			damage2 += scalingBonusIntelligenceCompanion() * 4;
			damage2 = Math.round(damage2 * increasedEfficiencyOfAttacks());
			if (monster.plural) damage2 *= 5;
			outputText("Alvina sighs in annoyance and tosses a fireball which explodes on impact, setting "+(monster.plural ? "all ":"")+"the enem"+(monster.plural ? "ies ":"y")+" on fire!\n\n");
			doFireDamage(damage2);
			if (!monster.hasPerk(PerkLib.Resolute)) {
				monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
			} else {
				outputText("However, [Themonster] quickly regains their bearings!\n\n");
			}
		}
		public function alvinaCombatActions5():void {
			var dmg:Number = player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
			dmg += scalingBonusIntelligenceCompanion() * 40;
			dmg = Math.round(dmg * increasedEfficiencyOfAttacks());
			outputText("Alvina is looking terribly bored.\n\n");
			outputText("\"<i>[name] I am seriously going to fall asleep at this rate so if you would let me handle this...</i>\"\n\n");
			outputText("Without any warning she opens both hands, her scythe floating by her side as she gets to work, tracing a pattern in the air as the very reality in front of you collapses! You watch in horror and awe as a swirling hole of empty blackness pulls your opponent into what looks to be a null space between dimensions. ");
			outputText(monster.capitalA + monster.short + " reappears a few seconds later with gashes and wounds all over as the black hole, for what else could it be, collapses on itself and explodes in a deflagration of black magic so strong you are pushed back a few meters. ");
			doMagicDamage(dmg, true, true);
			outputText("\n\n");
		}
		
		public function mitziCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerMitzi) > 0) {
				var choice9:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) mitziCombatActions0();
					else {
						if (choice9 < 9) mitziCombatActions1();
						if (choice9 >= 9 && choice9 < 14) mitziCombatActions2();
						if (choice9 >= 14 && choice9 < 17) mitziCombatActions3();
						if (choice9 >= 17) mitziCombatActions4();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice9 < 4) mitziCombatActions0();
					if (choice9 >= 4 && choice9 < 12) mitziCombatActions1();
					if (choice9 >= 12 && choice9 < 15) mitziCombatActions2();
					if (choice9 >= 15 && choice9 < 18) mitziCombatActions3();
					if (choice9 == 18 || choice9 == 19) mitziCombatActions4();
				}
				else {
					if (choice9 < 10) mitziCombatActions0();
					if (choice9 >= 10 && choice9 < 14) mitziCombatActions1();
					if (choice9 == 14 || choice9 == 15) mitziCombatActions2();
					if (choice9 == 16 || choice9 == 17) mitziCombatActions3();
					if (choice9 == 18 || choice9 == 19) mitziCombatActions4();
				}
			}
			else {
				outputText("Mitzi grabs a couple needles off her belt along with her daughters and adopts a fighting stance.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerMitzi, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Mitzi" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Mitzi" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Mitzi" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function mitziCombatActions0():void {
			outputText("Mitzi and her daughters stand by, waiting for an opportunity to attack.\n\n");
		}
		public function mitziCombatActions1():void {
			var dmg4:Number = player.statusEffectv1(StatusEffects.CombatFollowerMitzi);
			dmg4 += scalingBonusStrengthCompanion() * 0.5;
			dmg4 = Math.round(dmg4 * increasedEfficiencyOfAttacks());
			outputText("Mitzi takes a couple needles from her belt then hurls them at [themonster]. ");
			doDamage(dmg4, true, true);
			outputText("\n\n");
		}
		public function mitziCombatActions2():void {
			outputText("Lildea pulls out a bubbling vial of a green liquid then tosses at [themonster]. The vial shatters on contact, causing the contents to spill onto [monster him]. ");
			if (!monster.hasPerk(PerkLib.EnemyConstructType) || !monster.hasPerk(PerkLib.EnemyGhostType)) {
				doPoisonDamage((((player.statusEffectv2(StatusEffects.CombatFollowerMitzi)/4)+20)*increasedEfficiencyOfAttacks()), true, true);
				outputText("\n\n");
				if (monster.hasStatusEffect(StatusEffects.PoisonDoTH)) monster.addStatusValue(StatusEffects.PoisonDoTH, 1, 1);
				else monster.createStatusEffect(StatusEffects.PoisonDoTH, 4, 0.02, 0, 0);
			}
		}
		public function mitziCombatActions3():void {
			var lustDmg:Number = Math.round((player.statusEffectv3(StatusEffects.CombatFollowerMitzi) / 6) * increasedEfficiencyOfAttacks());
			outputText("Furxia throws out a barrage of aphrodisia laced needles at [themonster]. ");
			monster.teased(Math.round(monster.lustVuln * lustDmg));
			outputText("\n\n");
		}
		public function mitziCombatActions4():void {
			outputText("Roxy whips out two circular glass bottles filled with a pink liquid. She tosses them at [themonster] releasing a cloud of pink fog around [monster him]. ");
			monster.teased(Math.round(monster.lustVuln * (rand(player.statusEffectv3(StatusEffects.CombatFollowerMitzi)/4)+20) * increasedEfficiencyOfAttacks()));
			outputText("\n\n");
			if (monster.hasStatusEffect(StatusEffects.LustDoTH)) monster.addStatusValue(StatusEffects.LustDoTH,1,1);
			else monster.createStatusEffect(StatusEffects.LustDoTH,4,0.02,0,0);
		}
		
		public function excelliaCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerExcellia) > 0) {
				if (player.HP < player.maxHP() * .5) excelliaCombatActions5();
				else {
					var choice10:Number = rand(20);
					if (player.hasPerk(PerkLib.MotivationEx)) {
						if (rand(100) == 0) excelliaCombatActions0();
						else {
							if (choice10 < 9) excelliaCombatActions1();
							if (choice10 >= 9 && choice10 < 14) excelliaCombatActions2();
							if (choice10 >= 14 && choice10 < 17) excelliaCombatActions3();
							if (choice10 >= 17) excelliaCombatActions4();
						}
					}
					else if (player.hasPerk(PerkLib.Motivation)) {
						if (choice10 < 4) excelliaCombatActions0();
						if (choice10 >= 4 && choice10 < 12) excelliaCombatActions1();
						if (choice10 >= 12 && choice10 < 15) excelliaCombatActions2();
						if (choice10 >= 15 && choice10 < 18) excelliaCombatActions3();
						if (choice10 == 18 || choice10 == 19) excelliaCombatActions4();
					}
					else {
						if (choice10 < 10) excelliaCombatActions0();
						if (choice10 >= 10 && choice10 < 14) excelliaCombatActions1();
						if (choice10 == 14 || choice10 == 15) excelliaCombatActions2();
						if (choice10 == 16 || choice10 == 17) excelliaCombatActions3();
						if (choice10 == 18 || choice10 == 19) excelliaCombatActions4();
					}
				}
			}
			else {
				outputText("Excellia drops into a fighting stance, ready to take on [themonster].\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerExcellia, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Excellia" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Excellia" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Excellia" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function excelliaCombatActions0():void {
			outputText("Excellia glares at [themonster], looking for an opportunity to strike\n\n");
		}
		public function excelliaCombatActions1():void {
			var dmg7:Number = player.statusEffectv1(StatusEffects.CombatFollowerExcellia);
			dmg7 += scalingBonusStrengthCompanion() * 0.5;
			dmg7 = Math.round(dmg7 * increasedEfficiencyOfAttacks());
			outputText("Excellia moos out as she charges at [themonster] at full force, delivering a devastating blow. ");
			doDamage(dmg7, true, true);
			outputText("\n\n");
		}
		public function excelliaCombatActions2():void {
			var dmg8:Number = player.statusEffectv1(StatusEffects.CombatFollowerExcellia);
			dmg8 += scalingBonusStrengthCompanion() * 0.7;
			dmg8 = Math.round(dmg8 * increasedEfficiencyOfAttacks());
			outputText("Excellia lunges at [themonster], throwing her full weight at [monster him] for ");
			doDamage(dmg8, true, true);
			outputText(" damage.\n\n");
		}
		public function excelliaCombatActions3():void {
			var dmg9:Number = Math.round(player.statusEffectv2(StatusEffects.CombatFollowerExcellia) * increasedEfficiencyOfAttacks());
			outputText("Excellia smirks as she stares down [themonster]. She lunges at [monster him] with a hip check, effectively knocking back and dazing [monster him]. ");
			doDamage(dmg9, true, true);
			outputText("\n\n");
			if (!monster.hasStatusEffect(StatusEffects.LoweredAccuracy)) monster.createStatusEffect(StatusEffects.LoweredAccuracy, 40, 0, 0, 0);
		}
		public function excelliaCombatActions4():void {
			var dmg10:Number = player.statusEffectv1(StatusEffects.CombatFollowerExcellia);
			var unarmedExcellia:Number = player.statusEffectv2(StatusEffects.CombatFollowerExcellia);
			unarmedExcellia *= (1.6 + 0.15 * rand(7));
			dmg10 += scalingBonusStrengthCompanion();
			dmg10 += unarmedExcellia * 2;
			dmg10 = Math.round(dmg10 * increasedEfficiencyOfAttacks());
			outputText("Excellia lets out a battle cry as she charges at [themonster]. She thrashes, headbutts, and kicks [monster him] with one powerful blow after another. ");
			doDamage(dmg10, true, true);
			outputText("\n\n");
		}
		public function excelliaCombatActions5():void {
			outputText("Excellia gasps when notices that you're hurt.\n\n");
			outputText("\"<i>[name]! Hang on!</i>\"\n\n");
			outputText("She quickly grabs you and shoves you down onto one of her leaking nipples. The restorative milk squirts into your mouth, giving you a burst of energy and healing some of your wounds.\n\n");
			HPChange(Math.round(player.maxHP() * .25), true);
            dynStats("lus", 5, "scale", false);
            fatigue(-50);
		}
		
		public function amilyCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerAmily) > 0) {
				var choice11:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) amilyCombatActions0();
					else {
						if (choice11 < 9) amilyCombatActions1();
						if (choice11 >= 9 && choice11 < 14) amilyCombatActions2();
						if (choice11 >= 14 && choice11 < 17) amilyCombatActions3();
						if (choice11 >= 17) amilyCombatActions4();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice11 < 4) amilyCombatActions0();
					if (choice11 >= 4 && choice11 < 12) amilyCombatActions1();
					if (choice11 >= 12 && choice11 < 15) amilyCombatActions2();
					if (choice11 >= 15 && choice11 < 18) amilyCombatActions3();
					if (choice11 == 18 || choice11 == 19) amilyCombatActions4();
				}
				else {
					if (choice11 < 10) amilyCombatActions0();
					if (choice11 >= 10 && choice11 < 14) amilyCombatActions1();
					if (choice11 == 14 || choice11 == 15) amilyCombatActions2();
					if (choice11 == 16 || choice11 == 17) amilyCombatActions3();
					if (choice11 == 18 || choice11 == 19) amilyCombatActions4();
				}
			}
			else {
				outputText("Amily takes cover, ready to bombard [themonster] with blow darts and blades while hidden from view.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerAmily, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Amily" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Amily" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Amily" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function amilyCombatActions0():void {
			outputText("Amily remains hidden, making sure she has escaped from sight.\n\n");
		}
		public function amilyCombatActions1():void {
			var dmg5:Number = player.statusEffectv1(StatusEffects.CombatFollowerAmily);
			dmg5 += scalingBonusStrengthCompanion() * 0.5;
			dmg5 = Math.round(dmg5 * increasedEfficiencyOfAttacks());
			outputText("Amily peeks out from her cover before shooting a blowdart at [themonster]. ");
			doDamage(dmg5, true, true);
			outputText("\n\n");
		}
		public function amilyCombatActions2():void {
			outputText("Amily peeks out from her cover, taking careful aim as she shoots a blow dart at [themonster]’s eyes. ");
			monster.createStatusEffect(StatusEffects.Blind, 2, 0, 0, 0);
			if (rand(3) == 0 || monster.hasPerk(PerkLib.Resolute)) outputText("[Themonster] shakes off the blow, but they’re still blinded from the impact.\n\n");
			else {
				outputText("[Themonster] recoils as they’re momentarily disoriented.");
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			}
		}
		public function amilyCombatActions3():void {
			outputText("Amily peeks out from her cover, shooting a poisoned dart, debilitating the enemy.\n\n");
			if (monster.hasStatusEffect(StatusEffects.EnemyLoweredDamageH)) monster.addStatusValue(StatusEffects.EnemyLoweredDamageH,1,1);
			else monster.createStatusEffect(StatusEffects.EnemyLoweredDamageH,3,40,0,0);
		}
		public function amilyCombatActions4():void {
			var dmg6:Number = player.statusEffectv1(StatusEffects.CombatFollowerAmily);
			dmg6 += scalingBonusStrengthCompanion() * 2;
			dmg6 = Math.round(dmg6 * increasedEfficiencyOfAttacks());
			outputText("Amily rushes out with her dagger. Blitzing through, she slices through them with a flurry of swift cuts before leaping off of them, away from view. ");
			doDamage(dmg6, true, true);
			outputText(" ");
			if (!monster.hasPerk(PerkLib.EnemyConstructType) || !monster.hasPerk(PerkLib.EnemyGhostType)) {
				doPoisonDamage(((player.statusEffectv2(StatusEffects.CombatFollowerAmily)/4)+20), true, true);
				outputText("\n\n");
				if (!monster.isImmuneToBleed()) {
				  if (monster.hasStatusEffect(StatusEffects.Hemorrhage2)) monster.addStatusValue(StatusEffects.Hemorrhage2, 1, 1);
				  else monster.createStatusEffect(StatusEffects.Hemorrhage2, 3, 0.1, 0, 0);
				}
				if (monster.hasStatusEffect(StatusEffects.PoisonDoTH)) monster.addStatusValue(StatusEffects.PoisonDoTH,1,1);
				else monster.createStatusEffect(StatusEffects.PoisonDoTH,4,0.02,0,0);
			}
		}
		
		public function siegweirdCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerSiegweird) > 0) {
				var choice12:Number = rand(20);
				if (choice12 < 10) outputText("\n\n");
				if (choice12 >= 10 && choice12 < 14) outputText("\n\n");
				if (choice12 >= 14 && choice12 < 17) outputText("\n\n");
				if (choice12 == 17 || choice12 == 18) outputText("\n\n");
				if (choice12 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerSiegweird, 4, 1);
			}
		}
		
		public function zenjiCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerZenji) > 0) {
				if ((player.HP < player.maxHP() * 0.35) && player.statusEffectv3(StatusEffects.CombatFollowerZenji) < 4 && rand(10) > 1) zenjiCombatActions5();
				else {
					var choice13:Number = rand(20);
					if (player.hasPerk(PerkLib.MotivationEx)) {
						if (rand(100) == 0) zenjiCombatActions0();
						else {
							if (choice13 < 8) zenjiCombatActions1();
							if (choice13 >= 8 && choice13 < 14) zenjiCombatActions2();
							if (choice13 >= 14 && choice13 < 18) {
								if (player.lust > player.maxLust() * 0.7) zenjiCombatActions3();
								else {
									choice13 = rand(20);
									if (choice13 < 10) zenjiCombatActions0();
									if (choice13 >= 10 && choice13 < 14) zenjiCombatActions1();
									if (choice13 >= 14 && choice13 < 18) zenjiCombatActions2();
									if (choice13 == 18 || choice13 == 19) zenjiCombatActions4();
								}
							}
							if (choice13 >= 18) zenjiCombatActions4();
						}
					}
					else if (player.hasPerk(PerkLib.Motivation)) {
						if (choice13 < 4) zenjiCombatActions0();
						if (choice13 >= 4 && choice13 < 10) zenjiCombatActions1();
						if (choice13 >= 10 && choice13 < 16) zenjiCombatActions2();
						if (choice13 >= 16 && choice13 < 19) {
							if (player.lust > player.maxLust() * 0.7) zenjiCombatActions3();
							else {
								choice13 = rand(20);
								if (choice13 < 10) zenjiCombatActions0();
								if (choice13 >= 10 && choice13 < 14) zenjiCombatActions1();
								if (choice13 >= 14 && choice13 < 18) zenjiCombatActions2();
								if (choice13 == 18 || choice13 == 19) zenjiCombatActions4();
							}
						}
						if (choice13 == 19) zenjiCombatActions4();
					}
					else {
						if (choice13 < 10) zenjiCombatActions0();
						if (choice13 >= 10 && choice13 < 14) zenjiCombatActions1();
						if (choice13 >= 14 && choice13 < 17) zenjiCombatActions2();
						if (choice13 == 17 || choice13 == 18) {
							if (player.lust > player.maxLust() * 0.7) zenjiCombatActions3();
							else {
								choice13 = rand(20);
								if (choice13 < 10) zenjiCombatActions0();
								if (choice13 >= 10 && choice13 < 14) zenjiCombatActions1();
								if (choice13 >= 14 && choice13 < 18) zenjiCombatActions2();
								if (choice13 == 18 || choice13 == 19) zenjiCombatActions4();
							}
						}
						if (choice13 == 19) zenjiCombatActions4();
					}
				}
			}
			else {
				outputText("Zenji readies his spear, wedging himself between you and your opponent, \"<i>¡Si quieres lastimar [name], tendrás que pasar por mí!</i>\"\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerZenji, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Zenji" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Zenji" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Zenji" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function zenjiCombatActions0():void {
			outputText("Zenji remains fixated on your opponent, ready to deflect their blows.\n\n");
			player.addStatusValue(StatusEffects.CombatFollowerZenji, 4, 1);
		}
		public function zenjiCombatActions1():void {
			var dmg11:Number = player.statusEffectv1(StatusEffects.CombatFollowerZenji);
			var weaponZenji:Number = player.statusEffectv2(StatusEffects.CombatFollowerZenji);
			dmg11 += scalingBonusStrengthCompanion();
			if (weaponZenji < 51) dmg11 *= (1 + (weaponZenji * 0.03));
			else if (weaponZenji >= 51 && weaponZenji < 101) dmg11 *= (2.5 + ((weaponZenji - 50) * 0.025));
			else if (weaponZenji >= 101 && weaponZenji < 151) dmg11 *= (3.75 + ((weaponZenji - 100) * 0.02));
			else if (weaponZenji >= 151 && weaponZenji < 201) dmg11 *= (4.75 + ((weaponZenji - 150) * 0.015));
			else dmg11 *= (5.5 + ((weaponZenji - 200) * 0.01));
			dmg11 = Math.round(dmg11 * increasedEfficiencyOfAttacks());
			outputText("Seeing an opening, Zenji thrusts his spear at [themonster]. ");
			doDamage(dmg11, true, true);
			outputText("\n\n");
		}
		public function zenjiCombatActions2():void {
			var dmg12:Number = player.statusEffectv1(StatusEffects.CombatFollowerZenji);
			var weaponZenji:Number = player.statusEffectv2(StatusEffects.CombatFollowerZenji);
			dmg12 += scalingBonusStrengthCompanion() * 0.7;
			if (weaponZenji < 51) dmg12 *= (1 + (weaponZenji * 0.03));
			else if (weaponZenji >= 51 && weaponZenji < 101) dmg12 *= (2.5 + ((weaponZenji - 50) * 0.025));
			else if (weaponZenji >= 101 && weaponZenji < 151) dmg12 *= (3.75 + ((weaponZenji - 100) * 0.02));
			else if (weaponZenji >= 151 && weaponZenji < 201) dmg12 *= (4.75 + ((weaponZenji - 150) * 0.015));
			else dmg12 *= (5.5 + ((weaponZenji - 200) * 0.01));
			dmg12 = Math.round(dmg12 * increasedEfficiencyOfAttacks());
			outputText("Zenji charges at [themonster] with his spear in a feint before bashing them with his tusks. ");
			doDamage(dmg12, true, true);
			outputText(" [Themonster]");
			if (monster.hasPerk(PerkLib.Resolute) || rand(4) == 0) outputText(" remains focused despite Zenji’s brutal strikes");
			else {
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				outputText(" seems disoriented for a moment");
			}
			outputText(".\n\n");
		}
		public function zenjiCombatActions3():void {
			outputText("Zenji turns around to you, gripping you by the shoulders and giving you a firm shake. \"<i>Snap out of it [name]! ");
			if (silly()) outputText("If you keep dis up, no more sex after dis fight! I mean it dis time");
			else outputText("Remained focused, don’t give in");
			outputText("!</i>\"\n\n");
			dynStats("lust", -(player.maxLust() * 0.2));
		}
		public function zenjiCombatActions4():void {
			var dmg13:Number = player.statusEffectv1(StatusEffects.CombatFollowerZenji);
			var weaponZenji:Number = player.statusEffectv2(StatusEffects.CombatFollowerZenji);
			dmg13 += scalingBonusStrengthCompanion() * 0.4;
			if (weaponZenji < 51) dmg13 *= (1 + (weaponZenji * 0.03));
			else if (weaponZenji >= 51 && weaponZenji < 101) dmg13 *= (2.5 + ((weaponZenji - 50) * 0.025));
			else if (weaponZenji >= 101 && weaponZenji < 151) dmg13 *= (3.75 + ((weaponZenji - 100) * 0.02));
			else if (weaponZenji >= 151 && weaponZenji < 201) dmg13 *= (4.75 + ((weaponZenji - 150) * 0.015));
			else dmg13 *= (5.5 + ((weaponZenji - 200) * 0.01));
			dmg13 = Math.round(dmg13 * increasedEfficiencyOfAttacks());
			outputText("Zenji charges at [themonster], knocking them down and pinning them beneath him with his spear. ");
			doDamage(dmg13, true, true);
			if (!monster.hasPerk(PerkLib.Resolute)) {
				outputText(" Zenji has [themonster] pinned beneath him. \"<i>And stay down!</i>\" Zenji shouts.\n\n");
				monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
			} else {
				outputText(" Zenji has [themonster] pinned beneath him. \"<i>And stay down!</i>\" Zenji shouts. [Themonster] struggles beneath him before finally shaking him off.\n\n");
			}
		}
		public function zenjiCombatActions5():void {
			outputText("Seeing your injuries, Zenji quickly rushes to your side, \"<i>It’s okay [name]... I’m here for you…</i>\" he says, wrapping you within his arms, completely shielding you from your enemies. ");
			outputText("\"<i>It’s… okay… I won’t let them hurt you… I will endure it all for you so you don’t have to. I’d do anything for you.</i>\" He gently rubs a hand over your wounds, helping you recover slightly.\n\n");
			HPChange(Math.round(player.maxHP() * .1), true);
			player.addStatusValue(StatusEffects.CombatFollowerZenji, 3, 1);
			if (player.statusEffectv3(StatusEffects.CombatFollowerZenji) == 1) outputText(" Zenji remains weary, but he stands as if he were completely unaffected by the physical trauma he just endured.");
			else outputText("Zenji seems much worse for wear after protecting you, \"<i>I’m fine.</i>\" he mumbles, but it’s apparent that he’s sustained heavy damage.");
		}
		
		public function tyrantiaCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerTyrantia) > 0) {
				//if (TyrantiaFollower.TyraniaPostFinalKissScene) tyrantiaCombatActions5();
				if (monster.hasStatusEffect(StatusEffects.PouncedByCompanion)) tyrantiaCombatActions1();
				else {
					var choice1:Number = rand(20);
					if (player.hasPerk(PerkLib.MotivationEx)) {
						if (rand(100) == 0) tyrantiaCombatActions0();
						else {
							if (choice1 < 5) tyrantiaCombatActions1();
							if (choice1 >= 5 && choice1 < 10) tyrantiaCombatActions2();
							if (choice1 >= 10 && choice1 < 15) tyrantiaCombatActions3();
							if (choice1 >= 15) tyrantiaCombatActions4();
						}
					}
					else if (player.hasPerk(PerkLib.Motivation)) {
						if (choice1 < 4) tyrantiaCombatActions0();
						if (choice1 >= 4 && choice1 < 11) tyrantiaCombatActions1();
						if (choice1 >= 11 && choice1 < 16) tyrantiaCombatActions2();
						if (choice1 >= 16 && choice1 < 19) tyrantiaCombatActions3();
						if (choice1 == 19) tyrantiaCombatActions4();
					}
					else {
						if (choice1 < 10) tyrantiaCombatActions0();
						if (choice1 >= 10 && choice1 < 14) tyrantiaCombatActions1();
						if (choice1 >= 14 && choice1 < 17) tyrantiaCombatActions2();
						if (choice1 == 17 || choice1 == 18) tyrantiaCombatActions3();
						if (choice1 == 19) tyrantiaCombatActions4();
					}
				}
			}
			else {
				outputText("You hold on as Tyrantia wheels about, facing [themonster] with a grin on her face. \"<i>You want to fight us?!</i>\" She brandishes her Dick, keeping her upper body between [themonster] and you. \"<i>Let’s GO!</i>\" ");
				outputText("Her horns spill darkness, and you ready yourself for battle. Tyrantia instinctively shields you with her body, and you can’t help but feel a bit of affection for the giantess. You watch as several stone spears, duplicates of her Phalluspear, rise from the ground.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerTyrantia, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_0] == "Tyrantia" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Tyrantia" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Tyrantia" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Tyrantia" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function tyrantiaCombatActions0():void {
			outputText("Your Drider companion stares at the [themonster], making no movements towards them.\n\n");
		}
		public function tyrantiaCombatActions1():void {
			outputText("Tyrantia’s Dick is thrust into the [themonster]. ");
			var dmg14:Number = player.statusEffectv1(StatusEffects.CombatFollowerTyrantia);
			var weaponTyrantia:Number = player.statusEffectv2(StatusEffects.CombatFollowerTyrantia);
			var lustDmg:Number = Math.round(25 + monster.lib / 5 + monster.sens / 5 + monster.cor / 5);
			dmg14 += scalingBonusStrengthCompanion() * 1.5;
			weaponTyrantia *= 3;
			if (weaponTyrantia < 51) dmg14 *= (1 + (weaponTyrantia * 0.03));
			else if (weaponTyrantia >= 51 && weaponTyrantia < 101) dmg14 *= (2.5 + ((weaponTyrantia - 50) * 0.025));
			else if (weaponTyrantia >= 101 && weaponTyrantia < 151) dmg14 *= (3.75 + ((weaponTyrantia - 100) * 0.02));
			else if (weaponTyrantia >= 151 && weaponTyrantia < 201) dmg14 *= (4.75 + ((weaponTyrantia - 150) * 0.015));
			else dmg14 *= (5.5 + ((weaponTyrantia - 200) * 0.01));
			dmg14 = Math.round(dmg14 * increasedEfficiencyOfAttacks());
			doDamage(dmg14, true, true);
			doDamage(dmg14, true, true);
			doDamage(dmg14, true, true);
			monster.teased(Math.round(monster.lustVuln * lustDmg));
			outputText("\n\n");
		}
		public function tyrantiaCombatActions2():void {
			var dmg15:Number = player.statusEffectv1(StatusEffects.CombatFollowerTyrantia);
			dmg15 += scalingBonusStrengthCompanion() * 2;
			outputText("Tyrantia bowls over [themonster] with a mighty roar, then slams her steel-coated front legs down into the [themonster]’s luckless frame, pinning them in place as they bleed profusely. ");
			if (rand(2) == 0) {
				outputText("Tyrantia’s front limbs are brought up and back down, getting a cry of pain from [themonster]. She lets loose a cheerful war cry, stabbing down again. [Themonster] is pinned for now.");
				monster.createStatusEffect(StatusEffects.PouncedByCompanion,2+rand(2),0,0,0);
			}
			else outputText("To your surprise, Tyrantia flinches, backing off from [themonster]. They fight their way to their feet, and take a fighting stance.");
			if (!monster.isImmuneToBleed()) {
				if (monster.hasStatusEffect(StatusEffects.Hemorrhage2)) monster.addStatusValue(StatusEffects.Hemorrhage2, 1, 1);
				else monster.createStatusEffect(StatusEffects.Hemorrhage2, 3, 0.1, 0, 0);
			}
			doDamage(dmg15, true, true);
			outputText("\n\n");
		}
		public function tyrantiaCombatActions3():void {
			var dmg16:Number = player.statusEffectv3(StatusEffects.CombatFollowerTyrantia);
			dmg16 += scalingBonusIntelligenceCompanion() * 1.5;
			dmg16 = Math.round(dmg16 * increasedEfficiencyOfAttacks());
			if (monster.hasStatusEffect(StatusEffects.AcidDoT)) {
				monster.addStatusValue(StatusEffects.AcidDoT,1,1);
				monster.addStatusValue(StatusEffects.AcidDoT,3,1);
			}
			else monster.createStatusEffect(StatusEffects.AcidDoT,4,0.02,1,0);
			outputText("Tyrantia turns her body around, spraying her acidic goop at the enemy. ");
			doAcidDamage(dmg16, true, true);
			outputText("\n\n");
		}
		public function tyrantiaCombatActions4():void {
			var lustDmg:Number = Math.round((25 + monster.lib / 5 + monster.sens / 5 + monster.cor / 5) * 4);
			monster.statStore.addBuffObject({spe:-20}, "Web",{text:"Web"});
			outputText("Tyrantia rushes forward, biting [themonster] and sinking her fangs into it. [Themonster] manages to get loose, but not before their blood coats her fangs. [Themonster] looks woozy, and slightly horny. ");
			monster.teased(Math.round(monster.lustVuln * lustDmg));
			outputText("\n\n");
		}
		public function tyrantiaCombatActions5():void {
			outputText("Your Drider companion stares at the [enemy], making no movements towards them.\n\n");
		}

		public function kihaCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerKiha) > 0) {
				var choice11:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx) || player.hasStatusEffect(StatusEffects.FrenziedKiha)) {
					if (rand(100) == 0) kihaCombatActions0();
					else {
						if (choice11 < 9) kihaCombatActions1();
						if (choice11 >= 9 && choice11 < 14) kihaCombatActions2();
						if (choice11 >= 14 && choice11 < 17) kihaCombatActions3();
						if (choice11 >= 17) kihaCombatActions4();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice11 < 4) kihaCombatActions0();
					if (choice11 >= 4 && choice11 < 12) kihaCombatActions1();
					if (choice11 >= 12 && choice11 < 15) kihaCombatActions2();
					if (choice11 >= 15 && choice11 < 18) kihaCombatActions3();
					if (choice11 == 18 || choice11 == 19) kihaCombatActions4();
				}
				else {
					if (choice11 < 10) kihaCombatActions0();
					if (choice11 >= 10 && choice11 < 14) kihaCombatActions1();
					if (choice11 == 14 || choice11 == 15) kihaCombatActions2();
					if (choice11 == 16 || choice11 == 17) kihaCombatActions3();
					if (choice11 == 18 || choice11 == 19) kihaCombatActions4();
				}
			}
			else {
				outputText("Kiha readies her axe, small spurts of flame escaping her nostrils as she stares down your opponent.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerKiha, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_0] == "Kiha" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Kiha" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Kiha" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Kiha" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function kihaCombatActions0():void {
			outputText("Kiha remains steady, ready to smash away any blows [themonster] might throw.\n\n");
		}
		public function kihaCombatActions1():void {
			var dmg17:Number = player.statusEffectv1(StatusEffects.CombatFollowerKiha);
			var weaponKiha:Number = player.statusEffectv2(StatusEffects.CombatFollowerKiha);
			dmg17 += scalingBonusStrengthCompanion();
			if (weaponKiha < 51) dmg17 *= (1 + (weaponKiha * 0.03));
			else if (weaponKiha >= 51 && weaponKiha < 101) dmg17 *= (2.5 + ((weaponKiha - 50) * 0.025));
			else if (weaponKiha >= 101 && weaponKiha < 151) dmg17 *= (3.75 + ((weaponKiha - 100) * 0.02));
			else if (weaponKiha >= 151 && weaponKiha < 201) dmg17 *= (4.75 + ((weaponKiha - 150) * 0.015));
			else dmg17 *= (5.5 + ((weaponKiha - 200) * 0.01));
			dmg17 = Math.round(dmg17 * increasedEfficiencyOfAttacks());
			if (player.hasStatusEffect(StatusEffects.FrenziedKiha))
				dmg17 *= 1+ player.statusEffectv1(StatusEffects.FrenziedKiha)*0.2;
			outputText("Seeing an opening, Kiha swings her battleaxe, smashing [themonster]. ");
			doDamage(dmg17, true, true);
			outputText("\n\n");
		}
		public function kihaCombatActions2():void {
			var dmg18:Number = player.statusEffectv1(StatusEffects.CombatFollowerKiha);
			dmg18 += scalingBonusStrengthCompanion() * 0.5;
			dmg18 = Math.round(dmg18 * increasedEfficiencyOfAttacks());
			if (player.hasStatusEffect(StatusEffects.FrenziedKiha))
				dmg18 *= 1+ player.statusEffectv1(StatusEffects.FrenziedKiha)*0.2;
			outputText("Kiha throws her trusty weapon into the sodden ground, building up balls of flame around her fists.  She runs towards [themonster], launching herself into action with a flurry of punches. ");
			doFireDamage(dmg18, true, true);
			outputText("\n\n");
		}
		public function kihaCombatActions3():void {
			outputText("Kiha throws her arms back and roars, exhaling a swirling tornado of fire directly at [themonster]!\n");
			var dmg19:Number = player.statusEffectv1(StatusEffects.CombatFollowerKiha);
			dmg19 += scalingBonusStrengthCompanion();
			dmg19 = Math.round(dmg19 * increasedEfficiencyOfAttacks());
			if (player.hasStatusEffect(StatusEffects.FrenziedKiha))
				dmg19 *= 1+ player.statusEffectv1(StatusEffects.FrenziedKiha)*0.2;
			doFireDamage(dmg19, true, true);
			outputText("\n\n");
		}
		public function kihaCombatActions4():void {
			outputText("She supports the axe on a shoulder, cracking her neck and arching her back to stretch herself, giving [themonster] an unintended show.  ");
			if (monster.lustVuln > 0)
				monster.teased(monster.lib/20, true);
			outputText("\n\n");
		}

		public function midokaCombatActions():void {
			if (player.statusEffectv4(StatusEffects.CombatFollowerMidoka) > 0) {
				var choice11:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationEx)) {
					if (rand(100) == 0) midokaCombatActions0();
					else {
						if (choice11 < 9) midokaCombatActions1();
						if (choice11 >= 9 && choice11 < 14) midokaCombatActions2();
						if (choice11 >= 14 && choice11 < 17) midokaCombatActions3();
						if (choice11 >= 17) midokaCombatActions4();
					}
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice11 < 4) midokaCombatActions0();
					if (choice11 >= 4 && choice11 < 12) midokaCombatActions1();
					if (choice11 >= 12 && choice11 < 15) midokaCombatActions2();
					if (choice11 >= 15 && choice11 < 18) midokaCombatActions3();
					if (choice11 == 18 || choice11 == 19) midokaCombatActions4();
				}
				else {
					if (choice11 < 10) midokaCombatActions0();
					if (choice11 >= 10 && choice11 < 14) midokaCombatActions1();
					if (choice11 == 14 || choice11 == 15) midokaCombatActions2();
					if (choice11 == 16 || choice11 == 17) midokaCombatActions3();
					if (choice11 == 18 || choice11 == 19) midokaCombatActions4();
				}
			}
			else {
				outputText("Midoka her fists as she stares down your opponent.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerMidoka, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_0] == "Midoka" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_0_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Midoka" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Midoka" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Midoka" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxOverLust()) enemyAI();
		}
		public function midokaCombatActions0():void {
			outputText("Midoka remains steady, ready to deflect away any blows [themonster] might throw.\n\n");
		}
		public function midokaCombatActions1():void {
			var dmg17:Number = player.statusEffectv1(StatusEffects.CombatFollowerMidoka);
			var weaponMidoka:Number = player.statusEffectv2(StatusEffects.CombatFollowerMidoka);
			dmg17 += scalingBonusStrengthCompanion();
			if (weaponMidoka < 51) dmg17 *= (1 + (weaponMidoka * 0.03));
			else if (weaponMidoka >= 51 && weaponMidoka < 101) dmg17 *= (2.5 + ((weaponMidoka - 50) * 0.025));
			else if (weaponMidoka >= 101 && weaponMidoka < 151) dmg17 *= (3.75 + ((weaponMidoka - 100) * 0.02));
			else if (weaponMidoka >= 151 && weaponMidoka < 201) dmg17 *= (4.75 + ((weaponMidoka - 150) * 0.015));
			else dmg17 *= (5.5 + ((weaponMidoka - 200) * 0.01));
			dmg17 = Math.round(dmg17 * increasedEfficiencyOfAttacks());
			outputText("[midokaname] attack 1 ");
			doDamage(dmg17, true, true);
			outputText("\n\n");
		}
		public function midokaCombatActions2():void {
			var dmg18:Number = player.statusEffectv1(StatusEffects.CombatFollowerMidoka);
			dmg18 += scalingBonusStrengthCompanion() * 0.5;
			dmg18 = Math.round(dmg18 * increasedEfficiencyOfAttacks());
			outputText("[midokaname] attack 2 ");
			doDamage(dmg18, true, true);
			outputText("\n\n");
		}
		public function midokaCombatActions3():void {
			outputText("[midokaname] attack 3\n");
			var dmg19:Number = player.statusEffectv1(StatusEffects.CombatFollowerMidoka);
			dmg19 += scalingBonusStrengthCompanion();
			dmg19 = Math.round(dmg19 * increasedEfficiencyOfAttacks());
			doDamage(dmg19, true, true);
			outputText("\n\n");
		}
		public function midokaCombatActions4():void {
			outputText("[midokaname] tease ");
			if (monster.lustVuln > 0)
				monster.teased(monster.lib/20, true);
			outputText("\n\n");
		}/*
		
		public function divaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.) > 0) {
				var choice7:Number = rand(20);
				if (choice7 < 10) outputText("\n\n");
				if (choice7 >= 10 && choice7 < 14) outputText("\n\n");
				if (choice7 >= 14 && choice7 < 17) outputText("\n\n");
				if (choice7 == 17 || choice7 == 18) outputText("\n\n");
				if (choice7 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.addStatusValue(StatusEffects., 4, 1);
			}
		}
		public function ayaneCombatActions0():void {

		}/*

		public function divaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.) > 0) {
				var choice7:Number = rand(20);
				if (choice7 < 10) outputText("\n\n");
				if (choice7 >= 10 && choice7 < 14) outputText("\n\n");
				if (choice7 >= 14 && choice7 < 17) outputText("\n\n");
				if (choice7 == 17 || choice7 == 18) outputText("\n\n");
				if (choice7 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.addStatusValue(StatusEffects., 4, 1);
			}
		}
		public function ayaneCombatActions0():void {

		}*/
	}
}