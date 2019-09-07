/**
 * Created by aimozg on 27.03.2017.
 */
package classes.GlobalFlags {
import classes.internals.CountersStorage;

public class kCOUNTERS {
	function kCOUNTERS() {
	}

	// ======================
	// COUNTER LISTS
	// =====================
	public static const VERSION:int = 0; // May contain versioning. ATM [] is "old save" and [1] is "new save"
	// Monsters (excluding ones with low encounter limit)
	public static const MONSTER_BEEGIRL:int        = 1;
	public static const MONSTER_CUMWITCH:int       = 2;
	public static const MONSTER_GOBLIN:int         = 3;
	public static const MONSTER_GOBLINASSASSIN:int = 4;
	public static const MONSTER_GOBLINMATRON:int   = 5; // Tamani
	public static const MONSTER_GOBLINELDER:int    = 6;
	public static const MONSTER_GOBLINSHAMAN:int   = 7;
	public static const MONSTER_GOBLINWARRIOR:int  = 8;
	public static const MONSTER_IMP:int            = 9;
	public static const MONSTER_IMPLORD:int        = 10;
	public static const MONSTER_IMPWARLORD:int     = 11;
	public static const MONSTER_IMPOVERLORD:int    = 12;
	public static const MONSTER_NAGA:int           = 13;
	public static const MONSTER_SANDTRAP:int       = 14;
	public static const MONSTER_SANDWITCH:int      = 15;
	public static const MONSTER_SUCCUBUS:int       = 16;
	public static const MONSTER_TENTACLEBEAST:int  = 17;
	// Monster groups, can be nested. It's even possible to build a proper taxonomy
	public static const MONGROUP_HUMAN:int         = 201; // down to ~3/4 humanity
	public static const MONGROUP_HUMANOID:int      = 202; // giants, oni
	public static const MONGROUP_GOBLINOID:int     = 203; // all kinds of goblins
	public static const MONGROUP_DEMON:int         = 204;
	public static const MONGROUP_INSECT:int        = 205;
	public static const MONGROUP_REPTILIAN:int     = 206;

	// ======================
	// COUNTER LIST ITEMS
	// =====================
	// Monster and monster group counter list structure
	// monster WON/LOST [to] player
	public static const _MONSTER_VERSION:int       = 0;
	public static const _MONSTER_ENCOUNTERED:int   = 1;
	public static const _MONSTER_BATTLED:int       = 2;
	public static const _MONSTER_WON_TOTAL:int     = 3;
	public static const _MONSTER_WON_LUST:int      = 4;
	public static const _MONSTER_WON_HP:int        = 5;
	public static const _MONSTER_LOST_TOTAL:int    = 6;
	public static const _MONSTER_LOST_LUST:int     = 7;
	public static const _MONSTER_LOST_HP:int       = 8;
	public static const _MONSTER_RANFROM:int       = 9;
	public static const _MONSTER_SEX_TOTAL:int     = 10;
	public static const _MONSTER_SEX_WHEN_WON:int  = 11;
	public static const _MONSTER_SEX_WHEN_LOST:int = 12;
	public static const _MONSTER_SEX_NO_BATTLE:int = 13;

	public static const internals:* = {
		MAX_COUNTER: 500
	};

	public static function create():CountersStorage {
		return new CountersStorage();
	}

	/**
	 * Initialize for new game values
	 */
	public static function initialize(counters:CountersStorage):void {
		counters[VERSION] = [1];
	}

	public static function isInitialized(counters:CountersStorage):Boolean {
		return counters[VERSION] is Array && counters[VERSION].length > 0;
	}
}
}
