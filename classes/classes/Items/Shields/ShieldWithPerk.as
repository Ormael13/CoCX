/**
 * ...
 * @author Ormael
 */
package classes.Items.Shields
{
	import classes.Items.Shield;
    import classes.PerkClass;
    import classes.PerkType;
    import classes.PerkLib;

	public class ShieldWithPerk extends Shield {
		protected var shieldPerk:PerkClass;

		public function ShieldWithPerk(id:String, shortName:String, name:String, longName:String, block:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "")
		{
			super(id, shortName, name,longName, block, value, description, perk);
            this.shieldPerk = new PerkClass(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}

        override public function playerEquip():Shield { //This item is being equipped by the player. Add any perks, etc.
			if (shieldPerk.ptype == PerkLib.WizardsFocus && game.player.hasPerk(shieldPerk.ptype))
				game.player.addPerkValue(shieldPerk.ptype, 1, shieldPerk.value1); //additive - for spidersilk underwear
			else {
				if (game.player.removePerk(shieldPerk.ptype)) //attempt to remove perk if exists (if not, no perk - no problems)
					outputText("\n\nOld perk '" + shieldPerk.perkName + "' was removed!" + "\n\n"); //returns true - replaced
				game.player.createPerk(shieldPerk.ptype, shieldPerk.value1, shieldPerk.value2, shieldPerk.value3, shieldPerk.value4);
			}
			return super.playerEquip();
		}
		
		override public function playerRemove():Shield { //This item is being removed by the player. Remove any perks, etc.
            if (shieldPerk.ptype == PerkLib.WizardsFocus && game.player.perkv1(shieldPerk.ptype) > shieldPerk.value1)
                game.player.addPerkValue(shieldPerk.ptype, 1, -shieldPerk.value1); //if stacked
            else
			    game.player.removePerk(shieldPerk.ptype); //attempt to remove perk if exists (if not, no perk - no problems)
			return super.playerRemove();
		}

		override public function get description():String {
			var desc:String = super.description;
			desc += "\nSpecial: " + shieldPerk.perkName + " ";
			desc += shieldPerk.perkDesc;
            return desc;
		}
	}
}
