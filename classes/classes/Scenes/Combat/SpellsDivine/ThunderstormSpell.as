package classes.Scenes.Combat.SpellsDivine {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractDivineSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class ThunderstormSpell extends AbstractDivineSpell {
	public function ThunderstormSpell() {
		super(
			"Thunderstorm",
			"Call upon the heavenly thunder, starting a lightning storm that will systematically zap your opponents every turn for up to 30 rounds.  ",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DAMAGING, TAG_LIGHTNING]
		);
		baseManaCost = 1200;
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsThunderstorm)
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~"+numberFormat(calcDamage(target, false, false))+" lightning damage for "+numberOfThings(calcDuration(),"round");
	}
	
	override public function isActive():Boolean {
		return player.statusEffectv2(StatusEffects.Thunderstorm) > 0;
	}
	
	override protected function usabilityCheck():String {
		if (player.hasStatusEffect(StatusEffects.Thunderstorm)) {
			return "Can be casted only once per combat.";
		}
		return super.usabilityCheck();
	}
	
	override public function calcDuration():int {
		return 30;
	}
	
	public override function advance(display:Boolean):void {
		player.addStatusValue(StatusEffects.Thunderstorm, 2, -1);
		if (display) {
			outputText("<b>A bolt of divine lightning falls from the sky and strikes [themonster]</b>. ");
		}
		doLightningDamage(player.statusEffectv1(StatusEffects.Thunderstorm), true, display);
		if (display) {
			outputText("\n\n");
		}
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean=true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		return adjustSpellDamage(
				scalingBonusIntelligence(randomize),
				DamageType.LIGHTNING,
				CAT_SPELL_DIVINE,
				monster,
				false,
                casting
			);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You call upon the anger of the gods to smite your foe and they gladly answer with thunder. Lightning begins to strike down upon your opponent"+(monster.plural ? "s":"")+" with perfect precision.");
		}
		var damage:Number = calcDamage(monster, true, true);
		
		player.createStatusEffect(StatusEffects.Thunderstorm, damage, calcDuration(), 0, 0);
		damage = critAndRepeatDamage(display, damage, DamageType.LIGHTNING);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
