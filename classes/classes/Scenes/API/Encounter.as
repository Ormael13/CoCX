/*
 * Created by aimozg on 26.03.2017.
 */
package classes.Scenes.API {
/**
 * An interface for exploration encounters.
 *
 * - For each encounter registered in area, a Encounter.encounterChance() method is called.
 * -- If the chance is Encounters.ALWAYS = Number.POSITIVE_INFINITY, that encounter is executed immediataly
 *    and no further encounter checks are performed.
 * - If there were no such encounter, the weighted (by the returned chance) encounter is executed.
 * The scale is arbitrary as long as it's same in the grouped encounters.
 * - Numbers aroung 100 are easy to read, write, and understand.
 * - (preferred) Scale from 0 to 1 enables multiplication of chances without them going out of scale
 */
public interface Encounter {
	/**
	 * - 1 for "generic",
	 * - 2-4 for varying scales of "often",
	 * - 0.1-0.5 for "rare",
	 * - 0.01-0.1 for "very rare"
	 */
	function encounterChance():Number;
	function execEncounter():void;
	function encounterName():String;
}
}
