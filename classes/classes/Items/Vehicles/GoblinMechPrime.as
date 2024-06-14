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

public class GoblinMechPrime extends Vehicles
	{
		
		public function GoblinMechPrime()
		{
			super("GobMPri", "GoblinMechPrime", "Goblin Mech Prime", "a Goblin Mech Prime", 0, 0, 2000, "A customisable goblin invention, this six-legged, large mech is equipped with a comfortable seat, fit for a goblin or a rather small person. The prime design, unlike the more common model, sports a better armature and energy management, which improves both the defensive and offensive capacity of the mech. \n\nType: Goblin Mech \nBase value: 2000","Mech");
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!super.canEquip(doOutput)) {
				return false;
			}
			if (game.player.isRace(Races.ELF) || game.player.isRace(Races.WOODELF)) { //Elf
				if(doOutput) outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				return false;
			}
			if (game.player.basetallness > 48 || game.player.tailType != Tail.NONE || game.player.hasPhysicalWings()) { //Taller than 4 ft or having wings/tail
				if (doOutput) outputText("Your current anatomy or size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				return false;
			}
			return true;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP = 1.4 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP = 1.8 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP = 2.2 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0) game.player.HP = 2.6 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0) game.player.HP = 3 * game.player.maxHP();
				if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0) game.player.HP = 3.4 * game.player.maxHP();
				outputText("As you turn the mech on the welcoming voice of your AI booms in. \"<i>Welcome back aboard operator [name]. All functions are nominal.</i>\"");
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP /= 1.4;
			if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP /= 1.8;
			if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP /= 2.2;
			if (game.player.hasKeyItem("Upgraded Armor plating 4.0") >= 0) game.player.HP /= 2.6;
			if (game.player.hasKeyItem("Upgraded Armor plating 5.0") >= 0) game.player.HP /= 3;
			if (game.player.hasKeyItem("Upgraded Armor plating 6.0") >= 0) game.player.HP /= 3.4;
			game.player.HP = Math.round(game.player.HP);
			super.afterUnequip(doOutput);
		}
	}
}
