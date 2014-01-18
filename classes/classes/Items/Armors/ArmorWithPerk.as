/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.Player;

	public class ArmorWithPerk extends Armor
	{
		private var playerPerkName:String;
		private var playerPerkDesc:String;
		private var playerPerkV1:Number;
		private var playerPerkV2:Number;
		private var playerPerkV3:Number;
		private var playerPerkV4:Number;


		override public function equipEffect(player:Player, output:Boolean):void
		{
			if(player.hasPerk(playerPerkName) < 0)
				player.createPerk(playerPerkName,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4,playerPerkDesc);
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			while(player.hasPerk(playerPerkName) >= 0) player.removePerk(playerPerkName);
		}

		public function ArmorWithPerk(id:String, shortName:String,name:String, longName:String, def:Number, value:Number, description:String, perk:String, playerPerkName:String, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String)
		{
			super(id, shortName, name,longName, def, value, description, perk);
			this.playerPerkName = playerPerkName;
			this.playerPerkDesc = playerPerkDesc;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV1 = playerPerkV2;
			this.playerPerkV1 = playerPerkV3;
			this.playerPerkV1 = playerPerkV4;
		}
	}
}
