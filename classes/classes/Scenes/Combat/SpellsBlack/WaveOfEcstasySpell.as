package classes.Scenes.Combat.SpellsBlack {
import classes.GlobalFlags.kFLAGS;
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Areas.Mountain.WormMass;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.NPCs.Zenji;
import classes.StatusEffects;

public class WaveOfEcstasySpell extends AbstractBlackSpell {
	public function WaveOfEcstasySpell() {
		super("Wave of Ecstasy",
			"The arouse spell draws on your own inner lust in order to enflame the enemies passions.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_LUSTDMG, TAG_AOE, TAG_TIER1]);
		baseManaCost = 100;
	}
	
	override public function get buttonName():String {
		return "WaveOfEcstasy"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsWaveOfEcstasy);
	}
	
	override public function calcCooldown():int {
		return spellBlackCooldown();
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "~" + numberFormat(calcDamage(target, false, false)) + " lust damage"
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		return adjustLustDamage(
				(scalingBonusIntelligence() + scalingBonusLibido()),
				monster,
				CAT_SPELL_BLACK,
				randomize
		);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You almost moan in pleasure as you draw on this spell, sending forth your lust like a shockwave. ");
			if (player.perkv1(PerkLib.ImpNobility) > 0) {
				outputText("Your imp cohorts assist your spellcasting, adding their diagrams to your own.  ");
			}
		}
		if (monster is WormMass) {
			if (display) {
				outputText("The worms appear to be unaffected by your magic!\n\n");
			}
			return;
		} else if (monster is Zenji) {
			if (monster.short == "Zenji") {
				outputText("\nZenji shakes off the effects of the spell.\n\n");
				outputText("\n\"<i>Gonna have ta do more dan dat ta break me.</i>\"\n\n");
			} else if (flags[kFLAGS.ZENJI_PROGRESS] == 2) outputText("\nThe troll shakes off the effects of the spell, \"<i>I. Will. Not. Break.</i>\"\n\n");
			else {
				outputText("\nThe troll shakes off the effects of the spell.\n\n");
				outputText("\n\"<i>Gonna have ta do more dan dat ta break me.</i>\"\n\n");
			}
			return;
		} else if (monster.lustVuln == 0) {
			if (display) {
				outputText("It has no effect!  Your foe clearly does not experience lust in the same way as you.\n\n");
			}
			return;
		}
		var lustDmg:Number = calcDamage(monster, true, true);
		if (display) {
			if (monster.plural) {
				outputText("Arousal breaks in the eyes of your many opponents as pleasure strikes them");
			} else {
				outputText("Unable to evade it [themonster] is struck squarely by the pleasure wave");
			}
		}
		
		var resultArray:Array = critAndRepeatLust(display, lustDmg, CAT_SPELL_BLACK);
		if (!monster.hasPerk(PerkLib.Resolute)) monster.createStatusEffect(StatusEffects.Stunned, 2, 0, 0, 0);
		postLustSpellEffect(resultArray[1]);
	}
}
}
