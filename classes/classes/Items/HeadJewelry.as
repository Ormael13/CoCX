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
		
		
		override public function effectDescriptionParts():Array {
			var list:Array = super.effectDescriptionParts();
			// Type
			switch (_type) {
				case HJT_CROWN:
					list.push([10, "Type: Jewelry (Crown)"]);
					break;
				case HJT_HAIRPIN:
					list.push([10, "Type: Jewelry (Hairpin)"]);
					break;
				case HJT_HELMET:
					list.push([10, "Type: Armor (Helm)"]);
					break;
			}
			// Effect
			switch (effectId) {
				case HEADEFF_SF:
					list.push([50, "Special: Increases maximum Soulforce by " + effectMagnitude + "."]);
					break;
				case HEADEFF_MP:
					list.push([50, "Special: Increases maximum Mana by " + effectMagnitude + "."]);
					break;
				case HEADEFF_HP:
					list.push([50, "Special: Increases maximum HP by " + effectMagnitude + "."]);
					break;
				case HEADEFF_ATTACK_POWER:
					list.push([50, "Special: Increases melee damage by " + effectMagnitude + " percent."]);
					break;
				case HEADEFF_SPELL_POWER:
					list.push([50, "Special: Increases spellpower by " + effectMagnitude + " percent."]);
					break;
				case HEADEFF_R_ATTACK_POWER:
					list.push([50, "Special: Increases ranged damage by " + effectMagnitude + " percent."]);
					break;
				case HEADEFF_WR:
					list.push([50, "Special: Increases maximum Wrath by " + effectMagnitude + "."]);
					break;
				case HEADEFF_FIRE_R:
					list.push([50, "Special: Increases fire resistance by " + effectMagnitude + "%."]);
					break;
				case HEADEFF_ICE_R:
					list.push([50, "Special: Increases ice resistance by " + effectMagnitude + "%."]);
					break;
				case HEADEFF_LIGH_R:
					list.push([50, "Special: Increases lightning resistance by " + effectMagnitude + "%."]);
					break;
				case HEADEFF_DARK_R:
					list.push([50, "Special: Increases darkness resistance by " + effectMagnitude + "%."]);
					break;
				case HEADEFF_POIS_R:
					list.push([50, "Special: Increases poison resistance by " + effectMagnitude + "%."]);
					break;
				case HEADEFF_MAGIC_R:
					list.push([50, "Special: Increases magic resistance by " + effectMagnitude + "%."]);
					break;
				case HEADEFF_LUST_R:
					list.push([50, "Special: Increases lust resistance by " + effectMagnitude + "%."]);
					break;
				case HEADEFF_PHYS_R:
					list.push([50, "Special: Increases physical resistance by " + effectMagnitude + "%."]);
					break;
			}
			// Extra effect
			if (_effectDescription) list.push([70,_effectDescription]);
			return list;
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very much like to equip this item, but your body stiffness prevents you from doing so.");
				return false;
			}
			return super.canEquip(doOutput, slot);
		}
		
	}

}
