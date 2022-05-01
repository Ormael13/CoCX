/**
 * ...
 * @author Ormael
 */
package classes.Items.Vehicles 
{
	import classes.Items.Vehicles;
	import classes.PerkLib;
	import classes.Player;

	public class HowlingBansheeMech extends Vehicles
	{
		
		public function HowlingBansheeMech() 
		{
			super("HB Mech", "HowlingBansheeMech", "Howling Banshee Mech", "a Howling Banshee Mech", 0, 0, 2000, "This twenty meters tall mech is equipped with a comfortable seat, fit for a medium sized person. It white bipedal frame covered with white armor plates is customisable. \n\nType: Howling Banshee Mech \nBase value: 2000","Mech");
		}
		
		override public function canUse():Boolean {
			if (!super.canUse()) {
				return false;
			}
			if (game.player.tallness < 84) { //Shorter than 7 ft
				outputText("You aren't tall enough to properly use this vehicle.\n\n");
				return false;
			}//bonus to piloting HBmech if elf subtype especialy psionic elf / eldar ^^
			return true;
		}
		
		override public function playerEquip():Vehicles {
			var oldHPratio:Number = game.player.hp100/100;
			game.player.buff("HB Mech").addStats( {"str.mult":0.15, "tou.mult":0.10, "spe.mult":0.25} );
			game.player.HP = oldHPratio*game.player.maxHP();
			var boost:int = 1;
			if (game.player.hasKeyItem("HB Armor Plating") >= 0) {
				if (game.player.keyItemvX("HB Armor Plating", 1) == 1) boost += 0.25;
				if (game.player.keyItemvX("HB Armor Plating", 1) == 2) boost += 0.25;
				if (game.player.keyItemvX("HB Armor Plating", 1) == 3) boost += 0.25;
				if (game.player.keyItemvX("HB Armor Plating", 1) == 4) boost += 0.25;
			}
			if (game.player.hasKeyItem("HB Leather Insulation") >= 0) {
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 1) boost += 0.25;
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 2) boost += 0.25;
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 3) boost += 0.25;
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 4) boost += 0.25;
			}
			game.player.HP = boost * game.player.maxHP();
			game.player.HP = Math.round(game.player.HP);
			return super.playerEquip();
		}
		
		override public function playerRemove():Vehicles {
			var oldHPratio:Number = game.player.hp100/100;
			game.player.buff("HB Mech").remove();
			game.player.HP = oldHPratio*game.player.maxHP();
			var boost:int = 1;
			if (game.player.hasKeyItem("HB Armor Plating") >= 0) {
				if (game.player.keyItemvX("HB Armor Plating", 1) == 1) boost += 0.25;
				if (game.player.keyItemvX("HB Armor Plating", 1) == 2) boost += 0.25;
				if (game.player.keyItemvX("HB Armor Plating", 1) == 3) boost += 0.25;
				if (game.player.keyItemvX("HB Armor Plating", 1) == 4) boost += 0.25;
			}
			if (game.player.hasKeyItem("HB Leather Insulation") >= 0) {
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 1) boost += 0.25;
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 2) boost += 0.25;
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 3) boost += 0.25;
				if (game.player.keyItemvX("HB Leather Insulation", 1) == 4) boost += 0.25;
			}
			game.player.HP /= boost;
			game.player.HP = Math.round(game.player.HP);
			return super.playerRemove();
		}
	}
}