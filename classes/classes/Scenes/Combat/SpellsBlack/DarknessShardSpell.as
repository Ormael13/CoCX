package classes.Scenes.Combat.SpellsBlack {
import classes.GlobalFlags.kACHIEVEMENTS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class DarknessShardSpell extends AbstractBlackSpell {
	public var ex:Boolean;
	
	public function DarknessShardSpell(ex:Boolean = false) {
		super(
				ex ? "Darkness Shard (Ex)" : "Darkness Shard",
				ex ?
						"Drawning your own lust and wrath to condense part of the the ambivalent darkness into a shard to attack your enemies."
						: "Drawning your own lust to condense part of the the ambivalent darkness into a shard to attack your enemies.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING, TAG_DARKNESS]
		);
		baseManaCost = 40;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	
	override public function get buttonName():String {
		return ex ? "DarkShard(Ex)" : "DarkShard"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false) + " darkness damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsDarknessShard) &&
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
			outputText("You narrow your eyes, focusing your own lust with deadly intent.  At the palm of your hand form a shard from pure darkness that shots toward [themonster]!\n");
		}
		var damage:Number = calcDamage(monster);
		critAndRepeatDamage(display, damage, DamageType.DARKNESS);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		damage *= omnicasterRepeatCount();
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
