/**
 * ...
 * @author Ormael
 */
package classes.Items.Vehicles 
{
	import classes.BodyParts.Tail;
	import classes.BodyParts.Wings;
	import classes.Items.Vehicles;
	import classes.PerkLib;
	import classes.Player;

	public class GiantSlayerMech extends Vehicles
	{
		
		public function GiantSlayerMech() 
		{
			super("GS Mech", "GiantSlayerMech", "Giant Slayer Mech", "a Giant Slayer Mech", 0, 0, 2000, "A customisable goblin invention, this bipedal, large mech is equipped with a comfortable seat, fit for a goblin or a small person. Within it you feel like you could kill gods or well gigants... \n\nType: Goblin Mech \nBase value: 2000","Mech");
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			if (game.player.elfScore() >= 11 || game.player.woodElfScore() >= 22) { //Elf
				outputText("No way you’re going into this mechanical abomination. You’re an Elf and as such you have a natural disgust of technology, not to mention the claustrophobia.\n\n");
				return false;
			}
			if (game.player.tallness > 66 || game.player.haveWingsForWingSlap()) { //Taller than 5'6" ft
				outputText("Your current size prevents you from properly entering the small compact cockpit of the vehicle.\n\n");
				return false;
			}
			return true;
		}
		
		override public function playerEquip():Vehicles {
			//status effect to later track when mech enter enrage/stage 2 mode
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0 || game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) {
				var EHP:Number = 1;
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) EHP += 0.25;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) EHP += 0.5;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) EHP += 0.75;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) EHP += 0.25;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 2.0") >= 0) EHP += 0.5;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 3.0") >= 0) EHP += 0.75; 
				game.player.HP = EHP * game.player.maxHP();
			}
			return super.playerEquip();
		}
		
		override public function playerRemove():Vehicles {
			
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0 || game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) {
				var RHP:Number = 1;
				if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) RHP += 0.25;
				if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) RHP += 0.5;
				if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) RHP += 0.75;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 1.0") >= 0) RHP += 0.25;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 2.0") >= 0) RHP += 0.5;
				if (game.player.hasKeyItem("Upgraded Leather Insulation 3.0") >= 0) RHP += 0.75;
				game.player.HP /= RHP;
			}
			game.player.HP = Math.round(game.player.HP);
			return super.playerRemove();
		}
	}
}