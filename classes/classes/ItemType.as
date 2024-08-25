/**
 * Created by aimozg on 09.01.14.
 */
package classes
{
import classes.Items.Enchantment;
import classes.Items.EnchantmentType;
import classes.Items.ItemConstants;
import classes.Items.ItemEffect;
import classes.Items.ItemEffectType;
import classes.Items.ItemTypeNothing;
import classes.internals.Utils;

import coc.view.IconLib;

import flash.utils.Dictionary;

public class ItemType extends ItemConstants
	{
		
		/**
		 * Unique item DB
		 */
		private static var ITEM_LIBRARY:Dictionary = new Dictionary();
		/**
		 * Dynamic item cache
		 */
		private static var DYNAMIC_ITEM_LIBRARY:Dictionary = new Dictionary();
		private static var dynamicItemCounter:int = 0;
		/**
		 * Short name -> Item mapping. Used for button labeling.
		 */
		private static var ITEM_SHORT_LIBRARY:Dictionary = new Dictionary();
		public static function get NOTHING():ItemType {
			if (!_NOTHING) _NOTHING = new ItemTypeNothing();
			return _NOTHING;
		}
		private static var _NOTHING:ItemType;
		/**
		 * "Old id" -> "New id" mapping
		 */
		private static const LEGACY_REMAP:Object = {
			// Old hair dyes
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
			"QWhiteD": dynamicItemId("HairDye", {color:"Quartz White",rarity:3}),
			// Old skin oils
			"DarkOil": dynamicItemId("SkinOil", {color: "dark"}),
			"EbonyOl": dynamicItemId("SkinOil", {color: "ebony"}),
			"FairOil": dynamicItemId("SkinOil", {color: "fair"}),
			"LightOl": dynamicItemId("SkinOil", {color: "light"}),
			"MahogOl": dynamicItemId("SkinOil", {color: "mahogany"}),
			"OliveOl": dynamicItemId("SkinOil", {color: "olive"}),
			"RussOil": dynamicItemId("SkinOil", {color: "russet"}),
			"Tan Oil": dynamicItemId("SkinOil", {color: "tan"}),
			// Old weapons
			"Claymor":  dynamicItemId("DynamicWeapon",
					{t: "claymore", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Dagger ": dynamicItemId("DynamicWeapon",
					{t: "dagger", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Halberd": dynamicItemId("DynamicWeapon",
					{t: "halberd", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Kama": dynamicItemId("DynamicWeapon",
					{t: "kama", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Katana ": dynamicItemId("DynamicWeapon",
					{t: "katana", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Mace   ": dynamicItemId("DynamicWeapon",
					{t: "mace", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Nodachi": dynamicItemId("DynamicWeapon",
					{t: "nodachi", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Ribbon ": dynamicItemId("DynamicWeapon",
					{t: "ribbon", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Scimitr": dynamicItemId("DynamicWeapon",
					{t: "scimitar", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Uchigatana ": dynamicItemId("DynamicWeapon",
					{t: "uchigatana", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Warhamr": dynamicItemId("DynamicWeapon",
					{t: "warhammer", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Whip   ": dynamicItemId("DynamicWeapon",
					{t: "whip", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []}),
			"Zwnder ": dynamicItemId("DynamicWeapon",
					{t: "zweihander", q: 0, c: CS_KNOWN_UNCURSED, r: RARITY_COMMON, e: []})
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
		
		public static function lookupCachedItem(id:String):ItemType {
			if (id in LEGACY_REMAP) id = LEGACY_REMAP[id];
			var i:int = id.indexOf(";");
			if (i >= 0) return DYNAMIC_ITEM_LIBRARY[id];
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
		 * Max stack size for items of that type
		 */
		public static var DEFAULT_STACK_SIZE:int = 10;
		public static var DEFAULT_PEARL_STACK_SIZE:int = 20;
		public var stackSize:int = DEFAULT_STACK_SIZE;
		public var pearlStackSize:int = DEFAULT_PEARL_STACK_SIZE;

		public function get ownIconId():String {
			if (this.isDynamicItem) return "I_"+templateId();
			else return "I_"+id;
		}
		public function get iconId():String {
			return IconLib.pickIcon(ownIconId, "I_GenericItem_"+category, "I_GenericItem");
		}
		public function get category():String {
			CoC_Settings.errorAMC("ItemType","category",_id)
			return CATEGORY_OTHER;
		}
		public function get tagForBuffs():String {
			return "item_"+_id;
		}
		public function get isDynamicItem():Boolean {
			return _id.indexOf(';') >= 0;
		}
		public function get cursed():Boolean {
			return false;
		}
		public function get buttonColor():String {
			return "#000000";
		}
		public function templateId():String {
			var i:int = _id.indexOf(';');
			if (i < 0) throw new Error(longName+" is not a dynamic item!");
			return _id.substr(0, i);
		}
		public function templateParams():Object {
			var i:int = _id.indexOf(';');
			if (i < 0) throw new Error(longName+" is not a dynamic item!");
			return JSON.parse(_id.substr(i+1));
		}
		
		public var itemEffects:/*ItemEffect*/Array = [];
		/**
		 * Index = item effect flag IEF_XXXX
		 * Value = array of item effects that have this flag
		 * */
		protected var _effectsFlagged:/*Array*/Array = [];
		
		public function getEnchantments():/*Enchantment*/Array {
			return [];
		}
		
		/**
		 * @return true if enchantment of that type is present on an item
		 */
		public function hasEnchantment(type:EnchantmentType):Boolean {
			return false;
		}
		/**
		 * @return power of enchantment of that type, or 0 if there's no such enchantment
		 */
		public function enchantmentPower(type:EnchantmentType):Number {
			return 0;
		}
		
		/**
		 * @return enchantment of specified type, or null if there's no such enchantment
		 */
		public function enchantmentOfType(type:EnchantmentType):Enchantment{
			return null;
		}
		
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
		public function get longNameBase():String {
			return longName.replace(/^(the|a|an)\s+/i,'');
		}
		public function get name():String {
			return longName;
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
		
		public function get isNothing():Boolean {
			return false;
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
				if (_id in DYNAMIC_ITEM_LIBRARY) {
					trace("[WARNING] Duplicate dynamic item "+_id);
				}
				DYNAMIC_ITEM_LIBRARY[_id] = this;
				dynamicItemCounter++;
				trace("new "+_id+" / "+dynamicItemCounter);
			} else {
				if (ITEM_LIBRARY[_id] != null) {
					var msg:String = "Duplicate itemid " + _id + ", old item is " + (ITEM_LIBRARY[_id] as ItemType).longName;
					CoC_Settings.error(msg);
					throw new Error(msg);
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
		public function withTag(tag:String):ItemType {
			this._tags[tag] = 1;
			return this;
		}
		
		/**
		 * Add multiple tags to this item type. Use only when registering new item type!
		 * @param tags array of tags
		 * @return this
		 */
		public function withTags(...tags:/*String*/Array):ItemType {
			for each (var tag:String in tags) this._tags[tag] = 1;
			return this;
		}
		
		/**
		 * Add multiple tags to this item type. Use only when registering new item type!
		 * @param tags array of tags
		 * @return this
		 */
		public function withTagsV(tags:/*String*/Array):ItemType {
			for each (var tag:String in tags) this._tags[tag] = 1;
			return this;
		}

		public function hasTag(tag:String):Boolean {
			return tag in this._tags;
		}
		public function hasAllTags(...tags:/*String*/Array):Boolean {
			for each (var tag:String in tags) {
				if (!(tag in this._tags)) return false;
			}
			return true;
		}
		public function hasAnyTag(...tags:/*String*/Array):Boolean {
			for each (var tag:String in tags) {
				if (tag in this._tags) return true;
			}
			return false;
		}
		
		/**
		 * Called when item effect is added during the construction.
		 */
		protected function addEffect(ie:ItemEffect):void {
			itemEffects.push(ie);
			if (ie.type.flags) {
				// flag goes 1, 2, 4, 8, 16, ..., (1<<31)
				for (var flag:int = 1; flag <= ItemEffectLastFlag && flag > 0; flag <<= 1) {
					if ((ie.type.flags & flag) != 0) {
						(_effectsFlagged[flag] ||= []).push(ie);
					}
				}
			}
		}
		/**
		 * Add property to this item type. Use only when registering new item type!
		 * @param type IELib.XXXX
		 */
		public function withEffect(type:ItemEffectType, power:Number, value1:* = undefined, value2:* = undefined, value3:* = undefined, value4:* = undefined):ItemType {
			addEffect(new ItemEffect(type, power, value1, value2, value3, value4));
			return this;
		}
		
		/**
		 * List of all effect that have flag set
		 * @param flag ItemConstants.IEF_XXXX
		 * @return
		 */
		public function effectsFlagged(flag:int):/*ItemEffect*/Array {
			return _effectsFlagged[flag] || [];
		}
		public function findEffect(type:ItemEffectType):ItemEffect {
			for each (var ie:ItemEffect in itemEffects) {
				if (ie.type == type) return ie;
			}
			return null;
		}
		public function hasEffect(type:ItemEffectType):Boolean {
			return !!findEffect(type);
		}
		public function effectPower(type:ItemEffectType, defaultPower:Number=0):Number {
			var ie:ItemEffect = findEffect(type);
			return ie ? ie.power : defaultPower;
		}
		public function effectValue1(type:ItemEffectType, defaultValue:*):* {
			var ie:ItemEffect = findEffect(type);
			return ie ? ie.value1 : defaultValue;
		}
		public function effectValue2(type:ItemEffectType, defaultValue:*):* {
			var ie:ItemEffect = findEffect(type);
			return ie ? ie.value2 : defaultValue;
		}
		public function effectValue3(type:ItemEffectType, defaultValue:*):* {
			var ie:ItemEffect = findEffect(type);
			return ie ? ie.value3 : defaultValue;
		}
		public function effectValue4(type:ItemEffectType, defaultValue:*):* {
			var ie:ItemEffect = findEffect(type);
			return ie ? ie.value4 : defaultValue;
		}

		public function toString():String
		{
			return "\""+_id+"\"";
		}
	}
}
