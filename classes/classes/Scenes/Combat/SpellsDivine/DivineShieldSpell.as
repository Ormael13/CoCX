package classes.Scenes.Combat.SpellsDivine {
import classes.Monster;
import classes.Scenes.Combat.AbstractDivineSpell;
import classes.StatusEffects;

public class DivineShieldSpell extends AbstractDivineSpell {
	public function DivineShieldSpell() {
		super(
			"Divine Shield",
			"Increase magic resistance by 40%.",
			TARGET_SELF,
			TIMING_LASTING,
			[TAG_BUFF]
		);
		baseManaCost = 600;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsDivineShield)
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "+"+calcMagnitude()+"% magic resistance for "+numberOfThings(calcDuration(),"round");
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.DivineShield);
	}
	
	override public function calcDuration():int {
		var duration:Number = 6;
		duration += combat.magic.perkRelatedDurationBoosting();
		return duration;
	}
	
	public function calcMagnitude():Number {
		return 40;
	}
	
	override public function advance(display:Boolean):void {
		if (player.statusEffectv2(StatusEffects.DivineShield) <= 0) {
			player.removeStatusEffect(StatusEffects.DivineShield);
		} else {
			player.addStatusValue(StatusEffects.DivineShield, 2, -1);
		}
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You usher a prayer for protection from the dark spells cast by the heretics and a powerful bubble of raw energy encases you, deflecting most of the magical assaults away.\n\n");
		}
		player.createStatusEffect(StatusEffects.DivineShield,calcMagnitude(),calcDuration(),0,0);
	}
}
}
