/**
 * ...
 * @author Liadri
 */
package classes.Items.Vehicles 
{
	import classes.BodyParts.Tail;
	import classes.BodyParts.Wings;
	import classes.Items.Vehicles;
	import classes.PerkLib;
	import classes.Player;

	public class GoblinMechAlpha extends Vehicles
	{
		
		public function GoblinMechAlpha() 
		{
			super("GobMAlp", "GoblinMechAlpha", "Goblin Mech Alpha", "a Goblin Mech Alpha", 0, 0, 500, "A customisable goblin invention, this six-legged, large mech is equipped with a comfortable seat, fit for a goblin or a rather small person. \n\nType: Goblin Mech \nBase value: 500","Mech");
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			if (game.player.elfScore() >= 11) { //Elf
				outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				return false;
			}
			if (game.player.tallness > 48 || game.player.tailType != Tail.NONE || game.player.wings.type != Wings.NONE) { //Taller than 4 ft or having wings/tail
				outputText("Your current anatomy or size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				return false;
			}
			return true;
		}
		
		override public function playerEquip():Vehicles {
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP = 1.2 * game.player.maxHP();
			if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP = 1.35 * game.player.maxHP();
			if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP = 1.5 * game.player.maxHP();
			return super.playerEquip();
		}
		
		override public function playerRemove():Vehicles {
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP /= 1.2;
			if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP /= 1.35;
			if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP /= 1.5;
			game.player.HP = Math.round(game.player.HP);
			return super.playerRemove();
		}
	}
}