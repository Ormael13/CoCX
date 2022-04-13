/**
 * Created by aimozg on 18.01.14.
 */
package classes.Items.Armors
{
	import classes.Items.Armor;
	import classes.PerkType;
	import classes.PerkLib;
	import classes.Player;

	public class ArmorWithPerk extends Armor {
		private var playerPerk:PerkType;
		private var playerPerkV1:Number;
		private var playerPerkV2:Number;
		private var playerPerkV3:Number;
		private var playerPerkV4:Number;

		public function ArmorWithPerk(id:String, shortName:String,name:String, longName:String, def:Number, mdef:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "", supportsBulge:Boolean = false, supportsUndergarment:Boolean = true) {
			super(id, shortName, name,longName, def, mdef, value, description, perk, supportsBulge, supportsUndergarment);
			this.playerPerk = playerPerk;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV2 = playerPerkV2;
			this.playerPerkV3 = playerPerkV3;
			this.playerPerkV4 = playerPerkV4;
		}

		override public function playerEquip():Armor { //This item is being equipped by the player. Add any perks, etc.
			while (game.player.hasPerk(playerPerk)) game.player.removePerk(playerPerk);
			game.player.createPerk(playerPerk, playerPerkV1, playerPerkV2, playerPerkV3, playerPerkV4);
			return super.playerEquip();
		}

		override public function playerRemove():Armor { //This item is being removed by the player. Remove any perks, etc.
			while (game.player.hasPerk(playerPerk)) game.player.removePerk(playerPerk);
			return super.playerRemove();
		}

		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: ";
			if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0) {
				desc += "Armor ";
				if (perk == "Light" || perk == "Medium") {
					desc += "(Light)";
				}
				else if (perk == "Medium") desc += "(Medium)";
				else if (perk == "Heavy") desc += "(Heavy)";
				else if (perk == "Light Ayo") desc += "(Light Ayo)";
				else if (perk == "Heavy Ayo") desc += "(Heavy Ayo)";
				else if (perk == "Ultra Heavy Ayo") desc += "(Ultra Heavy Ayo)";
			}
			else desc += "Clothing ";
			//Defense
			if (def > 0) desc += "\nDefense (P): " + String(def);
			if (mdef > 0) desc += "\nDefense (M): " + String(mdef);
			//Value
			if (value != 0) desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: " + playerPerk.name();
			if (playerPerk == PerkLib.WizardsEndurance) desc += " (-" + playerPerkV1 + "% Spell Cost)";
			else if (playerPerkV1 > 0) desc += " (Magnitude: " + playerPerkV1 + ")";
			return desc;
		}

/*
		override public function equipEffect(player:Player, output:Boolean):void
		{
			if(!player.hasPerk(playerPerk))
				player.createPerk(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			while(player.hasPerk(playerPerk)) player.removePerk(playerPerk);
		}
*/
	}
}
