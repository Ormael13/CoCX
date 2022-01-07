package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class IceRainSpell extends AbstractBlackSpell {
	public function IceRainSpell() {
		super(
				"Ice Rain",
				"This spell causes a radical change in your surroundings. You can call forth an Ice Rain that will strike enemies in a wide area. Fueled by your own desires, this spell can backfire, making the user wet instead.",
				TARGET_ENEMY,
				TIMING_INSTANT,
				[TAG_DAMAGING, TAG_ICE, TAG_AOE]
		);
		baseManaCost = 40;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false) + " ice damage"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsIceRain);
	}
	
	override public function calcCooldown():int {
		return spellBlackCooldown();
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true):Number {
		var baseDamage:Number = 6 * scalingBonusIntelligence(randomize);
		return adjustSpellDamage(baseDamage, DamageType.ICE, CAT_SPELL_BLACK, monster);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You narrow your eyes, focusing on the force of your lust as you raise your hands to the sky. Your mana and lust pulses, rising, pulling. A dark cloud coalesces above you, stretching further until there is nothing but an eerie darkness above you. You bring your head back down, focusing your gaze at  [monster a] [monster name] as countless razor-like shards of ice rain upon your opponent.\n");
		}
		var damage:Number = calcDamage(monster);
		damage = critAndRepeatDamage(display, damage, DamageType.ICE);
		checkAchievementDamage(damage);
		combat.heroBaneProc(damage);
	}
}
}
