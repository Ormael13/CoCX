/**
 * ...
 * @author Ormael
 */
package classes.Items.WeaponsRange 
{
	import classes.Items.WeaponRange;
import classes.PerkClass;
import classes.PerkType;
	import classes.PerkLib;
	import classes.Player;
	
	public class WeaponRangeWithPerk extends WeaponRange {
		private var weapPerk:PerkClass;
		
		public function WeaponRangeWithPerk(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "")
		{
			super(id, shortName, name, longName, verb, attack, value, description, perk);
			this.weapPerk = new PerkClass(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}
		
		override public function playerEquip():WeaponRange { //This item is being equipped by the player. Add any perks, etc.
			while (game.player.hasPerk(weapPerk.ptype)) game.player.removePerk(weapPerk.ptype);
			game.player.createPerk(weapPerk.ptype, weapPerk.value1, weapPerk.value2, weapPerk.value3, weapPerk.value4);
			return super.playerEquip();
		}
		
		override public function playerRemove():WeaponRange { //This item is being removed by the player. Remove any perks, etc.
			while (game.player.findPerk(weapPerk.ptype) >= 0) game.player.removePerk(weapPerk.ptype);
			return super.playerRemove();
		}
		
		override public function get description():String {
			var desc:String = super.description;
			desc += "\nSpecial: " + weapPerk.perkName + " ";
			desc += weapPerk.perkDesc;
			return desc;
		}
		
	}

}