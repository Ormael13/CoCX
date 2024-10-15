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
	import classes.EngineCore;

	public class UltraHeavyAyoArmor extends Armor {
		
		public function UltraHeavyAyoArmor() {//150 * armor + mres
			super("UHAyoArm","UHAyoArm","ultra heavy ayo armor","an ultra heavy ayo armor",180,30,31500,"This suit of armor is more than typical heavy armor—it has added pieces of Ayo Tech that greatly increase its properties, as long user at the user regularly feeds it with soulforce.","Ultra Heavy Ayo");
		}
		
		override public function get def():Number {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 180;
			else return 108;
		}
		
		override public function get mdef():Number {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 30;
			else return 18;
		}

		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				var oldHPratio:Number = game.player.hp100/100;
				game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
				game.player.buff("Ayo Armor").remove();
				game.player.buff("Ayo Armor").addStats( {"str.mult":-0.40, "spe.mult":-0.30, "tou.mult":-0.10} );
				game.player.HP = oldHPratio*game.player.maxHP();
				EngineCore.statScreenRefresh();
			}
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) {
				game.player.soulforce += game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR];
				if (game.player.soulforce > game.player.maxOverSoulforce()) game.player.soulforce = game.player.maxOverSoulforce();
				game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
			}
			game.player.buff("Ayo Armor").remove();
			super.afterUnequip(doOutput, slot);
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.str >= 100 && game.player.spe >= 100) return super.canEquip(doOutput, slot);
			if (doOutput) outputText("You aren't strong and/or agile enough to wear this armor!  Unless you like moving slower than a snail and hitting as weak as a wet noodle?  ");
			return false;
		}
	}
}
