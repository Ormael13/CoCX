/**
 * Coded by aimozg on 06.05.2018.
 */
package classes.Stats {
import classes.Creature;

public interface IStat {
	function get statName():String;
	function get host():Creature;
	function get value():Number;
	function get min():Number;
	function get max():Number;
}
}
