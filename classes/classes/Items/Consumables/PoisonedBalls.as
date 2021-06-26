/**
 * ...
 * @author Ormael
 */
package classes.Items.Consumables 
{
	import classes.Items.Consumable;
	import classes.PerkLib;
	//import classes.Monster;
	import classes.internals.Utils;
	import classes.Scenes.SceneLib;

	public class PoisonedBalls extends Consumable {
		
		public function PoisonedBalls() 
		{
			super("PoisonB", "PoisonedBalls", "a Poisoned Balls", 60, "Three poisonous ball-shaped throwing weapons.  Though good for only a single use, they're guaranteed to do medium to high damage to solo or weak group of enemies if they hit.  Inflicts 1440 to 8640 poison damage.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss Poisoned Balls at your foe");
			if (game.monster.hasPerk(PerkLib.EnemyGroupType) || game.monster.hasPerk(PerkLib.EnemyLargeGroupType)) outputText("s");
			outputText("!  The toxic spheres fly straight and true, almost as if they are sentient as they arc towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 320 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 320
				outputText("Quick reflexes allow " + game.monster.pronoun2 + " to avoid the balls!  The deadly spheres shatter into a toxic cloud far from your opponent upon landing somewhere in the distance.");
			}
			else { //Not dodged
				var damage:Number = 1440 + Utils.rand(721);
				if (game.player.level >= 6) {
					if (game.player.level >= 24) {
						if (game.player.level >= 42) damage *= 4;
						else damage *= 3;
					}
					else damage *= 2;
				}
				if (game.monster.hasPerk(PerkLib.EnemyGroupType) || game.monster.hasPerk(PerkLib.EnemyLargeGroupType)) damage *= 5;
				outputText(game.monster.capitalA + game.monster.short + " is hit with the Poisoned Balls!  They breaks apart, leaving " + game.monster.pronoun2 + " in a cloud of poison. ");
				damage = SceneLib.combat.doPoisonDamage(damage, true, true);
				if (game.monster.HP < game.monster.minHP()) game.monster.HP = game.monster.minHP() - 1;
			}
			return(false);
		}
	}
}