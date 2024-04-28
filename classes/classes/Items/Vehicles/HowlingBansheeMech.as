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
			withBuffs({"str.mult": 0.15, "tou.mult": 0.10, "spe.mult": 0.25});
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (!super.canEquip(doOutput)) {
				return false;
			}
			if (game.player.basetallness < 84) { //Shorter than 7 ft
				if (doOutput) outputText("You aren't tall enough to properly use this vehicle.\n\n");
				return false;
			}//bonus to piloting HBmech if elf subtype especialy psionic elf / eldar ^^
			return true;
		}
		
		public function get boost():Number {
			var boost:Number = 1;
			if (game.player.hasKeyItem("HB Armor Plating") >= 0) {
				var value:Number = game.player.keyItemvX("HB Armor Plating", 1);
				boost += 0.25;
				if (value >= 2) boost += 0.25;
				if (value >= 3) boost += 0.25;
				if (value >= 4) boost += 0.25;
				if (value >= 5) boost += 0.25;
				if (value >= 6) boost += 0.25;
			}
			if (game.player.hasKeyItem("HB Leather Insulation") >= 0) {
				value = game.player.keyItemvX("HB Leather Insulation", 1);
				boost += 0.25;
				if (value >= 2) boost += 0.25;
				if (value >= 3) boost += 0.25;
				if (value >= 4) boost += 0.25;
				if (value >= 5) boost += 0.25;
				if (value >= 6) boost += 0.25;
			}
			return boost;
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				game.player.HP = boost * game.player.maxHP();
				game.player.HP = Math.round(game.player.HP);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			game.player.HP /= boost;
			game.player.HP = Math.round(game.player.HP);
			super.afterUnequip(doOutput);
		}
	}
}
