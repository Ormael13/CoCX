/**
 * Created by aimozg on 26.01.14.
 */
package classes
{
	import flash.utils.Dictionary;

	public class PerkType
	{
		private static var PERK_LIBRARY:Dictionary = new Dictionary();

		public static function lookupPerk(id:String):PerkType{
			return PERK_LIBRARY[id];
		}

		public static function getPerkLibrary():Dictionary
		{
			return PERK_LIBRARY;
		}

		private var _id:String;
		private var _name:String;
		private var _desc:String;

		/**
		 * Unique perk id, should be kept in future game versions
		 */
		public function get id():String
		{
			return _id;
		}

		/**
		 * Perk short name, could be changed in future game versions
		 */
		public function get name():String
		{
			return _name;
		}

		public function get desc():String
		{
			return _desc;
		}

		public function PerkType(id:String,name:String,desc:String)
		{
			this._id = id;
			this._name = name;
			this._desc = desc;
			if (PERK_LIBRARY[id] != null) {
				CoC_Settings.error("Duplicate perk id "+id+", old perk is "+(PERK_LIBRARY[id] as PerkType)._name);
			}
			PERK_LIBRARY[id] = this;
		}


		public function toString():String
		{
			return "\""+_id+"\"";
		}
	}
}
