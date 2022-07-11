/**
 * ...
 * @author Ormael
 */
package classes.Items.FlyingSwords
{
	import classes.Items.FlyingSwords;
	import classes.PerkClass;
	import classes.PerkType;
	
	public class FlyingSwordsWithPerk extends FlyingSwords
	{
		private var weapPerk:PerkClass;
		
		public function FlyingSwordsWithPerk(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "")
		{
			super(id, shortName, name, longName, verb, attack, value, description, perk);
			this.weapPerk = new PerkClass(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}
		
		override public function afterEquip(doOutput:Boolean):void {
			if (!game.isLoadingSave) {
				while (game.player.hasPerk(weapPerk.ptype)) game.player.removePerk(weapPerk.ptype);
				game.player.createPerk(weapPerk.ptype, weapPerk.value1, weapPerk.value2, weapPerk.value3, weapPerk.value4);
			}
			super.afterEquip(doOutput);
		}
		
		override public function afterUnequip(doOutput:Boolean):void {
			while (game.player.hasPerk(weapPerk.ptype)) game.player.removePerk(weapPerk.ptype);
			super.afterUnequip(doOutput);
		}
		
		override public function get description():String {
			var desc:String = super.description;
			desc += "\nSpecial: " + weapPerk.perkName + " ";
			desc += weapPerk.perkDesc;
			return desc;
		}
		
	}

}
