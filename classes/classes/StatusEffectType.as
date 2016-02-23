/**
 * Created by aimozg on 31.01.14.
 */
package classes
{
	import flash.utils.Dictionary;

	public class StatusEffectType
	{
			private static var STATUSAFFECT_LIBRARY:Dictionary = new Dictionary();

			public static function lookupStatusEffect(id:String):StatusEffectType{
				return STATUSAFFECT_LIBRARY[id];
			}

			public static function getStatusEffectLibrary():Dictionary
			{
				return STATUSAFFECT_LIBRARY;
			}

			private var _id:String;

			/**
			 * Unique perk id, should be kept in future game versions
			 */
			public function get id():String
			{
				return _id;
			}

			public function StatusEffectType(id:String)
			{
				this._id = id;
				if (STATUSAFFECT_LIBRARY[id] != null) {
					CoC_Settings.error("Duplicate status affect "+id);
				}
				STATUSAFFECT_LIBRARY[id] = this;
			}


			public function toString():String
			{
				return "\""+_id+"\"";
			}
		}
}
