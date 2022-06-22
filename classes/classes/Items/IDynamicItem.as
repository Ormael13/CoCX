package classes.Items {
public interface IDynamicItem {
	function get subtypeId():String;
	function get subtype():Object;
	function get quality():int;
	function get rarity():int;
	function get curseStatus():int;
	function get identified():Boolean;
	function get effects():/*Enchantment*/Array;
}
}
