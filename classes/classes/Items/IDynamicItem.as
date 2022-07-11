package classes.Items {
import classes.ItemType;

public interface IDynamicItem {
	function get subtypeId():String;
	function get subtype():Object;
	function get quality():int;
	function get rarity():int;
	function get curseStatus():int;
	function get identified():Boolean;
	function get effects():/*Enchantment*/Array;
	/**
	 * Returns fully identified copy of this item (this if it is already identified)
	 */
	function identifiedCopy():ItemType;
	
	/**
	 * Returns copy of this item with curse flag removed
	 */
	function uncursedCopy():ItemType;
	
	/**
	 * Returns a copy of this item, modified with options
	 * @param options
	 * @param options.t (optional) New subtype
	 * @param options.c (optional) New curse status
	 * @param options.q (optional) New quality
	 * @param options.r (optional) New rarity
	 * @param options.e (optional) New Enchantment[] array
	 */
	function moddedCopy(options:Object):ItemType;
	function copyWithEnchantment(e:Enchantment):ItemType;
	function copyWithoutEnchantment(e:Enchantment):ItemType;
}
}
