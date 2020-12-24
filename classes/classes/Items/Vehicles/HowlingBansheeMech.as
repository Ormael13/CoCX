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
			super("HB Mech", "HowlingBansheeMech", "Howling Banshee Mech", "a Howling Banshee Mech", 0, 0, 1000, "This twenty meters tall mech is equipped with a comfortable seat, fit for a medium sized person. It white bipedal frame covered with white armor plates is customisable. \n\nType: Howling Banshee Mech \nBase value: 1000","Mech");
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
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP = 1.25 * game.player.maxHP();
			if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP = 1.5 * game.player.maxHP();
			if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP = 1.75 * game.player.maxHP();
			return super.playerEquip();
		}
		
		override public function playerRemove():Vehicles {
			var oldHPratio:Number = game.player.hp100/100;
			game.player.buff("HB Mech").remove();
			game.player.HP = oldHPratio*game.player.maxHP();
			if (game.player.hasKeyItem("Upgraded Armor plating 1.0") >= 0) game.player.HP /= 1.25;
			if (game.player.hasKeyItem("Upgraded Armor plating 2.0") >= 0) game.player.HP /= 1.5;
			if (game.player.hasKeyItem("Upgraded Armor plating 3.0") >= 0) game.player.HP /= 1.75;
			game.player.HP = Math.round(game.player.HP);
			return super.playerRemove();
		}
	}
}