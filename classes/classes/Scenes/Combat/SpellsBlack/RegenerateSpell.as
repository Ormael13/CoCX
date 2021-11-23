package classes.Scenes.Combat.SpellsBlack {
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.StatusEffects;

public class RegenerateSpell extends AbstractBlackSpell {
	public function RegenerateSpell() {
		super(
				"Regenerate",
				"Regenerate will attempt to trigger health recovery over time, however like all black magic used on yourself, it has a chance of backfiring and greatly arousing you.  ",
				TARGET_SELF,
				TIMING_LASTING,
				[TAG_BUFF, TAG_HEALING]
		);
		baseManaCost           = 50;
		canBackfire            = true;
		isLastResortApplicable = false;
		isBloodMagicApplicable = false;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsRegenerate)
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.PlayerRegenerate);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus on your body and its desire to end pain, trying to draw on your arousal without enhancing it.");
		}
		if (!backfired(display)) {
			if (player.hasStatusEffect(StatusEffects.PlayerRegenerate)) player.addStatusValue(StatusEffects.PlayerRegenerate, 1, 7);
			else player.createStatusEffect(StatusEffects.PlayerRegenerate, 7, 0, 0, 0);
			outputText(" This should hold up for about seven rounds.");
		}
		
	}
}
}
