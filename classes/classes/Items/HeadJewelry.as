/**
 * Created by Ormael on 17.09.18.
 */
package classes.Items
{
	import classes.ItemType;
	import classes.PerkLib;
	import classes.Player;

	public class HeadJewelry extends Equipable
	{
		private var _effectId:Number;
		private var _effectMagnitude:Number;
		private var _perk:String;
		private var _type:String;
		private var _effectDescription:String;
		
		override public function get category():String {
			return CATEGORY_JEWELRY_HEAD;
		}
		
		public function HeadJewelry(id:String, shortName:String, name:String, longName:String, effectId:Number, effectMagnitude:Number, value:Number, description:String, type:String, perk:String = "", effectDescription:String = "")
		{
			super(id, shortName, name, longName, value, description);
			this._effectId = effectId;
			this._effectMagnitude = effectMagnitude;
			this._type = type;
			this._perk = perk;
			this._effectDescription = effectDescription;
		}
		
		private static const SLOTS:Array = [SLOT_HEAD];
		override public function slots():Array {
			return SLOTS; // don't recreate every time
		}

		public function get effectId():Number { return _effectId; }

		public function get effectMagnitude():Number { return _effectMagnitude; }
		
		public function get perk():String { return _perk; }
		
		override public function effectDescription():String {
			var desc:String = super.effectDescription();
			switch (_type) {
				case HJT_CROWN:
					desc = "\nType: Jewelry (Crown)" + desc;
					break;
				case HJT_HAIRPIN:
					desc = "\nType: Jewelry (Hairpin)" + desc;
					break;
				case HJT_HELMET:
					desc = "\nType: Helm" + desc;
					break;
			}
			switch (effectId) {
				case HEADEFF_SF:
					desc += "\nSpecial: Increases maximum Soulforce by " + effectMagnitude + ".";
					break;
				case HEADEFF_MP:
					desc += "\nSpecial: Increases maximum Mana by " + effectMagnitude + ".";
					break;
				case HEADEFF_HP:
					desc += "\nSpecial: Increases maximum HP by " + effectMagnitude + ".";
					break;
				case HEADEFF_ATTACK_POWER:
					desc += "\nSpecial: Increases melee damage by " + effectMagnitude + " percent.";
					break;
				case HEADEFF_SPELL_POWER:
					desc += "\nSpecial: Increases spellpower by " + effectMagnitude + " percent.";
					break;
				case HEADEFF_R_ATTACK_POWER:
					desc += "\nSpecial: Increases ranged damage by " + effectMagnitude + " percent.";
					break;
				case HEADEFF_WR:
					desc += "\nSpecial: Increases maximum Wrath by " + effectMagnitude + ".";
					break;
				case HEADEFF_FIRE_R:
					desc += "\nSpecial: Increases fire resistance by " + effectMagnitude + "%.";
					break;
				case HEADEFF_ICE_R:
					desc += "\nSpecial: Increases ice resistance by " + effectMagnitude + "%.";
					break;
				case HEADEFF_LIGH_R:
					desc += "\nSpecial: Increases lightning resistance by " + effectMagnitude + "%.";
					break;
				case HEADEFF_DARK_R:
					desc += "\nSpecial: Increases darkness resistance by " + effectMagnitude + "%.";
					break;
				case HEADEFF_POIS_R:
					desc += "\nSpecial: Increases poison resistance by " + effectMagnitude + "%.";
					break;
				case HEADEFF_MAGIC_R:
					desc += "\nSpecial: Increases magic resistance by " + effectMagnitude + "%.";
					break;
				case HEADEFF_LUST_R:
					desc += "\nSpecial: Increases lust resistance by " + effectMagnitude + "%.";
					break;
				case HEADEFF_PHYS_R:
					desc += "\nSpecial: Increases physical resistance by " + effectMagnitude + "%.";
					break;
			}
			if (_effectDescription) desc += "\n"+_effectDescription;
			return desc;
		}
		
		override public function canEquip(doOutput:Boolean):Boolean {
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return super.canEquip(doOutput);
		}
		
	}

}
