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
import classes.Races;

public class GoblinMechAlpha extends Vehicles
	{
		
		public function GoblinMechAlpha()
		{
			super("GobMAlp", "GoblinMechAlpha", "Goblin Mech Alpha", "a Goblin Mech Alpha", 0, 0, 500, "A customisable goblin invention, this six-legged, large mech is equipped with a comfortable seat, fit for a goblin or a rather small person. \n\nType: Goblin Mech \nBase value: 500","Mech");
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (!super.canEquip(doOutput, slot)) {
				return false;
			}
			if (game.player.isRace(Races.ELF) || game.player.isRace(Races.WOODELF)) { //Elf
				if(doOutput) outputText("There's no way you're going into this mechanical abomination. As an Elf, you have a natural aversion to technology, not to mention the claustrophobia.\n\n");
				return false;
			}
			if (game.player.basetallness > 48 || game.player.tailType != Tail.NONE || game.player.hasPhysicalWings()) { //Taller than 4 ft or having wings/tail
				if (doOutput) outputText("Your current anatomy or size prevents you from properly entering the small, compact cockpit of the vehicle.\n\n");
				return false;
			}
			return true;
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP = 1.2 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP = 1.4 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP = 1.6 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0) game.player.HP = 1.8 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0) game.player.HP = 2 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0) game.player.HP = 2.2 * game.player.maxHP();
				outputText("As you turn the mech on, the welcoming voice of your AI booms. \"<i>Welcome back aboard operator [name]. All functions are nominal.</i>\"");
			}
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP /= 1.2;
			if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP /= 1.4;
			if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP /= 1.6;
			if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0) game.player.HP /= 1.8;
			if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0) game.player.HP /= 2;
			if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0) game.player.HP /= 2.2;
			game.player.HP = Math.round(game.player.HP);
			super.afterUnequip(doOutput, slot);
		}
	}
}
