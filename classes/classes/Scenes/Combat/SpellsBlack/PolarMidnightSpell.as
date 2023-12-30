package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class PolarMidnightSpell extends AbstractBlackSpell {
	public function PolarMidnightSpell() {
		super(
			"Polar Midnight",
			"Cause a massive temperature drop which freezes the air solid in an area. Opponents caught in this spell take the cold damage and are stunned for 5 round.  " +
			"\n<b>Req. 1 turn channeling. Cooldown: 12 turns</b>",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_ICE, TAG_AOE, TAG_TIER3]
		);
		baseManaCost = 1250;
	}
	
	override public function get buttonName():String {
		return "PolarMidnight"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsPolarMidnight);
	}
	
	override public function calcCooldown():int {
		return spellBlackTier3Cooldown();
	}
	
	override public function setCooldown():void {
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			super.setCooldown();
		} else {
			/* we're channeling, don't renew cooldown */
		}
	}
	
	override public function useResources():void {
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			super.useResources();
		} else {
			/* we're channeling, don't use mana */
		}
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " ice damage. "
	}
	
	public function calcDamage(target:Monster, randomize:Boolean = true, casting:Boolean = true):Number {
		var baseDamage:Number = scalingBonusIntelligence(randomize) * 24;
		if (player.weaponRangeName == "Artemis") baseDamage *= 1.5;
		return adjustSpellDamage(
				baseDamage,
				DamageType.ICE,
				CAT_SPELL_BLACK,
				target,
                true,
                casting
		);
	}
	
	public function polarMidnightHit(display:Boolean = true):void {
		player.removeStatusEffect(StatusEffects.ChanneledAttack);
		player.removeStatusEffect(StatusEffects.ChanneledAttackType);
		if ((player.hasPerk(PerkLib.GlacialStormSu) || player.hasPerk(PerkLib.GlacialStormMastered)) && player.hasStatusEffect(StatusEffects.CounterGlacialStorm)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 3, -1);
		if (display) {
			outputText("You drain the heat out of the air around your foe, causing its temperature to plummet far below its freezing point in an instant, effectively flash freezing your enemy for \n");
		}
		var damage:Number = calcDamage(monster, true, true);
		damage = critAndRepeatDamage(display, damage, DamageType.ICE);
		if (!monster.hasPerk(PerkLib.Resolute)) {
			if (display) outputText("\n\n[Monster A] [monster name] is encased in a thick layer of ice.\n\n");
			monster.createStatusEffect(StatusEffects.FrozenSolid, 5, 0, 0, 0);
		}
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
	
	public function polarMidnightChannel(display:Boolean = true):void {
		if (display) {
			outputText("You begin to channel magic, the air temperature dropping around you.");
		}
		player.createStatusEffect(StatusEffects.ChanneledAttack, 1, 0, 0, 0);
		player.createStatusEffect(StatusEffects.ChanneledAttackType, 5, 0, 0, 0);
		if (player.hasPerk(PerkLib.GlacialStormSu) || player.hasPerk(PerkLib.GlacialStormMastered)) player.addStatusValue(StatusEffects.CounterGlacialStorm, 3, 1);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (player.statusEffectv1(StatusEffects.ChanneledAttack) == 1) {
			polarMidnightHit(display);
		} else {
			polarMidnightChannel(display);
		}
	}
}
}
