/**
 * ...
 * @author Ormael
 */
package classes.Items.Shields 
{
	import classes.Items.Shield;
	import classes.PerkType;
	import classes.PerkLib;
	import classes.Player;
	
	public class ShieldWithPerk extends Shield {
		private var playerPerk:PerkType;
		private var playerPerkV1:Number;
		private var playerPerkV2:Number;
		private var playerPerkV3:Number;
		private var playerPerkV4:Number;
		
		public function ShieldWithPerk(id:String, shortName:String, name:String, longName:String, block:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "") 
		{
			super(id, shortName, name,longName, block, value, description, perk);
			this.playerPerk = playerPerk;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV2 = playerPerkV2;
			this.playerPerkV3 = playerPerkV3;
			this.playerPerkV4 = playerPerkV4;
		}
		
		override public function playerEquip():Shield { //This item is being equipped by the player. Add any perks, etc.
			while (game.player.hasPerk(playerPerk)) game.player.removePerk(playerPerk);
			game.player.createPerk(playerPerk, playerPerkV1, playerPerkV2, playerPerkV3, playerPerkV4);
			return super.playerEquip();
		}
		
		override public function playerRemove():Shield { //This item is being removed by the player. Remove any perks, etc.
			while (game.player.hasPerk(playerPerk)) game.player.removePerk(playerPerk);
			return super.playerRemove();
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Shield";
			//Block Rating
			desc += "\nBlock: " + String(block);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: " + playerPerk.name;
			if (playerPerk == PerkLib.Obsession) desc += " (+" + (playerPerkV1 * 100) + "% spell effect multiplier, " + (playerPerkV2 * 100) + "% power boost/cost reduction for black magic)";
			return desc;
		}
	}
}