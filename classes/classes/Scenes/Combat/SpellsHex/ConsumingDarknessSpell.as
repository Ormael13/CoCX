package classes.Scenes.Combat.SpellsHex {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractHexSpell;
import classes.Scenes.Combat.Combat;
import classes.Scenes.Combat.DamageType;
import classes.StatusEffects;

public class ConsumingDarknessSpell extends AbstractHexSpell {
	public function ConsumingDarknessSpell() {
		super(
			"Consuming Darkness",
			"For the next 7 round the target is devoured by living shadow trying to tear its body apart deals good damage on each round.",
			TARGET_ENEMY,
			TIMING_LASTING,
			[TAG_DAMAGING, TAG_DARKNESS]
		);
		baseManaCost = 350;
		useManaType = Combat.USEMANA_MAGIC_HEAL;
		canBackfire  = true;
	}
	
	override public function get buttonName():String {
		return "ConsDarkness";
	}
	
	override public function describeEffectVs(target:Monster):String {
		return "" + numberFormat(calcDamage(target, false, false)) + " darkness damage over "+
				numberOfThings(calcDuration(),"round") +
				"; " + calcBackfirePercent() + "% backfire"
	}
	
	override public function get isKnown():Boolean {
		return player.hasStatusEffect(StatusEffects.KnowsLifeSiphon);
	}
	
	override public function isActive():Boolean {
		return monster.hasStatusEffect(StatusEffects.ConsumingDarkness);
	}
	
	override public function calcDuration():int {
		return 7;
	}
	
	override public function calcCooldown():int {
		var calcC:int = 12;
		calcC += spellGenericCooldown();
		if (player.hasPerk(PerkLib.Necromancy)) calcC -= 1;
		return calcC;
	}
	
	override public function advance(display:Boolean):void {
		if (monster.statusEffectv1(StatusEffects.ConsumingDarkness) <= 0) {
			monster.removeStatusEffect(StatusEffects.ConsumingDarkness);
		} else {
			monster.addStatusValue(StatusEffects.ConsumingDarkness, 1, -1);
			if (display) {
				outputText("Hungry darkness gnaw at your foe for ");
			}
			var store11:Number = 0;
			store11 += monster.statusEffectv2(StatusEffects.ConsumingDarkness);
			store11 *= 0.2;
			if (player.hasPerk(PerkLib.Necromancy)) store11 *= 1.5;
			combat.doDarknessDamage(store11, true, display);
			if (display) {
				outputText(" damage.\n\n");
			}
		}
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean=true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		return adjustSpellDamage(
				scalingBonusIntelligence()*2,
				DamageType.DARKNESS,
				CAT_SPELL_HEX,
				monster,
				false,
                casting
		);
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (display) {
			outputText("You focus on your magic, trying to draw on it without enhancing your own arousal.\n");
		}
		if (!backfired(display)) {
			outputText("You call on the power of primordial darkness, which is all too happy to oblige your request of ripping your foe to shreds. The shadows all around you sprouting countless mouths and claws to do just that. [Themonster] can only scream in surprise, then in pain, at the sudden assault. ");
			var consumingdarkness:Number = calcDamage(monster, true, true);
			monster.createStatusEffect(StatusEffects.ConsumingDarkness, calcDuration(), consumingdarkness, 0, 0);
			doDarknessDamage(consumingdarkness, true, true);
		}
	}
}
}
