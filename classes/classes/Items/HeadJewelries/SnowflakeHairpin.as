/**
 * ...
 * @author Liadri
 */
package classes.Items.HeadJewelries 
{
	import classes.Items.HeadJewelry;
	import classes.Player;
	import classes.StatusEffects;

	public class SnowflakeHairpin extends HeadJewelry
	{
		
		public function SnowflakeHairpin() 
		{
			super("SnowfH", "Snowflake hairpin", "Snowflake hairpin", "a Snowflake hairpin", 0, 0, 400, "This hair ornament favored by Yuki Onna empowers ice abilities and magic but weaken fire magic as well. (+30% ice spell dmg, -30% fire spell dmg) \n\nType: Jewelry (Hairpin) \nBase value: 400","Hairpin");
		}
		
		override public function playerEquip():HeadJewelry {
			while (game.player.hasStatusEffect(StatusEffects.YukiOnnaHairpin)) game.player.removeStatusEffect(StatusEffects.YukiOnnaHairpin);
			game.player.createStatusEffect(StatusEffects.YukiOnnaHairpin,0,0,0,0);
			return super.playerEquip();
		}
		
		override public function playerRemove():HeadJewelry {
			while (game.player.hasStatusEffect(StatusEffects.YukiOnnaHairpin)) game.player.removeStatusEffect(StatusEffects.YukiOnnaHairpin);
			return super.playerRemove();
		}
		
	}

}