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
						"Drawning your own lust and wrath to concentrate it into chilling spike of ice that will attack your enemies."
						: "Drawning your own lust to concentrate it into chilling spike of ice that will attack your enemies.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING, TAG_ICE]
		);
		baseManaCost = 40;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false) + " ice damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsIceSpike) &&
				(!ex || player.hasPerk(PerkLib.MagesWrathEx));
	}
	
	override public function get currentCooldown():int {
		return ex ?
				player.statusEffectv1(StatusEffects.CooldownSpellIceSpikeEx)
				: player.statusEffectv1(StatusEffects.CooldownSpellIceSpike);
	}
	
	override public function useResources():void {
		super.useResources();
		player.createStatusEffect(
				ex ?
						StatusEffects.CooldownSpellIceSpikeEx
						: StatusEffects.CooldownSpellIceSpike,
				spellBlackCooldown(), 0, 0, 0);
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true):Number {
		var baseDamage:Number = 2 * scalingBonusIntelligence(randomize);
		if (ex) baseDamage *= 2;
		return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form ice spike that shots toward [monster a] [monster name]!\n");
		}
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(display, damage, DamageType.ICE);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		damage *= omnicasterRepeatCount();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
