/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.PerkType;
	import classes.Player;

	public class ArmorWithPerk extends Armor
	{
		private var playerPerk:PerkType;
		private var playerPerkV1:Number;
		private var playerPerkV2:Number;
		private var playerPerkV3:Number;
		private var playerPerkV4:Number;


		override public function equipEffect(player:Player, output:Boolean):void
		{
			if(player.findPerk(playerPerk) < 0)
				player.createPerk(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			while(player.findPerk(playerPerk) >= 0) player.removePerk(playerPerk);
		}

		public function ArmorWithPerk(id:String, shortName:String,name:String, longName:String, def:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number)
		{
			super(id, shortName, name,longName, def, value, description, perk);
			this.playerPerk = playerPerk;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV2 = playerPerkV2;
			this.playerPerkV3 = playerPerkV3;
			this.playerPerkV4 = playerPerkV4;
		}
	}
}
