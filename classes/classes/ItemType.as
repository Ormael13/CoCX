/**
 * Created by aimozg on 09.01.14.
 */
package classes
{
import classes.internals.Utils;

import flash.utils.Dictionary;

	public class ItemType extends Utils
	{
		private static var ITEM_LIBRARY:Dictionary = new Dictionary();
		private static var ITEM_SHORT_LIBRARY:Dictionary = new Dictionary();
		public static const NOTHING:ItemType = new ItemType("NOTHING!");

		/**
		 * Looks up item by <b>ID</b>.
		 * @param	id 7-letter string that identifies an item.
		 * @return  ItemType
		 */
		public static function lookupItem(id:String):ItemType{
			return ITEM_LIBRARY[id];
		}

		/**
		 * Looks up item by <b>shortName</b>.
		 * @param	shortName The short name that was displayed on buttons.
		 * @return  ItemType
		 */
		public static function lookupItemByShort(shortName:String):ItemType{
			return ITEM_SHORT_LIBRARY[shortName];
		}

		public static function getItemLibrary():Dictionary
		{
			return ITEM_LIBRARY;
		}

		private var _id:String;
		protected var _shortName:String;
		protected var _longName:String;
		protected var _description:String;
		protected var _value:Number;
		protected var _tags:Object;

		/**
		 * Short name to be displayed on buttons
		 */
		public function get shortName():String
		{
			return _shortName;
		}

		/**
		 * A full name of the item, to be described in text
		 */
		public function get longName():String
		{
			return _longName;
		}

		/**
		 * Item base price
		 */
		public function get value():Number
		{
			return _value;
		}

		/**
		 * Detailed description to use on tooltips
		 */
		public function get description():String
		{
			return _description;
		}

		/**
		 * 7-character unique (across all the versions) string, representing that item type.
		 */
		public function get id():String
		{
			return _id;
		}

		public function get tags():Object
		{
			return _tags;
		}

		public function ItemType(_id:String,_shortName:String=null,_longName:String=null,_value:Number=0,_description:String=null)
		{

			this._id = _id;
			this._shortName = _shortName || _id;
			this._longName = _longName || this.shortName;
			this._description = _description || this.longName;
			this._value = _value;
			this._tags = {};
			if (ITEM_LIBRARY[_id] != null) {
				CoC_Settings.error("Duplicate itemid "+_id+", old item is "+(ITEM_LIBRARY[_id] as ItemType).longName);
			}
			if (ITEM_SHORT_LIBRARY[_shortName] != null){
				trace("WARNING: Item with duplicate shortname: '"+_id+"' and '"+(ITEM_SHORT_LIBRARY[this._shortName] as ItemType)._id+"' share "+this._shortName);
			}
			ITEM_LIBRARY[_id] = this;
			ITEM_SHORT_LIBRARY[this._shortName] = this;
		}

		/**
		 * Add tag to this item type. Use only when registering new item type!
		 * @return this
		 */
		public function withTag(...tags:/*String*/Array):ItemType {
			for each(var tag:String in tags) {
				this.tags[tag] = true;
			}
			return this;
		}

		public function hasTag(tag:String):Boolean {
			return this.tags[tag];
		}
		public function hasAllTags(...tags:/*String*/Array):Boolean {
			for each (var tag:String in tags) {
				if (!this.tags[tag]) return false;
			}
			return true;
		}
		public function hasAnyTag(...tags:/*String*/Array):Boolean {
			for each (var tag:String in tags) {
				if (this.tags[tag]) return true;
			}
			return false;
		}

		public function toString():String
		{
			return "\""+_id+"\"";
		}
	}
}
