/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries
{
	import classes.Items.HeadJewelry;
	import classes.StatusEffects;

	public class SnowflakeHairpin extends HeadJewelry
	{
		
		public function SnowflakeHairpin()
		{
			super("SnowfH", "Snowflake hairpin", "Snowflake hairpin", "a Snowflake hairpin", 0, 0, 400, "This hair ornament favored by Yuki Onna empowers ice abilities and magic but weaken fire magic as well. (+30% ice spell dmg, -30% fire spell dmg)",HJT_HAIRPIN);
		}
		
		override public function afterEquip(doOutput:Boolean, slot:int):void {
			if (!game.isLoadingSave) {
				while (game.player.hasStatusEffect(StatusEffects.YukiOnnaHairpin)) game.player.removeStatusEffect(StatusEffects.YukiOnnaHairpin);
				game.player.createStatusEffect(StatusEffects.YukiOnnaHairpin, 0, 0, 0, 0);
			}
			super.afterEquip(doOutput, slot);
		}
		
		override public function afterUnequip(doOutput:Boolean, slot:int):void {
			while (game.player.hasStatusEffect(StatusEffects.YukiOnnaHairpin)) game.player.removeStatusEffect(StatusEffects.YukiOnnaHairpin);
			super.afterUnequip(doOutput, slot);
		}
		
	}

}
