/**
 * Created by aimozg on 10.01.14.
 */
package classes.Items
{
	import classes.Player;

	public class Armor extends Equipable
	{
		private var _def:Number;
		private var _perk:String;


		override public function equip(player:Player, output:Boolean):void
		{
			if (canEquip(player, true)) {
				player.armor.unequip(output);
				player.setArmorHiddenField(this);
				if (output){
					clearOutput();
					if(output) outputText("You equip your " + player.armorName + ".  ");
				}
				equipped(player,output);
			}
		}

		override public function unequip(output:Boolean):void
		{
			while(wearer.hasPerk("Bulge Armor") >= 0) wearer.removePerk("Bulge Armor");// TODO remove this Exgartuan hack
			if(_perk != "") wearer.removePerk(_perk);
			wearer.armor = ArmorLib.COMFORTABLE_UNDERCLOTHES;
			unequipped(output);
		}

		public function Armor(id:String, shortName:String, longName:String, def:Number, value:Number = 0, description:String = null, perk:String = "")
		{
			super(id, shortName, longName, value, description);
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
	}
}
