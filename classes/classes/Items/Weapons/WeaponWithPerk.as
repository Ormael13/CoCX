package classes.Items.Weapons
{
import classes.Items.Weapon;
import classes.PerkClass;
import classes.PerkType;
import classes.PerkLib;

public class WeaponWithPerk extends Weapon {
		protected var weapPerk:PerkClass;
		
		public function WeaponWithPerk(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "", type:String = "")
		{
			super(id, shortName, name, longName, verb, attack, value, description, perk, type);
			this.weapPerk = new PerkClass(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}
		
		override public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc.
			if (weapPerk.ptype == PerkLib.WizardsFocus && game.player.hasPerk(weapPerk.ptype))
				game.player.addPerkValue(weapPerk.ptype, 1, weapPerk.value1); //additive - for spidersilk underwear
			else {
				if (game.player.removePerk(weapPerk.ptype)) //attempt to remove perk if exists (if not, no perk - no problems)
					outputText("\n\nOld perk '" + weapPerk.perkName + "' was removed!" + "\n\n"); //returns true - replaced
				game.player.createPerk(weapPerk.ptype, weapPerk.value1, weapPerk.value2, weapPerk.value3, weapPerk.value4);
			}
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc.
            if (weapPerk.ptype == PerkLib.WizardsFocus && game.player.perkv1(weapPerk.ptype) > weapPerk.value1)
                game.player.addPerkValue(weapPerk.ptype, 1, -weapPerk.value1); //if stacked
            else
			    game.player.removePerk(weapPerk.ptype); //attempt to remove perk if exists (if not, no perk - no problems)
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