package classes.Scenes.Combat.SpellsBlack {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class IceSpikeSpell extends AbstractBlackSpell {
	public var ex:Boolean;
	
	public function IceSpikeSpell(ex:Boolean = false) {
		super(
			ex ? "Ice Spike (Ex)" : "Ice Spike",
			ex ?
				"Drawing your own lust and wrath to concentrate it into chilling spike of ice that will attack your enemies."
				: "Drawing your own lust to concentrate it into chilling spike of ice that will attack your enemies.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_ICE, TAG_TIER1]
		);
		baseManaCost = 40;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " ice damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsIceSpike) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
	}
	
	override public function calcCooldown():int {
		var calcC:int = 0;
		calcC += spellBlackCooldown();
		if (player.weaponRange == weaponsrange.RB_TOME && player.level < 18) {
			if (player.level < 6) calcC -= 1;
			if (player.level < 12) calcC -= 1;
			calcC -= 1;
			if (calcC < 0) calcC = 0;
		}
		return calcC;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var baseDamage:Number = 2 * scalingBonusIntelligence(randomize);
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form ice spike that shots toward [monster a] [monster name]!\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.ICE);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
