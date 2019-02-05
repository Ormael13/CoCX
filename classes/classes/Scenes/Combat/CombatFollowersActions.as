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
					var dmg1:Number = 100;
					doDamage(dmg1);
					outputText("Neisa slash at " + monster.a + monster.short + " with her sword. (Attack)<b>(<font color=\"#800000\">" + String(dmg1) + "</font>)</b>\n\n");
				}
				if (choice1 >= 14 && choice1 < 17) outputText("Neisa move in front of you deflecting the opponent attacks with her shield in order to assist your own defence. (pc gain a +1 armor/level for 1 round)\n\n");
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
			
			if (monster.HP <= 0) enemyAI();
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