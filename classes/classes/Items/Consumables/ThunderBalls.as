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

	public class ThunderBalls extends Consumable {
		
		public function ThunderBalls() 
		{
			super("THUNDBl", "THUNDERballs", "a THUNDERballs", 60, "Three electrified ball-shaped throwing weapons.  Though good for only a single use, they're guaranteed to do medium to high damage to solo or weak group of enemies if they hit.  Inflicts 1440 to 8640 lighting damage.");
		}
		
		override public function canUse():Boolean {
			if (game.inCombat) return true;
			outputText("There's no one to throw it at!");
			return false;
		}
		
		override public function useItem():Boolean {
			clearOutput();
			outputText("You toss THUNDERballs at your foe");
			if (game.monster.hasPerk(PerkLib.EnemyGroupType) || game.monster.hasPerk(PerkLib.EnemyLargeGroupType)) outputText("s");
			outputText("!  The shocking spheres fly straight and true, almost as if they are sentient as they arc towards " + game.monster.a + game.monster.short + "!\n");
			if (game.monster.spe - 320 > Utils.rand(100) + 1) { //1% dodge for each point of speed over 320
				outputText("Quick reflexes allow " + game.monster.pronoun2 + " to avoid the balls!  The thunderous spheres shatter far from your opponent, causing electricity discharge as they impact something in the distance.");
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
				outputText(game.monster.capitalA + game.monster.short + " is hit with the THUNDERballs!  They crackle and shock, electrocuting " + game.monster.pronoun2 + ". ");
				damage = SceneLib.combat.doLightingDamage(damage, true, true);
				if (game.monster.HP < game.monster.minHP()) game.monster.HP = game.monster.minHP() - 1;
			}
			return(false);
		}
	}
}