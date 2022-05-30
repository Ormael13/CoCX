package classes.internals.race {
import classes.BodyData;
import classes.RaceTier;
import classes.Stats.StatUtils;

public class DynamicBuffRaceTier extends RaceTier {
	/**
	 * `(body:BodyData)=>buff object`
	 */
	private var dynamicBuffsFn:Function;
	private var dynamicBuffDescription:String;
	
	/**
	 * @param nameFn `(body:BodyData)=>String`
	 * @param staticBuffs buff object
	 * @param dynamicBuffsFn `(body:BodyData)=>buff object`
	 * @param dynamicBuffDescription string to display when tier is not present
	 */
	public function DynamicBuffRaceTier(
			tierNumber:int,
			name:String,
			nameFn:Function,
			minScore:int,
			staticBuffs:Object,
			dynamicBuffsFn:Function,
			dynamicBuffDescription:String,
			requirements:/*RaceTierRequirement*/Array,
			extraBonuses:/*String*/Array
	) {
		super(
				tierNumber,
				name,
				nameFn,
				minScore,
				staticBuffs,
				requirements,
				extraBonuses
		);
		this.dynamicBuffsFn = dynamicBuffsFn;
		this.dynamicBuffDescription = dynamicBuffDescription;
	}
	
	override public function hasBuffs():Boolean {
		return true;
	}
	
	override public function unscaledBuffs(body:BodyData):Object {
		if (!body) return _buffs;
		return StatUtils.mergeBuffObjects(
				dynamicBuffsFn(body),
				_buffs
		);
	}
	
	override public function describeBuffs(body:BodyData, separator:String = ", ", withExtraBonuses:Boolean = true):String {
		var s:String = super.describeBuffs(body, separator, withExtraBonuses);
		if (!body && dynamicBuffDescription && withExtraBonuses) {
			if (s) s += ", "+dynamicBuffDescription;
			else s = dynamicBuffDescription;
		}
		return s;
	}
}
}
