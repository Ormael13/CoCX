package classes.internals.race {
import classes.BodyData;

public class BloodlineRacialRequirement extends RacialRequirement {
	public function BloodlineRacialRequirement(
			name:String,
			perks:/*PerkType*/Array
	) {
		super(
				"",
				name,
				RaceUtils.hasAnyPerkFn(perks),
				0,
				0
		);
	}
	
	override public function score(body:BodyData):int {
		return body.player.increaseFromBloodlinePerks();
	}
	
	override public function varyingScore():Boolean {
		return true;
	}
}
}
