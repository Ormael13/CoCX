/**
 * Coded by Ormael on 31.01.2019.
 */
package classes.Scenes.Combat 
{
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.StatusEffects;

	public class CombatFollowersActions extends BaseCombatContent
	{
		
		public function CombatFollowersActions() {
		}
		
		public function neisaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerNeisa) > 0) {
				var choice1:Number = rand(20);
				if (choice1 < 10) outputText("Neisa look for an opening in the battle.\n\n");
				if (choice1 >= 10 && choice1 < 14) {
					var dmg1:Number = player.statusEffectv1(StatusEffects.CombatFollowerNeisa);
					var weaponNeisa:Number = player.statusEffectv2(StatusEffects.CombatFollowerNeisa);
					dmg1 += scalingBonusStrengthCompanion() * 0.25;
					if (weaponNeisa < 51) dmg1 *= (1 + (weaponNeisa * 0.03));
					else if (weaponNeisa >= 51 && weaponNeisa < 101) dmg1 *= (2.5 + ((weaponNeisa - 50) * 0.025));
					else if (weaponNeisa >= 101 && weaponNeisa < 151) dmg1 *= (3.75 + ((weaponNeisa - 100) * 0.02));
					else if (weaponNeisa >= 151 && weaponNeisa < 201) dmg1 *= (4.75 + ((weaponNeisa - 150) * 0.015));
					else dmg1 *= (5.5 + ((weaponNeisa - 200) * 0.01));
					dmg1 = Math.round(dmg1);
					doDamage(dmg1);
					outputText("Neisa slash at " + monster.a + monster.short + " with her sword. <b>(<font color=\"#800000\">" + String(dmg1) + "</font>)</b>\n\n");
				}
				if (choice1 >= 14 && choice1 < 17) {
					outputText("Neisa move in front of you deflecting the opponent attacks with her shield in order to assist your own defence.\n\n");
					player.createStatusEffect(StatusEffects.CompBoostingPCArmorValue, 0, 0, 0, 0);
				}
				if (choice1 == 17 || choice1 == 18) {
					outputText("Neisa smash her shield on " + monster.a + monster.short + " head stunning it.\n\n");
					monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
				if (choice1 == 19) {
					outputText("Neisa viciously ram her shield on " + monster.a + monster.short + " dazing it.\n\n");
					monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
				}
			}
			else {
				outputText("Neisa step forward shield at the ready in order to defend you.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerNeisa, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (monster.HP <= 0) enemyAI();
			else {
				menu();
				addButton(0, "Next", combatMenu, false);
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
				player.createStatusEffect(StatusEffects.CombatFollowerDiana, 0, 0, 0, 0);
			}
			menu();
			addButton(0, "Next", combatMenu, false);
		}
		
		public function etnaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerEtna) > 0) {
				var choice3:Number = rand(20);
				if (choice3 < 10) outputText("Etna fly around looking for an opportunity to strike.\n\n");
				if (choice3 >= 10 && choice3 < 14) {
					var lustDmg:Number = Math.round(player.statusEffectv2(StatusEffects.CombatFollowerEtna) / 6);
					outputText("Etna shoot a spike at " + monster.a + monster.short + " you can see the telltale sign of arousal in " + monster.pronoun3 + " movement. ");
					monster.teased(lustDmg);
					outputText("\n\n");
				}
				if (choice3 >= 14 && choice3 < 18) {
					var dmg2:Number = player.statusEffectv1(StatusEffects.CombatFollowerEtna);
					dmg2 += scalingBonusStrengthCompanion() * 0.25;
					dmg2 = Math.round(dmg2);
					doDamage(dmg2);
					outputText("Etna dive at " + monster.a + monster.short + " mauling " + monster.pronoun3 + " viciously with her claws before taking flight again. <b><font color=\"#800000\">" + String(dmg2) + "</font></b> damage!\n\n");
				}
				if (choice3 >= 18) {
					outputText("Etna dive at " + monster.a + monster.short + " and crash boob first in " + monster.pronoun3 + " face staggering it before taking flight again.\n\n");
					monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
				}
			}
			else {
				outputText("Etna take flight her tail taking aim at " + monster.a + monster.short + " ready for aerial bombardment.\n\n");
				player.createStatusEffect(StatusEffects.CombatFollowerEtna, 0, 0, 0, 0);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (monster.HP <= 0 || monster.lust >= monster.maxLust()) enemyAI();
			else {
				menu();
				addButton(0, "Next", combatMenu, false);
			}
		}
		
		public function ayaneCombatActions():void {
			clearOutput();
			
		}
		
		public function divaCombatActions():void {
			clearOutput();
			
		}
		
		public function alvinaCombatActions():void {
			clearOutput();
			
		}
	}
}