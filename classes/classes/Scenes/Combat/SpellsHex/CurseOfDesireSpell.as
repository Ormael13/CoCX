package classes.Scenes.Combat.SpellsHex {
import classes.Monster;
import classes.PerkLib;
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
			[TAG_DEBUFF,TAG_LUSTDMG, TAG_TIER3]
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
				numberFormat(calcLustDamage(target, false)) + " lust damage over " +
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
	
	override public function calcDuration():int {
		return 8;
	}
	
	override public function calcCooldown():int {
		return spellBlackTier3Cooldown();
	}
	
	override public function advance(display:Boolean):void {
		if (monster.statusEffectv1(StatusEffects.CurseOfDesire) <= 0) {
			if (monster.statusEffectv3(StatusEffects.CurseOfDesire) > 0) {
				monster.lustVuln += monster.statusEffectv3(StatusEffects.CurseOfDesire);
			}
			monster.removeStatusEffect(StatusEffects.CurseOfDesire);
		} else {
			monster.addStatusValue(StatusEffects.CurseOfDesire, 1, -1);
			var lustDmg3:Number = monster.statusEffectv2(StatusEffects.CurseOfDesire);
			if (player.hasPerk(PerkLib.Necromancy)) lustDmg3 *= 1.5;
			if (lustDmg3 < 1) lustDmg3 = 1;
			else lustDmg3 = Math.round(lustDmg3);
			if (display) {
				outputText("The curse of desire slowly saps at your victim's resolve and countenance. ");
				if (player.perkv1(PerkLib.ImpNobility) > 0) {
					outputText("Your imp cohorts assist your spellcasting, adding their diagrams to your own. ");
				}
			}
			monster.teased(Math.round(lustDmg3), false, display);
			if (display) {
				outputText("\n\n");
			}
		}
	}
	
	public function calcLustDamage(monster:Monster, randomize:Boolean =true):Number {
		return adjustLustDamage(
			(scalingBonusIntelligence() * 0.75 + scalingBonusLibido() * 0.75), 
			monster, 
			CAT_SPELL_HEX, 
			randomize
		);
	}
	
	public function calcSelfLustDamage():Number {
		return player.maxLust() * 0.01;
	}
	
	public function calcLustResReduction(monster:Monster):Number {
		if (monster != null && monster.lustVuln != 0) {
			if (monster.lustVuln < 0.1) return monster.lustVuln;
			else
				return 0.1;
		} else
			return 0;
		
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
			if (player.perkv1(PerkLib.ImpNobility) > 0) {
				outputText("  Your imp cohorts assist your spellcasting, adding their diagrams to your own.\n");
			}
		}
		if (!backfired(display)) {
			var llr:Number = calcLustResReduction(monster);
			monster.lustVuln += llr;
			if (display) {
				outputText("You moan in pleasure as you curse your target with lewd thoughts. [Themonster] pants in arousal, unable to stop the encroaching fantasies you forced on [monster him] from having their desired effect. ");
				if (player.perkv1(PerkLib.ImpNobility) > 0) {
					outputText("Your imp cohorts assist your spellcasting, adding their diagrams to your own.");
				}
			}
			var lustDmg:Number = calcLustDamage(monster);
			var resultArray:Array = critAndRepeatLust(display, lustDmg, CAT_SPELL_BLACK);
			monster.createStatusEffect(StatusEffects.CurseOfDesire, calcDuration(), resultArray[0], llr, 0);
			postLustSpellEffect(resultArray[1]);
			dynStats("lus", calcSelfLustDamage());
		}
	}
}
}
