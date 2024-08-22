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

	public class HBArmor extends Armor {
		
		public function HBArmor() {//160 * armor + mres
			super("HBArmor","HBArmor","HB armor","a HB armor",100,80,28800,"This white suit of armor is more than just platemail - it was reverse engineered from almost intact armor of elf-like offworlder. It protective properties would increase as long user is capable to feed it on regular basis with soulforce. (Req. to be 7+ feet tall)","Light Ayo");
		}
		
		override public function get def():Number {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 100;
			else return 60;
		}
		
		override public function get mdef():Number {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) return 80;
			else return 48;
		}

		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				var oldHPratio:Number = game.player.hp100/100;
				game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
				game.player.buff("Ayo Armor").remove();
				game.player.buff("Ayo Armor").addStats( {"str.mult":-0.18, "spe.mult":-0.60} );
				game.player.HP = oldHPratio*game.player.maxHP();
				EngineCore.statScreenRefresh();
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			if (game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] > 0) {
				game.player.soulforce += game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR];
				if (game.player.soulforce > game.player.maxOverSoulforce()) game.player.soulforce = game.player.maxOverSoulforce();
				game.flags[kFLAGS.SOULFORCE_STORED_IN_AYO_ARMOR] = 0;
			}
			super.afterUnequip(doOutput);
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.str >= 60 && game.player.spe >= 60 && game.player.tallness >= 84) return super.canEquip(doOutput);
			if (doOutput) {
				if (game.player.tallness < 84) outputText("You aren't tall enough to wear this armor!  ");
				else outputText("You aren't strong and agile enough to wear this armor!  Unless you likes to move slower than snail and hit weaked than wet noddle!  ");
			}
			return false;
		}
	}
}
