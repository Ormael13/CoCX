package classes.Items.Weapons 
{
	import classes.Items.Weapon;
	import classes.PerkType;
	import classes.PerkLib;
	import classes.Player;
	
	public class WeaponWithPerk extends Weapon {
		private var playerPerk:PerkType;
		private var playerPerkV1:Number;
		private var playerPerkV2:Number;
		private var playerPerkV3:Number;
		private var playerPerkV4:Number;
		
		public function WeaponWithPerk(id:String, shortName:String, name:String, longName:String, verb:String, attack:Number, value:Number, description:String, perk:String, playerPerk:PerkType, playerPerkV1:Number, playerPerkV2:Number, playerPerkV3:Number, playerPerkV4:Number, playerPerkDesc:String = "")
		{
			super(id, shortName, name, longName, verb, attack, value, description, perk);
			this.playerPerk = playerPerk;
			this.playerPerkV1 = playerPerkV1;
			this.playerPerkV2 = playerPerkV2;
			this.playerPerkV3 = playerPerkV3;
			this.playerPerkV4 = playerPerkV4;
		}
		
		override public function playerEquip():Weapon { //This item is being equipped by the player. Add any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			game.player.createPerk(playerPerk, playerPerkV1, playerPerkV2, playerPerkV3, playerPerkV4);
			return super.playerEquip();
		}
		
		override public function playerRemove():Weapon { //This item is being removed by the player. Remove any perks, etc.
			while (game.player.findPerk(playerPerk) >= 0) game.player.removePerk(playerPerk);
			return super.playerRemove();
		}
		
		override public function get description():String {
			var desc:String = _description;
			//Type
			desc += "\n\nType: Weapon "
			if (perk == "Large") desc += "(Large)";
			else if (name.indexOf("staff") >= 0) desc += "(Staff)";
			else if (verb.indexOf("whip") >= 0) desc += "(Whip)";
			else if (verb.indexOf("punch") >= 0) desc += "(Gauntlet)";
			else if (verb == "shot") desc += "(Ranged)";
			else if (verb == "slash" || verb == "keen cut") desc += "(Sword)";
			else if (verb == "stab") desc += "(Dagger)";
			else if (verb == "smash") desc += "(Blunt)";
			//Attack
			desc += "\nAttack: " + String(attack);
			//Value
			desc += "\nBase value: " + String(value);
			//Perk
			desc += "\nSpecial: " + playerPerk.name;
			if (playerPerk == PerkLib.WizardsFocus) desc += " (+" + playerPerkV1 * 100 + "% Spell Power)";
			else if (playerPerkV1 > 0) desc += " (Magnitude: " + playerPerkV1 + ")";
			return desc;
		}
		
	}

}