package classes.Scenes.Combat.SpellsHex {
import classes.Monster;
import classes.Scenes.Combat.AbstractHexSpell;
import classes.Scenes.Combat.Combat;
import classes.StatusEffects;

public class CurseOfDesireSpell extends AbstractHexSpell {
	public function CurseOfDesireSpell() {
		super(
			"Curse of Desire",
			"Arouse yourself and curse the target with lewd thoughts, weakening its resistance to lust and forcing it to take low lust damage each round for 8 rounds.",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DEBUFF,TAG_LUSTDMG]
		);
		baseManaCost = 400;
		useManaType = Combat.USEMANA_BLACK;
		canBackfire  = true;
	}
	
	override public function get buttonName():String {
		return "CurseOfDesire";
	}
	
	override public function describeEffectVs(target:Monster):String {
		var lrr:Number = calcLustResReduction(target);
		return "" +
				(lrr > 0 ? Math.round(-lrr * 100) + "% lust vuln., " : "") +
				calcLustDamage(target, false) + " lust damage over " +
				numberOfThings(calcDuration(),"round") +
				"; +" + calcSelfLustDamage() + " own lust" +
				"; " + calcBackfirePercent() + "% backfire"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsCurseOfDesire);
	}
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.CurseOfDesire);
	}
	
	public function calcDuration():int {
		return 8
	}
	
	override public function calcCooldown():int {
		return 15;
	}
	
	override public function advance(display:Boolean):void {
		if (monster.statusEffectv1(StatusEffects.CurseOfDesire) <= 0) {
			if (monster.statusEffectv3(StatusEffects.CurseOfDesire) > 0) {
				monster.lustVuln += monster.statusEffectv3(StatusEffects.CurseOfDesire);
			}
			monster.removeStatusEffect(StatusEffects.CurseOfDesire);
		} else {
			monster.addStatusValue(StatusEffects.CurseOfDesire, 1, -1);
			var lustDmg3:Number = 0;
			lustDmg3 += monster.statusEffectv2(StatusEffects.CurseOfDesire);
			lustDmg3 *= 0.2;
			if (lustDmg3 < 1) lustDmg3 = 1;
			else lustDmg3 = Math.round(lustDmg3);
			if (display) {
				outputText("The curse of desire slowly sap at your victim's resolve and countenance. ");
			}
			monster.teased(Math.round(monster.lustVuln * lustDmg3), false);
			if (display) {
				outputText("\n\n");
			}
		}
	}
	
	public function calcLustDamage(monster:Monster, randomize:Boolean =true):Number {
		var lustDmg:Number = adjustLustDamage(
				player.inte / 5,
				monster,
				CAT_SPELL_HEX,
				randomize
		);
		if (lustDmg < 1) lustDmg = 1;
		return lustDmg;
	}
	
	public function calcSelfLustDamage():Number {
		return 10;
	}
	
	public function calcLustResReduction(monster:Monster):Number {
		if (monster != null && monster.lustVuln != 0) {
			if (monster.lustVuln < 0.1) return monster.lustVuln;
		}
		return 0.1;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
		}
		if (!backfired(display)) {
			var llr:Number = calcLustResReduction(monster);
			monster.lustVuln += llr;
			if (display) {
				outputText("You moan in pleasure as you curse your target with lewd thoughts. [Themonster] pants in arousal, unable to stop the encroaching fantasies you forced on [monster him] from having their desired effect. ");
			}
			var lustDmg:Number = calcLustDamage(monster);
			monster.createStatusEffect(StatusEffects.CurseOfDesire, calcDuration(), lustDmg, llr, 0);
			monster.teased(lustDmg, false);
			dynStats("lus", calcSelfLustDamage());
		}
	}
}
}
