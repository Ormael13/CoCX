/**
 * Coded by Ormael on 31.01.2019.
 */
package classes.Scenes.Combat 
{
import classes.CoC;
import classes.GlobalFlags.kFLAGS;
import classes.PerkLib;
import classes.StatusEffects;

	public class CombatFollowersActions extends BaseCombatContent
	{
		
		public function CombatFollowersActions() {
		}
		
		public function neisaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerNeisa) > 0) {
				var choice1:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationSu)) {
					if (choice1 == 0) neisaCombatActions0();
					if (choice1 >= 1 && choice1 < 9) neisaCombatActions1();
					if (choice1 >= 9 && choice1 < 15) neisaCombatActions2();
					if (choice1 >= 15 && choice1 < 18) neisaCombatActions3();
					if (choice1 >= 18) neisaCombatActions4();
				}
				else if (player.hasPerk(PerkLib.MotivationEx)) {
					if (choice1 < 4) neisaCombatActions0();
					if (choice1 >= 4 && choice1 < 11) neisaCombatActions1();
					if (choice1 >= 11 && choice1 < 16) neisaCombatActions2();
					if (choice1 >= 16 && choice1 < 19) neisaCombatActions3();
					if (choice1 == 19) neisaCombatActions4();
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice1 < 7) neisaCombatActions0();
					if (choice1 >= 7 && choice1 < 13) neisaCombatActions1();
					if (choice1 >= 13 && choice1 < 17) neisaCombatActions2();
					if (choice1 == 17 || choice1 == 18) neisaCombatActions3();
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
				outputText("Neisa step forward shield at the ready in order to defend you.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerNeisa, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Neisa" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxLust()) enemyAI();
			else {
				menu();
				addButton(0, "Next", combatMenu, false);
			}
		}
		public function neisaCombatActions0():void {
			outputText("Neisa look for an opening in the battle.\n\n");
		}
		public function neisaCombatActions1():void {
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
		public function neisaCombatActions2():void {
			outputText("Neisa move in front of you deflecting the opponent attacks with her shield in order to assist your own defence.\n\n");
			player.createStatusEffect(StatusEffects.CompBoostingPCArmorValue, 0, 0, 0, 0);
		}
		public function neisaCombatActions3():void {
			outputText("Neisa smash her shield on " + monster.a + monster.short + " head stunning it.\n\n");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		public function neisaCombatActions4():void {
			outputText("Neisa viciously ram her shield on " + monster.a + monster.short + " dazing it.\n\n");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
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
				if (player.hasPerk(PerkLib.MotivationSu)) {
					if (choice3 == 0) etnaCombatActions0();
					if (choice3 >= 1 && choice3 < 8) etnaCombatActions1();
					if (choice3 >= 8 && choice3 < 15) etnaCombatActions2();
					if (choice3 >= 15) etnaCombatActions3();
				}
				else if (player.hasPerk(PerkLib.MotivationEx)) {
					if (choice3 < 4) etnaCombatActions0();
					if (choice3 >= 4 && choice3 < 10) etnaCombatActions1();
					if (choice3 >= 10 && choice3 < 16) etnaCombatActions2();
					if (choice3 >= 16) etnaCombatActions3();
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice3 < 7) etnaCombatActions0();
					if (choice3 >= 7 && choice3 < 12) etnaCombatActions1();
					if (choice3 >= 12 && choice3 < 17) etnaCombatActions2();
					if (choice3 >= 17) etnaCombatActions3();
				}
				else {
					if (choice3 < 10) etnaCombatActions0();
					if (choice3 >= 10 && choice3 < 14) etnaCombatActions1();
					if (choice3 >= 14 && choice3 < 18) etnaCombatActions2();
					if (choice3 >= 18) etnaCombatActions3();
				}
			}
			else {
				outputText("Etna take flight her tail taking aim at " + monster.a + monster.short + " ready for aerial bombardment.\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerEtna, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Etna" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxLust()) enemyAI();
			else {
				menu();
				addButton(0, "Next", combatMenu, false);
			}
		}
		public function etnaCombatActions0():void {
			outputText("Etna fly around looking for an opportunity to strike.\n\n");
		}
		public function etnaCombatActions1():void {
			var lustDmg:Number = Math.round(player.statusEffectv2(StatusEffects.CombatFollowerEtna) / 6);
			outputText("Etna shoot a spike at " + monster.a + monster.short + " you can see the telltale sign of arousal in " + monster.pronoun3 + " movement. ");
			monster.teased(lustDmg);
			outputText("\n\n");
		}
		public function etnaCombatActions2():void {
			var dmg2:Number = player.statusEffectv1(StatusEffects.CombatFollowerEtna);
			dmg2 += scalingBonusStrengthCompanion() * 0.25;
			dmg2 = Math.round(dmg2);
			doDamage(dmg2);
			outputText("Etna dive at " + monster.a + monster.short + " mauling " + monster.pronoun3 + " viciously with her claws before taking flight again. <b><font color=\"#800000\">" + String(dmg2) + "</font></b> damage!\n\n");
		}
		public function etnaCombatActions3():void {
			outputText("Etna dive at " + monster.a + monster.short + " and crash boob first in " + monster.pronoun3 + " face staggering it before taking flight again.\n\n");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		public function auroraCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerAurora) > 0) {
				var choice4:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationSu)) {
					if (choice4 == 0) auroraCombatActions0();
					if (choice4 >= 1 && choice4 < 10) auroraCombatActions1();
					if (choice4 >= 10 && choice4 < 14) auroraCombatActions2();
					if (choice4 >= 14 && choice4 < 17) auroraCombatActions3();
					if (choice4 >= 17) auroraCombatActions4();
				}
				else if (player.hasPerk(PerkLib.MotivationEx)) {
					if (choice4 < 4) auroraCombatActions0();
					if (choice4 >= 4 && choice4 < 11) auroraCombatActions1();
					if (choice4 >= 11 && choice4 < 15) auroraCombatActions2();
					if (choice4 >= 15 && choice4 < 18) auroraCombatActions3();
					if (choice4 >= 18) auroraCombatActions4();
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice4 < 7) auroraCombatActions0();
					if (choice4 >= 7 && choice4 < 12) auroraCombatActions1();
					if (choice4 >= 12 && choice4 < 16) auroraCombatActions2();
					if (choice4 == 16 || choice4 == 17) auroraCombatActions3();
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
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxLust()) enemyAI();
			else {
				menu();
				addButton(0, "Next", combatMenu, false);
			}
		}
		public function auroraCombatActions0():void {
			outputText("Aurora look for an opening in the battle.\n\n");
		}
		public function auroraCombatActions1():void {
			var dmg01:Number = player.statusEffectv1(StatusEffects.CombatFollowerAurora);
			var weaponAurora1:Number = player.statusEffectv2(StatusEffects.CombatFollowerAurora);
			dmg01 += scalingBonusStrengthCompanion() * 0.25;
			if (weaponAurora1 < 51) dmg01 *= (1 + (weaponAurora1 * 0.03));
			else if (weaponAurora1 >= 51 && weaponAurora1 < 101) dmg01 *= (2.5 + ((weaponAurora1 - 50) * 0.025));
			else if (weaponAurora1 >= 101 && weaponAurora1 < 151) dmg01 *= (3.75 + ((weaponAurora1 - 100) * 0.02));
			else if (weaponAurora1 >= 151 && weaponAurora1 < 201) dmg01 *= (4.75 + ((weaponAurora1 - 150) * 0.015));
			else dmg01 *= (5.5 + ((weaponAurora1 - 200) * 0.01));
			dmg01 = Math.round(dmg01);
			doDamage(dmg01);
			outputText("Aurora thrust her hand at " + monster.a + monster.short + ". <b>(<font color=\"#800000\">" + String(dmg01) + "</font>)</b>\n\n");
		}
		public function auroraCombatActions2():void {
			outputText("Aurora move in front of you deflecting the opponent attacks with her body in order to assist your own defence.\n\n");
			player.createStatusEffect(StatusEffects.CompBoostingPCArmorValue, 0, 0, 0, 0);
		}
		public function auroraCombatActions3():void {
			var dmg3:Number = player.statusEffectv1(StatusEffects.CombatFollowerAurora);
			var weaponAurora:Number = player.statusEffectv2(StatusEffects.CombatFollowerAurora);
			dmg3 += scalingBonusStrengthCompanion() * 0.5;
			if (weaponAurora < 51) dmg3 *= (1 + (weaponAurora * 0.03));
			else if (weaponAurora >= 51 && weaponAurora < 101) dmg3 *= (2.5 + ((weaponAurora - 50) * 0.025));
			else if (weaponAurora >= 101 && weaponAurora < 151) dmg3 *= (3.75 + ((weaponAurora - 100) * 0.02));
			else if (weaponAurora >= 151 && weaponAurora < 201) dmg3 *= (4.75 + ((weaponAurora - 150) * 0.015));
			else dmg3 *= (5.5 + ((weaponAurora - 200) * 0.01));
			dmg3 *= 3;
			dmg3 = Math.round(dmg3);
			doDamage(dmg3);
			outputText("Aurora thrust her hand at " + monster.a + monster.short + ". Her claws hits thrice against " + monster.a + monster.short + ", dealing <b>(<font color=\"#800000\">" + String(dmg3) + "</font>)</b> damage!\n\n");
		}
		public function auroraCombatActions4():void {
			outputText("Aurora flaps her huge bat wings at " + monster.a + monster.short + " trying to knock it down.\n\n");
			monster.createStatusEffect(StatusEffects.Stunned, 1, 0, 0, 0);
		}
		
		public function ayaneCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerAyane) > 0) {
				var choice5:Number = rand(20);
				if (choice5 < 10) outputText("\n\n");
				if (choice5 >= 10 && choice5 < 14) outputText("\n\n");
				if (choice5 >= 14 && choice5 < 17) outputText("\n\n");
				if (choice5 == 17 || choice5 == 18) outputText("\n\n");
				if (choice5 == 19) outputText("\n\n");
			}
			else {
				outputText("\n\n");
				player.createStatusEffect(StatusEffects.CombatFollowerAyane, 0, 0, 0, 0);
			}
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
				player.createStatusEffect(StatusEffects.CombatFollowerDiva, 0, 0, 0, 0);
			}
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
				player.createStatusEffect(StatusEffects., 0, 0, 0, 0);
			}
		}*/
		
		public function alvinaCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerAlvina) > 0) {
				var choice8:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationSu)) {
					if (choice8 == 0) alvinaCombatActions0();
					if (choice8 >= 1 && choice8 < 10) alvinaCombatActions1();
					if (choice8 >= 10 && choice8 < 13) alvinaCombatActions2();
					if (choice8 >= 13 && choice8 < 16) alvinaCombatActions3();
					if (choice8 >= 16 && choice8 < 19) alvinaCombatActions4();
					if (choice8 == 19) alvinaCombatActions5();
				}
				else if (player.hasPerk(PerkLib.MotivationEx)) {
					if (choice8 < 4) alvinaCombatActions0();
					if (choice8 >= 4 && choice8 < 11) alvinaCombatActions1();
					if (choice8 >= 11 && choice8 < 14) alvinaCombatActions2();
					if (choice8 >= 14 && choice8 < 17) alvinaCombatActions3();
					if (choice8 >= 17 && choice8 < 19) alvinaCombatActions4();
					if (choice8 == 19) alvinaCombatActions5();
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice8 < 7) alvinaCombatActions0();
					if (choice8 >= 7 && choice8 < 12) alvinaCombatActions1();
					if (choice8 >= 12 && choice8 < 15) alvinaCombatActions2();
					if (choice8 >= 15 && choice8 < 17) alvinaCombatActions3();
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
				outputText("Alvina nonchalantly grab her scythe smirking sadistically as she opens her spellbook.\n\n");
				outputText("\"<i>I’m amused you would have me fight with you against such a lowly opponent [name]. This is a task unworthy of my time but regardless I will take great pleasure in destroying ");
				if (monster.plural) outputText("these");
				else outputText("this");
				outputText(" vermin. It's not worth me trying too hard however, just enough that I can record the results into my field experimentation book.</i>\"\n\n");
				player.addStatusValue(StatusEffects.CombatFollowerAlvina, 4, 1);
			}
			if (flags[kFLAGS.PLAYER_COMPANION_1] == "Alvina" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_1_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_2] == "Alvina" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_2_ACTION] = 1;
			if (flags[kFLAGS.PLAYER_COMPANION_3] == "Alvina" && flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] != 1) flags[kFLAGS.IN_COMBAT_PLAYER_COMPANION_3_ACTION] = 1;
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxLust()) enemyAI();
			else {
				menu();
				addButton(0, "Next", combatMenu, false);
			}
		}
		public function alvinaCombatActions0():void {
			outputText("Alvina is studying her spellbook, readying her next action.\n\n");
		}
		public function alvinaCombatActions1():void {
			var damage1:Number = player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
			damage1 += scalingBonusIntelligenceCompanion() * 2;
			damage1 = Math.round(damage1);
			doIceDamage(damage1);
			outputText("Alvina incant a spell and freeze the enemy solid, now's your chance! (<b><font color=\"#800000\">" + String(damage1) + "</font></b>)\n\n");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		public function alvinaCombatActions2():void {
			var lustDmg:Number = Math.round(player.statusEffectv2(StatusEffects.CombatFollowerAlvina) / 3);
			lustDmg + (rand(player.statusEffectv3(StatusEffects.CombatFollowerAlvina) - player.statusEffectv2(StatusEffects.CombatFollowerAlvina) * 2 + monster.cor) / 3);
			lustDmg = Math.round(lustDmg);
			outputText("Alvina incant a spell and a powerful wave of lust hit " + monster.a + monster.short + " leaving it more then aroused! ");
			monster.teased(lustDmg);
			outputText("\n\n");
		}
		public function alvinaCombatActions3():void {
			var dmg1:Number = player.statusEffectv1(StatusEffects.CombatFollowerAlvina);
			var weaponAlvina:Number = 25;
			dmg1 += scalingBonusStrengthCompanion() * 0.25;
			if (weaponAlvina < 51) dmg1 *= (1 + (weaponAlvina * 0.03));
			else if (weaponAlvina >= 51 && weaponAlvina < 101) dmg1 *= (2.5 + ((weaponAlvina - 50) * 0.025));
			else if (weaponAlvina >= 101 && weaponAlvina < 151) dmg1 *= (3.75 + ((weaponAlvina - 100) * 0.02));
			else if (weaponAlvina >= 151 && weaponAlvina < 201) dmg1 *= (4.75 + ((weaponAlvina - 150) * 0.015));
			else dmg1 *= (5.5 + ((weaponAlvina - 200) * 0.01));
			dmg1 = Math.round(dmg1);
			doDamage(dmg1);
			outputText("Alvina slice at " + monster.a + monster.short + " with her scythe leaving deep wounds. (<b><font color=\"#800000\">" + String(dmg1) + "</font></b>)\n\n");
			monster.createStatusEffect(StatusEffects.Hemorrhage2, 3, 0.1, 0, 0);
		}
		public function alvinaCombatActions4():void {
			var damage2:Number = player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
			damage2 += scalingBonusIntelligenceCompanion() * 2;
			damage2 = Math.round(damage2);
			if (monster.plural) damage2 *= 5;
			doFireDamage(damage2);
			outputText("Alvina sigh in annoyance and toss a fireball which explode on impact setting ");
			if (monster.plural) outputText("all enemies");
			else outputText("the enemy");
			outputText(" on fire! (<b><font color=\"#800000\">" + String(damage2) + "</font></b>)\n\n");
			monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		}
		public function alvinaCombatActions5():void {
			var dmg:Number = player.statusEffectv2(StatusEffects.CombatFollowerAlvina);
			dmg += scalingBonusIntelligenceCompanion() * 20;
			dmg = Math.round(dmg);
			doDamage(dmg);
			outputText("Alvina is looking terribly bored.\n\n");
			outputText("\"<i>[name] I am seriously going to fall asleep at this rate so if you would let me handle this...</i>\"\n\n");
			outputText("Without warning she open both hands, her scythe floating by her side, as she get to work, tracing a pattern in the air as the very reality in front of you collapse! You watch in horror and awe as a swirling hole of empty blackness pulls your opponent into what looks to be a null space between dimensions. ");
			outputText(monster.capitalA + monster.short + " appear back a few seconds later with gashes and wounds all over as the black hole, for what else could it be, collapse on itself and explode in a deflagration of black magic so strong you are pushed back a few meters. (<b><font color=\"#800000\">" + String(dmg) + "</font></b>)\n\n");
		}
		
		public function mitziCombatActions():void {
			clearOutput();
			if (player.statusEffectv4(StatusEffects.CombatFollowerMitzi) > 0) {
				var choice9:Number = rand(20);
				if (player.hasPerk(PerkLib.MotivationSu)) {
					if (choice9 == 0) mitziCombatActions0();
					if (choice9 >= 1 && choice9 < 10) mitziCombatActions1();
					if (choice9 >= 10 && choice9 < 14) mitziCombatActions2();
					if (choice9 >= 14 && choice9 < 17) mitziCombatActions3();
					if (choice9 >= 17) mitziCombatActions4();
				}
				else if (player.hasPerk(PerkLib.MotivationEx)) {
					if (choice9 < 4) mitziCombatActions0();
					if (choice9 >= 4 && choice9 < 12) mitziCombatActions1();
					if (choice9 >= 12 && choice9 < 15) mitziCombatActions2();
					if (choice9 >= 15 && choice9 < 18) mitziCombatActions3();
					if (choice9 == 18 || choice9 == 19) mitziCombatActions4();
				}
				else if (player.hasPerk(PerkLib.Motivation)) {
					if (choice9 < 7) mitziCombatActions0();
					if (choice9 >= 7 && choice9 < 13) mitziCombatActions1();
					if (choice9 >= 13 && choice9 < 16) mitziCombatActions2();
					if (choice9 == 16 || choice9 == 17) mitziCombatActions3();
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
			if (monster.HP <= monster.minHP() || monster.lust >= monster.maxLust()) enemyAI();
			else {
				menu();
				addButton(0, "Next", combatMenu, false);
			}
		}
		public function mitziCombatActions0():void {
			outputText("Mitzi and her daughters stand by, waiting for an opportunity to attack.\n\n");
		}
		public function mitziCombatActions1():void {
			var dmg4:Number = player.statusEffectv1(StatusEffects.CombatFollowerMitzi);
			dmg4 += scalingBonusStrengthCompanion() * 0.25;
			dmg4 = Math.round(dmg4);
			doDamage(dmg4);
			outputText("Mitzi takes a couple needles from her belt then hurls them at " + monster.a + monster.short + ". <b>(<font color=\"#800000\">" + String(dmg4) + "</font>)</b>\n\n");
		}
		public function mitziCombatActions2():void {
			outputText("Lildea pulls out a bubbling vial of a green liquid then tosses at " + monster.a + monster.short + ". The vial shatters on contact, causing the contents to spill onto " + monster.pronoun2 + ". ");
			doPoisonDamage(((player.statusEffectv2(StatusEffects.CombatFollowerMitzi)/4)+20), true, true);
			outputText("\n\n");
			if (monster.hasStatusEffect(StatusEffects.PoisonDoTH)) monster.addStatusValue(StatusEffects.PoisonDoTH,1,1);
			else monster.createStatusEffect(StatusEffects.PoisonDoTH,4,0.02,0,0);
		}
		public function mitziCombatActions3():void {
			var lustDmg:Number = Math.round(player.statusEffectv3(StatusEffects.CombatFollowerMitzi) / 6);
			outputText("Furxia throws out a barrage of aphrodisia laced needles at " + monster.a + monster.short + ". ");
			monster.teased(lustDmg);
			outputText("\n\n");
		}
		public function mitziCombatActions4():void {
			outputText("Roxy whips out two circular glass bottles filled with a pink liquid. She tosses them at " + monster.a + monster.short + " releasing a cloud of pink fog around " + monster.pronoun2 + ". ");
			monster.teased(rand(player.statusEffectv3(StatusEffects.CombatFollowerMitzi)/4)+20);
			outputText("\n\n");
			if (monster.hasStatusEffect(StatusEffects.LustDoTH)) monster.addStatusValue(StatusEffects.LustDoTH,1,1);
			else monster.createStatusEffect(StatusEffects.LustDoTH,4,0.02,0,0);
		}
	}
}