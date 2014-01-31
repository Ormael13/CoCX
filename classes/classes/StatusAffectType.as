/**
 * Created by aimozg on 31.01.14.
 */
package classes
{
	import flash.utils.Dictionary;

	public class StatusAffectType
	{
			private static var STATUSAFFECT_LIBRARY:Dictionary = new Dictionary();

			public static function lookupStatusAffect(id:String):StatusAffectType{
				return STATUSAFFECT_LIBRARY[id];
			}

			public static function getStatusAffectLibrary():Dictionary
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

			public function StatusAffectType(id:String)
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
