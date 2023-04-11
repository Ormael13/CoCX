package classes.Scenes.Combat.SpellsBlood {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBloodSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class BloodShieldSpell extends AbstractBloodSpell {
	public function BloodShieldSpell() {
		super(
			"Blood Shield",
			"Blood Shield will form blood shield to block enemy attacks.",
			TARGET_SELF,
			TIMING_TOGGLE,
			[TAG_BUFF]
		);
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "Absorb "+calcPower()+" damage";
	}
	
	override public function get buttonName():String {
		return isActive() ? "Deactiv BS" : "Blood Shield";
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsBloodShield);
	}
	
	override public function isActive():Boolean {
		return player.hasStatusEffect(StatusEffects.BloodShield);
	}
	
	override public function hpCost():Number {
		return spellCostBlood(calcBasePower());
	}
	public function calcPower():Number {
		var cP:Number = calcBasePower() * spellModBlood();
		if (player.hasPerk(PerkLib.BloodDemonIntelligence)) cP *= 2;
		return Math.round(cP);
	}
	public function calcBasePower():Number {
		var shieldcost:Number = 0;
		shieldcost += (player.maxOverHP() * 0.2);
		return shieldcost;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You concentrate, focusing on the power of your blood before drawing it from your body, " + (player.HP < player.maxOverHP() ? "wounds":"skin pores") + ". Blood starts to gather around you, coalescing into a semi transparent crimson "+(player.hasStatusEffect(StatusEffects.Flying)?"":"hemi")+"sphere.");
		}
		player.createStatusEffect(StatusEffects.BloodShield,calcPower(),0,0,0);
	}
	
	override public function toggleOff(display:Boolean = true):void {
		if (display) {
			outputText("Deciding you no longer need to maintain your blood shield, you stop maintaining it.");
		}
		player.removeStatusEffect(StatusEffects.BloodShield);
	}
	
}
}
