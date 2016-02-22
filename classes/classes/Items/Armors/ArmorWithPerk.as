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
		
		public function ArmorWithPerk(id:String, shortName:String,name:String, longName:String, def:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "", supportsBulge:Boolean = false, supportsUndergarment:Boolean = true) {
			super(id, shortName, name,longName, def, value, description, perk, supportsBulge, supportsUndergarment);
			this.playerPerk = playerPerk;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV2 = playerPerkV2;
			this.playerPerkV3 = playerPerkV3;
			this.playerPerkV4 = playerPerkV4;
		}
		
		override public function playerEquip():Armor { //This item is being equipped by the player. Add any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			game.player.createPerk(playerPerk, playerPerkV1, playerPerkV2, playerPerkV3, playerPerkV4);
			return super.playerEquip();
		}
		
		override public function playerRemove():Armor { //This item is being removed by the player. Remove any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			return super.playerRemove();
		}

		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: "
			if (name.indexOf("armor") >= 0 || name.indexOf("armour") >= 0 || name.indexOf("chain") >= 0 || name.indexOf("mail") >= 0 || name.indexOf("plates") >= 0) {
				desc += "Armor ";
				if (perk == "Light" || perk == "Medium") {
					desc += "(Light)";
				}
				else if (perk == "Medium") desc += "(Medium)";
				else desc += "(Heavy)";
			}
			else desc += "Clothing ";
			//Defense
			if (def > 0) desc += "\nDefense: " + String(def);
			//Value
			if (value != 0) desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: " + playerPerk.name;
			if (playerPerk == PerkLib.WizardsEndurance) desc += " (-" + playerPerkV1 + "% Spell Cost)";
			else if (playerPerkV1 > 0) desc += " (Magnitude: " + playerPerkV1 + ")";
			return desc;
		}
		
/*
		override public function equipEffect(player:Player, output:Boolean):void
		{
			if (player.findPerk(playerPerk) < 0)
				player.createPerk(playerPerk,playerPerkV1,playerPerkV2,playerPerkV3,playerPerkV4);
		}

		override public function unequipEffect(player:Player, output:Boolean):void
		{
			while(player.findPerk(playerPerk) >= 0) player.removePerk(playerPerk);
		}
*/
	}
}
