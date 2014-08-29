/**
 * Created by Kitteh6660 on 08.29.14.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class Jewelry extends Equipable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _perk:String;
		private var _name:String;

		override public function equip(player:Player, returnOldItem:Boolean,output:Boolean):void
		{
			if (output) clearOutput();
			if (canUse(player, true)) {
				if(output) outputText("You equip your " + _name + ".  ");
				var oldJewelry:Jewelry = player.jewelry;
				oldJewelry.unequip(player, returnOldItem, output);
				player.setJewelryHiddenField(this);
				equipped(player,output);
			}
		}

		override public function unequip(player:Player, returnToInventory:Boolean, output:Boolean):void
		{
			if (returnToInventory) 
			{
				var itype:ItemType = unequipReturnItem(player, output);
				if (itype != null) 
				{
					game.itemSwapping = true;
					if (output && itype == this)
						outputText("You have your previous jewelry, " + longName + ", left over.  ");
					game.inventory.takeItem(this, false);
				}
			}
			player.setJewelryHiddenField(JewelryLib.NOTHING);
			unequipped(player,output);
		}

		public function Jewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number = 0, description:String = null, type:String = "", perk:String = "")
		{
			super(id, shortName, longName, value, description);
			this._name = name;
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			this._perk = perk;
		}

		public function get effectId():Number
		{
			return _effectId;
		}

		public function get effectMagnitude():Number
		{
			return _effectMagnitude;
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
