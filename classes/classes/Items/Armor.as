/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.Player;

	public class Armor extends Equipable
	{
		private var _def:Number;
		private var _perk:String;
		private var _name:String;

		override public function equip(player:Player, output:Boolean):void
		{
			clearOutput();
			if (canUse(player, true)) {
				if(output) outputText("You equip your " + _name + ".  ");
				var oldArmor:Armor = player.armor;
				oldArmor.unequip(player,output);
				player.setArmorHiddenField(this);
				equipped(player,output);
			}
		}

		override public function unequip(player:Player,output:Boolean):void
		{
			while(player.hasPerk("Bulge Armor") >= 0) player.removePerk("Bulge Armor");// TODO remove this Exgartuan hack
			if(_perk != "") player.removePerk(_perk);
			var itype:ItemType = unequipReturnItem(player,output);
			if (itype != null){
				game.itemSwapping = true;
				if (output && itype == this)
					outputText("You have your old set of " + longName + " left over.  ");
				game.inventory.takeItem(this);
			}
			player.setArmorHiddenField(ArmorLib.COMFORTABLE_UNDERCLOTHES);
			unequipped(player,output);
		}

		public function Armor(id:String, shortName:String, name:String, longName:String, def:Number, value:Number = 0, description:String = null, perk:String = "")
		{
			super(id, shortName, longName, value, description);
			this._name = name;
			this._def = def;
			this._perk = perk;
		}

		public function get def():Number
		{
			return _def;
		}

		public function get perk():String
		{
			return _perk;
		}

		public function get name():String
		{
			return _name;
		}
	}
}
