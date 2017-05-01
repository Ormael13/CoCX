/**
 * Created by aimozg on 28.03.2017.
 */
package classes.Scenes.API {
import classes.BaseContent;
import classes.GlobalFlags.kFLAGS;
import classes.GlobalFlags.kGAMECLASS;

public class FnHelpers extends BaseContent {
	public static const FN:FnHelpers = new FnHelpers();
	/**
	 * @param chances An array of chances or chance functions
	 * @return A function returning product of chances. If encountered, 0 beats INFINITY
	 */
	public function product(chances:Array):Function {
		var saved:Array = chances.concat([]);
		return function():Number {
			var rslt:Number = 1;
			for (var i:int=0;i<saved.length;i++) {
				var o:* = Encounters.convertChance(saved[i]);
				if (o <= 0) return 0;
				rslt *= o;
			}
			return rslt;
		}
	}

	/**
	 * @param chance Number | Boolean | Function():Number|Boolean
	 * @return Function returning 0 if `chance` is not 0, 1 otherwise
	 */
	public function not(chance:*):Function {
		return function():Number {
			var c:* = (chance is Function) ? chance() : chance;
			return Encounters.convertChance(c) ? 0 : 1;
		}
	}
	/**
	 * @param chances Array of [Number | Boolean | Function():Number|Boolean]
	 * @return Function returning 1 iff all chances are not 0, 0 if any is 0
	 */
	public function all(...chances):Function {
		return function():Number {
			for each (var chance:Object in chances) {
				var c:*=chance;
				if (c is Function) c = c();
				if (!Encounters.convertChance(c)) return 0;
			}
			return 1;
		}
	}
	/**
	 * @param chances Array of [Number | Boolean | Function():Number|Boolean]
	 * @return Function returning 1 iff all chances are 0, 0 if any is 1
	 */
	public function none(...chances):Function {
		return function():Number {
			for each (var chance:Object in chances) {
				var c:*=chance;
				if (c is Function) c = c();
				if (Encounters.convertChance(c)) return 0;
			}
			return 1;
		}
	}
	/**
	 * @param chances Array of [Number | Boolean | Function():Number|Boolean]
	 * @return Function returning 0 iff all chances are 0, 1 if any is not 0
	 */
	public function any(...chances):Function {
		return function():Number {
			for each (var chance:Object in chances) {
				var c:*=chance;
				if (c is Function) c = c();
				if (Encounters.convertChance(c)) return 1;
			}
			return 0;
		}
	}
	/**
	 * @return Function returning `iftrue` if player is at least `level` or at least `daysPerLevel`*`level` days have passed, `iffalse` otherwise
	 */
	public function ifLevelMin(level:int, daysPerLevel:int =6, iftrue:* =1, iffalse:* =0):Function {
		return function():* {
			return (player.level>=level || time.days>=level*daysPerLevel) ? iftrue : iffalse;
		}
	}
	/**
	 * @return Function returning Number, linearly dependent on player level:
	 * - at levleA: valueA
	 * - at levelB: valueB
	 * - in levelA..levelB: linearly interpolated value
	 * - if bound==true (default), for levels < levelA returns valueA, for levels > levelB returns valueB
	 * - if bound==false, continues the interpolation outside the levelA..levelB interval,
	 * optionally capped between min and max
	 */
	public function lineByLevel(levelA:int,
								levelB:int,
								valueA:Number,
								valueB:Number,
								bound:Boolean = true,
								min:Number    = Number.NEGATIVE_INFINITY,
								max:Number    = Number.POSITIVE_INFINITY):Function {
		const factor:Number = (valueB - valueA) / (levelB - levelA);
		return function():Number {
			const x:Number = player.level;
			if (bound) {
				if (x <= levelA) return valueA;
				if (x >= levelB) return valueB;
			}
			if (levelA == levelB) return (valueA+valueB)/2;
			const y:Number = valueA + (x - levelA) * factor;
			return Math.min(max,Math.max(min,y));
		}
	}

	/**
	 * @return Function returning `iftrue` if current time (in hours) is between `minimum` (0-23, INCLUSIVELY) and `maximum` (0-24, EXCLUSIVELY)
	 */
	public function ifTimeOfDay(minimum:int,maximum:int,iftrue:*=1,iffalse:*=0):Function {
		return function():* {
			var hours:Number = time.hours;
			return (hours >= minimum && hours < maximum) ? iftrue : iffalse;
		}
	}

	/**
	 * @return Function returning `iftrue` if NG+ level is at least `minimum`, `iffalse` otherwise
	 */
	public function ifNGplusMin(minimum:int,iftrue:*=1,iffalse:*=0):Function {
		return function():* {
			return flags[kFLAGS.NEW_GAME_PLUS_LEVEL] > 0 ? iftrue : iffalse;
		}
	}

	public function FnHelpers() {
	}

	public function ifPregnantWith(pregnancyType:int,iftrue:*=1,iffalse:*=0):Function {
		return function():* {
			return player.pregnancyIncubation > 1 && player.pregnancyType == pregnancyType ? iftrue : iffalse
		}
	}
}
}
