/**
 * Coded by Ormael on 31.01.2019.
 */
package classes.Scenes.Combat 
{
import classes.CoC;
import classes.EngineCore;
//import classes.Races;
import classes.GlobalFlags.kFLAGS;
//import classes.IMutations.IMutationsLib;
import classes.Scenes.SceneLib;
//import classes.Scenes.NPCs.TyrantiaFollower;
import classes.PerkLib;
import classes.StatusEffects;
//import classes.StatusEffects.VampireThirstEffect;

	public class CombatTamedMonstersActions extends BaseCombatContent
	{
		
		public function CombatTamedMonstersActions() {}
		
		public function increasedEfficiencyOfTamedMostersAttacks():Number {
			var dmgamp:Number = 1;
			if (player.weapon == weapons.SCECOMM) dmgamp += 0.5;
			if (player.shield == shields.Y_U_PAN) dmgamp += 0.25;
			if (player.hasPerk(PerkLib.CommandingTone)) dmgamp += 0.1;
			if (player.hasPerk(PerkLib.DiaphragmControl)) dmgamp += 0.1;
			if (player.hasPerk(PerkLib.VocalTactician)) dmgamp += 0.15;
			return dmgamp;
		}

		public function tamedMonstersMenu():void {
			menu();
			if (player.hasStatusEffect(StatusEffects.TamedMonster01)) {
				if (monster.isFlying() || monster.flyer) addButtonIfTrue(0, "No1", curry(tamedMonsterAttack, 1), "Your tamed monster can't attack flying enemy.", !SceneLib.campMakeWinions.tameMonster01FlightCapable, "Use tamed monster No1.");
				else addButton(0, "No1", curry(tamedMonsterAttack, 1)).hint("Use tamed monster No1.");
			}
			else addButtonDisabled(0, "No1", "You not have tamed monster No1.");
			if (player.hasPerk(PerkLib.Beast02)) {
				if (player.hasStatusEffect(StatusEffects.TamedMonster02)) {
					if (monster.isFlying() || monster.flyer) addButtonIfTrue(1, "No2", curry(tamedMonsterAttack, 2), "Your tamed monster can't attack flying enemy.", !SceneLib.campMakeWinions.tameMonster02FlightCapable, "Use tamed monster No2.");
					else addButton(1, "No2", curry(tamedMonsterAttack, 2)).hint("Use tamed monster No2.");
				}
				else addButtonDisabled(1, "No2", "You not have tamed monster No2.");
			}
			if (player.hasPerk(PerkLib.ThreeTimesATame)) {
				if (player.hasStatusEffect(StatusEffects.TamedMonster03)) {
					if (monster.isFlying() || monster.flyer) addButtonIfTrue(2, "No3", curry(tamedMonsterAttack, 3), "Your tamed monster can't attack flying enemy.", !SceneLib.campMakeWinions.tameMonster03FlightCapable, "Use tamed monster No3.");
					else addButton(2, "No3", curry(tamedMonsterAttack, 3)).hint("Use tamed monster No3.");
				}
				else addButtonDisabled(2, "No3", "You not have tamed monster No3.");
			}
			if (player.hasPerk(PerkLib.FourthTamerOfTheApocalypse)) {
				if (player.hasStatusEffect(StatusEffects.TamedMonster04)) {
					if (monster.isFlying() || monster.flyer) addButtonIfTrue(3, "No4", curry(tamedMonsterAttack, 4), "Your tamed monster can't attack flying enemy.", !SceneLib.campMakeWinions.tameMonster04FlightCapable, "Use tamed monster No4.");
					else addButton(3, "No4", curry(tamedMonsterAttack, 4)).hint("Use tamed monster No4.");
				}
				else addButtonDisabled(3, "No4", "You not have tamed monster No4.");
			}
			addButton(14, "Back", SceneLib.combat.combatMenu, false);
		}
		
		public function tamedMonsterAttack(no:Number):void {
			clearOutput();
			var weapon:Number = 0;
			var dmg:Number = 0;
			if (no == 1) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster01);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(1);
			}
			if (no == 2) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster02);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(2);
			}
			if (no == 3) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster03);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(3);
			}
			if (no == 4) {
				weapon += player.statusEffectv1(StatusEffects.TamedMonster04);
				dmg += SceneLib.combat.scalingBonusStrengthTamedMonster(4);
			}
			if (weapon < 51) dmg *= (1 + (weapon * 0.03));
			else if (weapon >= 51 && weapon < 101) dmg *= (2.5 + ((weapon - 50) * 0.025));
			else if (weapon >= 101 && weapon < 151) dmg *= (3.75 + ((weapon - 100) * 0.02));
			else if (weapon >= 151 && weapon < 201) dmg *= (4.75 + ((weapon - 150) * 0.015));
			else dmg *= (5.5 + (weapon * 0.01));
			dmg *= increasedEfficiencyOfTamedMostersAttacks();
			if (player.hasPerk(PerkLib.WorkingTogether) && SceneLib.campMakeWinions.currentTamedMonstersCount() > 1) dmg *= SceneLib.campMakeWinions.currentTamedMonstersCount();
			dmg = Math.round(dmg * SceneLib.combat.comfoll.increasedEfficiencyOfAttacks());
			outputText("Your tamed ");
			if (no == 1) outputText("" + SceneLib.campMakeWinions.tameMonster01 + "");
			if (no == 2) outputText("" + SceneLib.campMakeWinions.tameMonster02 + "");
			if (no == 3) outputText("" + SceneLib.campMakeWinions.tameMonster03 + "");
			if (no == 4) outputText("" + SceneLib.campMakeWinions.tameMonster04 + "");
			outputText(" attacks [themonster]. ");
			doDamage(dmg, true, true);
			outputText("\n\n");
			SceneLib.combat.enemyAIImpl();
		}
	}
}