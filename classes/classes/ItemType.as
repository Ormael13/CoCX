/**
 * Created by aimozg on 09.01.14.
 */
package classes
{
import classes.internals.Utils;

import flash.utils.Dictionary;

	public class ItemType extends Utils
	{
		/**
		 * Unique item DB
		 */
		private static var ITEM_LIBRARY:Dictionary = new Dictionary();
		/**
		 * Dynamic item cache
		 */
		private static var DYNAMIC_ITEM_LIBRARY:Dictionary = new Dictionary();
		/**
		 * Short name -> Item mapping. Used for button labeling.
		 */
		private static var ITEM_SHORT_LIBRARY:Dictionary = new Dictionary();
		public static const NOTHING:ItemType = new ItemType("NOTHING!");
		/**
		 * "Old id" -> "New id" mapping
		 */
		private static const LEGACY_REMAP:Object = {
			"AuburnD": dynamicItemId("HairDye", {color:"Auburn",rarity:1}),
			"Black D": dynamicItemId("HairDye", {color:"Black",rarity:1}),
			"Blond D": dynamicItemId("HairDye", {color:"Blond",rarity:1}),
			"BlueDye": dynamicItemId("HairDye", {color:"Blue",rarity:1}),
			"Brown D": dynamicItemId("HairDye", {color:"Brown",rarity:1}),
			"GrayDye": dynamicItemId("HairDye", {color:"Gray",rarity:1}),
			"Green D": dynamicItemId("HairDye", {color:"Green",rarity:1}),
			"OrangDy": dynamicItemId("HairDye", {color:"Orange",rarity:1}),
			"PinkDye": dynamicItemId("HairDye", {color:"Pink",rarity:1}),
			"PurpDye": dynamicItemId("HairDye", {color:"Purple",rarity:1}),
			"RainDye": dynamicItemId("HairDye", {color:"Rainbow",rarity:4}),
			"Red Dye": dynamicItemId("HairDye", {color:"Red",rarity:1}),
			"WhiteDy": dynamicItemId("HairDye", {color:"White",rarity:1}),
			"RussetD": dynamicItemId("HairDye", {color:"Russet",rarity:1}),
			"SnowW D": dynamicItemId("HairDye", {color:"Snow White",rarity:2}),
			"QWhiteD": dynamicItemId("HairDye", {color:"Quartz White",rarity:3})
		};

		public static function dynamicItemId(templateId:String, parameters:Object):String {
			return templateId+";"+JSON.stringify(parameters);
		}
		
		/**
		 * Looks up item by <b>ID</b>.
		 * @param	id item id, or a (template_id + ";" + template_params_json)
		 * @return  ItemType
		 */
		public static function lookupItem(id:String):ItemType{
			if (id in LEGACY_REMAP) id = LEGACY_REMAP[id];
			var i:int = id.indexOf(";");
			if (i >= 0) {
				var it:ItemType = DYNAMIC_ITEM_LIBRARY[id];
				if (it) return it;
				return ItemTemplate.createTemplatedItem(id.substr(0, i), id.substr(i+1));
			}
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
			if (_id.indexOf(";") > 0) {
				DYNAMIC_ITEM_LIBRARY[_id] = this;
			} else {
				if (ITEM_LIBRARY[_id] != null) {
					CoC_Settings.error("Duplicate itemid " + _id + ", old item is " + (ITEM_LIBRARY[_id] as ItemType).longName);
				}
				if (ITEM_SHORT_LIBRARY[_shortName] != null) {
					trace("WARNING: Item with duplicate shortname: '" + _id + "' and '" + (ITEM_SHORT_LIBRARY[this._shortName] as ItemType)._id + "' share " + this._shortName);
				}
				ITEM_LIBRARY[_id] = this;
			}
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
