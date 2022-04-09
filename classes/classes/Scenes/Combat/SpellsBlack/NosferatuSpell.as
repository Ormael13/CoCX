package classes.Scenes.Combat.SpellsBlack {
import classes.Monster;
import classes.PerkLib;
import classes.Scenes.Combat.AbstractBlackSpell;
import classes.Scenes.Combat.Combat;
import classes.StatusEffects;

public class NosferatuSpell extends AbstractBlackSpell {
	public function NosferatuSpell() {
		super(
			"Nosferatu",
			"Vampirise the health of your foe, dealing damage and healing you back for 100% of the damage done.",
			TARGET_ENEMY,
			TIMING_INSTANT,
			[TAG_DAMAGING, TAG_HEALING]
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
		return 7;
	}
	
	public function calcDamage(monster:Monster, randomize:Boolean = true, casting:Boolean = true):Number { //casting - Increase Elemental Counter while casting (like Raging Inferno)
		var damage:Number = player.inte + scalingBonusIntelligence(randomize);
		if (player.hasPerk(PerkLib.WisenedHealer)) damage += scalingBonusWisdom();
		damage = Math.round(damage * healModBlack() * spellModBlack());
		return damage;
	}
	
	override protected function doSpellEffect(display:Boolean = true):void {
		if (!backfired(display)) {
			var damage:Number = calcDamage(monster, true, true);
			if (display) {
				outputText(" You chant as your shadow suddenly takes on a life of its own, sprouting a multitude of mouths and tentacles which seek and tear into [monster a] [monster name] shadow");
				if (monster.plural) outputText("s");
				outputText(", gorging on its owner’s life force to replenish your own. Soon enough the spell is over and your shadow returns to you, leaving you better for the wear. <b>(<font color=\"#800000\">" + damage + "</font>)</b>");
			}
			monster.HP -= damage;
			HPChange(damage, false);
			checkAchievementDamage(damage);
			combat.heroBaneProc(damage);
		}
	}
}
}
