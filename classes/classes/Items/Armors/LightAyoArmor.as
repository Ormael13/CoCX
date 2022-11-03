/**
 * ...
 * @author Ormael
 */
package classes.Items.Armors
{
	import classes.GlobalFlags.kFLAGS;
	import classes.ItemType;
	import classes.Items.Armor;
	import classes.Player;

	public final class LightAyoArmor extends Armor {
		
		public function LightAyoArmor() {//80 * armor + mres
			super("LAyoArm","LAyoArm","light ayo armor","a light ayo armor",60,10,5600,"This suit of armor is more than typical heavy armor - it have added pieces of Ayo Tech that increase it properties as long user is capable to feed it on regular basis with soulforce.","Light Ayo");
		}
		
		override public function get def():Number {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 60;
			else return 36;
		}
		
		override public function get mdef():Number {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 10;
			else return 6;
		}

		override public function afterEquip(doOutput:Boolean):void {
			game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
			game.player.buff("Ayo Armor").remove();
			game.player.buff("Ayo Armor").addStats( {"str": -10, "spe": -10} );
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) {
				game.player.soulforce += game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR];
				if (game.player.soulforce > game.player.maxOverSoulforce()) game.player.soulforce = game.player.maxOverSoulforce();
				game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
			}
			game.player.buff("Ayo Armor").remove();
			super.afterUnequip(doOutput);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.str >= 20 && game.player.spe >= 20) return super.canEquip(doOutput);
			if (doOutput) outputText("You aren't strong and agile enough to wear this armor!  Unless you likes to move slower than snail and hit weaked than wet noddle!  ");
			return false;
		}
	}
}
