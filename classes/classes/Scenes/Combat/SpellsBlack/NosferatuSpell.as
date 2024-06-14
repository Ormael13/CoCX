package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.Combat;
import classes.StatusEffects;
import classes.Scenes.Combat.DamageType;

public class NosferatuSpell extends AbstractBlackSpell {
	public function NosferatuSpell() {
		super(
			"Nosferatu",
			"Vampirise the health of your foe, dealing damage and healing you back for 100% of the damage done.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_HEALING, TAG_TIER2]
		);
		baseManaCost           = 50;
		useManaType            = Combat.USEMANA_BLACK_HEAL;
		isBloodMagicApplicable = false;
		isLastResortApplicable = false;
		canBackfire            = true;
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + calcDamage(target, false, false) + " HP leech; " + calcBackfirePercent() + "% backfire"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsNosferatu);
	}
	
	override public function calcCooldown():int {
		var calcC:int = 4;
		calcC += spellGenericCooldown();
		return calcC;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var damage:Number = 5 * scalingBonusIntelligence(randomize);
		if (player.hasPerk(PerkLib.WisenedHealer)) damage += scalingBonusWisdom();
		return adjustSpellDamage(damage, DamageType.DARKNESS, CAT_SPELL_BLACK, monster, true, casting);
	}

	public function calcHeal(monster:Monster, randomize:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var amountToHeal:Number = 5 * scalingBonusIntelligence(randomize);
		if (player.hasPerk(PerkLib.WisenedHealer)) amountToHeal += scalingBonusWisdom();
		return amountToHeal * healModBlack();
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (!backfired(display)) {
			var damage:Number = calcDamage(monster, true, true);
			if (display) {
				outputText(" You chant as your shadow suddenly takes on a life of its own, sprouting a multitude of mouths and tentacles which seek and tear into [monster a] [monster name] shadow");
				if (monster.plural) outputText("s");
				outputText(", gorging on its owner’s life force to replenish your own. Soon enough the spell is over and your shadow returns to you, leaving you better for the wear. ");
			}
			damage = critAndRepeatDamage(display, damage, DamageType.DARKNESS);
			var amountToHeal:Number = Math.round(calcHeal(monster, true));
			HPChange(amountToHeal, display);
			checkAchievementDamage(damage);
			combat.heroBaneProc(damage);
		}
	}
}
}
