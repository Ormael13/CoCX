/**
 * Coded by Ormael on 31.01.2019.
 */
package classes.Scenes.Combat 
{
import classes.CoC;
import classes.EngineCore;
import classes.GlobalFlags.kFLAGS;
import classes.Scenes.SceneLib;
import classes.PerkLib;
import classes.StatusEffects;

	public class CombatTamedMonstersActions extends BaseCombatContent
	{
		
		public function CombatTamedMonstersActions() {}
		
		public function increasedEfficiencyOfTamedMostersAttacks():Number {
			var dmgamp:Number = 1;
			if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
			if (player.shield == shields.Y_U_PAN) dmgamp += 0.25;
			if (player.armor == armors.ARCHNECC) dmgamp += 0.25;
			if (player.upperGarment == undergarments.ARCHNECB) dmgamp += 0.2;
			if (player.lowerGarment == undergarments.ARCHNECP) dmgamp += 0.2;
			if (player.hasPerk(PerkLib.NoLimits)) dmgamp += 0.25;
			if (player.hasPerk(PerkLib.CommandingTone)) dmgamp += 0.1;
			if (player.hasPerk(PerkLib.DiaphragmControl)) dmgamp += 0.1;
			if (player.hasPerk(PerkLib.VocalTactician)) dmgamp += 0.15;
			if (player.hasPerk(PerkLib.AbsorbNutrient) && player.perkv1(PerkLib.AbsorbNutrient) > 4) dmgamp += 0.5;
			if (player.hasPerk(PerkLib.AbsorbNutrient) && player.perkv1(PerkLib.AbsorbNutrient) > 5) dmgamp += 0.5;
			if (player.hasPerk(PerkLib.AbsorbNutrient) && player.perkv1(PerkLib.AbsorbNutrient) > 6) dmgamp += 1;
			return dmgamp;
		}

		public function tamedMonstersMenu(page:int = 1):void {
			menu();
			if (player.hasStatusEffect(StatusEffects.TamedMonster01)) outputText("<b>Tamed Monster No.1 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster01))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster02)) outputText("<b>Tamed Monster No.2 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster02))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster03)) outputText("<b>Tamed Monster No.3 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster03))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster04)) outputText("<b>Tamed Monster No.4 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster04))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster05)) outputText("<b>Tamed Monster No.5 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster05))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster06)) outputText("<b>Tamed Monster No.6 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster06))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster07)) outputText("<b>Tamed Monster No.7 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster07))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster08)) outputText("<b>Tamed Monster No.8 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster08))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster09)) outputText("<b>Tamed Monster No.9 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster09))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster10)) outputText("<b>Tamed Monster No.10 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster10))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster11)) outputText("<b>Tamed Monster No.11 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster11))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster12)) outputText("<b>Tamed Monster No.12 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster12))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster13)) outputText("<b>Tamed Monster No.13 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster13))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster14)) outputText("<b>Tamed Monster No.14 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster14))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster15)) outputText("<b>Tamed Monster No.15 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster15))+"%");
			if (player.hasStatusEffect(StatusEffects.TamedMonster16)) outputText("<b>Tamed Monster No.16 HP:</b> "+(100-player.statusEffectv2(StatusEffects.TamedMonster16))+"%");
			if (page == 1) {
				//0 - taming ring
				if (player.hasStatusEffect(StatusEffects.TamedMonster01)) addButton(1, "No.1", tamedMonstersActionMenu, 1, 1).hint("Use tamed monster No.1");
				else addButtonDisabled(1, "No.1", "You do not have Monster No.1 tamed.");
				if (player.hasPerk(PerkLib.Beast02)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster02)) addButton(2, "No.2", tamedMonstersActionMenu, 2, 1).hint("Use tamed monster No.2");
					else addButtonDisabled(2, "No.2", "You do not have Monster No.2 tamed.");
				}
				if (player.hasPerk(PerkLib.ThreeTimesATame)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster03)) addButton(3, "No.3", tamedMonstersActionMenu, 3, 1).hint("Use tamed monster No.3");
					else addButtonDisabled(3, "No.3", "You do not have Monster No.3 tamed.");
				}
				if (player.hasPerk(PerkLib.FourthTamerOfTheApocalypse)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster04)) addButton(4, "No.4", tamedMonstersActionMenu, 4, 1).hint("Use tamed monster No.4");
					else addButtonDisabled(4, "No.4", "You do not have Monster No.4 tamed.");
				}
				if (player.hasPerk(PerkLib.FifthTamed)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster05)) addButton(5, "No.5", tamedMonstersActionMenu, 5, 1).hint("Use tamed monster No.5");
					else addButtonDisabled(5, "No.5", "You do not have Monster No.5 tamed.");
				}
				if (player.hasPerk(PerkLib.SicEmSix)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster06)) addButton(6, "No.6", tamedMonstersActionMenu, 6, 1).hint("Use tamed monster No.6");
					else addButtonDisabled(6, "No.6", "You do not have Monster No.6 tamed.");
				}
				if (player.hasPerk(PerkLib.LuckyNumberTamer)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster07)) addButton(7, "No.7", tamedMonstersActionMenu, 7, 1).hint("Use tamed monster No.7");
					else addButtonDisabled(7, "No.7", "You do not have Monster No.7 tamed.");
				}
				if (player.hasPerk(PerkLib.KaijuNo8)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster08)) addButton(8, "No.8", tamedMonstersActionMenu, 8, 1).hint("Use tamed monster No.8");
					else addButtonDisabled(8, "No.8", "You do not have Monster No.8 tamed.");
				}
				if (player.hasPerk(PerkLib.CloudNumber9)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster09)) addButton(9, "No.9", tamedMonstersActionMenu, 9, 1).hint("Use tamed monster No.9");
					else addButtonDisabled(9, "No.9", "You do not have Monster No.9 tamed.");
				}
				addButton(10, "Next", tamedMonstersMenu, page - 1);
				addButton(11, "Prev", tamedMonstersMenu, page + 1);
			}
			if (page == 2) {
				if (player.hasPerk(PerkLib.ThereIs10TypesOfTamedMonsters)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster10)) addButton(0, "No.10", tamedMonstersActionMenu, 10, 2).hint("Use tamed monster No.10");
					else addButtonDisabled(0, "No.10", "You do not have Monster No.10 tamed.");
				}
				if (player.hasPerk(PerkLib.UpToEleven)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster11)) addButton(1, "No.11", tamedMonstersActionMenu, 11, 2).hint("Use tamed monster No.11");
					else addButtonDisabled(1, "No.11", "You do not have Monster No.11 tamed.");
				}
				if (player.hasPerk(PerkLib.DirtyDozen)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster12)) addButton(2, "No.12", tamedMonstersActionMenu, 12, 2).hint("Use tamed monster No.12");
					else addButtonDisabled(2, "No.12", "You do not have Monster No.12 tamed.");
				}
				if (player.hasPerk(PerkLib.Friday13th)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster13)) addButton(3, "No.13", tamedMonstersActionMenu, 13, 2).hint("Use tamed monster No.13");
					else addButtonDisabled(3, "No.13", "You do not have Monster No.13 tamed.");
				}
				if (player.hasPerk(PerkLib.Lucky14)) {
					if (player.hasStatusEffect(StatusEffects.TamedMonster14)) addButton(4, "No.14", tamedMonstersActionMenu, 14, 2).hint("Use tamed monster No.14");
					else addButtonDisabled(4, "No.14", "You do not have Monster No.14 tamed.");
				}
				//5
				//6
				addButton(10, "Next", tamedMonstersMenu, page + 1);
				addButton(11, "Prev", tamedMonstersMenu, page - 1);
			}
			addButton(14, "Back", SceneLib.combat.combatMenu, false);
		}
		
		public function tamedMonstersFirstAttack():void {
			if (player.hasStatusEffect(StatusEffects.TamedMonster01)) tamedMonsterAttackMelee(1);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster02)) tamedMonsterAttackMelee(2);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster03)) tamedMonsterAttackMelee(3);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster04)) tamedMonsterAttackMelee(4);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster05)) tamedMonsterAttackMelee(5);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster06)) tamedMonsterAttackMelee(6);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster07)) tamedMonsterAttackMelee(7);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster08)) tamedMonsterAttackMelee(8);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster09)) tamedMonsterAttackMelee(9);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster10)) tamedMonsterAttackMelee(10);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster11)) tamedMonsterAttackMelee(11);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster12)) tamedMonsterAttackMelee(12);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster13)) tamedMonsterAttackMelee(13);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster14)) tamedMonsterAttackMelee(14);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster15)) tamedMonsterAttackMelee(15);
			else if (player.hasStatusEffect(StatusEffects.TamedMonster16)) tamedMonsterAttackMelee(16);
		}
		
		public function tamedMonstersActionMenu(no:Number, page:Number):void {
			menu();
			if (no == 1) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 1), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster01)>0, "Command tamed monster No.1 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 1)).hint("Command tamed monster No.1 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 1), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster01)>0, "Command tamed monster No.1 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 1), "Tamed monster No.1 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster01)>0, "Command tamed monster No.1 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 2) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 2), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster02)>0, "Command tamed monster No.2 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 2)).hint("Command tamed monster No.2 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 2), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster02)>0, "Command tamed monster No.2 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 2), "Tamed monster No.2 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster02)>0, "Command tamed monster No.2 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 3) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 3), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster03)>0, "Command tamed monster No.3 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 3)).hint("Command tamed monster No.3 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 3), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster03)>0, "Command tamed monster No.3 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 3), "Tamed monster No.3 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster03)>0, "Command tamed monster No.3 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 4) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 4), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster04)>0, "Command tamed monster No.4 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 4)).hint("Command tamed monster No.4 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 4), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster04)>0, "Command tamed monster No.4 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 4), "Tamed monster No.4 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster04)>0, "Command tamed monster No.4 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 5) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 5), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster05)>0, "Command tamed monster No.5 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 5)).hint("Command tamed monster No.5 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 5), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster05)>0, "Command tamed monster No.5 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 5), "Tamed monster No.5 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster05)>0, "Command tamed monster No.5 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 6) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 6), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster06)>0, "Command tamed monster No.6 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 6)).hint("Command tamed monster No.6 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 6), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster06)>0, "Command tamed monster No.6 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 6), "Tamed monster No.6 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster06)>0, "Command tamed monster No.6 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 7) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 7), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster07)>0, "Command tamed monster No.7 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 7)).hint("Command tamed monster No.7 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 7), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster07)>0, "Command tamed monster No.7 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 7), "Tamed monster No.7 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster07)>0, "Command tamed monster No.7 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 8) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 8), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster08)>0, "Command tamed monster No.8 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 8)).hint("Command tamed monster No.8 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 8), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster08)>0, "Command tamed monster No.8 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 8), "Tamed monster No.8 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster08)>0, "Command tamed monster No.8 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 9) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 9), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster09)>0, "Command tamed monster No.9 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 9)).hint("Command tamed monster No.9 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 9), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster09)>0, "Command tamed monster No.9 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 9), "Tamed monster No.9 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster09)>0, "Command tamed monster No.9 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 10) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 10), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster10)>0, "Command tamed monster No.10 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 10)).hint("Command tamed monster No.10 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 10), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster10)>0, "Command tamed monster No.10 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 10), "Tamed monster No.10 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster10)>0, "Command tamed monster No.10 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 11) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 11), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster11)>0, "Command tamed monster No.11 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 11)).hint("Command tamed monster No.11 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 11), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster11)>0, "Command tamed monster No.11 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 11), "Tamed monster No.11 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster11)>0, "Command tamed monster No.11 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 12) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 12), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster12)>0, "Command tamed monster No.12 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 12)).hint("Command tamed monster No.12 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 12), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster12)>0, "Command tamed monster No.12 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 12), "Tamed monster No.12 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster12)>0, "Command tamed monster No.12 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 13) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 13), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster13)>0, "Command tamed monster No.13 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 13)).hint("Command tamed monster No.13 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 13), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster13)>0, "Command tamed monster No.13 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 13), "Tamed monster No.13 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster13)>0, "Command tamed monster No.13 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 14) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 14), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster14)>0, "Command tamed monster No.14 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 14)).hint("Command tamed monster No.14 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 14), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster14)>0, "Command tamed monster No.14 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 14), "Tamed monster No.14 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster14)>0, "Command tamed monster No.14 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 15) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 15), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster15)>0, "Command tamed monster No.15 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 15)).hint("Command tamed monster No.15 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 15), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster15)>0, "Command tamed monster No.15 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 15), "Tamed monster No.15 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster15)>0, "Command tamed monster No.15 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			if (no == 16) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "Attack", curry(tamedMonsterAttackMelee, 16), "Your tamed monster can’t attack flying enemies.", player.statusEffectv3(StatusEffects.TamedMonster16)>0, "Command tamed monster No.16 to attack.");
				else addButton(0, "Attack", curry(tamedMonsterAttackMelee, 16)).hint("Command tamed monster No.16 to attack.");
				addButtonIfTrue(1, "M.Bolt", curry(tamedMonsterAttackMagic, 16), "Your tamed monster can’t spellcast.", player.statusEffectv2(StatusEffects.TamedMonster16)>0, "Command tamed monster No.16 to cast magic bolt.");
				if (flags[kFLAGS.TAMED_MONSTER_PROTECTING] > 0) addButtonIfTrue(4, "Protect", curry(tamedMonsterProtect, 16), "Tamed monster No.16 has not yet fully recovered.", player.statusEffectv2(StatusEffects.TamedMonster16)>0, "Command tamed monster No.16 to protect you.");
				else addButtonDisabled(4, "Protect", "You already commanded one of the tamed monsters to protect you.");
			}
			addButton(14, "Back", tamedMonstersMenu, page);
		}
		
		public function tamedMonsterAttackMelee(no:Number):void {
			clearOutput();
			var weapon:Number = 0;
			var dmg:Number = 0;
			var repeat:Number = 0;
			if (no == 1) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster01);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(1);
				if (player.statusEffectv4(StatusEffects.TamedMonster01) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster01);
				if (player.statusEffectv4(StatusEffects.TamedMonster01a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster01a);
				}
			}
			if (no == 2) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster02);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(2);
				if (player.statusEffectv4(StatusEffects.TamedMonster02) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster02);
				if (player.statusEffectv4(StatusEffects.TamedMonster02a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster02a);
				}
			}
			if (no == 3) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster03);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(3);
				if (player.statusEffectv4(StatusEffects.TamedMonster03) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster03);
				if (player.statusEffectv4(StatusEffects.TamedMonster03a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster03a);
				}
			}
			if (no == 4) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster04);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(4);
				if (player.statusEffectv4(StatusEffects.TamedMonster04) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster04);
				if (player.statusEffectv4(StatusEffects.TamedMonster04a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster04a);
				}
			}
			if (no == 5) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster05);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(5);
				if (player.statusEffectv4(StatusEffects.TamedMonster05) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster05);
				if (player.statusEffectv4(StatusEffects.TamedMonster05a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster05a);
				}
			}
			if (no == 6) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster06);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(6);
				if (player.statusEffectv4(StatusEffects.TamedMonster06) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster06);
				if (player.statusEffectv4(StatusEffects.TamedMonster06a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster06a);
				}
			}
			if (no == 7) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster07);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(7);
				if (player.statusEffectv4(StatusEffects.TamedMonster07) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster07);
				if (player.statusEffectv4(StatusEffects.TamedMonster07a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster07a);
				}
			}
			if (no == 8) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster08);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(8);
				if (player.statusEffectv4(StatusEffects.TamedMonster08) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster08);
				if (player.statusEffectv4(StatusEffects.TamedMonster08a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster08a);
				}
			}
			if (no == 9) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster09);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(9);
				if (player.statusEffectv4(StatusEffects.TamedMonster09) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster09);
				if (player.statusEffectv4(StatusEffects.TamedMonster09a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster09a);
				}
			}
			if (no == 10) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster10);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(10);
				if (player.statusEffectv4(StatusEffects.TamedMonster10) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster10);
				if (player.statusEffectv4(StatusEffects.TamedMonster10a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster10a);
				}
			}
			if (no == 11) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster11);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(11);
				if (player.statusEffectv4(StatusEffects.TamedMonster11) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster11);
				if (player.statusEffectv4(StatusEffects.TamedMonster11a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster11a);
				}
			}
			if (no == 12) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster12);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(12);
				if (player.statusEffectv4(StatusEffects.TamedMonster12) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster12);
				if (player.statusEffectv4(StatusEffects.TamedMonster12a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster12a);
				}
			}
			if (no == 13) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster13);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(13);
				if (player.statusEffectv4(StatusEffects.TamedMonster13a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster13a);
				}
			}
			if (no == 14) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster14);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(14);
				if (player.statusEffectv4(StatusEffects.TamedMonster14a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster14a);
				}
			}
			if (no == 15) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster15);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(15);
				if (player.statusEffectv4(StatusEffects.TamedMonster15a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster15a);
				}
			}
			if (no == 16) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster16);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(16);
				if (player.statusEffectv4(StatusEffects.TamedMonster16a) > 0) {
					if (repeat < 1) repeat = 1;
					repeat *= player.statusEffectv4(StatusEffects.TamedMonster16a);
				}
			}
			if (weapon < 51) dmg *= (1 + (weapon * 0.01));
			else if (weapon >= 51 && weapon < 101) dmg *= (1.5 + ((weapon - 50) * 0.015));
			else if (weapon >= 101 && weapon < 151) dmg *= (2.25 + ((weapon - 100) * 0.02));
			else if (weapon >= 151 && weapon < 201) dmg *= (3.25 + ((weapon - 150) * 0.025));
			else if (weapon >= 201 && weapon < 251) dmg *= (5.5 + ((weapon - 200) * 0.03));
			else if (weapon >= 251 && weapon < 301) dmg *= (7 + ((weapon - 250) * 0.035));
			else if (weapon >= 301 && weapon < 351) dmg *= (8.75 + ((weapon - 300) * 0.04));
			else if (weapon >= 351 && weapon < 401) dmg *= (10.75 + ((weapon - 350) * 0.045));
			else dmg *= (13 + ((weapon - 400) * 0.05));
			if (repeat > 0) dmg *= (1 + (0.5 * repeat));
			dmg *= increasedEfficiencyOfTamedMostersAttacks();
			if (player.hasPerk(PerkLib.WorkingTogether) && SceneLib.campMakeWinions.currentTamedMonstersIncludingGroupsCount() > 1) dmg *= SceneLib.campMakeWinions.currentTamedMonstersIncludingGroupsCount();
			dmg = Math.round(dmg * SceneLib.combat.comfoll.increasedEfficiencyOfAttacks());
			outputText("Your tamed ");
			if (no == 1) outputText(""+flags[kFLAGS.TAMED_01_NAME]+"");
			if (no == 2) outputText(""+flags[kFLAGS.TAMED_02_NAME]+"");
			if (no == 3) outputText(""+flags[kFLAGS.TAMED_03_NAME]+"");
			if (no == 4) outputText(""+flags[kFLAGS.TAMED_04_NAME]+"");
			if (no == 5) outputText(""+flags[kFLAGS.TAMED_05_NAME]+"");
			if (no == 6) outputText(""+flags[kFLAGS.TAMED_06_NAME]+"");
			if (no == 7) outputText(""+flags[kFLAGS.TAMED_07_NAME]+"");
			if (no == 8) outputText(""+flags[kFLAGS.TAMED_08_NAME]+"");
			if (no == 9) outputText(""+flags[kFLAGS.TAMED_09_NAME]+"");
			if (no == 10) outputText(""+flags[kFLAGS.TAMED_10_NAME]+"");
			if (no == 11) outputText(""+flags[kFLAGS.TAMED_11_NAME]+"");
			if (no == 12) outputText(""+flags[kFLAGS.TAMED_12_NAME]+"");
			if (no == 13) outputText(""+flags[kFLAGS.TAMED_13_NAME]+"");
			if (no == 14) outputText(""+flags[kFLAGS.TAMED_14_NAME]+"");
			if (no == 15) outputText(""+flags[kFLAGS.TAMED_15_NAME]+"");
			if (no == 16) outputText(""+flags[kFLAGS.TAMED_16_NAME]+"");
			outputText(" attacks [themonster]. ");
			doMinionPhysDamage(dmg, true, true);
			while (repeat-->0) doMinionPhysDamage(dmg, true, true);
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
		}
		public function tamedMonsterAttackMagic(no:Number):void {
			clearOutput();
			var weapon:Number = 0;
			var dmg:Number = 0;
			var repeat:Number = 0;
			if (no == 1) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(1);
				if (player.statusEffectv4(StatusEffects.TamedMonster01) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster01);
			}
			if (no == 2) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(2);
				if (player.statusEffectv4(StatusEffects.TamedMonster02) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster02);
			}
			if (no == 3) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(3);
				if (player.statusEffectv4(StatusEffects.TamedMonster03) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster03);
			}
			if (no == 4) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(4);
				if (player.statusEffectv4(StatusEffects.TamedMonster04) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster04);
			}
			if (no == 5) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(5);
				if (player.statusEffectv4(StatusEffects.TamedMonster05) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster05);
			}
			if (no == 6) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(6);
				if (player.statusEffectv4(StatusEffects.TamedMonster06) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster06);
			}
			if (no == 7) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(7);
				if (player.statusEffectv4(StatusEffects.TamedMonster07) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster07);
			}
			if (no == 8) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(8);
				if (player.statusEffectv4(StatusEffects.TamedMonster08) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster08);
			}
			if (no == 9) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(9);
				if (player.statusEffectv4(StatusEffects.TamedMonster09) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster09);
			}
			if (no == 10) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(10);
				if (player.statusEffectv4(StatusEffects.TamedMonster10) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster10);
			}
			if (no == 11) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(11);
				if (player.statusEffectv4(StatusEffects.TamedMonster11) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster11);
			}
			if (no == 12) {
				dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(12);
				if (player.statusEffectv4(StatusEffects.TamedMonster12) > 0) repeat += player.statusEffectv4(StatusEffects.TamedMonster12);
			}
			if (no == 13) dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(13);
			if (no == 14) dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(14);
			if (no == 15) dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(15);
			if (no == 16) dmg += SceneLib.combat.scalingBonusIntelligenceTamedMonster(16);
			if (weapon < 51) dmg *= (1 + (weapon * 0.01));
			else if (weapon >= 51 && weapon < 101) dmg *= (1.5 + ((weapon - 50) * 0.015));
			else if (weapon >= 101 && weapon < 151) dmg *= (2.25 + ((weapon - 100) * 0.02));
			else if (weapon >= 151 && weapon < 201) dmg *= (3.25 + ((weapon - 150) * 0.025));
			else if (weapon >= 201 && weapon < 251) dmg *= (5.5 + ((weapon - 200) * 0.03));
			else if (weapon >= 251 && weapon < 301) dmg *= (7 + ((weapon - 250) * 0.035));
			else if (weapon >= 301 && weapon < 351) dmg *= (8.75 + ((weapon - 300) * 0.04));
			else if (weapon >= 351 && weapon < 401) dmg *= (10.75 + ((weapon - 350) * 0.045));
			else dmg *= (13 + ((weapon - 400) * 0.05));
			if (repeat > 0) dmg *= (1 + (0.5 * repeat));
			dmg *= increasedEfficiencyOfTamedMostersAttacks();
			if (player.hasPerk(PerkLib.WorkingTogether) && SceneLib.campMakeWinions.currentTamedMonstersIncludingGroupsCount() > 1) dmg *= SceneLib.campMakeWinions.currentTamedMonstersIncludingGroupsCount();
			dmg = Math.round(dmg * SceneLib.combat.comfoll.increasedEfficiencyOfAttacks());
			outputText("Your tamed ");
			if (no == 1) outputText(""+flags[kFLAGS.TAMED_01_NAME]+"");
			if (no == 2) outputText(""+flags[kFLAGS.TAMED_02_NAME]+"");
			if (no == 3) outputText(""+flags[kFLAGS.TAMED_03_NAME]+"");
			if (no == 4) outputText(""+flags[kFLAGS.TAMED_04_NAME]+"");
			if (no == 5) outputText(""+flags[kFLAGS.TAMED_05_NAME]+"");
			if (no == 6) outputText(""+flags[kFLAGS.TAMED_06_NAME]+"");
			if (no == 7) outputText(""+flags[kFLAGS.TAMED_07_NAME]+"");
			if (no == 8) outputText(""+flags[kFLAGS.TAMED_08_NAME]+"");
			if (no == 9) outputText(""+flags[kFLAGS.TAMED_09_NAME]+"");
			if (no == 10) outputText(""+flags[kFLAGS.TAMED_10_NAME]+"");
			if (no == 11) outputText(""+flags[kFLAGS.TAMED_11_NAME]+"");
			if (no == 12) outputText(""+flags[kFLAGS.TAMED_12_NAME]+"");
			if (no == 13) outputText(""+flags[kFLAGS.TAMED_13_NAME]+"");
			if (no == 14) outputText(""+flags[kFLAGS.TAMED_14_NAME]+"");
			if (no == 15) outputText(""+flags[kFLAGS.TAMED_15_NAME]+"");
			if (no == 16) outputText(""+flags[kFLAGS.TAMED_16_NAME]+"");
			outputText(" shoot a magic bolt toward [themonster]. ");
			doMinionMagDamage(dmg, true, true);
			while (repeat-->0) doMinionMagDamage(dmg, true, true);
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
		}
		public function tamedMonsterProtect(no:Number):void {
			clearOutput();
			outputText("Your command tamed ");
			if (no == 1) outputText(""+flags[kFLAGS.TAMED_01_NAME]+"");
			if (no == 2) outputText(""+flags[kFLAGS.TAMED_02_NAME]+"");
			if (no == 3) outputText(""+flags[kFLAGS.TAMED_03_NAME]+"");
			if (no == 4) outputText(""+flags[kFLAGS.TAMED_04_NAME]+"");
			if (no == 5) outputText(""+flags[kFLAGS.TAMED_05_NAME]+"");
			if (no == 6) outputText(""+flags[kFLAGS.TAMED_06_NAME]+"");
			if (no == 7) outputText(""+flags[kFLAGS.TAMED_07_NAME]+"");
			if (no == 8) outputText(""+flags[kFLAGS.TAMED_08_NAME]+"");
			if (no == 9) outputText(""+flags[kFLAGS.TAMED_09_NAME]+"");
			if (no == 10) outputText(""+flags[kFLAGS.TAMED_10_NAME]+"");
			if (no == 11) outputText(""+flags[kFLAGS.TAMED_11_NAME]+"");
			if (no == 12) outputText(""+flags[kFLAGS.TAMED_12_NAME]+"");
			if (no == 13) outputText(""+flags[kFLAGS.TAMED_13_NAME]+"");
			if (no == 14) outputText(""+flags[kFLAGS.TAMED_14_NAME]+"");
			if (no == 15) outputText(""+flags[kFLAGS.TAMED_15_NAME]+"");
			if (no == 16) outputText(""+flags[kFLAGS.TAMED_16_NAME]+"");
			outputText(" to protect you from next enemy attack.");
			flags[kFLAGS.TAMED_MONSTER_PROTECTING] = no;
			menu();
			addButton(0, "Next", SceneLib.combat.combatMenu, false);
		}
	}
}