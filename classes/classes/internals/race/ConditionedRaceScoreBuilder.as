package classes.internals.race {
public class ConditionedRaceScoreBuilder extends RaceScoreBuilder{
	private var condition:Function;
	private var conditionName:String;
	public function ConditionedRaceScoreBuilder(
			raceBuilder:RaceBuilder,
			prev:RaceScoreBuilder,
			condition:Function,
			conditionName:String,
			minScore:int
	) {
		super(raceBuilder, prev, minScore);
		this.next = prev||this;
		this.condition = condition;
		this.conditionName = conditionName;
	}
	
	override protected function addRequirement(requirement:RacialRequirement):void {
		super.addRequirement(requirement.withCondition(condition, conditionName));
	}
}
}
