package classes.internals.race {
import classes.Race;
import classes.RaceTier;
import classes.internals.Utils;

public class RaceBuilder {
	private var id:int;
	internal var name:String;
	internal var tiers:/*RaceTier*/Array = [];
	internal var requirements:/*RacialRequirement*/Array = [];
	private var raceClass:Class;
	
	public function RaceBuilder(raceClass:Class, id:int, name:String) {
		this.id = id;
		this.name = name;
		this.raceClass = raceClass;
	}
	
	public function addRequirement(requirement:RacialRequirement):void {
		requirements.push(requirement);
	}
	
	public function withBasicScores():RaceScoreBuilder {
		return new RaceScoreBuilder(this);
	}
	/**
	 * @param conditionFn `(body:BodyData) => boolean`
	 * @return
	 */
	public function withConditionedScores(
			conditionFn:Function,
			conditionName:String,
			minScore:int=0
	):RaceScoreBuilder {
		return new ConditionedRaceScoreBuilder(this, null, conditionFn, conditionName, minScore);
	}
	
	public function withTier(minScore:int, name:String, femaleName:String=""):RaceTierBuilder {
		if (!femaleName) femaleName = name;
		var builder:RaceTierBuilder = new RaceTierBuilder(
				this,
				this.tiers.length+1,
				minScore,
				name,
				femaleName
		);
		return builder
	}
	
	public function build():Race {
		// Race imports RaceBuilder and RaceBuilder imports Race
		// And RaceBuilder is invoked at Race static init
		// At that time imported Race in RaceBuilder is null
		// So we have to pass Race constructor from Race itself
		var race:Race = new raceClass(
				this.name,
				this.id,
				"",
				tiers.length>0 ? tiers[0].minScore :1
		);
		Utils.pushAll(race.requirements, requirements);
		Utils.pushAll(race.tiers, tiers);
		return race;
	}
}
}
