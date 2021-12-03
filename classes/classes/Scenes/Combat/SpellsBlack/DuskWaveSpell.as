package classes.Scenes.Combat.SpellsBlack {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class DuskWaveSpell extends AbstractBlackSpell {
	public var ex:Boolean;
	
	public function DuskWaveSpell(ex:Boolean = false) {
		super(
				ex ? "Dusk Wave (Ex)" : "Dusk Wave",
				ex ?
						"Drawning your own lust to condense part of the the ambivalent darkness into a wave to attack your enemies."
						: "Drawning your own lust and wrath to condense part of the the ambivalent darkness into a wave to attack your enemies.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING, TAG_DARKNESS, TAG_AOE]
		);
		baseManaCost = 200;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function get buttonName():String {
		return ex ? "DuskWave(Ex)" : "Dusk Wave"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false) + " darkness damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsDuskWave) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
	}
	
	override public function calcCooldown():int {
		return spellBlackCooldown();
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true):Number {
		var baseDamage:Number = 2 * scalingBonusIntelligence(randomize);
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You wave the signs with your hands and all light fades as you call down to the primordial darkness to gnaw at [themonster].  \n");
		}
		var damage:Number = calcDamage(monster);
		damage = critAndRepeatDamage(display, damage, DamageType.DARKNESS);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
