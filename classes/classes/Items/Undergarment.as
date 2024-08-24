package classes.Items
{
import classes.BodyParts.LowerBody;
import classes.PerkLib;
	/**
	 * @author Kitteh6660
	 */
	public class Undergarment extends Equipable
	{
		private var _type:Number;
		private var _def:int;
		private var _mdef:int;
		private var _sexiness:int;
		private var _perk:String;
		
		override public function get category():String {
			return CATEGORY_UNDERGARMENT;
		}
		
		public function Undergarment(id:String, shortName:String, name:String, longName:String, undergarmentType:Number, value:Number, def:Number, mdef:Number, sexiness:Number, description:String = null, perk:String = "")
		{
			super(id, shortName, name, longName, value, description);
			this._type = undergarmentType;
			this._def = def;
			this._mdef = mdef;
			this._sexiness = sexiness;
			this._perk = perk;
		}
		
		private static const SLOTS_UPPER:Array = [SLOT_UNDER_TOP];
		private static const SLOTS_LOWER:Array = [SLOT_UNDER_BOTTOM];
		private static const SLOTS_ANY:Array = [SLOT_UNDER_TOP, SLOT_UNDER_BOTTOM];
		override public function slots():Array {
			if (_type === UT_ANY) return SLOTS_ANY;
			if (_type === UT_BOTTOM) return SLOTS_LOWER;
			return SLOTS_UPPER; // UT_FULL goes into bra slot
		}
		// preferred slot
		public function get slot():int {
			return _type == UT_BOTTOM ? SLOT_UNDER_BOTTOM : SLOT_UNDER_TOP;
		}

		public function get type():Number { return _type; }

		public function get perk():String { return _perk; }

		override public function get description():String {
			var desc:String = _description;
			//Defense
			if (armorDef > 0) desc += "\nDefense (P): " + String(armorDef);
			if (armorMDef > 0) desc += "\nDefense (M): " + String(armorMDef);
			//Sexiness
			if (sexiness > 0) desc += "\nSexiness: " + String(sexiness);
			//Value
			desc += "\nBase value: " + String(value);
			return desc;
		}

		public function get armorDef():int {
			return _def;
		}

		public function get armorMDef():int {
			return _mdef;
		}

		public function get sexiness():int {
			return _sexiness;
		}
		
		override public function canEquip(doOutput:Boolean, slot:int):Boolean {
			if (!game.player.armor.supportsUndergarment) {
				outputText("It would be awkward to put on undergarments when you're currently wearing your type of clothing. You should consider switching to different clothes. You put it back into your inventory.");
				return false;
			}
			if (type == UT_BOTTOM) {
				if (!LowerBody.lowerGarmentDisabled(game.player, perk)) {
					return true;
				} else {
					outputText("Your form makes it impossible to put this on. You place it back into your inventory.");
					return false;
				}
			}
			if (game.player.hasPerk(PerkLib.Rigidity)) {
				outputText("You would very like to equip this item but your body stiffness prevents you from doing so.");
				return false;
			}
			return super.canEquip(doOutput, slot);
		}
	}

}
