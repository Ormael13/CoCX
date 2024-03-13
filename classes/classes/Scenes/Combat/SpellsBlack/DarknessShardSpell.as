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
				"Drawing your own lust and wrath to condense part of the ambient darkness into a shard to attack your enemies."
				: "Drawing your own lust to condense part of the ambient darkness into a shard to attack your enemies.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_DARKNESS, TAG_TIER1]
		);
		baseManaCost = 40;
		if (ex) baseWrathCost = 100;
		this.ex = ex;
	}
	
	
	override public function get buttonName():String {
		return ex ? "DarkShard(Ex)" : "DarkShard"
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " darkness damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsDarknessShard) &&
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
		return adjustSpellDamage(baseDamage, DamageType.DARKNESS, CAT_SPELL_BLACK, monster, true, casting);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You narrow your eyes, enfusing your mana with the sickly-sweet power of lust.  In the palm of your hand forms a shard of energy, blacker than night, which pushes the light away. You focus your will at your enemy, and your shadowy missile rockets toward [themonster]!\n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.DARKNESS);
		if (ex) awardAchievement("Edgy Caster", kACHIEVEMENTS.COMBAT_EDGY_CASTER);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
