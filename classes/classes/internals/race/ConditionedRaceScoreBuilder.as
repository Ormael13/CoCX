package classes.internals.race {
import classes.Race;

public class ConditionedRaceScoreBuilder extends RaceScoreBuilder{
	private var condition:Function;
	private var conditionName:String;
	public function ConditionedRaceScoreBuilder(
			race:Race,
			condition:Function,
			conditionName:String,
			minScore:int
	) {
		super(race, minScore);
		this.condition = condition;
		this.conditionName = conditionName;
	}
	
	override protected function addRequirement(requirement:RacialRequirement, customName:String = ""):void {
		super.addRequirement(requirement.withCondition(condition, conditionName),customName);
	}
}
}
